<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
//$brunchId = $_POST['brunchId'];
// customer ladger
    $res = new stdClass();
    // $customerId = $_POST['customerId'];
    $supplierId =$_POST['customerId'];
    $dateFrom = $_POST['dateFrom'];
    $dateTo = $_POST['dateTo'];
    $branchId =$_POST['brunchId'];
    $previousDueSql = "select ifnull(previous_due, 0.00) as previous_due from tbl_supplier where Supplier_SlNo = '$supplierId'";
    $previousDueQuery = mysqli_query($conn, $previousDueSql);
     
    //  echo $dateTo;
    //  exit;
    $paymentSql = "
                 select
                'a' as sequence,
                    pm.PurchaseMaster_SlNo as id,
                    pm.PurchaseMaster_OrderDate as date,
                    concat('Purchase ', pm.PurchaseMaster_InvoiceNo) as description,
                    pm.PurchaseMaster_TotalAmount as bill,
                    pm.PurchaseMaster_PaidAmount as paid,
                    (pm.PurchaseMaster_TotalAmount - pm.PurchaseMaster_PaidAmount) as due,
                    0.00 as returned,
                    0.00 as cash_received,
                    0.00 as balance
                from tbl_purchasemaster pm
                where pm.Supplier_SlNo = '$supplierId'
                and pm.status = 'a'
            
            UNION
            select
                'b' as sequence,
                sp.SPayment_id as id,
                sp.SPayment_date as date,
                concat('Paid - ', 
                    case sp.SPayment_Paymentby
                        when 'bank' then concat('Bank - ', ba.account_name, ' - ', ba.account_number, ' - ', ba.bank_name)
                        else 'Cash'
                    end, ' ', sp.SPayment_notes
                ) as description,
                0.00 as bill,
                sp.SPayment_amount as paid,
                0.00 as due,
                0.00 as returned,
                0.00 as cash_received,
                0.00 as balance
            from tbl_supplier_payment sp 
            left join tbl_bank_accounts ba on ba.account_id = sp.account_id
            where sp.SPayment_customerID = '$supplierId'
            and sp.SPayment_TransactionType = 'CP'
            and sp.SPayment_status = 'a'
            
            UNION
            select 
                'c' as sequence,
                sp2.SPayment_id as id,
                sp2.SPayment_date as date,
                concat('Received - ', 
                    case sp2.SPayment_Paymentby
                        when 'bank' then concat('Bank - ', ba.account_name, ' - ', ba.account_number, ' - ', ba.bank_name)
                        else 'Cash'
                    end, ' ', sp2.SPayment_notes
                ) as description,
                0.00 as bill,
                0.00 as paid,
                0.00 as due,
                0.00 as returned,
                sp2.SPayment_amount as cash_received,
                0.00 as balance
            from tbl_supplier_payment sp2
            left join tbl_bank_accounts ba on ba.account_id = sp2.account_id
            where sp2.SPayment_customerID = '$supplierId'
            and sp2.SPayment_TransactionType = 'CR'
            and sp2.SPayment_status = 'a'
            
            UNION
            select
                'd' as sequence,
                pr.PurchaseReturn_SlNo as id,
                pr.PurchaseReturn_ReturnDate as date,
                'Purchase Return' as description,
                0.00 as bill,
                0.00 as paid,
                0.00 as due,
                pr.PurchaseReturn_ReturnAmount as returned,
                0.00 as cash_received,
                0.00 as balance
            from tbl_purchasereturn pr
            where pr.Supplier_IDdNo = '$supplierId'
            
            order by date, sequence, id
        ";
 
    $paymentRunQuery = mysqli_query($conn, $paymentSql);
    // $payments = mysqli_fetch_assoc($paymentRunQuery);   
    
    
    $previous = mysqli_fetch_object($previousDueQuery);
    $previousBalance = $previous->previous_due;  

    $payments = mysqli_fetch_all($paymentRunQuery, MYSQLI_ASSOC);
    
    $newPayments = [];
    
    foreach($payments as $key => $payment) {
        
        $lastBalance = $key == 0 ? $previous->previous_due : $newPayments[$key - 1]['balance'];
        $payment['balance'] = ($lastBalance + $payment['bill'] + $payment['paid_out']) - ($payment['paid'] + $payment['returned']);
        
        array_push($newPayments, $payment);

    }
    
    if((isset($dateFrom) && $dateFrom != null) && (isset($dateTo) && $dateTo != null)){
        $previousPayments = array_filter($newPayments, function($payment) use ($dateFrom){
            return $payment['date'] < $dateFrom;
        });
        

        $previousBalance = count($previousPayments) > 0 ? $previousPayments[count($previousPayments) - 1]['balance'] : $previousBalance;

        $payments = array_filter($newPayments, function($payment) use ($dateFrom, $dateTo){
            if($payment['date'] >= $dateFrom && $payment['date'] <= $dateTo){
                return true;
            } else {
                return false;
            }
        });
        
        $newPayments = array_values($payments);

    }
  
    $res->previousBalance = $previousBalance;
    $res->payments = $newPayments;
    echo json_encode($res);
    // echo json_encode(mysqli_error($conn));


  
?>
