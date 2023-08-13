<style>
    #branch .Inactive{
        color: red;
    }
   
	#branch input[type="file"] {
		display: none;
	}
	#branch .custom-file-upload {
		border: 1px solid #ccc;
		display: inline-block;
		padding: 5px 12px;
		cursor: pointer;
		margin-top: 5px;
		background-color: #298db4;
		border: none;
		color: white;
	}
	#branch .custom-file-upload:hover{
		background-color: #41add6;
	}

	#branchImage{
		height: 100%;
	}
</style>
<div id="branch">
    <div class="row" style="margin-top: 15px;">
        <div class="col-md-12">
            <form  @submit.prevent="saveBranch">
                <div class="row">
                    <div class="col-md-4 col-md-offset-3">
                        <div class="form-group">
                            <label class="col-sm-4 control-label no-padding-right"> Branch Name </label>
                            <div class="col-sm-8">
                                <input type="text" placeholder="Branch Name" class="form-control" v-model="branch.name" required/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-4 control-label no-padding-right"> Branch Title </label>
                            <div class="col-sm-8">
                                <input type="text" placeholder="Branch Title" class="form-control" v-model="branch.title" required/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-4 control-label no-padding-right"> Branch Address </label>
                            <div class="col-sm-8">
                                <textarea class="form-control" placeholder="Branch Address" v-model="branch.address" required></textarea>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label class="col-sm-4 control-label no-padding-right"></label>
                            <div class="col-sm-8">
                                <button type="submit" class="btn btn-sm btn-success">
                                    Submit
                                    <i class="ace-icon fa fa-arrow-right icon-on-right bigger-110"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <div style="width: 100px;height:100px;border: 1px solid #ccc;overflow:hidden;text-align:center;">
                                <img id="branchImage" v-if="imageUrl == '' || imageUrl == null" src="/assets/no_image.gif">
                                <img id="branchImage" v-if="imageUrl != '' && imageUrl != null" v-bind:src="imageUrl">
                            </div>
                            <div style="text-align:center;">
                                <label class="custom-file-upload">
                                    <input type="file" @change="previewImage"/>
                                    Select Image
                                </label>
                                <label style="color: red;">Aspect Ratio: 116:45</label>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="row" style="margin-top: 20px;display:none;" v-bind:style="{display: branches.length > 0 ? '' : 'none'}">
        <div class="col-md-12">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Sl</th>
                        <th>Branch Name</th>
                        <th>Branch Title</th>
                        <th>Branch Address</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="(branch, sl) in branches">
                        <td>{{ sl + 1 }}</td>
                        <td>{{ branch.Brunch_name }}</td>
                        <td>{{ branch.Brunch_title }}</td>
                        <td>{{ branch.Brunch_address }}</td>
                        <td><span v-bind:class="branch.active_status">{{ branch.active_status }}</span></td>
                        <td>
                            <?php if($this->session->userdata('accountType') != 'u'){?>
                            <a href="" title="Edit Branch" @click.prevent="editBranch(branch)"><i class="fa fa-pencil"></i></a>&nbsp;
                            <a href="" title="Deactive Branch" v-if="branch.status == 'a'" @click.prevent="changeStatus(branch.brunch_id)"><i class="fa fa-trash"></i></a>
                            <a href="" title="Active Branch" v-else><i class="fa fa-check" @click.prevent="changeStatus(branch.brunch_id)"></i></a>
                            <?php }?>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="<?php echo base_url();?>assets/js/vue/vue.min.js"></script>
<script src="<?php echo base_url();?>assets/js/vue/axios.min.js"></script>

<script>
    new Vue({
        el: '#branch',
        data(){
            return {
                branch: {
                    branchId: 0,
                    name: '',
                    title: '',
                    address: ''
                },
                branches: [],
                imageUrl: '',
				selectedFile: null,
            }
        },
        created(){
            this.getBranches();
        },
        methods: {
            previewImage(){
				if(event.target.files.length > 0){
					this.selectedFile = event.target.files[0];
					this.imageUrl = URL.createObjectURL(this.selectedFile);
				} else {
					this.selectedFile = null;
					this.imageUrl = null;
				}
			},
            getBranches(){
                axios.get('/get_branches').then(res => {
                    this.branches = res.data;
                })
            },

            saveBranch(){
                let url = "/add_branch";
                if(this.branch.branchId != 0){
                    url = "/update_branch";
                }

                let fd = new FormData();
                fd.append('image', this.selectedFile);
				fd.append('data', JSON.stringify(this.branch));

                axios.post(url, fd).then(res => {
                    let r = res.data;
                    alert(r.message);
                    if(r.success){
                        this.getBranches();
                        this.clearForm();
                    }
                })
            },

            editBranch(branch){
                this.branch.branchId = branch.brunch_id;
                this.branch.name = branch.Brunch_name;
                this.branch.title = branch.Brunch_title;
                this.branch.address = branch.Brunch_address;
                this.imageUrl = '<?php echo base_url("uploads/branch_thum/")?>' + branch.image
            },

            changeStatus(branchId){
                let changeConfirm = confirm('Are you sure?');
                if(changeConfirm == false){
                    return;
                }
                axios.post('/change_branch_status', {branchId: branchId}).then(res => {
                    let r = res.data;
                    alert(r.message);
                    if(r.success){
                        this.getBranches();
                    }
                })
            },

            clearForm(){
                this.branch = {
                    branchId: 0,
                    name: '',
                    title: '',
                    address: ''
                }
                this.imageUrl = '';
            }
        }
    })
</script>
