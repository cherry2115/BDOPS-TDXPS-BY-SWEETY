<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Article</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/authoringtool/css/layout.css" type="text/css"
	media="screen" />

<link href="<%=request.getContextPath() %>/authoringtool/finaltable/easyui.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/icon.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/demo.css" type="text/css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/style.css" type="text/css" rel="stylesheet">

		
 <script type="text/javascript">

 $(document).ready(function() {
	load_table();
 });



function addArticle()
{
	$('#mask1').show();
	
var jname=document.getElementById('add_journal').value;
var jid=document.getElementById('add_jid').value;
var itemcode=document.getElementById('add_itemcode').value;
   
		 $.ajax({
			  type: "POST",
			  url: "<%=request.getContextPath()%>/authoringtool/processcontent/processaddnassignusers.jsp",
			 data:"itemcode="+itemcode+"&jid="+jid+"&jname="+jname+"&editors="+$('#editorselectbox').val()+"&assteditors="+$('#assteditorselectbox').val()+"&reviewers="+$('#reviewerselectbox').val()+"&authors="+$('#authorselectbox').val(),
			  success: function(msg){
			 document.getElementById('results').value=msg;
				
					$('#dlg_assignArticle').dialog('close');
					load_table();
					$('#mask1').hide();
			  }
			});

}
 
function assignArticle()
{
	

	try{
		
	$('#assign_fm').form('clear');
	document.getElementById('add_jid').value=values[6];
	document.getElementById('add_journal').value=values[0];
	document.getElementById('add_itemcode').value=values[1];
	$('#dlg_assignArticle').dialog('open').dialog('setTitle','Assign Article');
	$.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/getusers.jsp",
		  data: "add_JID="+$('#add_jid').val(),
		  
		  success: function(msg){
			  document.getElementById("selectEditor").innerHTML=msg;
			  
				
			  
		  }
		});
	} catch(e){$.messager.alert('ERROR','Please select one row from the table','error');

	
	}

}

function newArticle()
{
	 $.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/getalljournals.jsp",
		  success: function(msg){
			  //selectdiv
			  
			  $('#selectdiv').html('');
				$('#selectdiv').html(msg);
			  
				opendialog();
		  }
		});

	
	
}

 
 function opendialog(){
	 
		$('#dlg_newArticle').dialog('open').dialog('setTitle','New Article');
		$('#add_fm').form('clear');
		
		
	}


function load_table(){
	$('#mask').show();
	 $.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/processloadarticles.jsp",
		  success: function(msg){

				$('#datagrid_table').html(msg);
				bindtable();
				searchtable();
				$('#mask').hide();
		  }
		});

	
}
function insertArticle(){

	$('#mask').show();
	
	 $.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/insertarticle.jsp",
		  data: "add_TITLE="+$('#add_TITLE').val()
		  +"&add_journalname="+$('#journalselectid').val(),
		  success: function(msg){
			  
			  document.getElementById('results').value=msg;
				if(  document.getElementById('results').value=="success"){
					$('#dlg_newArticle').dialog('close');
					load_table();
					

					}
				else if(document.getElementById('results').value=="fail"){
					$('#dlg_newArticle').dialog('close');
					$('#datagrid_table').html("Some Error occurred");
					$('#mask').hide();
					}
				
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
		function searchtable() {
			grid = $('#one-column-emphasis');
			var option;
			// handle search fields key up event
			$('#search-term').keyup(function(e) { 

				var search_option = $('#search_option').val();
				if(search_option == "1") {

					option="1";
				}
				
				else if(search_option == "8") {

					option="8";
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
<div class="panel-title">Article Management</div>
</div>
<div class="datagrid-wrap panel-body" title="" style="width: 720px; height: 210px;">

<div id="toolbar" class="datagrid-toolbar">

<a class="easyui-linkbutton l-btn l-btn-plain" onclick="newArticle()" plain="true"  href="#">
<span class="l-btn-left">
<span class="icon-edit" style="padding-left: 20px;">Add article</span>
</span>
</a>
<a class="easyui-linkbutton l-btn l-btn-plain" onclick="assignArticle()" plain="true"  href="#">
<span class="l-btn-left">
<span class="icon-edit" style="padding-left: 20px;">Assign article</span>
</span>
</a>

<label style="padding-left: 20px;" for="search-term">Search By :</label>&nbsp;<select id="search_option" name="search_option">
		<option value="1">Journal-Name</option>
		<option value="8">Title</option>
		
		
		</select>&nbsp;<input type="text" id="search-term" /> 

</div>
<div class="datagrid-view" id="datagrid_table" style="width: 720px; height: 160px;overflow: auto;">



</div>
</div>
</div>
<div class="datagrid-mask-msg" id="mask" style="display: none; left:500.5px;">Processing, please wait ...</div>
	
<!-- div for new article start -->
	 <div id="dlg_newArticle" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons">
		<div class="ftitle">Article Information</div>
		<form id="add_fm" method="post" novalidate>
			<div class="fitem">
				<label >Title:</label>
				<input name="add_TITLE" id="add_TITLE" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem" id="selectdiv">
				
				
			</div>
			
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="insertArticle()">Add Article</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_newArticle').dialog('close')">Cancel</a>
	</div>
	
	
	 <div id="dlg_assignArticle" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons1">
		<div class="ftitle">Article Information<div class="datagrid-mask-msg" id="mask1" style="display: none; left:100.5px;">Processing, please wait ...</div></div>
		<form id="assign_fm" method="post" novalidate>
			<div class="fitem">
				<label>Item Code:</label>
				<input name="add_itemcode" id="add_itemcode" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label >Journal name:</label>
				<input name="add_journal" id="add_journal" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>Jid:</label>
				<input name="add_jid" id="add_jid" class="easyui-validatebox" required="true">
			</div>
			<div id="selectEditor">
			</div>
			
			
		</form>
	</div>
	<div id="dlg-buttons1">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="addArticle()">Assign Article</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg_assignArticle').dialog('close')">Cancel</a>
	</div>
    <!-- div for new article ends -->
   
    	
<input type="text" id="results" style="display: none;" name="results"/>
</body>
</html>