<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<LINK REL="SHORTCUT ICON" HREF="<%=request.getContextPath() %>/images/favicon.ico">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/style.css" type="text/css" rel="stylesheet">
<title>Create your journal</title>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/easyui.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/icon.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/demo.css" type="text/css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/style.css" type="text/css" rel="stylesheet">
<script type="text/javascript">
var i = 1;

function add_file(file) {
	
	var j = i - 1;

	var box = document.getElementById('file_list');
	var num = box.length;
	var file_exists = 0;

	for (x = 0; x < num; x++) {
		if (box.options[x].text == file) {
			alert('This file has already been added to the Upload List.');
			document.getElementById('file_' + j).value = "";
			file_exists = 1;
			break;
		}
	}

	if (file_exists == 0) {
		// For Internet Explorer
		try {
			el = document.createElement('<input type="file" name="file_'+i+'" id="file_'+i+'" size="30" onChange="javascript:add_file(this.value);">');
		}
		// For other browsers
		catch (e) {
			el = document.createElement('input');
			el.setAttribute('type', 'file');
			el.setAttribute('name', 'file_'+i );
			el.setAttribute('id', 'file_'+i);
			el.setAttribute('size', '30');
			el.setAttribute('onChange', 'javascript:add_file(this.value);');
		}

		document.getElementById('file_' + j).style.display = 'none';

		if (document.getElementById('list_div').style.display == 'none') {
			document.getElementById('list_div').style.display = 'block';
		}

		document.getElementById('files_div').appendChild(el);
		box.options[num] = new Option(file, 'file_' + j);

		i++;
	}
	enable();
}

function remove_file() {
	var box = document.getElementById('file_list');
	if (box.selectedIndex != -1) {
		var value = box.options[box.selectedIndex].value;
		var child = document.getElementById(value);
	
		box.options[box.selectedIndex] = null;
		document.getElementById('files_div').removeChild(child);
	
		if (box.length == 0) {
			//document.getElementById('list_div').style.display = 'none';
			disable();
		}
	}
	else {
		alert('You must first select a file from the bucket.');
	}
}


</script>

<SCRIPT type="text/javascript">
var counter = 0;
var limit = 10;
function addInput(divName){
	if (counter == limit)  {
   }
   else {
		   var newdiv = document.createElement('div');
          
          newdiv.innerHTML = "<input type='file'   name='optionalFile"+counter+"'>";
          document.getElementById(divName).appendChild(newdiv);
          counter++;
   } 
}
var counter1 = 0;
function addInput1(divName){
	if (counter1 == limit)  {
   }
   else {
	
          var newdiv = document.createElement('div');
          newdiv.innerHTML = " <input type='button'  value='Delete'>";
          document.getElementById(divName).appendChild(newdiv);
          counter1++;
   } 
}

</SCRIPT>
<script type="text/javascript">


function zipname_blur()
{			
	var zipn = document.getElementById("zipname").value;
	var patt =/^[A-Za-z0-9#]*$/g;
	if(document.getElementById("zipname").value=="")
	{check();
	document.getElementById("zipname").style.background="rgb(178,178,178)";
	alert("Please provide journal name");
	check();}
	else
	{
	if(patt.test(zipn)){check();
	document.getElementById("zipname").style.background="rgb(178,178,178)";
	check();
	}
	else {
		document.getElementById("zipname").style.background="rgb(178,178,178)";
		alert("Enter valid jounal name"); 
		
		}
	}
	
}
function check(){
if(document.getElementById('zipname').value==""){

	disable();
}
else{
	enable();
}
}
$(document).ready(function() {
	
	disable();
});
function enable(){
	$('a.easyui-linkbutton').linkbutton('enable');
}
function disable(){
	$('a.easyui-linkbutton').linkbutton('disable');
}

function uploadfiles(){

	$('#sform').submit();
}

</script>
</head>

<body  onload="disableSubmit()">

		<s:form action="UploadMyFile" name='sform' id="sform" enctype="multipart/form-data" method="POST">
		<input type="hidden" name="flag" id="flag" value="upload" />
		
		
		<%request.setAttribute("flag","upload");%>
		
		<div id="content2"></div>
		
		<input type="hidden" name="getSize" id="fileSize" value="" />
			
	<table id="box-table-b" summary="download/upload templates">
<thead>
<tr>
<th scope="col">Upload <img title="Select files to be uploaded" src="<%=request.getContextPath()%>/authoringtool/images/upload_file.gif"></th>
<th scope="col">Upload Bucket</th>
</tr>
</thead>
<tbody>
<tr>
<td>

<div id="content1"></div>
		<div name="files_div" id="files_div" style="display: block;">
		<input type="file" name="file_0" id="file_0" size="30" onChange="javascript:add_file(this.value);" >
		</div> 
</td>
<td>

<div align="right" name="list_div" id="list_div" style="display: block;overflow: auto;width: 20em" >
	<select multiple name="file_list" id="file_list" size="6" style="width: 20em;"></select>
</div>
<a href="#" class="easyui-linkbutton" id="uploadfilestoserver" onclick="uploadfiles();">Upload</a>
<a href="#" class="easyui-linkbutton"  id="remove_file_btn" onClick="javascript:remove_file();">Remove Selected</a>

</td>
</tr>
<tr>
<td>
<input type="hidden" id="uploadproceediakey"  name="uploadproceediakey" value="true" />
<font color="red">&nbsp;&nbsp;<s:actionerror /></font>
</td>
<td>
</td>

</tr>
</tbody>
</table>	
</s:form>		
		
</body>
</html>