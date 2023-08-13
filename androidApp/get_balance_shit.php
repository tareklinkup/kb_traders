<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');

$res = new stdClass;

$dateFrom = $_POST['dateFrom'];
$dateTo = $_POST['dateTo'];
$branchId = $_POST['brunchId'];

// sales paid
$salesQuery = "
    select 
        ifnull(sum(sm.SaleMaster_PaidAmount),0)as paid
    from tbl_salesmaster sm
    where sm.SaleMaster_branchid = $branchId
    and sm.Status = 'a'
    and sm.SaleMaster_SaleDate between '$dateFrom' and '$dateTo'
   
";
$salesRun = mysqli_query($conn, $salesQuery);

// purchase paid
$purchaseQuery = "
    select 
        ifnull(sum(pm.PurchaseMaster_PaidAmount),0)as paid
    from tbl_purchasemaster pm
    where pm.PurchaseMaster_BranchID  = $branchId
    and pm.Status = 'a'
    and pm.PurchaseMaster_OrderDate between '$dateFrom' and '$dateTo'
   
";
$purchaseRun = mysqli_query($conn, $purchaseQuery);

// customer payment receive 
$paymentReceiveQuery = "
    select 
    	ifnull(sum(cp.CPayment_amount), 0)as receive
    from tbl_customer_payment cp
    where cp.CPayment_status = 'a'
    and cp.CPayment_brunchid = $branchId
    and cp.CPayment_TransactionType = 'CR'
    and cp.CPayment_date between '$dateFrom' and '$dateTo'
"; 
$customerReceive = mysqli_query($conn, $paymentReceiveQuery);

// customer payment paid 
$paymentPaidQuery = "
    select 
    	ifnull(sum(cp.CPayment_amount), 0)as receive
    from tbl_customer_payment cp
    where cp.CPayment_status = 'a'
    and cp.CPayment_brunchid = $branchId
    and cp.CPayment_TransactionType = 'CP'
    and cp.CPayment_date between '$dateFrom' and '$dateTo'
"; 
$customerPaid = mysqli_query($conn, $paymentPaidQuery);

// supplier payment receive 
$supplierReceiveQuery = "
    select 
    	ifnull(sum(sp.SPayment_amount), 0)as receive
    from tbl_supplier_payment sp
    where sp.SPayment_status = 'a'
    and sp.SPayment_brunchid = $branchId
    and sp.SPayment_TransactionType = 'CR'
    and sp.SPayment_date between '$dateFrom' and '$dateTo'
"; 
$supplierReceive = mysqli_query($conn, $supplierReceiveQuery);

// supplier payment paid 
$supplierPaidQuery = "
    select 
    	ifnull(sum(sp.SPayment_amount), 0)as paid
    from tbl_supplier_payment sp
    where sp.SPayment_status = 'a'
    and sp.SPayment_brunchid = $branchId
    and sp.SPayment_TransactionType = 'CP'
    and sp.SPayment_date between '$dateFrom' and '$dateTo'
"; 
$supplierPaid = mysqli_query($conn, $supplierPaidQuery);

// bank  withdraw 
$bankWithdrawQuery = "
    select 
    	ifnull(sum(bt.amount), 0)as total
    from tbl_bank_transactions bt 
    where bt.status = 1
    and bt.branch_id = $branchId
    and bt.transaction_type = 'withdraw'
    and bt.transaction_date between '$dateFrom' and '$dateTo'
"; 
$bankWithdraw = mysqli_query($conn, $bankWithdrawQuery);

// bank  deposit 
$bankDepositQuery = "
    select 
    	ifnull(sum(bt.amount), 0)as total
    from tbl_bank_transactions bt 
    where bt.status = 1
    and bt.branch_id = $branchId
    and bt.transaction_type = 'deposit'
    and bt.transaction_date between '$dateFrom' and '$dateTo'
"; 
$bankDeposit = mysqli_query($conn, $bankDepositQuery);

// cash paid
$cashPaidQuery = "
    select
    	ifnull(sum(ct.Out_Amount),0)as total
    from tbl_cashtransaction ct
    where ct.status = 'a'
    and ct.Tr_branchid = $branchId
    and ct.Tr_Type = 'Out Cash'
    and ct.Tr_date between '$dateFrom' and '$dateTo'
";
$cashPaid = mysqli_query($conn, $cashPaidQuery);

// cash receive
$cashReceiveQuery = "
    select
    	ifnull(sum(ct.In_Amount),0)as total
    from tbl_cashtransaction ct
    where ct.status = 'a'
    and ct.Tr_branchid = $branchId
    and ct.Tr_Type = 'In Cash'
    and ct.Tr_date between '$dateFrom' and '$dateTo'
";
$cashReceive = mysqli_query($conn,$cashReceiveQuery);

// employee payment
$employeePaymentQuery = "
    select
    	ifnull(sum(ep.payment_amount), 0)as total
    from tbl_employee_payment ep
    where ep.status = 'a'
    and ep.paymentBranch_id = $branchId
    and ep.payment_date between '$dateFrom' and '$dateTo'
";
$employPayment = mysqli_query($conn,$employeePaymentQuery);

$res->sales = mysqli_fetch_assoc($salesRun);
$res->purchase = mysqli_fetch_assoc($purchaseRun);
$res->customer_receive = mysqli_fetch_assoc($customerReceive);
$res->customer_paid = mysqli_fetch_assoc($customerPaid);
$res->supplier_receive = mysqli_fetch_assoc($supplierReceive);
$res->supplier_paid = mysqli_fetch_assoc($supplierPaid);
$res->withdraw = mysqli_fetch_assoc($bankWithdraw);
$res->deposit = mysqli_fetch_assoc($bankDeposit);
$res->cash_receive = mysqli_fetch_assoc($cashReceive);
$res->cash_paid = mysqli_fetch_assoc($cashPaid);
$res->employee_payment = mysqli_fetch_assoc($employPayment);
echo json_encode($res);

  
?>
