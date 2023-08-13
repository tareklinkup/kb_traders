<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
        // s.Supplier_Mobile,
        // s.Supplier_Address,
        // s.contact_person,
        $brunchId = $_POST['brunchId'];
        $customerId = $_POST['suppliererId'];
    if(isset($customerId) && $customerId != 0) {
    $clauses .= " and s.Supplier_SlNo = $customerId";
}
$sql = "
    select
        s.Supplier_SlNo,
        s.Supplier_Code,
        s.Supplier_Name,
        s.Supplier_Mobile,
        s.Supplier_Address,
        
        (select (ifnull(sum(pm.PurchaseMaster_TotalAmount), 0.00) + ifnull(s.previous_due, 0.00)) from tbl_purchasemaster pm
            where pm.Supplier_SlNo = s.Supplier_SlNo
            and pm.status = 'a') as bill,
    
        (select ifnull(sum(pm2.PurchaseMaster_PaidAmount), 0.00) from tbl_purchasemaster pm2
            where pm2.Supplier_SlNo = s.Supplier_SlNo
            and pm2.status = 'a') as invoicePaid,
    
        (select ifnull(sum(sp.SPayment_amount), 0.00) from tbl_supplier_payment sp 
            where sp.SPayment_customerID = s.Supplier_SlNo 
            and sp.SPayment_TransactionType = 'CP'
            and sp.SPayment_status = 'a') as cashPaid,
            
        (select ifnull(sum(sp2.SPayment_amount), 0.00) from tbl_supplier_payment sp2 
            where sp2.SPayment_customerID = s.Supplier_SlNo 
            and sp2.SPayment_TransactionType = 'CR'
            and sp2.SPayment_status = 'a') as cashReceived,
    
        (select ifnull(sum(pr.PurchaseReturn_ReturnAmount), 0.00) from tbl_purchasereturn pr
            join tbl_purchasemaster rpm on rpm.PurchaseMaster_InvoiceNo = pr.PurchaseMaster_InvoiceNo
            where rpm.Supplier_SlNo = s.Supplier_SlNo) as returned,
        
        (select invoicePaid + cashPaid) as paid,
        
        (select (bill + cashReceived) - (paid + returned)) as due

    from tbl_supplier s
    where s.Supplier_brinchid = $brunchId
    and s.Supplier_Type != 'G'
    $clauses
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>
