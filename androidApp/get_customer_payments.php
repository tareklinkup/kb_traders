<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$dateFrom = $_POST['dateFrom'];
$dateTo = $_POST['dateTo'];
$brunchId = $_POST['brunchId'];

if(isset($dateFrom) && isset($dateTo)) {
    $clauses .= " and cp.CPayment_date between '$dateFrom' and '$dateTo'";
}


$sql = "
    select 
    	cp.*,
       	c.Customer_Name
    from tbl_customer_payment cp
    join tbl_customer c on c.Customer_SlNo = cp.CPayment_customerID
    where cp.CPayment_status = 'a'
    and cp.CPayment_brunchid = $brunchId
   $clauses
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    
    }
    echo $json ;

  
?>
