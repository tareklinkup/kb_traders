<?php
require_once('db.php');

// purchase master
    $data = json_decode($_POST['purchase']);
    $cart = json_decode($_POST['cartProducts']);
    
    $Supplier_IDNo = $data->supplierId;
    $employee_id = $data->employeeId;
    $PurchaseMaster_SaleDate = $data->purchaseDate;
    $PurchaseMaster_Description = $data->note;
    $PurchaseMaster_TotalSaleAmount = $data->total;
    $PurchaseMaster_TotalDiscountAmount = $data->discount;
    $PurchaseMaster_TaxAmount = $data->vat;
    $PurchaseMaster_SubTotalAmount = $data->subTotal;
    $PurchaseMaster_PaidAmount = $data->paid;
    $PurchaseMaster_DueAmount = $data->due;
    $PurchaseMaster_Previous_Due = $data->previousDue;

    $branchId = $data->branchId;
    $addBy = $data->addBy;
    $addTime = date("Y-m-d H:i:s");
//  echo $addTime;
// 	exit;
    
    $branchNo = strlen($branchId) < 10 ? '0' . $branchId : $branchId;
    $invoice = date('y') . $branchNo . "00001";
    $year = date('y');
    $invoiceSql = "select * from tbl_purchasemaster sm where sm.PurchaseMaster_InvoiceNo like '$year%' and PurchaseMaster_BranchID = $branchId";
    $sales = mysqli_query($conn, $invoiceSql);
    $count = mysqli_num_rows($sales);
    if($count > 0){
        $row = mysqli_fetch_assoc($sales);
        $newSalesId = $row['PurchaseMaster_SlNo'] + 1;
        $zeros = array('0', '00', '000', '0000');
        $invoice = date('y') . $branchNo . (strlen($newSalesId) > count($zeros) ? $newSalesId : $zeros[count($zeros) - strlen($newSalesId)] . $newSalesId);
	}

// 	echo"$invoice";
// 	exit;
$sql = "
    INSERT INTO tbl_purchasemaster (
        PurchaseMaster_InvoiceNo, Supplier_SlNo, Employee_SlNo, PurchaseMaster_OrderDate, PurchaseMaster_Description,
        PurchaseMaster_TotalAmount,PurchaseMaster_DiscountAmount,PurchaseMaster_Tax, PurchaseMaster_SubTotalAmount,
        PurchaseMaster_PaidAmount, PurchaseMaster_DueAmount, previous_due, PurchaseMaster_BranchID,AddBy,AddTime
    )
    values('$invoice', '$Supplier_IDNo','$employee_id','$PurchaseMaster_SaleDate',
        '$PurchaseMaster_Description','$PurchaseMaster_TotalSaleAmount','$PurchaseMaster_TotalDiscountAmount','$PurchaseMaster_TaxAmount','$PurchaseMaster_SubTotalAmount',
        '$PurchaseMaster_PaidAmount','$PurchaseMaster_DueAmount','$PurchaseMaster_Previous_Due', $branchId,$addBy,$addTime)
    ";
$run = mysqli_query($conn,$sql);

 $purchaseMasterId = mysqli_insert_id($conn);


// purchase details

foreach($cart as $value) {
 
    
    $salesDetails = "insert into  tbl_purchasedetails (PurchaseMaster_IDNo, Product_IDNo, cat_id, PurchaseDetails_TotalQuantity, PurchaseDetails_Rate, PurchaseDetails_TotalAmount, PurchaseDetails_branchID, Status)
        values('$purchaseMasterId', '$value->productId', '$value->cat_id', '$value->quantity', '$value->purchaseRate', '$value->total', '$value->PurchaseDetails_branchID', 'a')
    ";
    mysqli_query($conn,$salesDetails);
    
    // update current inventory purchase quantity
    $updateCurrentInventroy = "update tbl_currentinventory  set purchase_quantity = purchase_quantity + $value->quantity  where product_id = $value->productId and branch_id = $value->PurchaseDetails_branchID";
    mysqli_query($conn,$updateCurrentInventroy);
}


if($run==true){
	echo"Successfull";
//	echo json_encode($cart);
}
else{
    echo "Failed";
}

?>
