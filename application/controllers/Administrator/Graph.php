<?php
    class Graph extends CI_Controller{
        public function __construct(){
            parent::__construct();
            $access = $this->session->userdata('userId');
            $this->branchId = $this->session->userdata('BRANCHid');
            if($access == '' ){
                redirect("Login");
            }
            $this->load->model('Model_table', "mt", TRUE);
        }
        
        public function graph(){
            $data['title'] = "Graph";
            $data['content'] = $this->load->view('Administrator/graph/graph', $data, true);
            $this->load->view('Administrator/index', $data);
        }

        public function getGraphData(){
            $inputs = json_decode($this->input->raw_input_stream);
            // Monthly Record
            $monthlyRecord = [];
            $year = date('Y');
            $month = date('m');
            $dayNumber = cal_days_in_month(CAL_GREGORIAN, $month, $year);
            for($i = 1; $i <= $dayNumber; $i++){
                $date = $year . '-' . $month . '-'. sprintf("%02d", $i);
                $query = $this->db->query("
                    select ifnull(sum(sm.SaleMaster_TotalSaleAmount), 0) as sales_amount 
                    from tbl_salesmaster sm 
                    where sm.SaleMaster_SaleDate = ?
                    and sm.Status = 'a'
                    and sm.SaleMaster_branchid = ?
                    group by sm.SaleMaster_SaleDate
                ", [$date, $this->branchId]);

                $amount = 0.00;

                if($query->num_rows() == 0){
                    $amount = 0.00;
                } else {
                    $amount = $query->row()->sales_amount;
                }
                $sale = [sprintf("%02d", $i), $amount];
                array_push($monthlyRecord, $sale);
            }

            $yearlyRecord = [];
            for($i = 1; $i <= 12; $i++) {
                $yearMonth = $year . sprintf("%02d", $i);
                $query = $this->db->query("
                    select ifnull(sum(sm.SaleMaster_TotalSaleAmount), 0) as sales_amount 
                    from tbl_salesmaster sm 
                    where extract(year_month from sm.SaleMaster_SaleDate) = ?
                    and sm.Status = 'a'
                    and sm.SaleMaster_branchid = ?
                    group by extract(year_month from sm.SaleMaster_SaleDate)
                ", [$yearMonth, $this->branchId]);

                $amount = 0.00;
                $monthName = date("M", mktime(0, 0, 0, $i, 10));

                if($query->num_rows() == 0){
                    $amount = 0.00;
                } else {
                    $amount = $query->row()->sales_amount;
                }
                $sale = [$monthName, $amount];
                array_push($yearlyRecord, $sale);
            }

            // Sales text for marquee
            $sales = $this->db->query("
                select 
                    concat(
                        'Invoice: ', sm.SaleMaster_InvoiceNo,
                        ', Customer: ', c.Customer_Code, ' - ', c.Customer_Name,
                        ', Amount: ', sm.SaleMaster_TotalSaleAmount,
                        ', Paid: ', sm.SaleMaster_PaidAmount,
                        ', Due: ', sm.SaleMaster_DueAmount
                    ) as sale_text
                from tbl_salesmaster sm 
                join tbl_customer c on c.Customer_SlNo = sm.SalseCustomer_IDNo
                where sm.Status = 'a'
                and sm.SaleMaster_branchid = ?
                order by sm.SaleMaster_SlNo desc limit 20
            ", $this->branchId)->result();

            // Today's Sale
            $todaysSale = $this->db->query("
                select 
                    ifnull(sum(ifnull(sm.SaleMaster_TotalSaleAmount, 0)), 0) as total_amount
                from tbl_salesmaster sm
                where sm.Status = 'a'
                and sm.SaleMaster_SaleDate = ?
                and sm.SaleMaster_branchid = ?
            ", [date('Y-m-d'), $this->branchId])->row()->total_amount;

            // This Month's Sale
            $thisMonthSale = $this->db->query("
                select 
                    ifnull(sum(ifnull(sm.SaleMaster_TotalSaleAmount, 0)), 0) as total_amount
                from tbl_salesmaster sm
                where sm.Status = 'a'
                and month(sm.SaleMaster_SaleDate) = ?
                and year(sm.SaleMaster_SaleDate) = ?
                and sm.SaleMaster_branchid = ?
            ", [date('m'), date('Y'), $this->branchId])->row()->total_amount;

            // Today's Cash Collection
            $todaysCollection = $this->db->query("
                select 
                ifnull((
                    select sum(ifnull(sm.SaleMaster_PaidAmount, 0)) 
                    from tbl_salesmaster sm
                    where sm.Status = 'a'
                    and sm.SaleMaster_branchid = " . $this->branchId . "
                    and sm.SaleMaster_SaleDate = '" . date('Y-m-d') . "'
                ), 0) +
                ifnull((
                    select sum(ifnull(cp.CPayment_amount, 0)) 
                    from tbl_customer_payment cp
                    where cp.CPayment_status = 'a'
                    and cp.CPayment_TransactionType = 'CR'
                    and cp.CPayment_brunchid = " . $this->branchId . "
                    and cp.CPayment_date = '" . date('Y-m-d') . "'
                ), 0) +
                ifnull((
                    select sum(ifnull(ct.In_Amount, 0)) 
                    from tbl_cashtransaction ct
                    where ct.status = 'a'
                    and ct.Tr_branchid = " . $this->branchId . "
                    and ct.Tr_date = '" . date('Y-m-d') . "'
                ), 0) as total_amount
            ")->row()->total_amount;

            // Cash Balance
            $cashBalance = $this->mt->getTransactionSummary()->cash_balance;

            // Top Customers
            $topCustomers = $this->db->query("
                select 
                c.Customer_Name as customer_name,
                ifnull(sum(sm.SaleMaster_TotalSaleAmount), 0) as amount
                from tbl_salesmaster sm 
                join tbl_customer c on c.Customer_SlNo = sm.SalseCustomer_IDNo
                where sm.SaleMaster_branchid = ?
                and sm.SaleMaster_SaleDate between ? and ?
                group by sm.SalseCustomer_IDNo
                order by amount desc 
                limit 5
            ", [$this->branchId, $inputs->fromDate, $inputs->toDate])->result();

            // Top Products
            $topProducts = $this->db->query("
                select 
                    p.Product_Name as product_name,
                    ifnull(sum(sd.SaleDetails_TotalQuantity), 0) as sold_quantity
                from tbl_saledetails sd
                join tbl_salesmaster sm on sm.SaleMaster_SlNo = sd.SaleMaster_IDNo
                join tbl_product p on p.Product_SlNo = sd.Product_IDNo
                where sm.SaleMaster_branchid = ?
                and sm.SaleMaster_SaleDate between ? and ?
                group by sd.Product_IDNo
                order by sold_quantity desc
                limit 5
            ", [$this->branchId, $inputs->fromDate, $inputs->toDate])->result();

            // Top paid customer
            $topPaidCustomer = $this->db->query("
                select 
                    *, 
                    sum(sales_paid + partial_payment)as total 
                from 
                    (
                        select 
                            sm.SalseCustomer_IDNo as customer_id,
                            c.Customer_Name as customer_name,
                            ifnull(sum(sm.SaleMaster_PaidAmount), 0) as sales_paid,
                            (
                                select 
                                    ifnull(sum(cp.CPayment_amount), 0)
                                from tbl_customer_payment as cp
                                where cp.CPayment_status = 'a'
                                and cp.CPayment_TransactionType = 'CR'
                                and cp.CPayment_customerID = sm.SalseCustomer_IDNo
                                and cp.CPayment_brunchid = ?
                                and cp.CPayment_date between ? and ?
                            )as partial_payment
                        from tbl_salesmaster sm 
                        join tbl_customer c on c.Customer_SlNo = sm.SalseCustomer_IDNo
                        where sm.SaleMaster_branchid = ?
                        and customer_name != ''
                        and sm.SaleMaster_SaleDate between ? and ?
                        group by sm.SalseCustomer_IDNo
                    )as tbl
                group by customer_id
                order by total desc
                limit 5
            ", [$this->branchId, $inputs->fromDate, $inputs->toDate, $this->branchId, $inputs->fromDate, $inputs->toDate])->result();

            // Customer Due
            $customerDueResult = $this->mt->customerDue();
            $customerDue = array_sum(array_map(function($due) {
                return $due->dueAmount;
            }, $customerDueResult));

            // Bank balance
            $bankTransactions = $this->mt->getBankTransactionSummary();
            $bankBalance = array_sum(array_map(function($bank){
                return $bank->balance;
            }, $bankTransactions));

            // Current stock value
            $stockValue = $this->db->query("
                select sum(stock_value)as total_stock_value from
                (
                    select (
                        select 
                            (
                                ci.purchase_quantity + ci.sales_return_quantity + ci.transfer_to_quantity) -  		      		            		(ci.sales_quantity + ci.purchase_return_quantity + ci.damage_quantity + ci.transfer_from_quantity)
                            ) as current_quantity,
                                (select (p.Product_Purchase_Rate * current_quantity)) as stock_value
                        from tbl_currentinventory ci
                        join tbl_product p on p.Product_SlNo = ci.product_id
                        where p.status = 'a'
                        and p.is_service = 'false'
                        and ci.branch_id = ?
                ) as tbl where stock_value != 0
            ", $this->branchId)->row();

            // Total supplier
            $supplierDue = $this->db->query("
                select sum(due)as total_supplier_due from (
                    select
                        s.Supplier_SlNo,
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
                    where s.Supplier_brinchid = ?
                )as tbl
            ", $this->branchId)->row();

            $responseData = [
                'monthly_record' => $monthlyRecord,
                'yearly_record' => $yearlyRecord,
                'sales_text' => $sales,
                'todays_sale' => $todaysSale,
                'this_month_sale' => $thisMonthSale,
                'todays_collection' => $todaysCollection,
                'cash_balance' => $cashBalance,
                'top_customers' => $topCustomers,
                'top_paid_customer' => $topPaidCustomer,
                'top_products' => $topProducts,
                'customer_due' => $customerDue,
                'bank_balance' => $bankBalance,
                'stock_value' => $stockValue->total_stock_value,
                'supplier_due' => $supplierDue->total_supplier_due
            ];

            echo json_encode($responseData, JSON_NUMERIC_CHECK);
        }
    }
?>