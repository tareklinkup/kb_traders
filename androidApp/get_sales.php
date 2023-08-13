<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$dateFrom = $_POST['dateFrom'];
$dateTo = $_POST['dateTo'];
$customerId = $_POST['customerId'];
$brunchId = $_POST['brunchId'];
$clauses = '';

if(isset($dateFrom) && isset($dateTo)) {
    $clauses .= " and sm.SaleMaster_SaleDate between '$dateFrom' and '$dateTo'";
}

if(isset($customerId) && $customerId != 0) {
    $clauses .= " and sm.SalseCustomer_IDNo = $customerId";
}

$sql = "
    select 
        concat(sm.SaleMaster_InvoiceNo, ' - ', c.Customer_Name) as invoice_text,
        sm.*,
        c.Customer_Code,
        c.Customer_Name,
        c.Customer_Mobile,
        c.Customer_Address,
        c.Customer_Type,
        e.Employee_Name,
        br.Brunch_name
    from tbl_salesmaster sm
    left join tbl_customer c on c.Customer_SlNo = sm.SalseCustomer_IDNo
    left join tbl_employee e on e.Employee_SlNo = sm.employee_id
    left join tbl_brunch br on br.brunch_id = sm.SaleMaster_branchid
    where sm.SaleMaster_branchid = $brunchId
    and sm.Status = 'a'
    $clauses
    order by sm.SaleMaster_SlNo desc
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>
