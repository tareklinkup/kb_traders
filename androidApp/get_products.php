<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$branchId = $_POST['brunchId'];
$categoryId = $_POST['categoryID'];
$productId = $_POST['productId'];
// $sql = "
//     select
//         p.*,
//         concat(p.Product_Name, ' - ', p.Product_Code) as display_text,
//         pc.ProductCategory_Name,
//         br.brand_name,
//         u.Unit_Name
//     from tbl_product p
//     left join tbl_productcategory pc on pc.ProductCategory_SlNo = p.ProductCategory_ID
//     left join tbl_brand br on br.brand_SiNo = p.brand
//     left join tbl_unit u on u.Unit_SlNo = p.Unit_ID
//     where p.status = 'a' and
//     p.ProductCategory_ID = $categoryId
//     order by p.Product_SlNo desc
// ";


        $clauses = "";
        if(isset($categoryId) && $categoryId != null){
            $clauses .= " and p.ProductCategory_ID = '$categoryId'";
        }

        if(isset($productId) && $productId != null){
            $clauses .= " and p.Product_SlNo = '$productId'";
        }

        if(isset($brandId) && $brandId != null){
            $clauses .= " and p.brand = '$brandId'";
        }

  $sql = "
    select
        p.*,
        pc.ProductCategory_Name,
        b.brand_name,
        u.Unit_Name,
        br.Brunch_name,
        (select ifnull(sum(pd.PurchaseDetails_TotalQuantity), 0) 
                from tbl_purchasedetails pd 
                where pd.Product_IDNo = p.Product_SlNo
                and pd.Status = 'a' and  pd.PurchaseDetails_branchID=$branchId) as purchased_quantity,
                
        (select ifnull(sum(prd.PurchaseReturnDetails_ReturnQuantity), 0) 
                from tbl_purchasereturndetails prd 
                where prd.PurchaseReturnDetailsProduct_SlNo = p.Product_SlNo
                and prd.PurchaseReturnDetails_brachid=$branchId
                ) as purchase_returned_quantity,
                
        (select ifnull(sum(sd.SaleDetails_TotalQuantity), 0) 
                from tbl_saledetails sd
                where sd.Product_IDNo = p.Product_SlNo
               
                and sd.Status = 'a' and 
                sd.SaleDetails_BranchId=$branchId ) as sold_quantity,
                
        (select ifnull(sum(srd.SaleReturnDetails_ReturnQuantity), 0)
                from tbl_salereturndetails srd 
                where srd.SaleReturnDetailsProduct_SlNo = p.Product_SlNo
                and srd.SaleReturnDetails_brunchID=$branchId
                ) as sales_returned_quantity,
                
                (select ifnull(sum(dmd.DamageDetails_DamageQuantity), 0) 
                from tbl_damagedetails dmd
                join tbl_damage dm on dm.Damage_SlNo = dmd.Damage_SlNo
                where dmd.Product_SlNo = p.Product_SlNo
                and dmd.branch_id = '$branchId') as damaged_quantity,
    
                (select ifnull(sum(trd.quantity), 0)
                from tbl_transferdetails trd
                join tbl_transfermaster tm on tm.transfer_id = trd.transfer_id
                where trd.product_id = p.Product_SlNo
                and tm.transfer_from = '$branchId') as transferred_from_quantity,

        (select ifnull(sum(trd.quantity), 0)
                from tbl_transferdetails trd
                join tbl_transfermaster tm on tm.transfer_id = trd.transfer_id
                where trd.product_id = p.Product_SlNo
                and tm.transfer_to = '$branchId') as transferred_to_quantity,
                
        (select (purchased_quantity + sales_returned_quantity + transferred_to_quantity) - (sold_quantity + purchase_returned_quantity + damaged_quantity + transferred_from_quantity)) as current_quantity,
        (select p.Product_Purchase_Rate * current_quantity) as stock_value
    from tbl_product p
    left join tbl_productcategory pc on pc.ProductCategory_SlNo = p.ProductCategory_ID
    left join tbl_brand b on b.brand_SiNo = p.brand
    left join tbl_unit u on u.Unit_SlNo = p.Unit_ID 
    left join tbl_brunch br on br.brunch_id = $branchId
    where p.status = 'a' and p.is_service = 'false'
    $clauses
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>
