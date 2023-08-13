<?php
require_once('db.php');

// add customer payment

$CPayment_Paymentby = trim($_POST['CPayment_Paymentby']);
$CPayment_TransactionType = trim($_POST['CPayment_TransactionType']);
$CPayment_amount = trim($_POST['CPayment_amount']);
$CPayment_customerID = trim($_POST['CPayment_customerID']);
$CPayment_date = trim($_POST['CPayment_date']);
$CPayment_id = trim($_POST['CPayment_id']);
$CPayment_notes = trim($_POST['CPayment_notes']);
$CPayment_previous_due= trim($_POST['CPayment_previous_due']);
$account_id = trim($_POST['account_id']);
$Customer_brunchid = trim($_POST['brunchId']);
$status = 'a';
$SPayment_AddDAte =   date("Y-m-d H:i:s");
$saveBy = 'Admin';

// customer code generate
$paymentCode = "TR00001";
        
$lastCustomer = mysqli_query($conn ,"select * from tbl_customer_payment order by CPayment_id desc limit 1");
$count = mysqli_num_rows($lastCustomer);
if($count > 0){
    $row = mysqli_fetch_assoc($lastCustomer);
    $newPaymentId = $row['CPayment_id']+ 1;
     $zeros = array('0', '00', '000', '0000');
    $paymentCode = 'TR' . (strlen($newPaymentId) > count($zeros) ? $newPaymentId : $zeros[count($zeros) - strlen($newPaymentId)] . $newPaymentId);
}

$sql = "INSERT INTO tbl_customer_payment(CPayment_invoice,CPayment_Paymentby,CPayment_TransactionType,CPayment_amount,CPayment_customerID, 
CPayment_date,CPayment_notes, CPayment_previous_due,account_id,CPayment_brunchid,CPayment_status, CPayment_AddDAte , CPayment_Addby) VALUES ('$paymentCode', '$CPayment_Paymentby', '$CPayment_TransactionType', '$CPayment_amount',
'$CPayment_customerID', '$CPayment_date', '$CPayment_notes', '$CPayment_previous_due','$account_id','$Customer_brunchid','$status', '$SPayment_AddDAte', '$saveBy')";
$run = mysqli_query($conn,$sql);
if($run==true){
	echo"Successfull";
}
else{
    echo "Failed";
}

?>
