<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$dateFrom = $_POST['dateFrom'];
$dateTo = $_POST['dateTo'];
$brunchId = $_POST['brunchId'];

if(isset($dateFrom) && isset($dateTo)) {
    $clauses .= " and SPayment_date between '$dateFrom' and '$dateTo'";
}


$sql = "
    SELECT 
    tbl_supplier_payment .*,
    tbl_supplier.Supplier_Name
    FROM tbl_supplier_payment 
    join tbl_supplier on tbl_supplier.Supplier_SlNo = tbl_supplier_payment.SPayment_customerID
    WHERE tbl_supplier_payment.SPayment_status='a' and tbl_supplier_payment.SPayment_brunchid=$brunchId
   $clauses
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>