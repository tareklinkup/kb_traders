<?php
require_once('db.php');

// add customer payment

$SPayment_Paymentby = trim($_POST['SPayment_Paymentby']);
$SPayment_TransactionType = trim($_POST['SPayment_TransactionType']);
$SPayment_amount = trim($_POST['SPayment_amount']);
$SPayment_customerID = trim($_POST['SPayment_customerID']);
$SPayment_date = trim($_POST['SPayment_date']);
$SPayment_notes = trim($_POST['SPayment_notes']);
$account_id = trim($_POST['account_id']);
$Customer_brunchid = trim($_POST['brunchId']);
$status = 'a';
$SPayment_AddDAte =   date("Y-m-d H:i:s");
// customer code generate
$paymentCode = "TR00001";
        
$lastCustomer = mysqli_query($conn ,"select * from tbl_supplier_payment order by SPayment_id desc limit 1");
$count = mysqli_num_rows($lastCustomer);
if($count > 0){
    $row = mysqli_fetch_assoc($lastCustomer);
    $newPaymentId = $row['SPayment_id']+ 1;
     $zeros = array('0', '00', '000', '0000');
    $paymentCode = 'TR' . (strlen($newPaymentId) > count($zeros) ? $newPaymentId : $zeros[count($zeros) - strlen($newPaymentId)] . $newPaymentId);
}

$sql = "INSERT INTO tbl_supplier_payment(SPayment_invoice,SPayment_Paymentby,SPayment_TransactionType,SPayment_amount,SPayment_customerID, 
SPayment_date,SPayment_notes,account_id,SPayment_brunchid,SPayment_status,SPayment_AddDAte) VALUES ('$paymentCode', '$SPayment_Paymentby', '$SPayment_TransactionType', '$SPayment_amount',
'$SPayment_customerID', '$SPayment_date','$SPayment_notes','$account_id','$Customer_brunchid','$status', '$SPayment_AddDAte')";
$run = mysqli_query($conn,$sql);
if($run==true){
	echo"Successfull";
}
else{
    echo "Failed";
}

?>
