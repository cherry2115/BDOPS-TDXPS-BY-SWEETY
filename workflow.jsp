<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/easyui.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/icon.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/demo.css" type="text/css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/style.css" type="text/css" rel="stylesheet">
<title>Insert title here</title>
	<style type="text/css">


	.multipleSelectBoxControl span{	/* Labels above select boxes*/
		font-family:arial;
		font-size:11px;
		font-weight:bold;
	}
	.multipleSelectBoxControl div select{	/* Select box layout */
		font-family:arial;
		height:100%;
	}
	.multipleSelectBoxControl input{	/* Small butons */
		width:25px;	
	}
	
	.multipleSelectBoxControl div{
		float:left;
	}
		
	.multipleSelectBoxDiv
	</style>
	
	
	
	<script type="text/javascript">	
	var fromBoxArray = new Array();
	var toBoxArray = new Array();
	var selectBoxIndex = 0;
	var arrayOfItemsToSelect = new Array();
	
	
	function moveSingleElement()
	{
		var selectBoxIndex = this.parentNode.parentNode.id.replace(/[^\d]/g,'');
		var tmpFromBox;
		var tmpToBox;
		if(this.tagName.toLowerCase()=='select'){			
			tmpFromBox = this;
			if(tmpFromBox==fromBoxArray[selectBoxIndex])tmpToBox = toBoxArray[selectBoxIndex]; else tmpToBox = fromBoxArray[selectBoxIndex];
			}else{
		
			if(this.value.indexOf('>')>=0){
				tmpFromBox = fromBoxArray[selectBoxIndex];
				
				tmpToBox = toBoxArray[selectBoxIndex];			
			}else{
				
				tmpFromBox = toBoxArray[selectBoxIndex];
				tmpToBox = fromBoxArray[selectBoxIndex];	
			}
		}
		
		for(var no=0;no<tmpFromBox.options.length;no++){
			if(tmpFromBox.options[no].selected){
				tmpFromBox.options[no].selected = false;
				tmpToBox.options[tmpToBox.options.length] = new Option(tmpFromBox.options[no].text,tmpFromBox.options[no].value);
				
				for(var no2=no;no2<(tmpFromBox.options.length-1);no2++){
					tmpFromBox.options[no2].value = tmpFromBox.options[no2+1].value;
					tmpFromBox.options[no2].text = tmpFromBox.options[no2+1].text;
					tmpFromBox.options[no2].selected = tmpFromBox.options[no2+1].selected;
				}
				no = no -1;
				tmpFromBox.options.length = tmpFromBox.options.length-1;
											
			}			
		}
		
		
		var tmpTextArray = new Array();
		for(var no=0;no<tmpFromBox.options.length;no++){
			tmpTextArray.push(tmpFromBox.options[no].text + '___' + tmpFromBox.options[no].value);			
		}
		tmpTextArray.sort();
		var tmpTextArray2 = new Array();
		for(var no=0;no<tmpToBox.options.length;no++){
			tmpTextArray2.push(tmpToBox.options[no].text + '___' + tmpToBox.options[no].value);			
		}		
		tmpTextArray2.sort();
		
		for(var no=0;no<tmpTextArray.length;no++){
			var items = tmpTextArray[no].split('___');
			tmpFromBox.options[no] = new Option(items[0],items[1]);
			
		}		
		
		for(var no=0;no<tmpTextArray2.length;no++){
			var items = tmpTextArray2[no].split('___');
			tmpToBox.options[no] = new Option(items[0],items[1]);			
		}
	}
	
	function sortAllElement(boxRef)
	{
		var tmpTextArray2 = new Array();
		for(var no=0;no<boxRef.options.length;no++){
			tmpTextArray2.push(boxRef.options[no].text + '___' + boxRef.options[no].value);			
		}		
		tmpTextArray2.sort();		
		for(var no=0;no<tmpTextArray2.length;no++){
			var items = tmpTextArray2[no].split('___');
			boxRef.options[no] = new Option(items[0],items[1]);			
		}		
		
	}
	function moveAllElements()
	{
		var selectBoxIndex = this.parentNode.parentNode.id.replace(/[^\d]/g,'');
		var tmpFromBox;
		var tmpToBox;		
		if(this.value.indexOf('>')>=0){
			tmpFromBox = fromBoxArray[selectBoxIndex];
			tmpToBox = toBoxArray[selectBoxIndex];			
		}else{
			tmpFromBox = toBoxArray[selectBoxIndex];
			tmpToBox = fromBoxArray[selectBoxIndex];	
		}
		
		for(var no=0;no<tmpFromBox.options.length;no++){
			tmpToBox.options[tmpToBox.options.length] = new Option(tmpFromBox.options[no].text,tmpFromBox.options[no].value);			
		}	
		
		tmpFromBox.options.length=0;
		sortAllElement(tmpToBox);
		
	}
	
	
	/* This function highlights options in the "to-boxes". It is needed if the values should be remembered after submit. Call this function onsubmit for your form */
	function multipleSelectOnSubmit()
	{
		for(var no=0;no<arrayOfItemsToSelect.length;no++){
			var obj = arrayOfItemsToSelect[no];
			for(var no2=0;no2<obj.options.length;no2++){
				obj.options[no2].selected = true;
			}
		}
		
	}
	
	function createMovableOptions(fromBox,toBox,totalWidth,totalHeight,labelLeft,labelRight)
	{		
		fromObj = document.getElementById(fromBox);
		toObj = document.getElementById(toBox);
		
		arrayOfItemsToSelect[arrayOfItemsToSelect.length] = toObj;

		
		fromObj.ondblclick = moveSingleElement;
		toObj.ondblclick = moveSingleElement;

		
		fromBoxArray.push(fromObj);
		toBoxArray.push(toObj);
		
		var parentEl = fromObj.parentNode;
		
		var parentDiv = document.createElement('DIV');
		parentDiv.className='multipleSelectBoxControl';
		parentDiv.id = 'selectBoxGroup' + selectBoxIndex;
		parentDiv.style.width = totalWidth + 'px';
		parentDiv.style.height = totalHeight + 'px';
		parentEl.insertBefore(parentDiv,fromObj);
		
		
		var subDiv = document.createElement('DIV');
		subDiv.style.width = (Math.floor(totalWidth/2) - 15) + 'px';
		fromObj.style.width = (Math.floor(totalWidth/2) - 15) + 'px';

		var label = document.createElement('SPAN');
		label.innerHTML = labelLeft;
		subDiv.appendChild(label);
		
		subDiv.appendChild(fromObj);
		subDiv.className = 'multipleSelectBoxDiv';
		parentDiv.appendChild(subDiv);
		
		
		var buttonDiv = document.createElement('DIV');
		buttonDiv.style.verticalAlign = 'middle';
		buttonDiv.style.paddingTop = (totalHeight/2) - 50 + 'px';
		buttonDiv.style.width = '30px';
		buttonDiv.style.textAlign = 'center';
		parentDiv.appendChild(buttonDiv);
		
		var buttonRight = document.createElement('INPUT');
		buttonRight.type='button';
		buttonRight.value = '>';
		buttonDiv.appendChild(buttonRight);	
		buttonRight.onclick = moveSingleElement;	
		
		var buttonAllRight = document.createElement('INPUT');
		buttonAllRight.type='button';
		buttonAllRight.value = '>>';
		buttonAllRight.onclick = moveAllElements;
		buttonDiv.appendChild(buttonAllRight);		
		
		var buttonLeft = document.createElement('INPUT');
		buttonLeft.style.marginTop='10px';
		buttonLeft.type='button';
		buttonLeft.value = '<';
		buttonLeft.onclick = moveSingleElement;
		buttonDiv.appendChild(buttonLeft);		
		
		var buttonAllLeft = document.createElement('INPUT');
		buttonAllLeft.type='button';
		buttonAllLeft.value = '<<';
		buttonAllLeft.onclick = moveAllElements;
		buttonDiv.appendChild(buttonAllLeft);
		
		var subDiv = document.createElement('DIV');
		subDiv.style.width = (Math.floor(totalWidth/2) - 15) + 'px';
		toObj.style.width = (Math.floor(totalWidth/2) - 15) + 'px';

		var label = document.createElement('SPAN');
		label.innerHTML = labelRight;
		subDiv.appendChild(label);
				
		subDiv.appendChild(toObj);
		parentDiv.appendChild(subDiv);		
		
		toObj.style.height = (totalHeight - label.offsetHeight) + 'px';
		fromObj.style.height = (totalHeight - label.offsetHeight) + 'px';

			
		selectBoxIndex++;
		
	}
	
	
	
	</script>	
	
	<script type="text/javascript">
	function getrolesfromdb(){
	
		var ajaxRequest;  
		
		
		try{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		} catch (e){
			// Internet Explorer Browsers
			try{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e){
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}
		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function(){
			
			if(ajaxRequest.readyState == 4){
				document.getElementById("fromBox").innerHTML="";
				document.getElementById("mroles").value=ajaxRequest.responseText;

				 //alert("000"+document.getElementById("mroles").value);
				
				//merge(ajaxRequest.responseText);
				//setroles(ajaxRequest.responseText);
				
				getcustomerspecificrolesfromdb();
			}
		}
		
		ajaxRequest.open("post", "<%=request.getContextPath()%>/authoringtool/processcontent/getworkflow.jsp", true);
				
		
		ajaxRequest.send(null); 
	}



	
	function getcustomerspecificrolesfromdb(){
		
		var ajaxRequest;  
		
		
		try{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		} catch (e){
			// Internet Explorer Browsers
			try{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e){
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}
		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function(){
			
			if(ajaxRequest.readyState == 4){
			
				document.getElementById("toBox").innerHTML="";
				document.getElementById("croles").value=ajaxRequest.responseText;
				//merge(ajaxRequest.responseText);
				//setcustomerspecificroles(ajaxRequest.responseText);
				mergeroles();
					
			}
		}
		
		ajaxRequest.open("post", "<%=request.getContextPath()%>/authoringtool/processcontent/getcustomerspecificworkflowfromdb.jsp", true);
		
		
		ajaxRequest.send(null); 
		
	}

	</script>
<script type="text/javascript">

function setroles(response)
{
var rolestxt=document.getElementById('roles').value=response;
var rolesarray=response.split(",");

for(i=0;i<rolesarray.length;i++)
{

if(rolesarray[i].indexOf("[")!=-1  )
{
	
	ind=rolesarray[i].indexOf("[");
	rolesarray[i]=rolesarray[i].substring(ind+1,rolesarray[i].length); 
	
	}
else if(rolesarray[i].indexOf("]")!=-1)
{
	
	ind=rolesarray[i].indexOf("]");
	rolesarray[i]=rolesarray[i].substring(0,ind); 
	
}

else
{
rolesarray[i]=rolesarray[i];
}
}

//rolestxt.options.length = 0;
var select = document.getElementById("fromBox");  
for(i=0;i<rolesarray.length;i++)
{
    select.options[select.options.length] = new Option(rolesarray[i], rolesarray[i]);  
}
}



function setcustomerspecificroles(response)
{

var rolestxt=document.getElementById('roles').value=response;
var rolesarray=response.split(",");

for(i=0;i<rolesarray.length;i++)
{

if(rolesarray[i].indexOf("[")!=-1  )
{
	
	ind=rolesarray[i].indexOf("[");
	rolesarray[i]=rolesarray[i].substring(ind+1,rolesarray[i].length); 
	
	}
else if(rolesarray[i].indexOf("]")!=-1)
{
	
	ind=rolesarray[i].indexOf("]");
	rolesarray[i]=rolesarray[i].substring(0,ind); 
	
}

else
{
rolesarray[i]=rolesarray[i];
}
}

//rolestxt.options.length = 0;
var select = document.getElementById("toBox");  
for(i=0;i<rolesarray.length;i++)
{
    select.options[select.options.length] = new Option(rolesarray[i], rolesarray[i]);  
}
}




</script>

<script type="text/javascript">
var rolesarraytobox=[];
function setvaluesindb()
{
	
	var option=document.getElementById('toBox');
	for(i=0;i<option.length;i++){   
	    
		rolesarraytobox+=option[i].value+",";  



		var ajaxRequest;  
		
		
		try{
			// Opera 8.0+, Firefox, Safari
			ajaxRequest = new XMLHttpRequest();
		} catch (e){
			// Internet Explorer Browsers
			try{
				ajaxRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try{
					ajaxRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e){
					// Something went wrong
					alert("Your browser broke!");
					return false;
				}
			}
		}
		// Create a function that will receive data sent from the server
		ajaxRequest.onreadystatechange = function(){		
			if(ajaxRequest.readyState == 4){
				document.getElementById('results').value=ajaxRequest.responseText;

				if(document.getElementById('results').value=="fail"){
					show_message('Roles not updated! Error!!!!:: Please contact Super Admin');
				}else{
					show_message('Roles updated successfully');
				}
			}
		};
		
		}
		
		ajaxRequest.open("post", "<%=request.getContextPath()%>/authoringtool/processcontent/setworkflowstagestodb.jsp?content="+rolesarraytobox, true);
		
		ajaxRequest.send(null);

	}
	function show_message(message){
		$.messager.show({
			title:'Success',
			msg:message,
			timeout:2000,
			showType:'slide'
		});
	}
	$(document).ready(function() {
	getrolesfromdb();
	

});
	
function mergeroles(){

	/*
	 *  create a list of roles for customer table
	 */
	var croleslist=document.getElementById('croles').value;
	
	var crolesarray=croleslist.split(",");

	for(i=0;i<crolesarray.length;i++)
	{

	if(crolesarray[i].indexOf("[")!=-1  )
	{
		
		ind=crolesarray[i].indexOf("[");
		crolesarray[i]=crolesarray[i].substring(ind+1,crolesarray[i].length).replace("]",""); 
		
		}
	else if(crolesarray[i].indexOf("]")!=-1)
	{
		
		ind=crolesarray[i].indexOf("]");
		crolesarray[i]=crolesarray[i].substring(0,ind).replace("]",""); 
		
	}

	else
	{
	crolesarray[i]=crolesarray[i].replace("]","");
	}
	}
	
	

/*
 *  create a list of roles for master table
 */

 var mroleslist=document.getElementById('mroles').value;

	var mrolesarray=mroleslist.split(",");

	for(i=0;i<mrolesarray.length;i++)
	{

	if(mrolesarray[i].indexOf("[")!=-1  )
	{
		
		ind=mrolesarray[i].indexOf("[");
		mrolesarray[i]=mrolesarray[i].substring(ind+1,mrolesarray[i].length); 
		
		
		}
	else if(mrolesarray[i].indexOf("]")!=-1)
	{
		
		ind=mrolesarray[i].indexOf("]");
		mrolesarray[i]=mrolesarray[i].substring(0,ind); 
		
	}

	else
	{
	mrolesarray[i]=mrolesarray[i];
	}
	
	}
	

/*
 *  refine roles from both boxes
 */
 
var refinedmasterrolearray = [];

 for(i=0;i<mrolesarray.length;i++)
	{
		 var mflag= [];
	
		 for(j=0;j<crolesarray.length;j++)
		 {
			
				if(!(mrolesarray[i] == crolesarray[j])){
	
					mflag.push("false");
					
				}
				else{
					mflag.push("true");
				}
		 }

		
		 var foundanyTrue = false;
		 
		 for(k=0;k<mflag.length;k++)
		 {
			if ((mflag[k]=="true")){
				 foundanyTrue = true;
						
			}
					
		 }
		
		if(foundanyTrue == false){
			refinedmasterrolearray.push(mrolesarray[i]);
		 }
		
	}
	

 var select = document.getElementById("toBox");  
 for(i=0;i<crolesarray.length;i++)
 {
     select.options[select.options.length] = new Option(crolesarray[i], crolesarray[i]);  
 }

 var select = document.getElementById("fromBox");  
 for(i=0;i<refinedmasterrolearray.length;i++)
 {
     select.options[select.options.length] = new Option(refinedmasterrolearray[i], refinedmasterrolearray[i]);  
 }

	
	
}

</script>

</head>
<body>

<div class="panel datagrid" style="width: 725px;">
<div class="panel-header" style="width: 710px;">
<div class="panel-title">WorkFlow Management</div>
</div>
<div class="datagrid-wrap panel-body" title="" style="width: 720px; height: 350px;">

<div class="datagrid-view" id="datagrid_table" style="width: 720px; height: 320px;overflow: auto;">

<form method="post" action="multiple_select.html" onsubmit="multipleSelectOnSubmit()">
<select multiple name="fromBox" id="fromBox">
	
</select>
<select multiple name="toBox" id="toBox">
	
</select>
</form>
<script type="text/javascript">
createMovableOptions("fromBox","toBox",500,300,'Master Stages List','Customer Stages List');
</script>
<input type="text" id="roles" name="roles" style="display: none;">


</div>
<a id="add" href="#" style="padding-left: 210px" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="setvaluesindb();">Add</a>
</div>

</div>
<div class="datagrid-mask-msg" id="mask" style="display: none; left:500.5px;">Processing, please wait ...</div>

<input type="text" id="results" style="display: none;" name="results"/>


<input type="text" id="mroles" style="display: none;" name="mroles"/>
<input type="text" id="croles" style="display: none;" name="croles"/>


</body>
</html>