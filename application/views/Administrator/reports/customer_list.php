<div id="customerListReport">
    <div style="display:none;" v-bind:style="{display: customers.length > 0 ? '' : 'none'}">
        <div class="row">
            <div class="col-md-12">
                <a href="" @click.prevent="printCustomerList"><i class="fa fa-print"></i> Print</a>

                <div class="form-group">
				<label class="col-sm-1 control-label no-padding-right"> Type By </label>
				<div class="col-sm-2"> 
					<v-select v-bind:options="types" v-model="selectedType" label="type" placeholder="Select Type"
                    v-on:input="getCustomers" ></v-select>
				</div>
			</div>

            </div>
        </div>

        <div class="row" style="margin-top:15px;">
            <div class="col-md-12">
                <div class="table-responsive" id="printContent">
                    <table class="table table-bordered table-condensed">
                        <thead>
                            <th>Sl</th>
                            <th>Customer Id</th>
                            <th>Customer Type</th>
                            <th>Customer Name</th>
                            <th>Owner Name</th>
                            <th>Page Number</th>
                            <th>Address</th>
                            <th>Area</th>
                            <th>Contact No.</th>
                        </thead>
                        <tbody>
                            <tr v-for="(customer, sl) in customers">
                                <td>{{ sl + 1 }}</td>
                                <td>{{ customer.Customer_Code }}</td>
                                <td>{{ customer.Customer_Type }}</td>
                                <td>{{ customer.Customer_Name }}</td>
                                <td>{{ customer.owner_name }}</td>
                                <td>{{ customer.page_number }}</td>
                                <td>{{ customer.Customer_Address }}</td>
                                <td>{{ customer.District_Name }}</td>
                                <td>{{ customer.Customer_Mobile }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div style="display:none;text-align:center;" v-bind:style="{display: customers.length > 0 ? 'none' : ''}">
        No records found
    </div>
</div>

<script src="<?php echo base_url(); ?>assets/js/vue/vue.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/vue-select.min.js"></script>
<script src="<?php echo base_url(); ?>assets/js/vue/axios.min.js"></script>

<script>
	Vue.component('v-select', VueSelect.VueSelect);

    new Vue({
        el: '#customerListReport',
        data() {
            return {
                customers: [],
                types:[{type:'retail'},{type:'wholesale'}],
                selectedType:null
            }
        },
        created() {
            this.getCustomers();
        },
        methods: {
            getCustomers() {
                axios.post('/get_customers',{searchType:this.selectedType != null ? this.selectedType.type : null}).then(res => {
                    this.customers = res.data;
                })
            },

            async printCustomerList() {
                let printContent = `
                    <div class="container">
                        <h4 style="text-align:center">Customer List</h4 style="text-align:center">
						<div class="row">
							<div class="col-xs-12">
								${document.querySelector('#printContent').innerHTML}
							</div>
						</div>
                    </div>
                `;

                let printWindow = window.open('', '', `width=${screen.width}, height=${screen.height}`);
                printWindow.document.write(`
                    <?php $this->load->view('Administrator/reports/reportHeader.php'); ?>
                `);

                printWindow.document.body.innerHTML += printContent;
                printWindow.focus();
                await new Promise(r => setTimeout(r, 1000));
                printWindow.print();
                printWindow.close();
            }
        }
    })
</script>