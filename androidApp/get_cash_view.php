<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$brunchId = $_POST['brunchId'];

$sql = "
    select
            /* Received */
            (
                select ifnull(sum(sm.SaleMaster_PaidAmount), 0) from tbl_salesmaster sm
                where sm.SaleMaster_branchid= '$brunchId'
                and sm.Status = 'a'
            ) as received_sales,
            (
                select ifnull(sum(cp.CPayment_amount), 0) from tbl_customer_payment cp
                where cp.CPayment_TransactionType = 'CR'
                and cp.CPayment_status = 'a'
                and cp.CPayment_Paymentby != 'bank'
                and cp.CPayment_brunchid= '$brunchId'
            ) as received_customer,
            (
                select ifnull(sum(sp.SPayment_amount), 0) from tbl_supplier_payment sp
                where sp.SPayment_TransactionType = 'CR'
                and sp.SPayment_status = 'a'
                and sp.SPayment_Paymentby != 'bank'
                and sp.SPayment_brunchid= '$brunchId'
            ) as received_supplier,
            (
                select ifnull(sum(ct.In_Amount), 0) from tbl_cashtransaction ct
                where ct.Tr_Type = 'In Cash'
                and ct.status = 'a'
                and ct.Tr_branchid= '$brunchId'
            ) as received_cash,
            (
                select ifnull(sum(bt.amount), 0) from tbl_bank_transactions bt
                where bt.transaction_type = 'withdraw'
                and bt.status = 1
                and bt.branch_id= '$brunchId'
            ) as bank_withdraw,
            /* paid */
            (
                select ifnull(sum(pm.PurchaseMaster_PaidAmount), 0) from tbl_purchasemaster pm
                where pm.status = 'a'
                and pm.PurchaseMaster_BranchID= '$brunchId'
            ) as paid_purchase,
            (
                select ifnull(sum(pm.own_freight), 0) from tbl_purchasemaster pm
                where pm.status = 'a'
                and pm.PurchaseMaster_BranchID= '$brunchId'
            ) as own_freight,
            (
                select ifnull(sum(sp.SPayment_amount), 0) from tbl_supplier_payment sp
                where sp.SPayment_TransactionType = 'CP'
                and sp.SPayment_status = 'a'
                and sp.SPayment_Paymentby != 'bank'
                and sp.SPayment_brunchid= '$brunchId'
            ) as paid_supplier,
            (
                select ifnull(sum(cp.CPayment_amount), 0) from tbl_customer_payment cp
                where cp.CPayment_TransactionType = 'CP'
                and cp.CPayment_status = 'a'
                and cp.CPayment_Paymentby != 'bank'
                and cp.CPayment_brunchid= '$brunchId'
            ) as paid_customer,
            (
                select ifnull(sum(ct.Out_Amount), 0) from tbl_cashtransaction ct
                where ct.Tr_Type = 'Out Cash'
                and ct.status = 'a'
                and ct.Tr_branchid= '$brunchId'
            ) as paid_cash,
            (
                select ifnull(sum(bt.amount), 0) from tbl_bank_transactions bt
                where bt.transaction_type = 'deposit'
                and bt.status = 1
                and bt.branch_id= '$brunchId'
            ) as bank_deposit,
            (
                select ifnull(sum(ep.payment_amount), 0) from tbl_employee_payment ep
                where ep.paymentBranch_id = '$brunchId'
                and ep.status = 'a'
            ) as employee_payment,
            /* total */
            (
                select received_sales + received_customer + received_supplier + received_cash + bank_withdraw
            ) as total_in,
            (
                select paid_purchase + own_freight + paid_customer + paid_supplier + paid_cash + bank_deposit + employee_payment
            ) as total_out,
            (
                select total_in - total_out
            ) as cash_balance
";
    $run = mysqli_query($conn,$sql);
    
    $cash_result = mysqli_fetch_assoc($run);
    
    $cash_balance = $cash_result['cash_balance'];
    
    $sql2 = "
        select 
                ba.*,
                (
                    select ifnull(sum(bt.amount), 0) from tbl_bank_transactions bt
                    where bt.account_id = ba.account_id
                    and bt.transaction_type = 'deposit'
                    and bt.status = 1
                    and bt.branch_id = '$brunchId'
                ) as total_deposit,
                (
                    select ifnull(sum(bt.amount), 0) from tbl_bank_transactions bt
                    where bt.account_id = ba.account_id
                    and bt.transaction_type = 'withdraw'
                    and bt.status = 1
                    and bt.branch_id = '$brunchId'
                ) as total_withdraw,
                (
                    select ifnull(sum(cp.CPayment_amount), 0) from tbl_customer_payment cp
                    where cp.account_id = ba.account_id
                    and cp.CPayment_status = 'a'
                    and cp.CPayment_TransactionType = 'CR'
                    and cp.CPayment_brunchid = '$brunchId'
                ) as total_received_from_customer,
                (
                    select ifnull(sum(cp.CPayment_amount), 0) from tbl_customer_payment cp
                    where cp.account_id = ba.account_id
                    and cp.CPayment_status = 'a'
                    and cp.CPayment_TransactionType = 'CP'
                    and cp.CPayment_brunchid = '$brunchId'
                ) as total_paid_to_customer,
                (
                    select ifnull(sum(sp.SPayment_amount), 0) from tbl_supplier_payment sp
                    where sp.account_id = ba.account_id
                    and sp.SPayment_status = 'a'
                    and sp.SPayment_TransactionType = 'CP'
                    and sp.SPayment_brunchid = '$brunchId'
                ) as total_paid_to_supplier,
                (
                    select ifnull(sum(sp.SPayment_amount), 0) from tbl_supplier_payment sp
                    where sp.account_id = ba.account_id
                    and sp.SPayment_status = 'a'
                    and sp.SPayment_TransactionType = 'CR'
                    and sp.SPayment_brunchid = '$brunchId'
                ) as total_received_from_supplier,
                (
                    select (ba.initial_balance + total_deposit + total_received_from_customer + total_received_from_supplier) - (total_withdraw + total_paid_to_customer + total_paid_to_supplier)
                ) as balance
            from tbl_bank_accounts ba
            where ba.branch_id = '$brunchId'
    "; 
    
    $run2 = mysqli_query($conn,$sql2);
    
    $bank_balance = 0;

    while($data = mysqli_fetch_assoc($run2)){
        $bank_balance += $data['balance'];
    // 	$item[] = $data;
    // 	$json = json_encode(array('contents'=>$item));
    }
    
    $data_arr = [
        'cash_balance' => $cash_balance,
        'bank_balance' => $bank_balance,
        'total_balance' => $cash_balance + $bank_balance,
    ];
    	$item[] = $data_arr;
         echo json_encode(array('contents'=>$item));

  
?>
