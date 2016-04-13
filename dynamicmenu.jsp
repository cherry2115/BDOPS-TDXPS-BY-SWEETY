<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="td.xbp.model.UserDTO"%>
<%@ page import="td.xbp.model.BdusersDTO" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="<%=request.getContextPath() %>/authoringtool/slider/slider.js"></script>


	<%

// UserDTO userDTO1 =   (UserDTO)session.getAttribute("userDTO");
	BdusersDTO userDTO1 = (BdusersDTO)session.getAttribute("userDTO");
%>
	<script type="text/javascript">
	
	function empty_div(){
		document.getElementById("content_div").innerHTML="";
	}
	function empty_editordiv(){
		document.getElementById("load_editor").innerHTML="";
	}
	function empty_tdpmsrdiv(){
		document.getElementById("load_tdpms").innerHTML="";
	}
	function manage_user(jsp_name){
		tinyMCE.execCommand('mceRemoveControl', true, 'elm1');
		empty_div();
		empty_editordiv();
		empty_tdpmsrdiv();
		$('#slider').html("");
		var path="<%=request.getContextPath()%>/"+jsp_name+"?random="+new Date().getTime();
		
		$('#content_div').load(path, function() {
			});
	}

	function manage_pdfview(jsp_name){
		
		//var path= jsp_name+"?random="+new Date().getTime();
		var path= "<%=request.getContextPath()%>/"+jsp_name+"?random="+new Date().getTime();

		$('#load_pdf').html('<iframe src='+path+' width="100%" height="1100px" name=\"pdfframe\" id=\"pdfframe\">');
	}
	function manage_tdpms(jsp_name){
		
		empty_editordiv();
		empty_tdpmsrdiv();
		$('#slider').html("");
		var path="<%=request.getContextPath()%>/"+jsp_name+"?random="+new Date().getTime();
		
		$('#load_tdpms').load(path, function() {
			});
	}
	
	function manage_fms(){
		empty_div();
		empty_editordiv();
		empty_tdpmsrdiv();
		$('#slider').html("");
		$('#content_div').html('<iframe src=\"http:\/\/172.16.0.43:8081\/FMSNEW/login.go?loginID=<%=userDTO1.getEmpName()%>&password=<%=userDTO1.getEmpPassword()%>&browser=S7&src=TDXPS\" width="100%" height="800" name=\"fmsframe\" id=\"fmsframe\">');
		
	}
	function manage_fms_oup(){
		empty_div();
		empty_editordiv();
		empty_tdpmsrdiv();
		$('#slider').html("");
		$('#content_div').html('<iframe src=\"http:\/\/10.2.48.66:8081\/FMS2USER/login.go?loginID=<%=userDTO1.getEmpName()%>&password=<%=userDTO1.getEmpPassword()%>&opt_qc=NO&c_dept=0&src=TDXPS\" width="100%" height="800" name=\"fmsframe\" id=\"fmsframe\">');
		
		}
	
	
	function manage_editor(jsp_name){
		tinyMCE.execCommand('mceRemoveControl', true, 'elm1');
		empty_editordiv();
		empty_tdpmsrdiv();
		var path="<%=request.getContextPath()%>/"+jsp_name;
		
		$('#load_editor').load(path, function() {
			setup();
			show();
			
			});
		
	}

	function manage_issuecompilation(){
		
		
		var path="<%=request.getContextPath()%>/authoringtool/finaltable/issuecompilationdashboard.jsp";
		
		$('#load_issuecompile').load(path, function() {
			});
		
	}
	var urlPath = "";
	function getURLForArticle(itemcode){

		
		
		$.ajax({
			  type: "POST",
			  url: "<%=request.getContextPath()%>/authoringtool/processcontent/getURLForArticle.jsp?random="+new Date().getTime(),
			  data: "ITEMCODE="+itemcode,
			  success: function(url){
				
				urlPath = url;
				$('#hiddenstatus').val(urlPath);
				window.setTimeout('displayCentralProof()',2000);
			  }
			});

	}


	
function manage_load_proofcentral(itemcode){

	if(itemcode!=null && itemcode!=""){
		
		getURLForArticle(itemcode);
		
	}else{
		fail_notice("some error occurred!!! (Please select an chapter)");

	}

	}

function displayCentralProof(){
	
if($('#hiddenstatus').val()=="fail"){

	$('#load_editor').show();
	$('#load_issuecompile').hide();
	$('#load_proofcentral').hide();
	$('#load_proofcentral').html('');
	error_notice("Link for Proof Central not found on the server");
}else{
	$('#load_editor').hide();
	$('#load_issuecompile').hide();
	$('#load_proofcentral').html('');
	$('#load_proofcentral').html('<iframe src=\"'+urlPath+'\" width="100%" height="800" name=\"fmsframe\" id=\"fmsframe\">');
	
	
}
}
/*
 * manage_content_wizard('signin/onlinecontribution/editor/editor_files/onlineform.jsp');
 * load content wizard in editor
 */



	function manage_content_wizard(jsp_name){
	 	tinyMCE.execCommand('mceRemoveControl', true, 'elm1');
		empty_div();
		empty_editordiv();
		empty_tdpmsrdiv();
		var path="<%=request.getContextPath()%>/"+jsp_name;
		
		$('#load_editor').load(path, function() {
			setup();
			show();
			load_article_in_tinymce("<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/content.txt");
			  
			});
		
		
	}
	</script>
	<script type="text/javascript">
	
	$(document).ready(function() {
		
	//When page loads...
	$(".tab_content").hide(); //Hide all content
	$("ul.tabs li:first").addClass("active").show(); //Activate first tab
	$(".tab_content:first").show(); //Show first tab content

	//On Click Event
	$("ul.tabs li").click(function() {

		$("ul.tabs li").removeClass("active"); //Remove any "active" class
		$(this).addClass("active"); //Add "active" class to selected tab
		$(".tab_content").hide(); //Hide all tab content

		var activeTab = $(this).find("a").attr("href"); //Find the href attribute value to identify the active tab + content
		$(activeTab).fadeIn(); //Fade in the active ID content
		return false;
	});

});
    </script>
    
    <script type="text/javascript">
    function loaddynamicmenu(){
	
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
		
			document.getElementById("menuiid").innerHTML="";
			document.getElementById("menuiid").innerHTML=ajaxRequest.responseText;
		
		}
	}
	
	ajaxRequest.open("post", "<%=request.getContextPath()%>/authoringtool/processcontent/processdynamicmenu.jsp", true);
	
	ajaxRequest.send(null); 
}
    function selecttab(title){

    	$('#aa').accordion('select','Logs');
    	
    }

    function addslidertomenu(){
		var content = "<div class=\"header\" id=\"one-header\" >Logs</div><div class=\"content\" id=\"one-content\"><div class=\"text\" id=\"1\">  </div></div><div class=\"header\" id=\"two-header\">Apply Styles</div><div class=\"content\" id=\"two-content\">  <div class=\"text\" id=\"2\">   </div></div>";
		$('#slider').html("");
		$('#slider').html(content);
		slider.init('slider',0);
        }
</script>

</head>
<body onload="loaddynamicmenu();">

<div id="menuiid">		
		
	
	</div>	
	
	<div id="slider" >
	</div>
	<input type="hidden" id="hiddenstatus"/>
</body>
</html>