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
    select * from 
        ( select
            c.Customer_SlNo,
            c.Customer_Name,
            c.Customer_Code,
            c.Customer_Address,
            c.Customer_Mobile,
            c.owner_name,
            (select ifnull(sum(sm.SaleMaster_TotalSaleAmount), 0.00) + ifnull(c.previous_due, 0.00)
                from tbl_salesmaster sm 
                where sm.SalseCustomer_IDNo = c.Customer_SlNo
                and sm.Status = 'a') as billAmount,

            (select ifnull(sum(sm.SaleMaster_PaidAmount), 0.00)
                from tbl_salesmaster sm
                where sm.SalseCustomer_IDNo = c.Customer_SlNo
                and sm.Status = 'a') as invoicePaid,

            (select ifnull(sum(cp.CPayment_amount), 0.00) 
                from tbl_customer_payment cp 
                where cp.CPayment_customerID = c.Customer_SlNo and cp.CPayment_TransactionType = 'CR'
                and cp.CPayment_status = 'a') as cashReceived,

            (select ifnull(sum(cp.CPayment_amount), 0.00) 
                from tbl_customer_payment cp 
                where cp.CPayment_customerID = c.Customer_SlNo 
                and cp.CPayment_TransactionType = 'CP'
                and cp.CPayment_status = 'a') as paidOutAmount,

            (select ifnull(sum(sr.SaleReturn_ReturnAmount), 0.00) 
                from tbl_salereturn sr 
                join tbl_salesmaster smr on smr.SaleMaster_InvoiceNo = sr.SaleMaster_InvoiceNo 
                where smr.SalseCustomer_IDNo = c.Customer_SlNo) as returnedAmount,

            (select invoicePaid + cashReceived) as paidAmount,

            (select (billAmount + paidOutAmount) - (paidAmount + returnedAmount)) as dueAmount
            
            from tbl_customer c
            where c.Customer_brunchid = $brunchId 
            $clauses) as tbl
            
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));

    }
    
    //     if($json==null){
    // 	      echo json_encode(array('contents'=>[['dueAmount' => "0"]]));
    // 	  }else{
    	      echo $json;
    // 	  }
  

  
?>
