<?php
require_once('db.php');

// add customer payment

$account_id = trim($_POST['account_id']);
$amount = trim($_POST['amount']);
$note = trim($_POST['note']);
$transaction_date = trim($_POST['transaction_date']);
$transaction_type = trim($_POST['transaction_type']);

$Customer_brunchid = trim($_POST['brunchId']);
$status = '1';
$SPayment_AddDAte =   date("Y-m-d H:i:s");
$saveBy = '1';

// // customer code generate
// $paymentCode = "TR00001";
        
// $lastCustomer = mysqli_query($conn ,"select * from tbl_bank_transactions order by Tr_SlNo desc limit 1");
// $count = mysqli_num_rows($lastCustomer);
// if($count > 0){
//     $row = mysqli_fetch_assoc($lastCustomer);
//     $newPaymentId = $row['Tr_SlNo']+ 1;
//      $zeros = array('0', '00', '000', '0000');
//     $paymentCode = 'TR' . (strlen($newPaymentId) > count($zeros) ? $newPaymentId : $zeros[count($zeros) - strlen($newPaymentId)] . $newPaymentId);
// }

$sql = "INSERT INTO tbl_bank_transactions(account_id,amount,note,transaction_date,transaction_type,branch_id  ,  status  ,   saved_datetime,saved_by ) VALUES ('$account_id', '$amount', '$note', '$transaction_date',
'$transaction_type','$Customer_brunchid' , '$status' , '$SPayment_AddDAte', '$saveBy')";
$run = mysqli_query($conn,$sql);
if($run==true){
	echo"Successfull";
}
else{
    echo "Failed";
}

?>
