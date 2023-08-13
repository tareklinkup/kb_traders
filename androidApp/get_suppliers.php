<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');

$dateFrom = $_POST['dateFrom'];
$dateTo = $_POST['dateTo'];
$brunchId = $_POST['brunchId'];

if(isset($dateFrom) && isset($dateTo)) {
    $clauses .= " and sp.SPayment_date between '$dateFrom' and '$dateTo'";
}

$sql = "SELECT * FROM `tbl_supplier` where Supplier_brinchid='$brunchId'
$clauses
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>
