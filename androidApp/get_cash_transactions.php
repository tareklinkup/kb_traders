<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$dateFrom = $_POST['dateFrom'];
$dateTo = $_POST['dateTo'];
$accountsId = $_POST['accountsId'];
$brunchId = $_POST['brunchId'];
if(isset($dateFrom) && isset($dateTo)) {
    $clauses .= " and ct.Tr_date between '$dateFrom' and '$dateTo'";
}
if(isset($accountsId) && $accountsId != 0) {
    $clauses .= " and ct.Acc_SlID = $accountsId";
}

$sql = "
    select 
    	ct.*,
        ac.Acc_Name
    from tbl_cashtransaction ct
    left join tbl_account ac on ac.Acc_SlNo = ct.Acc_SlID
    where ct.status = 'a'
    and ct.Tr_branchid = $brunchId
      $clauses
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>
