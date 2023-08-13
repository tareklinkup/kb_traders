<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$brunchId = $_POST['brunchId'];
$customerId = $_POST['customerId'];


if(isset($customerId) && $customerId != 0) {
    $clauses .= " and c.Customer_SlNo = '$customerId'";
}
$sql = "
     select
        c.*,
        d.District_Name,
        concat(c.Customer_Code, ' - ', c.Customer_Name, ' - ', c.owner_name, ' - ', c.Customer_Mobile) as display_name
    from tbl_customer c
    left join tbl_district d on d.District_SlNo = c.area_ID
    where c.status = 'a'
    and c.Customer_Type != 'G'
    and (c.Customer_brunchid = $brunchId or c.Customer_brunchid = 0)
    $clauses
    order by c.Customer_SlNo desc
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>
