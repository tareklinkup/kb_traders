<?php
require_once('db.php');

// add customer payment

$In_Amount = trim($_POST['In_Amount']);
$Out_Amount = trim($_POST['Out_Amount']);
$Tr_Type = trim($_POST['Tr_Type']);
$Acc_SlID = trim($_POST['Acc_SlID']);
$Tr_Description = trim($_POST['Tr_Description']);
$Tr_date = trim($_POST['Tr_date']);
$Customer_brunchid = trim($_POST['brunchId']);
$status = 'a';
$SPayment_AddDAte =   date("Y-m-d H:i:s");
$saveBy = 'Admin';

// customer code generate
$paymentCode = "TR00001";
        
$lastCustomer = mysqli_query($conn ,"select * from tbl_cashtransaction order by Tr_SlNo desc limit 1");
$count = mysqli_num_rows($lastCustomer);
if($count > 0){
    $row = mysqli_fetch_assoc($lastCustomer);
    $newPaymentId = $row['Tr_SlNo']+ 1;
     $zeros = array('0', '00', '000', '0000');
    $paymentCode = 'TR' . (strlen($newPaymentId) > count($zeros) ? $newPaymentId : $zeros[count($zeros) - strlen($newPaymentId)] . $newPaymentId);
}

$sql = "INSERT INTO tbl_cashtransaction(Tr_Id,In_Amount,Out_Amount,Tr_Type,Acc_SlID, 
Tr_Description,Tr_date,Tr_branchid,status,AddTime,AddBy) VALUES ('$paymentCode', '$In_Amount', '$Out_Amount', '$Tr_Type',
'$Acc_SlID', '$Tr_Description','$Tr_date','$Customer_brunchid' ,'$status', '$SPayment_AddDAte', '$saveBy')";
$run = mysqli_query($conn,$sql);
if($run==true){
	echo"Successfull";
}
else{
    echo "Failed";
}

?>
