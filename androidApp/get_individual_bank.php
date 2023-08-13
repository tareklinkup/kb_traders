<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');

         $brunchId =  $_POST['brunchId'];


$sql = "
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
                and sp.SPayment_brunchid ='$brunchId'
            ) as total_received_from_supplier,
            (
                select (ba.initial_balance + total_deposit + total_received_from_customer + total_received_from_supplier) - (total_withdraw + total_paid_to_customer + total_paid_to_supplier)
            ) as balance
        from tbl_bank_accounts ba
        where ba.branch_id = '$brunchId'
";

    $run = mysqli_query($conn,$sql);

    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo "$json" ;

  
?>
