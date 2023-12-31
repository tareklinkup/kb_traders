<style>
	.v-select {
		margin-bottom: 5px;
	}

	.v-select .dropdown-toggle {
		padding: 0px;
	}

	.v-select input[type=search],
	.v-select input[type=search]:focus {
		margin: 0px;
	}

	.v-select .vs__selected-options {
		overflow: hidden;
		flex-wrap: nowrap;
	}

	.v-select .selected-tag {
		margin: 2px 0px;
		white-space: nowrap;
		position: absolute;
		left: 0px;
	}

	.v-select .vs__actions {
		margin-top: -5px;
	}

	.v-select .dropdown-menu {
		width: auto;
		overflow-y: auto;
	}
</style>

<div class="row" id="customerDueList">
	<div class="col-xs-12 col-md-12 col-lg-12" style="border-bottom:1px #ccc solid;">
		<div class="form-group">
			<label class="col-sm-1 control-label no-padding-right">Search Type</label>
			<div class="col-sm-2">
				<select class="form-control" v-model="searchType" v-on:change="onChangeSearchType" style="padding:0px;">
					<option value="all">All</option>
					<option value="retail">By Retail Customers</option>
					<option value="wholesale">By Wholesale Customers</option>
					<option value="unpaid">By Unpaid Customers</option>
					<option value="customer">By Customer</option>
				</select>
			</div>
		</div>
		<div class="form-group" style="display: none" v-bind:style="{display: searchType == 'customer' || searchType == 'retail' || searchType == 'wholesale' || searchType == 'unpaid'  ? 'block' : 'none'}">
			<label class="col-sm-2 control-label no-padding-right">Select Customer</label>
			<div class="col-sm-2">
				<v-select v-bind:options="customers" v-model="selectedCustomer" label="display_name" placeholder="Select customer"></v-select>
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-2">
				<input type="button" class="btn btn-primary" value="Show Report" v-on:click="getDues" style="margin-top:0px;border:0px;height:28px;">
			</div>
		</div>
	</div>

	<div class="col-md-12" style="display: none" v-bind:style="{display: dues.length > 0 ? '' : 'none'}">
		<a href="" style="margin: 7px 0;display:block;width:50px;" v-on:click.prevent="print">
			<i class="fa fa-print"></i> Print
		</a>
		<div class="table-responsive" id="reportTable">
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>Customer Id</th>
						<th>Customer Type</th>
						<th>Customer Name</th>
						<th>Customer Owner</th>
						<th>Customer Mobile</th>
						<th>Address</th>
						<th>Area</th>
						<th>Page Number</th>
						<!-- <th>Total Bill</th>
						<th>Total Paid</th>
						<th>Paid to Customer</th>
						<th>Sales Returned</th> -->
						<th>Due Amount</th>
					</tr>
				</thead>
				<tbody>
					<tr v-for="data in dues">
						<td>{{ data.Customer_Code }}</td>
						<td>{{ data.Customer_Type }}</td>
						<td>{{ data.Customer_Name }}</td>
						<td>{{ data.owner_name }}</td>
						<td>{{ data.Customer_Mobile }}</td>
						<td>{{ data.Customer_Address }}</td>
						<td>{{ data.District_Name }}</td>
						<td>{{ data.page_number }}</td>
						<!-- <td style="text-align:right">{{ parseFloat(data.billAmount).toFixed(2) }}</td>
						<td style="text-align:right">{{ parseFloat(data.paidAmount).toFixed(2) }}</td>
						<td style="text-align:right">{{ parseFloat(data.paidOutAmount).toFixed(2) }}</td>
						<td style="text-align:right">{{ parseFloat(data.returnedAmount).toFixed(2) }}</td> -->
						<td style="text-align:right">{{ parseFloat(data.dueAmount).toFixed(2) }}</td>
					</tr>
				</tbody>
				<tfoot>
					<tr style="font-weight:bold;">
						<td colspan="8" style="text-align:right">Total Due</td>
						<td style="text-align:right">{{ parseFloat(totalDue).toFixed(2) }}</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>

<script src="<?php echo base_url(); ?>assets/js/vue/vue.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/vue/axios.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/vue/vue-select.min.js"></script>

<script>
	Vue.component('v-select', VueSelect.VueSelect);
	new Vue({
		el: '#customerDueList',
		data() {
			return {
				searchType: 'all',
				customers: [],
				selectedCustomer: null,
				dues: [],
				totalDue: 0.00
			}
		},
		created() {},
		methods: {
			onChangeSearchType() {
				if (this.searchType == 'customer' || this.searchType == 'retail' || this.searchType == 'wholesale' || this.searchType == 'unpaid') {
					this.getCustomers();
				}
				if (this.searchType == 'all') {
					this.selectedCustomer = null;
				}
			},
			getCustomers() {
				axios.post('/get_customers', {
					searchType: this.searchType
				}).then(res => {
					this.customers = res.data;
				})
			},
			getDues() {
				if (this.searchType == 'customer' && this.selectedCustomer == null) {
					alert('Select customer');
					console.log(this.selectedCustomer);
					return;
				}

				let filter = {
					customerId: this.selectedCustomer == null ? null : this.selectedCustomer.Customer_SlNo
				}

				if (this.searchType == 'retail' || this.searchType == 'wholesale' || this.searchType == 'unpaid') {
					filter.customerType = this.searchType;
				}

				axios.post('/get_customer_due', filter).then(res => {
					if (this.searchType == 'customer') {
						this.dues = res.data;
					} else {
						this.dues = res.data.filter(d => parseFloat(d.dueAmount) != 0);
					}
					this.totalDue = this.dues.reduce((prev, cur) => {
						return prev + parseFloat(cur.dueAmount)
					}, 0);
				})
			},
			async print() {
				let reportContent = `
					<div class="container">
						<h4 style="text-align:center">Customer due report</h4 style="text-align:center">
						<div class="row">
							<div class="col-xs-12">
								${document.querySelector('#reportTable').innerHTML}
							</div>
						</div>
					</div>
				`;

				var mywindow = window.open('', 'PRINT', `width=${screen.width}, height=${screen.height}`);
				mywindow.document.write(`
					<?php $this->load->view('Administrator/reports/reportHeader.php'); ?>
				`);

				mywindow.document.body.innerHTML += reportContent;

				mywindow.focus();
				await new Promise(resolve => setTimeout(resolve, 1000));
				mywindow.print();
				mywindow.close();
			}
		}
	})
</script>