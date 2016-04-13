<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Management</title>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/easyui.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/icon.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/demo.css" type="text/css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/style.css" type="text/css" rel="stylesheet">

 <script type="text/javascript">

 $(document).ready(function() {
	
	 load_table();
	 getsubordinateroles();
 });

function getsubordinateroles()
{
	$.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/getsubordinateroles.jsp",
		  success: function(msg){
			 
			  $('#rolename').html('');
				$('#rolename').html(msg);
				$('#rolenamenewuser').html('');
				$('#rolenamenewuser').html(msg.replace("edit_rolename","add_rolename"));
		  }
		});
	 

}
 function load_table(){


	 $('#mask').show();
	
	 $.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/processvalues.jsp",
		  success: function(msg){
			 
			  $('#datagrid_table').html('');
				$('#datagrid_table').html(msg);
				bindtable();
				searchtable();
				$('#mask').hide();
		  }
		});
	 



	 }
 var values;
 
        function bindtable() { 
      
            var message = $('#message');
            var tr = $('#one-column-emphasis').find('tr');
            
            tr.bind('click', function(event) {
            	values=[];
                tr.removeClass('row-highlight');
                var tds = $(this).addClass('row-highlight').find('td');
                

                $.each(tds, function(index, item) {
                  values.push(item.innerHTML);// values + 'td' + (index + 1) + ':' + item.innerHTML + '<br/>';
                });
              

            });
        }
        
    </script>
    
    <script type="text/javascript">
	function saveUser(){

		$('#mask').show();
		
		 $.ajax({
			  type: "POST",
			  url: "<%=request.getContextPath()%>/authoringtool/processcontent/edituser.jsp",
			  data: "edit_username="+$('#edit_username').val()
			  +"&edit_password="+$('#edit_password').val()
			 
			  +"&edit_rolename="+$('#edit_rolename').val()//$('#edit_rolename').combogrid('getValue')
			  +"&edit_address1="+$('#edit_address1').val()
			  +"&edit_address2="+$('#edit_address2').val()
			  +"&edit_address3="+$('#edit_address3').val()
			  +"&edit_address4="+$('#edit_address4').val()
			  +"&edit_city="+$('#edit_city').val()
			  +"&edit_state="+$('#edit_state').val()
			  +"&edit_postalcode="+$('#edit_postalcode').val()
			  +"&edit_country="+$('#edit_country').val()//.combogrid('getValue')
			  +"&edit_workphone="+$('#edit_workphone').val()
			  +"&edit_extn="+$('#edit_extn').val()
			  +"&edit_mobile="+$('#edit_mobile').val()
			  +"&edit_homephone="+$('#edit_homephone').val()
			  +"&edit_faxnumber="+$('#edit_faxnumber').val()
			  +"&edit_email="+$('#edit_email').val()
			  +"&edit_userid="+values[0]
			  +"&edit_tollfreenumber="+$('#edit_tollfreenumber').val() ,
			  success: function(msg){
				
				  document.getElementById('results').value=msg;
					if(  document.getElementById('results').value=="success"){
						$('#dlg_editUser').dialog('close');
						load_table();
						

						}
					else if(document.getElementById('results').value=="fail"){
						$('#dlg_editUser').dialog('close');
						$('#datagrid_table').html("Some Error occurred");
						$('#mask').hide();
						}
					
			  }
			});
		 
		

	}
	function setValue(inVal,comboxId){
		selectBox=document.getElementById(comboxId);
		  selectedItem = selectBox[selectBox.selectedIndex];
		  selectedItem.value = inVal;
		  selectedItem.text = inVal;
		  
		}
    function editUser()
    {
     
        try{
    	
    	//setValue(values[4],"edit_rolename" );
    	
		$('#edit_fm').form('load',{
			edit_username: values[1],
			edit_password: values[2],
			
			//edit_rolename: values[4],
			edit_address1: values[5],
			edit_address2: values[6],
			edit_address3: values[7],
			edit_address4: values[8],
			edit_city: values[9],
			edit_state: values[10],
			edit_postalcode: values[11],
			edit_country: values[12],
			edit_workphone: values[13],
			edit_extn: values[14],
			edit_mobile: values[15],
			edit_homephone: values[16],
			edit_faxnumber: values[17],
			edit_email: values[18],
			edit_tollfreenumber: values[19]
		});
		
		$('#dlg_editUser').dialog('open').dialog('setTitle','Edit User');
        }
        catch(e){$.messager.alert('ERROR','Please select one row from the table','error');alert(e);}
	
    }
	
    function newUser(){
		$('#dlg_newUser').dialog('open').dialog('setTitle','New User');
		$('#add_fm').form('clear');
		
		
	}
	function addUser(){
		$('#mask').show();
		
		 $.ajax({
			  type: "POST",
			  url: "<%=request.getContextPath()%>/authoringtool/processcontent/addnewuser.jsp",
			  data: "add_username="+$('#add_username').val()
			  +"&add_password="+$('#add_password').val()
			  +"&edit_rolename="+document.getElementById('add_rolename').value
			  +"&add_address1="+$('#add_address1').val()
			  +"&add_address2="+$('#add_address2').val()
			  +"&add_address3="+$('#add_address3').val()
			  +"&add_address4="+$('#add_address4').val()
			  +"&add_city="+$('#add_city').val()
			  +"&add_state="+$('#add_state').val()
			  +"&add_postalcode="+$('#add_postalcode').val()
			  +"&add_country="+$('#add_country').val()//.combogrid('getValue')
			  +"&add_workphone="+$('#add_workphone').val()
			  +"&add_extn="+$('#add_extn').val()
			  +"&add_mobile="+$('#add_mobile').val()
			  +"&add_homephone="+$('#add_homephone').val()
			  +"&add_faxnumber="+$('#add_faxnumber').val()
			  +"&add_email="+$('#add_email').val()
			  +"&add_tollfreenumber="+$('#add_tollfreenumber').val() ,
			  success: function(msg){
				  document.getElementById('results').value=msg;
					if(document.getElementById('results').value=="success"){
						$('#dlg_newUser').dialog('close');
						load_table();
						$('#mask').hide();
						success_notice("New user has been added");

						}
					else if(document.getElementById('results').value=="fail"){
						$('#dlg_newUser').dialog('close');
						$('#mask').hide();
						$('#datagrid_table').html("Some Error occurred");
						}
					
			  }
			});
		 
	}

    function removeUser(){
	
			$.messager.confirm('Confirm','Are you sure you want to remove this user?',function(result){
			if(result){
				  try{
						$('#mask').show();
						
						 $.ajax({
							  type: "POST",
							  url: "<%=request.getContextPath()%>/authoringtool/processcontent/deleteuser.jsp",
							  data: "userid="+values[0],
							  success: function(msg){
								  document.getElementById('results').value=msg;
									if(document.getElementById('results').value=="success"){
										
										load_table();
										values=null;
										$('#mask').hide();
										}
									else if(document.getElementById('results').value=="fail"){
										
										$('#datagrid_table').html("Some Error occurred");
										$('#mask').hide();
										}
									
							  }
							});
						 
						
						
				        }
				        catch(e){$.messager.alert('ERROR','Please select one row from the table','error');
				        $('#mask').hide();}
					
			}		

			});
		
	}
</script>
    
   <script type="text/javascript">
		function searchtable() {
			grid = $('#one-column-emphasis');
			var option;
			// handle search fields key up event
			$('#search-term').keyup(function(e) { 

				var search_option = $('#search_option').val();
				if(search_option == "1") {

					option="1";
				}
				else if(search_option == "2") {

					option="2";


				}
				text = $(this).val(); // grab search term

				if(text.length > 1) {
					grid.find('tr:has(td)').hide(); // hide data rows, leave header row showing

					// iterate through all grid rows
					grid.find('tr').each(function(i) {
						// check to see if search term matches Name column
						if($(this).find('td:nth-child('+option+')').text().toUpperCase().match(text.toUpperCase()))
							$(this).show(); // show matching row
					});
				}
				else 
					grid.find('tr').show(); // if no matching name is found, show all rows
			});
		}
	</script>
    
</head>
<body>


<div class="panel datagrid" style="width: 725px;">
<div class="panel-header" style="width: 710px;">
<div class="panel-title">User Management</div>
</div>
<div class="datagrid-wrap panel-body" title="" style="width: 720px; height: 210px;">

<div id="toolbar" class="datagrid-toolbar">

<a id="" class="easyui-linkbutton l-btn l-btn-plain" onclick="newUser()" plain="true"  href="#">
<span class="l-btn-left">
<span class="icon-add"  style="padding-left: 20px;">New User</span>
</span>
</a>
<a class="easyui-linkbutton l-btn l-btn-plain" onclick="editUser()" plain="true"  href="#">
<span class="l-btn-left">
<span class="icon-edit" style="padding-left: 20px;">Edit User</span>
</span>
</a>
<a class="easyui-linkbutton l-btn l-btn-plain" onclick="removeUser()" plain="true"  href="#">
<span class="l-btn-left">
<span class="icon-remove" style="padding-left: 20px;">Remove User</span>
</span>
</a>

<label style="padding-left: 20px;" for="search-term">Search By :</label>&nbsp;<select id="search_option" name="search_option">
		<option value="1">User Id</option>
		<option value="2">Name</option>
		
		</select>&nbsp;<input type="text" id="search-term" /> 

</div>
<div class="datagrid-view" id="datagrid_table" style="width: 720px; height: 160px;overflow: auto;">



</div>
</div>
</div>
<div class="datagrid-mask-msg" id="mask" style="display: none; left:500.5px;">Processing, please wait ...</div>
<!-- div for edit user start -->
  <div id="dlg_editUser" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<div class="ftitle">User Information</div>
		<form id="edit_fm" method="post" novalidate>
			<div class="fitem">
				<label for="edit_username">User Name:</label>
				<input name="edit_username" id="edit_username" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label for="edit_password">Password:</label>
				<input name="edit_password" id="edit_password" type="password" class="easyui-validatebox" required="true">
			</div>
			<div id="rolename" class="fitem">
				
			</div>
			
			<div class="fitem">
				<label for="edit_address1">Address 1:</label>
				<input name="edit_address1" id="edit_address1" class="easyui-validatebox"  >
			</div>
			<div class="fitem">
				<label for="edit_address2">Address 2:</label>
				<input name="edit_address2" id="edit_address2" class="easyui-validatebox" >
			</div>
			<div class="fitem">
				<label for="edit_address3">Address 3:</label>
				<input name="edit_address3" id="edit_address3" class="easyui-validatebox" >
			</div>
			<div class="fitem">
				<label for="edit_address4">Address 4:</label>
				<input name="edit_address4" id="edit_address4" class="easyui-validatebox" >
			</div>
			<div class="fitem">
				<label for="edit_city">City:</label>
				<input name="edit_city" id="edit_city" class="easyui-validatebox" >
			</div>
			<div class="fitem">
				<label for="edit_state">State:</label>
				<input name="edit_state" id="edit_state" class="easyui-validatebox" >
			</div>
			<div class="fitem">
				<label for="edit_postalcode">Postal Code:</label>
				<input name="edit_postalcode" id="edit_postalcode" class="easyui-validatebox" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label for="edit_country">Country:</label>
				<select id="edit_country"  name="edit_country" style="width:122px;" >
		<option value="1000">India</option>
		<option value="1001">China</option>
		<option value="1002">USA</option>
		<option value="1003">Pakistan</option>
		<option value="1004">Russia</option>
		<option value="1005">Brazil</option>
		    
	</select>
			</div>
			<div class="fitem">
				<label for="edit_workphone">Work Phone:</label>
				<input name="edit_workphone" id="edit_workphone" class="easyui-numberbox" >
			</div>
			<div class="fitem">
				<label for="edit_extn">Extn.:</label>
				<input name="edit_extn" id="edit_extn" class="easyui-numberbox"  class="easyui-validatebox" required="true">
			</div>
			
			<div class="fitem">
				<label for="edit_mobile">Mobile:</label>
				<input name="edit_mobile" id="edit_mobile" class="easyui-numberbox" >
			</div>
			<div class="fitem">
				<label for="edit_homephone">Home Phone:</label>
				<input name="edit_homephone" id="edit_homephone" class="easyui-numberbox" >
			</div>
			<div class="fitem">
				<label for="edit_faxnumber">Fax Number:</label>
				<input name="edit_faxnumber" id="edit_faxnumber" class="easyui-numberbox" >
			</div>
			<div class="fitem">
				<label for="edit_email">Email:</label>
				<input name="edit_email" id="edit_email" class="easyui-validatebox" validType="email"  required="true">
			</div>
			<div class="fitem">
				<label for="edit_tollfreenumber">Toll Free Number:</label>
				<input name="edit_tollfreenumber" id="edit_tollfreenumber" class="easyui-numberbox" >
			</div>
		</form>
	</div>
	<div id="dlg-buttons" style="height: 50px">
	<span id="editerrreport" style="padding: 10px "></span>
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_editUser').dialog('close')">Cancel</a>
	</div>
	<!-- div for edit user end -->
	<!-- div for new user start -->
	 <div id="dlg_newUser" class="easyui-dialog" style="width:400px;height:350px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<div class="ftitle">User Information</div>
		<form id="add_fm" method="post" novalidate>
			<div class="fitem">
				<label >User Name:</label>
				<input name="add_username" id="add_username" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>Password:</label>
				<input name="add_password" id="add_password" type="password" class="easyui-validatebox" required="true">
			</div>
			
			<div class="fitem" id="rolenamenewuser">
				
			</div>
			<div class="fitem">
				<label>Address 1:</label>
				<input name="add_address1" id="add_address1" class="easyui-validatebox" validType="Address1">
			</div>
			<div class="fitem">
				<label>Address 2:</label>
				<input name="add_address2" id="add_address2" class="easyui-validatebox" validType="Address2">
			</div>
			<div class="fitem">
				<label>Address 3:</label>
				<input name="add_address3" id="add_address3" class="easyui-validatebox" validType="Address3">
			</div>
			<div class="fitem">
				<label>Address 4:</label>
				<input name="add_address4" id="add_address4" class="easyui-validatebox" validType="Address4">
			</div>
			<div class="fitem">
				<label>City:</label>
				<input name="add_city" id="add_city" class="easyui-validatebox" validType="city">
			</div>
			<div class="fitem">
				<label>State:</label>
				<input name="add_state" id="add_state" class="easyui-validatebox" validType="state">
			</div>
			<div class="fitem">
				<label>Postal Code:</label>
				<input name="add_postalcode" id="add_postalcode" class="easyui-validatebox" validType="postalcode">
			</div>
			<div class="fitem">
				<label>Country:</label>
				<select id="add_country" name="add_country" style="width:122px;" >
		<option value="1000">India</option>
		<option value="1001">China</option>
		<option value="1002">USA</option>
		<option value="1003">Pakistan</option>
		<option value="1004">Russia</option>
		<option value="1005">Brazil</option>
		    
	</select>
			</div>
			<div class="fitem">
				<label>Work Phone:</label>
				<input name="add_workphone" id="add_workphone" class="easyui-numberbox" >
			</div>
			<div class="fitem">
				<label>Extn.:</label>
				<input name="add_extn" id="add_extn" class="easyui-numberbox"  required="true">
			</div>
			
			<div class="fitem">
				<label>Mobile:</label>
				<input name="add_mobile" id="add_mobile" class="easyui-numberbox" >
			</div>
			<div class="fitem">
				<label>Home Phone:</label>
				<input name="add_homephone" id="add_homephone" class="easyui-numberbox" >
			</div>
			<div class="fitem">
				<label>Fax Number:</label>
				<input name="add_faxnumber" id="add_faxnumber" class="easyui-numberbox" >
			</div>
			<div class="fitem">
				<label>Email:</label>
				<input name="add_email" id="add_email" class="easyui-validatebox" validType="email"   required="true">
			</div>
			<div class="fitem">
				<label>Toll Free Number:</label>
				<input name="add_tollfreenumber" id="add_tollfreenumber" class="easyui-numberbox" >
			</div>
		</form>
	</div>
	<div id="dlg-buttons" style="height: 50px">
	<span id="errreport" style="padding: 10px "></span>
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="addUser()">Add User</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_newUser').dialog('close')">Cancel</a>
	</div>
	
    <!-- div for new user ends -->
    	<input type="text" id="results" style="display: none;" name="results"/>
</body>
</html>