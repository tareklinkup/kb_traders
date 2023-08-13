<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
$brunchId = $_POST['brunchId'];
mysqli_set_charset($conn,'utf8');
$sql = "SELECT * FROM `tbl_bank_accounts` where status = 1 and  branch_id =$brunchId";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>
