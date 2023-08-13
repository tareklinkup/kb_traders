<style>
	#balanceSheet .buttons {
		margin-top: -5px;
	}

	.balancesheet-table{
		width: 100%;
		border-collapse: collapse;
	}

	.balancesheet-table thead{
		text-align: center;
	}

	.balancesheet-table tfoot{
		font-weight: bold;
		background-color: #eaf3fd;
	}

	.balancesheet-table td, .balancesheet-table th{
		border: 1px solid #ccc;
		padding: 5px;
	}
</style>
<div id="balanceSheet">
	<div class="row" style="border-bottom: 1px solid #ccc;">
		<div class="col-md-12">
			<form action="" class="form-inline" @submit.prevent="getStatements">
				<div class="form-group">
					<input type="date" class="form-control" v-model="date">
				</div>

				<div class="form-group buttons">
					<input type="submit" value="Search">
				</div>
			</form>
		</div>
	</div>

	<div style="display:none;" v-bind:style="{display: showReport ? '' : 'none'}">
		<div class="row" style="margin-top:15px;">
			<div class="col-xs-12">
				<a href="" @click.prevent="print"><i class="fa fa-print"></i> Print</a>
			</div>
		</div>

		<div id="printContent">
			<div class="row" style="margin-top:15px;">
				<div class="col-xs-6">
					<table class="balancesheet-table">
						<thead>
							<tr>
								<td colspan="2">
									<h3>Asset</h3>
								</td>
							</tr>
						</thead>
						<tbody>
							<!-- <tr>
								<th>Asset</th>
								<td style="text-align:right;">{{assets | decimal}}</td>
							</tr> -->
							<tr>
								<th>Cash</th>
								<td style="text-align:right;">{{cash_balance | decimal}}</td>
							</tr>
							<tr>
								<td>	
									<table style="width: 100%;">
										<tr>
											<th colspan="2">Bank:-</th>
										</tr>
										<tr v-for="account in bank_accounts">
											<td style="width: 75%;">{{account.account_name}}, {{account.bank_name}} ({{account.account_number}})</td>
											<td>{{account.balance}}</td>
										</tr>
									</table>
								</td>
								<td style="text-align:right;">{{bank_balance | decimal}}</td>
							</tr>

							<tr>
								<td>	
									<table style="width: 100%;">
										<tr>
											<th colspan="2">Customer Due:-</th>
										</tr>
										<tr>
											<td style="width: 75%;">Wholesale Due</td>
											<td>{{wholesale_due | decimal}}</td>
										</tr>
										<tr>
											<td>Reatil Due</td>
											<td>{{retail_due | decimal}}</td>
										</tr>
										<tr>
											<td>Bad Debt</td>
											<td>{{bad_debt | decimal}}</td>
										</tr>
									</table>
								</td>
								<td style="text-align:right;">{{customer_due + bad_debt | decimal}}</td>
							</tr>

							<!-- <tr>
								<th>Customer Due</th>
								<td style="text-align:right;">{{customer_due | decimal}}</td>
							</tr> -->
							
							<!-- <tr>
								<th>Bad Debt</th>
								<td style="text-align:right;">{{bad_debt | decimal}}</td>
							</tr> -->

							<tr>
								<td>	
									<table style="width: 100%;">
										<tr>
											<th colspan="2">Stock Value:-</th>
										</tr>
										
										<tr v-if="branchId == 1">
											<td style="width: 75%;">KB AGRO FOOD</td>
											<td>{{ kbEnterprise.agrofood ? parseFloat(kbEnterprise.agrofood).toFixed(2) : 0 }}</td>
										</tr>
										<tr v-if="branchId == 1">
											<td style="width: 75%;">চাউল গোডাউন নং ২</td>
											<td>{{ kbEnterprise.challgodwon2 ? parseFloat(kbEnterprise.challgodwon2).toFixed(2) : 0 }}</td>
										</tr>
										<tr v-if="branchId == 1">
											<td>চাউল গোডাউন নং ৩</td>
											<td>{{ kbEnterprise.challgodwon3 ? parseFloat(kbEnterprise.challgodwon3).toFixed(2) : 0}}</td>
										</tr>

										<tr v-if="branchId == 5">
											<td style="width: 75%;">KB ENTERPRISE</td>
											<td>{{ kbEnterprise.enterprise ? parseFloat(kbEnterprise.enterprise).toFixed(2) : 0 }}</td>
										</tr>
										<tr v-if="branchId == 5">
											<td>সিমেন্ট গোডাউন নং ২</td>
											<td>{{ kbEnterprise.sementgodwon2 ? parseFloat(kbEnterprise.sementgodwon2).toFixed(2) : 0}}</td>
										</tr>

										
									</table>
								</td>
								<td v-if="branchId != 5 && branchId != 1" style="text-align:right;">{{stock_value | decimal}}</td>
								<td v-if="branchId == 1">{{ agroFoodTotalStockValue | decimal }}</td>
								<td v-if="branchId == 5">{{ kbEnterPriseTotalStockValue | decimal }}</td>
							</tr>

							
							<!-- <tr>
								<th>Stock Value</th>
								<td style="text-align:right;">{{stock_value | decimal}}</td>
							</tr> -->
							
							<!-- <tr>
								<th>Supplier Previous Due Adjustment</th>
								<td style="text-align:right;">{{supplier_prev_due | decimal}}</td>
							</tr> -->
							
							
							<!-- <tr>
								<th>Loss</th>
								<td style="text-align:right;">{{loss | decimal}}</td>
							</tr> -->
						</tbody>
						<tfoot>
							<tr>
								<th style="text-align:right;">Total Asset</th>
								<td style="text-align:right;">{{totalAsset | decimal}}</td>
							</tr>
						</tfoot>
					</table>
				</div>

				<div class="col-xs-6">
					<table class="balancesheet-table">
						<thead>
							<tr>
								<td colspan="2">
									<h3>Liability</h3>
								</td>
							</tr>
						</thead>
						<tbody>
							<!-- <tr>
								<td>	
									<table style="width: 100%;">
										<tr>
											<th colspan="2">Investment:-</th>
										</tr>
										<tr v-for="account in invest_accounts">
											<td>{{account.Acc_Name}} ({{account.Acc_Code}})</td>
											<td>{{account.balance}}</td>
										</tr>
									</table>
								</td>
								<td style="text-align:right;">{{invest_balance | decimal}}</td>
							</tr> -->

							<!-- <tr>
								<td>	
									<table style="width: 100%;">
										<tr>
											<th colspan="2">Loan:-</th>
										</tr>
										<tr v-for="account in loan_accounts">
											<td>{{account.account_name}}, {{account.bank_name}} ({{account.account_number}})</td>
											<td>{{account.balance}}</td>
										</tr>
									</table>
								</td>
								<td style="text-align:right;">{{loan_balance | decimal}}</td>
							</tr> -->
							<tr>
								<td>	
									<table style="width: 100%;">
										<tr>
											<th colspan="2">Supplier Due:-</th>
										</tr>
										<tr v-for="supplier in supplier_dues">
											<td style="width: 75%;">{{supplier.Supplier_Code}} - {{supplier.Supplier_Name}}</td>
											<td>{{supplier.due}}</td>
										</tr>
									</table>
								</td>
								<td style="text-align:right;">{{total_supplier_due | decimal}}</td>
							</tr>

							<!-- <tr>
								<th>Customer Previous Due Adjustment</th>
								<td style="text-align:right;">{{customer_prev_due | decimal}}</td>
							</tr> -->
							
							<!-- <tr>
								<th>Profit</th>
								<td style="text-align:right;">{{net_profit}}</td>
							</tr> -->
							
						</tbody>
						<tfoot>
							<tr>
								<th style="text-align:right;">Total Liability</th>
								<td style="text-align:right;">{{totalLiability | decimal}}</td>
							</tr>
						</tfoot>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div style="display:none;" v-bind:style="{display: showReport == false ? '' : 'none'}">
		<div class="row">
			<div class="col-md-12 text-center">
				<img src="/assets/loader.gif" alt="">
			</div>
		</div>
	</div>
</div>

<script src="<?php echo base_url(); ?>assets/js/vue/vue.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/vue/axios.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/moment.min.js"></script>

<script>
	new Vue({
		el: '#balanceSheet',
		data() {
			return {
				date: moment().format('YYYY-MM-DD'),
				assets: 0.00,
				cash_balance: 0.00,
				bank_balance: 0.00,
				bank_accounts: [],
				customer_due: 0.00,
				wholesale_due: 0.00,
				retail_due: 0.00,
				bad_debt: 0.00,
				// supplier_prev_due: 0.00,
				// customer_prev_due: 0.00,
				stock_value: 0.00,
				invest_balance: 0.00,
				invest_accounts: [],
				loan_balance: 0.00,
				loan_accounts: [],
				supplier_dues: [],
				total_supplier_due: 0.00,
				// net_profit: 0.00,
				// loss: 0.00,
				showReport: null,
				branchId: '<?php echo $this->session->userdata("BRANCHid")?>',
				kbEnterprise: []
			}
		},
		filters: {
			decimal(value) {
				return value == null ? 0.00 : parseFloat(value).toFixed(2);
			}
		},
		computed: {
			totalAsset() {
				return parseFloat(this.assets) +
					parseFloat(this.cash_balance) +
					parseFloat(this.bank_balance) +
					parseFloat(this.customer_due) +
					parseFloat(this.bad_debt) +
					// parseFloat(this.supplier_prev_due) +
					// parseFloat(this.loss) +
					parseFloat(this.stockValue);
			},
			stockValue() {
				$stockValue = 0;

				if(this.branchId != 5 && this.branchId != 1) {
					$stockValue = this.stock_value;
				} else if(this.branchId == 1) {
					$stockValue = this.agroFoodTotalStockValue;
				} else if(this.branchId == 5) {
					$stockValue = this.kbEnterPriseTotalStockValue;
				}
				return $stockValue;
			},
			totalLiability() {
				return parseFloat(this.invest_balance) +
					parseFloat(this.loan_balance) +
					// parseFloat(this.net_profit) +
					// parseFloat(this.customer_prev_due) +
					parseFloat(this.total_supplier_due);
			},
			kbEnterPriseTotalStockValue() {
				return parseFloat(this.kbEnterprise.enterprise) + parseFloat(this.kbEnterprise.sementgodwon2);
			},
			agroFoodTotalStockValue() {
				return parseFloat(this.kbEnterprise.agrofood) + parseFloat(this.kbEnterprise.challgodwon2) + parseFloat(this.kbEnterprise.challgodwon3);
			}
		},
		methods: {
			async getStatements() {
				this.showReport = false;
				await axios.post('/get_balance_report', {date : this.date})
				.then(res => {
					if(res.data.success){

						// kbenterprise
						this.kbEnterprise = res.data.statements.kbenterprise;


						// if(res.data.statements.net_profit){
						// 	if(res.data.statements.net_profit >= 0){
						// 		this.net_profit = res.data.statements.net_profit;
						// 		this.loss = 0.00;
						// 	}else{
						// 		this.loss = Math.abs(res.data.statements.net_profit);
						// 		this.net_profit = 0.00;
						// 	}
						// }

						// this.assets 			= res.data.statements.assets ?? 0;
						this.cash_balance		= res.data.statements.cash_balance ?? 0;
						this.bank_accounts 		= res.data.statements.bank_accounts;					
						this.customer_due 		= res.data.statements.customer_dues ?? 0;
						this.wholesale_due 		= res.data.statements.wholesale_dues ?? 0;
						this.retail_due			= res.data.statements.retail_dues ?? 0;
						this.bad_debt 			= res.data.statements.bad_debts ?? 0;
						// this.supplier_prev_due 	= res.data.statements.supplier_prev_due ?? 0;
						// this.customer_prev_due 	= res.data.statements.customer_prev_due ?? 0;
						this.stock_value 		= res.data.statements.stock_value ?? 0;
						// this.invest_accounts	= res.data.statements.invest_accounts;					
						// this.loan_accounts 		= res.data.statements.loan_accounts;					
						this.supplier_dues 		= res.data.statements.supplier_dues.filter((supplier)=> supplier.due != 0);
						this.total_supplier_due = res.data.statements.total_supplier_dues ?? 0;
						this.bank_balance 		= this.bank_accounts.reduce((prev, curr)=>{
							return prev + parseFloat(curr.balance);
						},0).toFixed(2);
						
						// this.invest_balance 	= this.invest_accounts.reduce((prev, curr)=>{
						// 	return prev + parseFloat(curr.balance);
						// },0).toFixed(2);
						
						// this.loan_balance 		= this.loan_accounts.reduce((prev, curr)=>{
						// 	return prev + parseFloat(curr.balance);
						// },0).toFixed(2);

						this.showReport = true;
					}else{
						alert(res.data.message);
					}
				});
			},

			async print() {
				let printContent = `
					<div class="container">
						<h4 style="text-align:center">Balance Sheet</h4 style="text-align:center">
						<div class="row" style="display:none">
							<div class="col-xs-12 text-center">
								Statement of <strong>${this.date}</strong> 
							</div>
						</div>
					</div>
					<div class="container">
						${document.querySelector('#printContent').innerHTML}
					</div>
				`;

				var printWindow = window.open('', 'PRINT', `width=${screen.width}, height=${screen.height}`);
				printWindow.document.write(`
					<?php $this->load->view('Administrator/reports/reportHeader.php'); ?>
				`);

				printWindow.document.body.innerHTML += printContent;
				printWindow.document.head.innerHTML += `
					<style>
						.balancesheet-table{
							width: 100%;
							border-collapse: collapse;
						}

						.balancesheet-table thead{
							text-align: center;
						}

						.balancesheet-table tfoot{
							font-weight: bold;
							background-color: #eaf3fd;
						}

						.balancesheet-table td, .balancesheet-table th{
							border: 1px solid #ccc;
							padding: 5px;
						}
					</style>
					
				`;

				printWindow.focus();
				await new Promise(resolve => setTimeout(resolve, 1000));
				printWindow.print();
				printWindow.close();
			}
		}
	})
</script>