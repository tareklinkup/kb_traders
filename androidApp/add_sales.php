<?php
require_once('db.php');

// sales master
    $data = json_decode($_POST['sales']);
    $cart = json_decode($_POST['cart']);
    
    $SalseCustomer_IDNo = $data->customerId;
    $employee_id = $data->employeeId;
    $SaleMaster_SaleDate = $data->salesDate;
    $SaleMaster_Description = $data->note;
    $SaleMaster_SaleType = $data->salesType;
    $SaleMaster_TotalSaleAmount = $data->total;
    $SaleMaster_TotalDiscountAmount = $data->discount;
    $SaleMaster_TaxAmount = $data->vat;
    // $SaleMaster_Freight = $data->SaleMaster_Freight;
    $SaleMaster_SubTotalAmount = $data->subTotal;
    $SaleMaster_PaidAmount = $data->paid;
    $SaleMaster_DueAmount = $data->due;
    $SaleMaster_Previous_Due = $data->previousDue;
    $is_service = $data->isService;
    $addBy = $data->addBy;
    $addTime = date("Y-m-d H:i:s");

    $branchId = $data->branchId;
    $branchNo = strlen($branchId) < 10 ? '0' . $branchId : $branchId;
    $invoice = date('y') . $branchNo . "00001";
    $year = date('y');
    $invoiceSql = "select * from tbl_salesmaster sm where sm.SaleMaster_InvoiceNo like '$year%' and SaleMaster_branchid = $branchId";
    $sales = mysqli_query($conn, $invoiceSql);
    $count = mysqli_num_rows($sales);
    if($count > 0){
        $row = mysqli_fetch_assoc($sales);
        $newSalesId = $row['SaleMaster_SlNo'] + 1;
        $zeros = array('0', '00', '000', '0000');
        $invoice = date('y') . $branchNo . (strlen($newSalesId) > count($zeros) ? $newSalesId : $zeros[count($zeros) - strlen($newSalesId)] . $newSalesId);
	}
	

$sql = "
    INSERT INTO tbl_salesmaster (
        SaleMaster_InvoiceNo, SalseCustomer_IDNo, employee_id, SaleMaster_SaleDate, SaleMaster_Description, SaleMaster_SaleType,
        SaleMaster_TotalSaleAmount,SaleMaster_TotalDiscountAmount,SaleMaster_TaxAmount, SaleMaster_SubTotalAmount,
        SaleMaster_PaidAmount, SaleMaster_DueAmount, SaleMaster_Previous_Due, is_service, SaleMaster_branchid,AddBy,AddTime
    )
    values('$invoice', '$SalseCustomer_IDNo','$employee_id','$SaleMaster_SaleDate',
'$SaleMaster_Description','$SaleMaster_SaleType','$SaleMaster_TotalSaleAmount','$SaleMaster_TotalDiscountAmount','$SaleMaster_TaxAmount','$SaleMaster_SubTotalAmount',
'$SaleMaster_PaidAmount','$SaleMaster_DueAmount','$SaleMaster_Previous_Due','$is_service','$branchId','$addBy','$addTime')
";
$run = mysqli_query($conn,$sql);

$salesMasterId = mysqli_insert_id($conn);

// sales details

foreach($cart as $value) {

    $salesDetails = "insert into  tbl_saledetails (SaleMaster_IDNo, Product_IDNo,cat_id, SaleDetails_TotalQuantity, Purchase_Rate, SaleDetails_Rate, SaleDetails_TotalAmount, Status, SaleDetails_BranchId)
        values('$salesMasterId', '$value->productId', '$value->cat_id', '$value->quantity', '$value->purchaseRate', '$value->salesRate', '$value->total','a','$value->SaleDetails_BranchId')
    ";
    mysqli_query($conn,$salesDetails);
    
    // update current inventory purchase quantity
     $updateCurrentInventroy = "update tbl_currentinventory  set sales_quantity = sales_quantity + $value->quantity  where product_id = $value->productId and branch_id = $value->SaleDetails_BranchId";
     
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
