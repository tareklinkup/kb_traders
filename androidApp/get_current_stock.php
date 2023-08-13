<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
$brunchId = $_POST['brunchId'];
$sql = "
    select * from(
        select
            ci.*,
            (select (ci.purchase_quantity + ci.sales_return_quantity + ci.transfer_to_quantity) - (ci.sales_quantity + ci.purchase_return_quantity + ci.damage_quantity + ci.transfer_from_quantity)) as current_quantity,
            p.Product_Name,
            p.Product_Code,
            p.Product_ReOrederLevel,
            (select (p.Product_Purchase_Rate * current_quantity)) as stock_value,
            pc.ProductCategory_Name,
            b.brand_name,
            u.Unit_Name
        from tbl_currentinventory ci
        join tbl_product p on p.Product_SlNo = ci.product_id
        left join tbl_productcategory pc on pc.ProductCategory_SlNo = p.ProductCategory_ID
        left join tbl_brand b on b.brand_SiNo = p.brand
        left join tbl_unit u on u.Unit_SlNo = p.Unit_ID
        where p.status = 'a'
        and p.is_service = 'false'
        and ci.branch_id = $brunchId
    ) as tbl
            where 1 = 1
";
    $run = mysqli_query($conn,$sql);
    while($data = mysqli_fetch_assoc($run)){
    	$item[] = $data ;
    	$json = json_encode(array('contents'=>$item));
    }
    echo $json ;

  
?>
