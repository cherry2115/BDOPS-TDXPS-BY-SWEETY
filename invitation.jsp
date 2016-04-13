<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Email Support</title>

<script type="text/javascript">
function submitfunc()
{
	var emailto=$('#emailto').val();
	var emailsubject= $('#emailsubject').val();
	var emailquery=$('#emailquery').val();
	var emailfrom=$('#emailfrom').val();

	if(emailsubject=="" || emailquery=="" || emailto=="")
	{
		document.getElementById("err").innerHTML="<b style='color: red'>Fields cannot be left empty.</b>";
		
	}
	else
	{	
		document.getElementById("err").innerHTML="";
		
		 $.ajax({
			  type: "POST",
			  url: "<%=request.getContextPath()%>/authoringtool/processcontent/sendinvitation.jsp",
			  data: "emailto="+emailto
			  +"&emailsubject="+emailsubject
			  +"&emailquery="+emailquery
			  +"&emailfrom="+emailfrom,
			  success: function(msg){
				
			 document.getElementById('results').value=msg;
				if( document.getElementById('results').value=="success"){
					
					success_notice("Invitation Sent !!!");

					}
				else if(document.getElementById('results').value=="fail"){
					fail_notice("Some Error Occurred:: Please contact administrator") ;
					}
					
			  }
			});
	}
}


</script>
</head>
<body>

<form name="general" id="general">
<table>
<tr>
<td ><img src="<%=request.getContextPath()%>/support/images/support-banner.jpg" width="100%" height="100%"></td>
</tr>
</table>
<table  border="0" width="100%">
<tr>
<td width="20%">
To
</td>
<td width="80%"><input type="text" id="emailto" name="emailto"  style="width: 100%"/> </td>
</tr>
<tr>
<td width="20%">
From
</td>
<td width="80%"><input type="text" id="emailfrom" value = "<%=session.getAttribute("username")%>"name="emailfrom" style="width: 100%" readonly="readonly"/> </td>
</tr>
<tr>
<td width="20%">
Subject
</td>
<td width="80%"><input type="text" id="emailsubject" name="emailsubject" style="width: 100%"/> </td>
</tr>
<tr>
<td width="20%">
Query
</td>
</tr><tr>
<td colspan="2" ><textarea rows="10" cols="40" id="emailquery" name="emailquery" style="width: 100%" ></textarea> </td>
</tr>
<tr>
<td colspan="2" ><input type="button" id="btnSearch" name="btnSearch" value="Send" onclick="submitfunc();" /></td>
</tr>
</table>
<SPAN id="err"></SPAN>
   	<input type="text" id="results" style="display: none;" name="results"/>
</form>
</body>
</html>