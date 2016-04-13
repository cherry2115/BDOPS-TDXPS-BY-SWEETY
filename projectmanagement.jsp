<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>review articles</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/authoringtool/css/layout.css" type="text/css" media="screen" />
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/easyui.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/icon.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/demo.css" type="text/css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/style.css" type="text/css" rel="stylesheet">


	
	<script type="text/javascript" src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery.easyui.min.js"></script>

<%@page import="td.xbp.model.UserDTO"%>
<%@ page import="td.xbp.model.BdusersDTO" %>
<%
String businesstype="";

// UserDTO userDTO =   (UserDTO)session.getAttribute("userDTO");
BdusersDTO userDTO = (BdusersDTO)session.getAttribute("userDTO");

if(userDTO !=null)   
{  
	businesstype = userDTO.getBusinesstype();
	
}    
%>
		
 <script type="text/javascript">

 $(document).ready(function() {
	load_table();
 });

function load_table(){
	
	$('#mask').show();
	 $.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/processreviewtable.jsp",
		  headers: { "cache-control": "no-cache" },
		  success: function(msg){

				$('#datagrid_table').html(msg);
				bindtable();
				searchtable();
				$('#mask').hide();
				
		  }
		});

}
 var stagename="";
 var atitle="";
 var values;
 var itemcode;
        function bindtable() { 
        	
            var message = $('#message');
            var tr = $('#one-column-emphasis').find('tr');
            
            tr.bind('click', function(event) {
            	values=[];
                tr.removeClass('row-highlight');
                var tds = $(this).addClass('row-highlight').find('td');
                

                $.each(tds, function(index, item) {

                  values.push(item.innerHTML);
                
                });
                fetch_itemcode(values[1]);
                stagename=values[2];
                atitle=values[3];
                showToolfields();
            });

        }
        function fetch_itemcode(val){
        	
        	var matched_content;
        	var queryLinkPattern = /<a(.*?)>(.*?)<\/a>/gi;
        	while ((matched_content = queryLinkPattern.exec(val))!= null) 
        	{
        		itemcode=matched_content[2];
        		
        	}
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
	
	<script type="text/javascript">
	function newproject(){
		manage_tdpms("authoringtool/tdpms/newprojecttdpms.jsp")

		}
	
	
	</script>
	
</head>
<body>
<div class="panel datagrid easyui-panel" style="width: 1019px;" data-options="title:'Dashboard',
						collapsible:true">

<div class="datagrid-wrap panel-body" title="" style="width: 1015px; height: 210px;">
<div id="toolbar" class="datagrid-toolbar">

<a id="" class="easyui-linkbutton l-btn l-btn-plain" onclick="newproject()" plain="true"  href="#">
<span class="l-btn-left">
<span class="icon-add"  style="padding-left: 20px;">New Project</span>
</span>
</a>
<a class="easyui-linkbutton l-btn l-btn-plain" onclick="editproject()" plain="true"  href="#">
<span class="l-btn-left">
<span class="icon-edit" style="padding-left: 20px;">Edit Project</span>
</span>
</a>
<a class="easyui-linkbutton l-btn l-btn-plain" onclick="removeproject()" plain="true"  href="#">
<span class="l-btn-left">
<span class="icon-remove" style="padding-left: 20px;">Remove Project</span>
</span>
</a>

<label style="padding-left: 20px;" for="search-term">Search By :</label>&nbsp;<select id="search_option" name="search_option">
		<option value="1">Project Name</option>
		<option value="2">Project Id</option>
		
		</select>&nbsp;<input type="text" id="search-term" /> 

</div>
<div class="datagrid-view" id="datagrid_table" style="width: 1017px; height: 180px;overflow: auto;">



</div>
</div>
</div>

<div class="datagrid-mask-msg" id="mask" style="display: none; left:500.5px;">Processing, please wait ...</div>
</body>
</html>