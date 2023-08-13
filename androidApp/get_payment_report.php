<?php
require_once('db.php');
// Create connection
$conn = mysqli_connect($servername, $username, $password, $dbname);
mysqli_set_charset($conn,'utf8');
//$brunchId = $_POST['brunchId'];
// customer ladger
    $res = new stdClass();
    // $customerId = $_POST['customerId'];
    $customerId =$_POST['customerId'];
    $dateFrom = $_POST['dateFrom'];
    $dateTo = $_POST['dateTo'];
    $branchId = $_POST['brunchId'];
    $previousDueSql = "select ifnull(previous_due, 0.00) as previous_due from tbl_customer where Customer_SlNo = $customerId";
    $previousDueQuery = mysqli_query($conn, $previousDueSql);
    
    $paymentSql = "
        select 
            'a' as sequence,
            sm.SaleMaster_SlNo as id,
            sm.SaleMaster_SaleDate as date,
            concat('Sales ', sm.SaleMaster_InvoiceNo) as description,
            sm.SaleMaster_TotalSaleAmount as bill,
            sm.SaleMaster_PaidAmount as paid,
            sm.SaleMaster_DueAmount as due,
            0.00 as returned,
            0.00 as paid_out,
            0.00 as balance
        from tbl_salesmaster sm
        where sm.SalseCustomer_IDNo = '$customerId'
        and sm.Status = 'a'
        
        UNION
        select
            'b' as sequence,
            cp.CPayment_id as id,
            cp.CPayment_date as date,
            concat('Received - ', 
                case cp.CPayment_Paymentby
                    when 'bank' then concat('Bank - ', ba.account_name, ' - ', ba.account_number, ' - ', ba.bank_name)
                    when 'By Cheque' then 'Cheque'
                    else 'Cash'
                end, ' ', cp.CPayment_notes
            ) as description,
            0.00 as bill,
            cp.CPayment_amount as paid,
            0.00 as due,
            0.00 as returned,
            0.00 as paid_out,
            0.00 as balance
        from tbl_customer_payment cp
        left join tbl_bank_accounts ba on ba.account_id = cp.account_id
        where cp.CPayment_TransactionType = 'CR'
        and cp.CPayment_customerID = '$customerId'
        and cp.CPayment_status = 'a'

        UNION
        select
            'c' as sequence,
            cp.CPayment_id as id,
            cp.CPayment_date as date,
            concat('Paid - ', 
                case cp.CPayment_Paymentby
                    when 'bank' then concat('Bank - ', ba.account_name, ' - ', ba.account_number, ' - ', ba.bank_name)
                    else 'Cash'
                end, ' ', cp.CPayment_notes
            ) as description,
            0.00 as bill,
            0.00 as paid,
            0.00 as due,
            0.00 as returned,
            cp.CPayment_amount as paid_out,
            0.00 as balance
        from tbl_customer_payment cp
        left join tbl_bank_accounts ba on ba.account_id = cp.account_id
        where cp.CPayment_TransactionType = 'CP'
        and cp.CPayment_customerID = '$customerId'
        and cp.CPayment_status = 'a'
        
        UNION
        select
            'd' as sequence,
            sr.SaleReturn_SlNo as id,
            sr.SaleReturn_ReturnDate as date,
            'Sales return' as description,
            0.00 as bill,
            0.00 as paid,
            0.00 as due,
            sr.SaleReturn_ReturnAmount as returned,
            0.00 as paid_out,
            0.00 as balance
        from tbl_salereturn sr
        join tbl_salesmaster smr on smr.SaleMaster_InvoiceNo  = sr.SaleMaster_InvoiceNo
        where smr.SalseCustomer_IDNo = '$customerId'
        
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

        $newPayments = array_filter($newPayments, function($payment) use ($dateFrom, $dateTo){
            if($payment['date'] >= $dateFrom && $payment['date'] <= $dateTo){
                return true;
            }else{
                return false;
            }
        });
            

    }
    $res->previousBalance = $previousBalance;
    $res->payments = $newPayments;
    echo json_encode($res);

// customer ladger

// $sql = "

// ";
//     $run = mysqli_query($conn,$sql);
//     while($data = mysqli_fetch_assoc($run)){
//     	$item[] = $data ;
//     	$json = json_encode(array('contents'=>$item));
//     }
//     echo $json ;

  
?>
