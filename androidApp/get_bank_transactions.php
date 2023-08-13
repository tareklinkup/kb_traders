<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$dateFrom = $_POST['dateFrom'];
$dateTo = $_POST['dateTo'];
$brunchId=$_POST['brunchId'];

if(isset($dateFrom) && isset($dateTo)) {
    $clauses .= " and bt.transaction_date between '$dateFrom' and '$dateTo'";
}

$sql = "
    select 
    	bt.*,
        ba.account_name,
        ba.account_number,
        ba.bank_name
    from tbl_bank_transactions bt
    left join tbl_bank_accounts ba on bt.account_id = ba.account_id
    where bt.status = $brunchId
    and bt.branch_id = $brunchId
    $clauses
";
$run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>
