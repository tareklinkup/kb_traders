<?php
require_once('db.php');

// today sales
$date = date('Y-m-d');
// $brunchId = $_POST['brunchId'];
$brunchId = $_POST['brunchId'];
$dateFrom = $_POST['dateFrom'];
$dateTo = $_POST['dateTo'];


$res = new stdClass();
$todaysSale ="
        select 
            ifnull(sum(ifnull(sm.SaleMaster_TotalSaleAmount, 0)), 0) as total_amount
        from tbl_salesmaster sm
        where sm.Status = 'a'
        and sm.SaleMaster_SaleDate = '$date'
        and sm.SaleMaster_branchid = $brunchId
    ";

    $run = mysqli_query($conn,$todaysSale);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    	$res->todaySales = $data['total_amount'];
    }
    
// monthly 
$year = date('Y');
$month = date('m');
$monthlySales = "
    select 
        ifnull(sum(ifnull(sm.SaleMaster_TotalSaleAmount, 0)), 0) as total_amount
    from tbl_salesmaster sm
    where sm.Status = 'a'
    and month(sm.SaleMaster_SaleDate) = '$month'
    and year(sm.SaleMaster_SaleDate) = '$year'
    and sm.SaleMaster_branchid = $brunchId
";
$monthly = mysqli_query($conn,$monthlySales);
    while($row = mysqli_fetch_assoc($monthly)){
        
    	$res->monthlySales =  $row['total_amount'];
    }

// total due 

$dueSql = "
    select  ifnull(sum(dueAmount), 0)as total_due from	(
        select
            (select ifnull(sum(sm.SaleMaster_TotalSaleAmount), 0.00) + ifnull(c.previous_due, 0.00)
                from tbl_salesmaster sm 
                where sm.SalseCustomer_IDNo = c.Customer_SlNo
                and sm.Status = 'a') as billAmount,

            (select ifnull(sum(sm.SaleMaster_PaidAmount), 0.00)
                from tbl_salesmaster sm
                where sm.SalseCustomer_IDNo = c.Customer_SlNo
                and sm.Status = 'a') as invoicePaid,

            (select ifnull(sum(cp.CPayment_amount), 0.00) 
                from tbl_customer_payment cp 
                where cp.CPayment_customerID = c.Customer_SlNo and cp.CPayment_TransactionType = 'CR'
                and cp.CPayment_status = 'a') as cashReceived,

            (select ifnull(sum(cp.CPayment_amount), 0.00) 
                from tbl_customer_payment cp 
                where cp.CPayment_customerID = c.Customer_SlNo 
                and cp.CPayment_TransactionType = 'CP'
                and cp.CPayment_status = 'a') as paidOutAmount,

            (select ifnull(sum(sr.SaleReturn_ReturnAmount), 0.00) 
                from tbl_salereturn sr 
                join tbl_salesmaster smr on smr.SaleMaster_InvoiceNo = sr.SaleMaster_InvoiceNo 
                where smr.SalseCustomer_IDNo = c.Customer_SlNo) as returnedAmount,

            (select invoicePaid + cashReceived) as paidAmount,

            (select (billAmount + paidOutAmount) - (paidAmount + returnedAmount)) as dueAmount
            
        from tbl_customer c
        where c.Customer_brunchid = $brunchId
        and c.Customer_Type != 'G'
    )as tbl
";

$due = mysqli_query($conn, $dueSql);
while($row = mysqli_fetch_assoc($due)) {
    $res->dueBalance = $row['total_due'];
}

// cash balance

$cashBalanceSql = "
    
    select
        /* Received */
        (
            select ifnull(sum(sm.SaleMaster_PaidAmount), 0) from tbl_salesmaster sm
            where sm.SaleMaster_branchid= $brunchId
            and sm.Status = 'a'
        ) as received_sales,
        (
            select ifnull(sum(cp.CPayment_amount), 0) from tbl_customer_payment cp
            where cp.CPayment_TransactionType = 'CR'
            and cp.CPayment_status = 'a'
            and cp.CPayment_Paymentby != 'bank'
            and cp.CPayment_brunchid= $brunchId
        ) as received_customer,
        (
            select ifnull(sum(sp.SPayment_amount), 0) from tbl_supplier_payment sp
            where sp.SPayment_TransactionType = 'CR'
            and sp.SPayment_status = 'a'
            and sp.SPayment_Paymentby != 'bank'
            and sp.SPayment_brunchid= $brunchId
        ) as received_supplier,
        (
            select ifnull(sum(ct.In_Amount), 0) from tbl_cashtransaction ct
            where ct.Tr_Type = 'In Cash'
            and ct.status = 'a'
            and ct.Tr_branchid= $brunchId
        ) as received_cash,
        (
            select ifnull(sum(bt.amount), 0) from tbl_bank_transactions bt
            where bt.transaction_type = 'withdraw'
            and bt.status = 1
            and bt.branch_id= $brunchId
            
        ) as bank_withdraw,
        /* paid */
        (
            select ifnull(sum(pm.PurchaseMaster_PaidAmount), 0) from tbl_purchasemaster pm
            where pm.status = 'a'
            and pm.PurchaseMaster_BranchID= $brunchId
            
        ) as paid_purchase,
        (
            select ifnull(sum(sp.SPayment_amount), 0) from tbl_supplier_payment sp
            where sp.SPayment_TransactionType = 'CP'
            and sp.SPayment_status = 'a'
            and sp.SPayment_Paymentby != 'bank'
            and sp.SPayment_brunchid= $brunchId
           
        ) as paid_supplier,
        (
            select ifnull(sum(cp.CPayment_amount), 0) from tbl_customer_payment cp
            where cp.CPayment_TransactionType = 'CP'
            and cp.CPayment_status = 'a'
            and cp.CPayment_Paymentby != 'bank'
            and cp.CPayment_brunchid= $brunchId
           
        ) as paid_customer,
        (
            select ifnull(sum(ct.Out_Amount), 0) from tbl_cashtransaction ct
            where ct.Tr_Type = 'Out Cash'
            and ct.status = 'a'
            and ct.Tr_branchid= $brunchId
           
        ) as paid_cash,
        (
            select ifnull(sum(bt.amount), 0) from tbl_bank_transactions bt
            where bt.transaction_type = 'deposit'
            and bt.status = 1
            and bt.branch_id= $brunchId
        ) as bank_deposit,
        (
            select ifnull(sum(ep.payment_amount), 0) from tbl_employee_payment ep
            where ep.paymentBranch_id = $brunchId
            and ep.status = 'a'
            " . ($date == null ? "" : " and ep.payment_date < '$date'") . "
        ) as employee_payment,
        /* total */
        (
            select received_sales + received_customer + received_supplier + received_cash + bank_withdraw
        ) as total_in,
        (
            select paid_purchase + paid_customer + paid_supplier + paid_cash + bank_deposit + employee_payment
        ) as total_out,
        (
            select total_in - total_out
        ) as cash_balance
";

$cashBalance = mysqli_query($conn, $cashBalanceSql);
while($row = mysqli_fetch_assoc($cashBalance)) {
    $res->cashBalance = $row['cash_balance'];
}

// today collections
$collecitonSql = "
    select 
        ifnull((
            select sum(ifnull(sm.SaleMaster_PaidAmount, 0)) 
            from tbl_salesmaster sm
            where sm.Status = 'a'
            and sm.SaleMaster_branchid = $brunchId
            and sm.SaleMaster_SaleDate = CURRENT_DATE()
        ), 0) +
        ifnull((
            select sum(ifnull(cp.CPayment_amount, 0)) 
            from tbl_customer_payment cp
            where cp.CPayment_status = 'a'
            and cp.CPayment_brunchid = $brunchId
            and cp.CPayment_date = CURRENT_DATE()
        ), 0) +
        ifnull((
            select sum(ifnull(ct.In_Amount, 0)) 
            from tbl_cashtransaction ct
            where ct.status = 'a'
            and ct.Tr_branchid = $brunchId
            and ct.Tr_date = CURRENT_DATE()
        ), 0) as total_amount
";

$todayCollection = mysqli_query($conn, $collecitonSql);
while( $collection = mysqli_fetch_assoc($todayCollection)) {
    $res->collection = $collection['total_amount'];
}

// bank balance
$bankBalanceSql = "
    select ifnull(sum(balance),0)as bankBalance  from(
        select 
            ba.*,
            (
                select ifnull(sum(bt.amount), 0) from tbl_bank_transactions bt
                where bt.account_id = ba.account_id
                and bt.transaction_type = 'deposit'
                and bt.status = 1
                and bt.branch_id = $brunchId
            ) as total_deposit,
            (
                select ifnull(sum(bt.amount), 0) from tbl_bank_transactions bt
                where bt.account_id = ba.account_id
                and bt.transaction_type = 'withdraw'
                and bt.status = 1
                and bt.branch_id = $brunchId
            ) as total_withdraw,
            (
                select ifnull(sum(cp.CPayment_amount), 0) from tbl_customer_payment cp
                where cp.account_id = ba.account_id
                and cp.CPayment_status = 'a'
                and cp.CPayment_TransactionType = 'CR'
                and cp.CPayment_brunchid = $brunchId
            ) as total_received_from_customer,
            (
                select ifnull(sum(cp.CPayment_amount), 0) from tbl_customer_payment cp
                where cp.account_id = ba.account_id
                and cp.CPayment_status = 'a'
                and cp.CPayment_TransactionType = 'CP'
                and cp.CPayment_brunchid = $brunchId
               
            ) as total_paid_to_customer,
            (
                select ifnull(sum(sp.SPayment_amount), 0) from tbl_supplier_payment sp
                where sp.account_id = ba.account_id
                and sp.SPayment_status = 'a'
                and sp.SPayment_TransactionType = 'CP'
                and sp.SPayment_brunchid = $brunchId
            ) as total_paid_to_supplier,
            (
                select ifnull(sum(sp.SPayment_amount), 0) from tbl_supplier_payment sp
                where sp.account_id = ba.account_id
                and sp.SPayment_status = 'a'
                and sp.SPayment_TransactionType = 'CR'
                and sp.SPayment_brunchid = $brunchId
            ) as total_received_from_supplier,
            (
                select (ba.initial_balance + total_deposit + total_received_from_customer + total_received_from_supplier) - (total_withdraw + total_paid_to_customer + total_paid_to_supplier)
            ) as balance
        from tbl_bank_accounts ba
        where ba.branch_id = $brunchId
    )as tbl
";

$bankBalance = mysqli_query($conn, $bankBalanceSql);
while($r = mysqli_fetch_assoc($bankBalance)) {
    $res->bankBalance = $r['bankBalance'];
}

// top customer
$topCustomerSql = "
    select 
        c.Customer_Name as customer_name,
        ifnull(sum(sm.SaleMaster_TotalSaleAmount), 0) as amount
    from tbl_salesmaster sm 
    join tbl_customer c on c.Customer_SlNo = sm.SalseCustomer_IDNo
    where sm.SaleMaster_branchid = $brunchId
    and sm.SaleMaster_SaleDate between '$dateFrom' and '$dateTo'
    group by sm.SalseCustomer_IDNo
    order by amount desc 
    limit 5
"; 

$topCustomer = mysqli_query($conn, $topCustomerSql);
while($customer = mysqli_fetch_assoc($topCustomer)) {
    $topCustomers[] = $customer;
    $res->topCustomer = $topCustomers;  
}

// top product
$topProductSql = "
    select 
        p.Product_Name as product_name,
        ifnull(sum(sd.SaleDetails_TotalQuantity), 0) as sold_quantity
    from tbl_saledetails sd
    join tbl_product p on p.Product_SlNo = sd.Product_IDNo
    join tbl_salesmaster sm on sm.SaleMaster_SlNo = sd.SaleMaster_IDNo
    where p.Product_branchid = $brunchId
    and sm.SaleMaster_SaleDate between '$dateFrom' and '$dateTo'
    group by sd.Product_IDNo
    order by sold_quantity desc
    limit 5
";

$topProduct = mysqli_query($conn, $topProductSql);

while($products = mysqli_fetch_assoc($topProduct)) {
    $topProducts[] = $products;
    $res->topProduct = $topProducts;  
}



// top paid customer
$topPaidCustomerSql = "
    select 
        *, 
        sum(sales_paid + partial_payment)as total 
    from 
        (
            select 
                sm.SalseCustomer_IDNo as customer_id,
                c.Customer_Name as customer_name,
                ifnull(sum(sm.SaleMaster_PaidAmount), 0) as sales_paid,
                (
                    select 
                        ifnull(sum(cp.CPayment_amount), 0)
                    from tbl_customer_payment as cp
                    where cp.CPayment_status = 'a'
                    and cp.CPayment_TransactionType = 'CR'
                    and cp.CPayment_customerID = sm.SalseCustomer_IDNo
                    and cp.CPayment_brunchid = $brunchId
                    and cp.CPayment_date between '$dateFrom' and '$dateTo'
                )as partial_payment
            from tbl_salesmaster sm 
            join tbl_customer c on c.Customer_SlNo = sm.SalseCustomer_IDNo
            where sm.SaleMaster_branchid = $brunchId
             and sm.SaleMaster_SaleDate between '$dateFrom' and '$dateTo'
            and customer_name != ''
            group by sm.SalseCustomer_IDNo
        )as tbl
    group by customer_id
    order by total desc
    limit 5
";
$paidCustomer = mysqli_query($conn, $topPaidCustomerSql);
while($paid = mysqli_fetch_assoc($paidCustomer)) {
    $topPaid[] = $paid;
    $res->topPaidCustomer = $topPaid;
}

// Monthly Record
$monthlyRecord = [];
$year = date('Y');
$month = date('m');
$dayNumber = cal_days_in_month(CAL_GREGORIAN, $month, $year);
for($i = 1; $i <= $dayNumber; $i++){
    $date = $year . '-' . $month . '-'. sprintf("%02d", $i);
    
    
    $query = "
        select ifnull(sum(sm.SaleMaster_TotalSaleAmount), 0) as sales_amount 
        from tbl_salesmaster sm 
        where sm.SaleMaster_SaleDate = '$date'
        and sm.Status = 'a'
        and sm.SaleMaster_branchid = $brunchId
        group by sm.SaleMaster_SaleDate
    ";
    
    $monthly = mysqli_query($conn, $query);

    $amount = 0.00;
    $rowcount = mysqli_num_rows($monthly);
    if($rowcount == 0){
        $amount = 0.00;
    } else {
        while($row = mysqli_fetch_assoc($monthly)) {
            $amount = $row['sales_amount'];
        }
    }
    $sale = ['day' => sprintf("%02d", $i), 'amount' => $amount];
    array_push($monthlyRecord, $sale);
}

// $res->monthlyRecord = $monthlyRecord;
$res->monthlyRecord = array_values($monthlyRecord);

echo json_encode(array('contents'=>$res));

  
?>
