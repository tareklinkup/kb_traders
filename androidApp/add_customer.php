<?php
require_once('db.php');
// // Create connection
// $conn = mysqli_connect($servername, $username, $password, $dbname);
// mysqli_set_charset($conn,'utf8');

// add customer

$Customer_Name = trim($_POST['Customer_Name']);
$Customer_Type = trim($_POST['Customer_Type']);
$Customer_Mobile = trim($_POST['Customer_Mobile']);

$Customer_Email = trim($_POST['Customer_Email']);
$Customer_OfficePhone = trim($_POST['Customer_OfficePhone']);
$Customer_Address = trim($_POST['Customer_Address']);

$owner_name = trim($_POST['owner_name']);
$area_ID= trim($_POST['area_ID']);
$Customer_Credit_Limit = trim($_POST['Customer_Credit_Limit']);

$previous_due = trim($_POST['previous_due']);

$Customer_brunchid = 1;

// customer code generate
$customerCode = "C00001";
        
$lastCustomer = mysqli_query($conn ,"select * from tbl_customer order by Customer_SlNo desc limit 1");
$count = mysqli_num_rows($lastCustomer);
if($count > 0){
    $row = mysqli_fetch_assoc($lastCustomer);
    $newCustomerId = $row['Customer_SlNo']+ 1;
    $zeros = array('0', '00', '000', '0000');
    $customerCode = 'C' . (strlen($newCustomerId) > count($zeros) ? $newCustomerId : $zeros[count($zeros) - strlen($newCustomerId)] . $newCustomerId);
}

$sql = "INSERT INTO tbl_customer(Customer_Code,Customer_Name,Customer_Type,Customer_Mobile,Customer_Email, 
Customer_OfficePhone,Customer_Address,owner_name, area_ID,Customer_Credit_Limit,previous_due,Customer_brunchid) VALUES ('$customerCode', '$Customer_Name','$Customer_Type','$Customer_Mobile',
'$Customer_Email','$Customer_OfficePhone','$Customer_Address','$owner_name','$area_ID','$Customer_Credit_Limit','$previous_due','$Customer_brunchid')";
$run = mysqli_query($conn,$sql);
if($run==true){
	echo"Successfull";
}
else{
    echo "Failed";
}

?>
