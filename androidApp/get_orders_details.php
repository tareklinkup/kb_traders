<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$orderId=trim($_POST['orderId']);
$brunchId=trim($_POST['brunchId']);
$sql = "SELECT tbl_saledetails.*,
tbl_product.Product_Name,
tbl_unit.Unit_Name

from tbl_saledetails 
JOIN tbl_salesmaster on tbl_salesmaster.SaleMaster_SlNo =  tbl_saledetails.SaleMaster_IDNo
left JOIN tbl_product on tbl_product.Product_SlNo = tbl_saledetails.Product_IDNo
left JOIN tbl_unit on tbl_unit.Unit_SlNo = tbl_product.Unit_ID
 where SaleMaster_IDNo = '$orderId' ";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>