<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>review articles</title>

<script type='text/javascript' src='<%=request.getContextPath() %>/authoringtool/gui/js/jquery-ui.js'></script>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/easyui.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/icon.css" type="text/css" rel="stylesheet">
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/demo.css" type="text/css" rel="stylesheet">

<script src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery.easyui.min.js" type="text/javascript"></script>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/style.css" type="text/css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath() %>/authoringtool/finaltable/tree/jquery.treeview.css" />
	
	<script src="<%=request.getContextPath() %>/authoringtool/finaltable/tree/jquery.cookie.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath() %>/authoringtool/finaltable/tree/jquery.treeview.js" type="text/javascript"></script>
	<script type='text/javascript' src='<%=request.getContextPath() %>/authoringtool/gui/js/jquery.droppy.js'></script>



<%@page import="td.xbp.model.UserDTO"%>
<%@page import="td.xbp.model.BdusersDTO"%>
<%
String businesstype="";
String	roleid="";
// UserDTO userDTO =   (UserDTO)session.getAttribute("userDTO");
BdusersDTO userDTO = (BdusersDTO)session.getAttribute("userDTO");
String	customer_account="";
if(userDTO !=null)   
{  
	roleid = userDTO.getRoleid();
// 	businesstype = userDTO.getBusinesstype();
	customer_account = userDTO.getUserCustomer();
	
}    
%>
	<%
  
  String getProtocol=request.getScheme();
  String getDomain=request.getServerName();
  String getPort=Integer.toString(request.getServerPort());
  
  String getPath = getProtocol+"://"+getDomain+":"+getPort+"/";
  String getPathwithoutport = getProtocol+"://"+getDomain+"/";
  
%>	
 <script type="text/javascript">

 $(document).ready(function() {
	load_table();
	

	
 });

 function launchepubreader(path) { 
		
		var launchepubreader=window.open(path,'launchepubreader','width=845px,height=665px,top=318,left=0,scrollbars=yes');
		
	}

 function launchsdatasetlog(itemcode){

		var datasetpath = "<%=getPath%>temp/files/"+itemcode+"/S5datasetlog.xml?random="+new Date().getTime();
		$('#log_list').html("");
		$('#log_list').html('<iframe src='+datasetpath+' width="100%" height="657px" name=\"styleguideframe\" id=\"styleguideframe\">');
		showlogstab();
		success_notice("Log retrieved successfully");
   
	 
 }
 function launchs100datasetlog(itemcode){

		var datasetpath = "<%=getPath%>temp/files/"+itemcode+"/S100datasetlog.xml?random="+new Date().getTime();
		$('#log_list').html("");
		$('#log_list').html('<iframe src='+datasetpath+' width="100%" height="657px" name=\"styleguideframe\" id=\"styleguideframe\">');
		showlogstab();
		success_notice("Log retrieved successfully");

	 
}
 function launchp100datasetlog(itemcode){

		var datasetpath = "<%=getPath%>temp/files/"+itemcode+"/P100datasetlog.xml?random="+new Date().getTime();

		$.ajax({
			
			  type: "POST",
			  url: datasetpath,
			  statusCode: {
				    404: function() {
			
							fail_notice("Dataset creation is under process...");


				    },
					200: function(msg) {

						// for demo change stage to dataset created and load table again
						
						updatestagetop100datasetcreated();
				    	
				    
							    }
				  }
			});
		
		
		

	 
}
 
 function updatestagetop100datasetcreated(){
	 var datasetpath = "<%=getPath%>temp/files/"+itemcode+"/P100datasetlog.xml?random="+new Date().getTime();
	 $.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/updatestagetop100datasetcreated.jsp",
		  success: function(msg){
			  
			  load_table_again();
			  $('#log_list').html("");
				$('#log_list').html('<iframe src='+datasetpath+' width="100%" height="657px" name=\"styleguideframe\" id=\"styleguideframe\">');
				showlogstab();
				success_notice("Log retrieved successfully");
		  }
		});



	 }
function downloadpdfworkpackettovm(itemcode){
var i = 0;
	success_notice("Workpacket is being downloaded.Please wait...");

	
	$.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/downloadpdfworkpackettovm.jsp?random="+new Date().getTime(),
		  data: "ITEMCODE="+itemcode,
		  success: function(url){
			  
				success_notice("Workpacket download completed.");
				
		  }
		});
	
	
}


function loadArticle(filepath){
	load_article_in_tinymce(filepath);

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

function submitarticletocentralproof(){

	if(itemcode==null | itemcode=="undefined" | itemcode=="")
	{
		alert("please select a file first");

	}
	else{
		
		$.ajax({
			  type: "POST",
			  url: "<%=request.getContextPath()%>/authoringtool/processcontent/submitarticleforcentralproof.jsp",
			  data: "filename="+itemcode ,
			  success: function(msg){
				  load_table_again();
				  success_notice("Article submitted ....");
					 
			  }
			});
	}

}

function manage_load_proofcentral(itemcode){

if(itemcode!=null && itemcode!=""){
	
	getURLForArticle(itemcode);
	
}else{
	fail_notice("some error occurred!!! (Please select an chapter)");

}

}

  function writeAidtoTxtFile(aidstring){
	  
	  $('#issuebutton').val('Issue sent');
	  $('#issuebutton').addClass('greenbutton');
	  $('#issuebutton').removeClass('pdf_view');

	  $('#issuebutton').attr("disabled","disabled");
	  
	var aid=aidstring.split("****");
	var selectedaid="";
	for(i=0;i<aid.length-1;i++){
		if(aid[i]!=null || aid[i]!=""){
		if(document.getElementById(aid[i]).checked){
			selectedaid+=aid[i]+"=true\n";
			}
		}
		
	}
	 $.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/processissueAidsTxtFile.jsp",
		  data: "selectedaid="+selectedaid+"&itemcode="+itemcode,
		  success: function(msg){

			  load_table_again();
		  }
		});
	
				 
	  }
  
function displaytdpms(){

	var urlPath = "http://172.16.0.53:8083/tdpmsTest/up?txt_username=1p1p&bookid="+itemcode+"&txt_password=p@ssw0rd&txt_acct=OUP&random="+new Date().getTime();
	$('#load_p100').hide();
	$('#load_editor').show();
	$('#load_proofcentral').hide();
	$('#load_vnc').hide();
	$('.EditorMenu').show();
	$('.RightPanel_btn').show();
	$('.tabs_btn').hide();
	$('.StyleGuide').hide();
	$('.MsgNoArticleSelected').hide();
	$('.load_jsptdpms').show();
	$('#load_pdf').hide();
	$('#load_jsptdpms').html('');
	$('#load_jsptdpms').html('<iframe src=\"'+urlPath+'\" width="100%" height="95%" name=\"tdpmsframe\" id=\"tdpmsframe\">');
	
}



function displayCentralProof(){

if($('#hiddenstatus').val()=="fail"){

$('#load_editor').show();
$('#load_tdpms').hide();
$('#load_proofcentral').hide();
$('#load_proofcentral').html('');
load_article_in_tinymce(articlefilepath);
$('.showLogs').show();
$('.showQuery').show();
$('.showStyle').show();
$('.showAction').show();
$('.EditorMenu').show();
$('#submitproofcentral').hide();

}else{
	urlPath = $('#hiddenstatus').val()+"?random="+new Date().getTime();
	
$('#load_editor').hide();
$('#load_proofcentral').html('');
$('#load_proofcentral').html('<iframe src=\"'+urlPath+'\" width="100%" height="95%" name=\"proofcentralframe\" id=\"proofcentralframe\">');

$('#load_p100').hide();
$('#load_tdpms').hide();
$('#load_proofcentral').show();



$('.showLogs').hide();
$('.showQuery').hide();
$('.showStyle').hide();
$('.showAction').hide();
$('.EditorMenu').hide();
$('#submitproofcentral').show();
}
}


function setMetroPathForbooks(stagename){
	//copy editor
	 if(stagename=="COPY_EDITOR")
	 {
	 	$("#step1div").removeClass('red');
	 	$("#step1div").removeClass('yellow');
	 	$("#step1div").addClass('green');
	 	
	 	$("#step2div").removeClass('red');
	 	$("#step2div").removeClass('yellow');
	 	$("#step2div").addClass('green');

	 	$("#step3div").removeClass('red');
	 	$("#step3div").removeClass('green');
	 	$("#step3div").addClass('yellow');

	 	$("#step4div").removeClass('yellow');
	 	$("#step4div").removeClass('green');
	 	$("#step4div").addClass('red');

	 	$("#step5div").removeClass('yellow');
	 	$("#step5div").removeClass('green');
	 	$("#step5div").addClass('red');

	 	$("#step6div").removeClass('yellow');
	 	$("#step6div").removeClass('green');
	 	$("#step6div").addClass('red');

	 }
	//For BDOps conversion
	 else if(stagename=='conversion')
	 {
	 	$("#step1div").removeClass('red');
	 	$("#step1div").removeClass('yellow');
	 	$("#step1div").addClass('green');
	 	$("#step2div").removeClass('green');
	 	$("#step2div").removeClass('red');
	 	$("#step2div").addClass('yellow');
	 	$("#step3div").removeClass('yellow');
	 	$("#step3div").removeClass('green');
	 	$("#step3div").addClass('red');
	 }
	//For BDOps Submit
	 else if(stagename=='submit')
	 {
	 	$("#step1div").removeClass('red');
	 	$("#step1div").removeClass('yellow');
	 	$("#step1div").addClass('green');
	 	
	 	$("#step2div").removeClass('yellow');
	 	$("#step2div").removeClass('red');
	 	$("#step2div").addClass('green');

	 	$("#step3div").removeClass('red');
	 	$("#step3div").removeClass('green');
	 	$("#step3div").addClass('yellow');

	 	
	 	
	 }
	
	 //auto astructuring
	 else if(stagename=="AUTO_STRUCTURING")
	 {
	 	$("#step1div").removeClass('red');
	 	$("#step1div").removeClass('yellow');
	 	$("#step1div").addClass('green');
	 	
	 	$("#step2div").removeClass('red');
	 	$("#step2div").removeClass('green');
	 	$("#step2div").addClass('yellow');

	 	$("#step3div").removeClass('yellow');
	 	$("#step3div").removeClass('green');
	 	$("#step3div").addClass('red');

	 	$("#step4div").removeClass('yellow');
	 	$("#step4div").removeClass('green');
	 	$("#step4div").addClass('red');

	 	$("#step5div").removeClass('yellow');
	 	$("#step5div").removeClass('green');
	 	$("#step5div").addClass('red');

	 	$("#step6div").removeClass('yellow');
	 	$("#step6div").removeClass('green');
	 	$("#step6div").addClass('red');
	 	
	 }


	 //cnu fail
	 
	 else if(stagename=="ST1022")
	 {
	 	$("#step1div").removeClass('red');
	 	$("#step1div").removeClass('green');
	 	$("#step1div").addClass('yellow');
	 	
	 	
	 	$("#step2div").removeClass('yellow');
	 	$("#step2div").removeClass('green');
	 	$("#step2div").addClass('red');
	 	
	 	$("#step3div").removeClass('yellow');
	 	$("#step3div").removeClass('green');
	 	$("#step3div").addClass('red');
	 	
	 	$("#step4div").removeClass('yellow');
	 	$("#step4div").removeClass('green');
	 	$("#step4div").addClass('red');

	 	$("#step5div").removeClass('yellow');
	 	$("#step5div").removeClass('green');
	 	$("#step5div").addClass('red');

	 	$("#step6div").removeClass('yellow');
	 	$("#step6div").removeClass('green');
	 	$("#step6div").addClass('red');
	 }

	 //master copy editor
	 
	 else if(stagename=="MASTER_COPY_EDITOR" || stagename=="PROOF_COLLATION")
	 {
		 $("#step1div").removeClass('red');
		 	$("#step1div").removeClass('yellow');
		 	$("#step1div").addClass('green');
		 	
		 	
		 	$("#step2div").removeClass('yellow');
		 	$("#step2div").removeClass('red');
		 	$("#step2div").addClass('green');
		 	
		 	$("#step3div").removeClass('yellow');
		 	$("#step3div").removeClass('red');
		 	$("#step3div").addClass('green');
		 	
		 	$("#step4div").removeClass('red');
		 	$("#step4div").removeClass('yellow');
		 	$("#step4div").addClass('green');

		 	$("#step5div").removeClass('red');
		 	$("#step5div").removeClass('green');
		 	$("#step5div").addClass('green');

		 	$("#step6div").removeClass('red');
		 	$("#step6div").removeClass('green');
		 	$("#step6div").addClass('yellow');
	 }

	 //qc
	 else if(stagename=="QC")
	 {
	 	$("#step1div").removeClass('red');
	 	$("#step1div").removeClass('yellow');
	 	$("#step1div").addClass('green');
	 	

		$("#step2div").removeClass('red');	
	 	$("#step2div").removeClass('yellow');
	 	$("#step2div").addClass('green');
	 	
	 	$("#step3div").removeClass('red');
		$("#step3div").removeClass('yellow');
	 	$("#step3div").addClass('green');
	 	
	 	$("#step4div").removeClass('red');
	 	$("#step4div").removeClass('yellow');
	 	$("#step4div").addClass('green');

	 	$("#step5div").removeClass('red');
	 	$("#step5div").removeClass('green');
	 	$("#step5div").addClass('yellow');

	 	$("#step6div").removeClass('yellow');
	 	$("#step6div").removeClass('green');
	 	$("#step6div").addClass('red');
	 }	

	 //author revision
	 else if(stagename=="AUTHOR_REVISION")
	 {
	 	$("#step1div").removeClass('red');
	 	$("#step1div").removeClass('yellow');
	 	$("#step1div").addClass('green');
	 	
	 	
	 	$("#step2div").removeClass('yellow');
	 	$("#step2div").removeClass('red');
	 	$("#step2div").addClass('green');
	 	
	 	$("#step3div").removeClass('yellow');
	 	$("#step3div").removeClass('red');
	 	$("#step3div").addClass('green');
	 	
	 	$("#step4div").removeClass('red');
	 	$("#step4div").removeClass('yellow');
	 	$("#step4div").addClass('green');

	 	$("#step5div").removeClass('red');
	 	$("#step5div").removeClass('green');
	 	$("#step5div").addClass('yellow');
	 }


	 //pagination
	 else if(stagename=="PAGINATION")
	 {
	 	$("#step1div").removeClass('red');
	 	$("#step1div").removeClass('yellow');
	 	$("#step1div").addClass('green');
	 	
	 	
	 	$("#step2div").removeClass('yellow');
	 	$("#step2div").removeClass('red');
	 	$("#step2div").addClass('green');
	 	
	 	$("#step3div").removeClass('yellow');
	 	$("#step3div").removeClass('red');
	 	$("#step3div").addClass('green');
	 	
	 	$("#step4div").removeClass('red');
	 	$("#step4div").removeClass('green');
	 	$("#step4div").addClass('yellow');

	 	$("#step5div").removeClass('yellow');
	 	$("#step5div").removeClass('green');
	 	$("#step5div").addClass('red');

	 	$("#step6div").removeClass('yellow');
	 	$("#step6div").removeClass('green');
	 	$("#step6div").addClass('red');
	 }
	//p100_qc
	 else if(stagename=="P100_QC")
	 {
	 	$("#step1div").removeClass('red');
	 	$("#step1div").removeClass('yellow');
	 	$("#step1div").addClass('green');
	 	
	 	
	 	$("#step2div").removeClass('yellow');
	 	$("#step2div").removeClass('red');
	 	$("#step2div").addClass('green');
	 	
	 	$("#step3div").removeClass('yellow');
	 	$("#step3div").removeClass('red');
	 	$("#step3div").addClass('green');
	 	
	 	$("#step4div").removeClass('red');
	 	$("#step4div").removeClass('yellow');
	 	$("#step4div").addClass('green');

	 	$("#step5div").removeClass('yellow');
	 	$("#step5div").removeClass('red');
	 	$("#step5div").addClass('green');

	 	$("#step6div").removeClass('red');
	 	$("#step6div").removeClass('green');
	 	$("#step6div").addClass('yellow');
	 }

	 
	 }





function setItemcodeOnBookClick(bookid){

	itemcode = bookid;

	
}


function showhandbookpdfforbook(){

	 var pdfserverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/handbook.pdf?random="+new Date().getTime();
		var path="pdfmaster/web/pdfviewer.jsp?pdfpath="+pdfserverpath;
		 	var iframepath= "<%=request.getContextPath()%>/"+path+"?random="+new Date().getTime();
		 	$('#load_pdf').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"handbookframe\" id=\"handbookframe\">');
		 	
		 	$('#load_pdf').show();
		 	$('.PDFEdit').addClass('PDFEditFull');
		 	$('.PDFLeftContainer').show();		
		 	$('.PDFEdit').removeClass('PDFEdit');
		 	$('.StyleGuide').hide();
			



	
}
function showpassportpdfforbook(){

	 var pdfserverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/passport.pdf?random="+new Date().getTime();
		var path="pdfmaster/web/pdfviewer.jsp?pdfpath="+pdfserverpath;
		 	var iframepath= "<%=request.getContextPath()%>/"+path+"?random="+new Date().getTime();
		 	$('#load_pdf').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"passportframe\" id=\"passportframe\">');
		 	
		 	$('#load_pdf').show();
		 	$('.PDFEdit').addClass('PDFEditFull');
		 	$('.PDFLeftContainer').show();		
		 	$('.PDFEdit').removeClass('PDFEdit');
		 	$('.StyleGuide').hide();
		

	
}





function view_docs(category){

		if(category=='artlog'){

			var serverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/artlog.pdf?random="+new Date().getTime();

		}else if(category=='castoff'){

			var serverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/castoff.pdf?random="+new Date().getTime();
			
		}else if(category=='designsample'){

			var serverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/designsample.pdf?random="+new Date().getTime();
			
		}else if(category=='analysisreport'){

			var serverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/analysisreport.pdf?random="+new Date().getTime();
			
		}else if(category=='stmchecklist'){
			
			var serverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/stmchecklist.pdf?random="+new Date().getTime();
			

		}else if(category=='stmcastoff'){
			
			var serverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/stmcastoff.pdf?random="+new Date().getTime();
			

		}else if(category=='stmanalysisreport'){

			var serverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/stmanalysisreport.pdf?random="+new Date().getTime();
			
		}


		var path="pdfmaster/web/pdfviewer.jsp?pdfpath="+serverpath;
		var iframepath= "<%=request.getContextPath()%>/"+path+"?random="+new Date().getTime();
		$('#load_pdf').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"pdfframe\" id=\"pdfframe\">');
		$('#load_pdf').show();
		$('.PDFEdit').addClass('PDFEditFull');	
		$('.PDFEdit').removeClass('PDFEdit');
		$('.StyleGuide').hide();
		$('.MsgNoArticleSelected').hide();
		$('.PDFLeftContainer').show();
		
	
}



function loadBook(filepath,batch,orderId,flow,bookName,monthYear,clOrderId,pFlow,articleORIssue){

		
				load_chapter_in_tinymce(filepath,batch,orderId,flow,bookName,monthYear,clOrderId,pFlow,articleORIssue);
				$('#load_editor').show();
				$('#load_proofcentral').hide();
				$('#load_proofcentral').html('');
				$('#load_vnc').hide();
				$('#submitproofcentral').hide();
				$('.PDFLeftContainer').show();
				$('#load_pdf').show();
				$('.PDFEdit').show();
				$('.PDFEdit').addClass('PDFEditFull');
				$('.PDFEdit').removeClass('PDFEdit');
				$('.EditorOuterContainer').show();
				$('.EditorContainer').show();
				$('.ArticleLoader').show();
		   		$('.StyleGuide').show();
		   	    $('#checklistp100').hide();
		   		$('#refreshpdf').show();
		   		$('#extranet').hide();
		   		$('#capguide').hide();
		   		$('#pdfview').show();
		   		$('#showxml').show();
		   		$('#orderxml').show();
		   		$('#carxml').show();
		   		$('#diff_pdf').hide();
		   		$('#stylesheet').show();
		   		$('#logsbutton').show();
		   		$('#querybutton').show();
		   		$('#stylebutton').show();
		   		$('.MsgNoArticleSelected').hide();
		   		$('.RightPanel_btn').show();
		   		$('#load_vnc').hide();
		   		$('#load_editor').show();
		   		$('#load_proofcentral').hide();
		   		$('#load_p100').hide();
		   		$('#load_tdpms').hide();
// 				showToolfields();
				$('#viewcomments').hide();
				$('#submitarticle').hide();
				$('#insertcomments').hide();
				$('#submitfinalarticle').show();
				$('#submitfinalarticles100').hide();
				$('#submitfinalarticlesauthor').hide();
				$('#conversion').show();
				$('#submitfinalarticlesme').hide();
				$('#submitfinalarticlebyme').hide();
				$('#submitfinalarticlesqc').hide();
				$('#uploadcorrectedpdf').hide();
				$('#submitfordelivery').hide();
				$('#dashboardtitle').html(bookName);
				

	
}

var articlefilepath="";
function loadArticle(filepath,stage,articlename){

	itemcode = articlename;
	stagename = stage;
	articlefilepath = filepath;

	$('#checklistp100').hide();
	$('#load_p100').hide();
	$('#load_tdpms').hide();
		if(stage=="MASTER_COPY_EDITOR" || stagename=="PROOF_COLLATION"){

			manage_load_proofcentral(itemcode);
			refreshpdfonroles();
			$('#load_vnc').hide();
			$('#displaypdf').show();
			$('#checklistp100').hide();
			

		}
		else if(stage=="S100_DATASET_CREATED"){

			load_article_in_tinymce(filepath);
			$('#load_editor').show();
			$('#load_proofcentral').hide();
			$('#load_proofcentral').html('');
			$('#load_vnc').hide();
			refreshpdfonroles();
			$('#submitproofcentral').hide();
			$('#checklistp100').hide();
			$('#displaypdf').hide();
			}


		else{

			load_article_in_tinymce(filepath);
			$('#load_editor').show();
			$('#displaypdf').hide();
			$('#load_proofcentral').hide();
			$('#load_proofcentral').html('');
			$('#load_vnc').hide();
			$('#submitproofcentral').hide();
			
			
			}

}

function publishepubfile(path){

	var iframepath= "<%=request.getContextPath()%>/"+path+"?random="+new Date().getTime();
	$('#common_box').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"epubframe\" id=\"epubframe\">');
	showboxtab();
}


function RunExe(itemcode)
{
netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");

var exe = window.Components.classes['@mozilla.org/file/local;1'].createInstance(Components.interfaces.nsILocalFile);
exe.initWithPath("c:\\TDXPS\\Upload.bat");
var run = window.Components.classes['@mozilla.org/process/util;1'].createInstance(Components.interfaces.nsIProcess);
run.init(exe);
var parameters = [itemcode];
run.run(false, parameters,parameters.length);

}
function showepubdiv(id){

	$('#'+id+'').show();
}

function hideepubdiv(id){

	$('#'+id+'').hide();
}

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
				
				manage_editor("signin/onlinecontribution/editor/editor_files/onlineform.jsp");
				collapseoptions();
				//tdxps.setLocale();
				$('#nav').droppy({trigger: 'click'});
		  }
		});

}

function statusComboBox(args,valueofcombo){

	if(args == "value"){
		$('#comboboxstatus').hide();
		$('#statuscombo').show();

		
	}else if(args == "combo"){
		$('#comboboxstatus').show();
		$('#statuscombo').hide();
		
		var statuscombo = $('#statuscombo').val();

		updateStatusOfArticle(statuscombo, itemcode);
		load_table_again();
		
	}
}

function updateStatusOfArticle(statuscombo, itemcode){

	$.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/updatestatusofarticle.jsp",
		  data: "statuscombo="+statuscombo+"&itemcode="+itemcode,
		  success: function(msg){
			  
				show_message("status updated successfully");
		  }
		});
	
}
function uploadcorrectedpdfbypse(){

	if(itemcode!=null && itemcode!=""){

		var serverpath = "files";
		
		var path="http://172.16.0.53:8086/upload/index.html?filename="+itemcode+"&path="+serverpath+"&random="+new Date().getTime();
		$('#common_box').html('<iframe src='+path+' width="100%" height="95%" scrolling="no" name=\"dropbox\" id=\"dropbox\">');
		showboxtab();
	}
	else{
		fail_notice("some error occurred!!! (Please select an chapter)");

		}
	
}
function uploadmarkedpdf(){

	if(itemcode!=null && itemcode!=""){
		var path="http://172.16.0.53:8086/upload/index.html?filename="+itemcode+"&random="+new Date().getTime();
		$('#common_box').html('<iframe src='+path+' width="100%" height="100%" scrolling="no" name=\"dropbox\" id=\"dropbox\">');
		showboxtab();
	}
	else{
		fail_notice("some error occurred!!! (Please select an chapter)");

		}
	
}
function collapseoptions(){

	$(".navigation").treeview({
		collapsed: true,
		
		persist: "location"
	});

	
}
function load_table_again(){
	
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
				collapseoptions();
				//tdxps.setLocale();
				$('#nav').droppy({trigger: 'click'});
				
		  }
		});

}
 var stagename="";
 var atitle="";
 var values;
 var itemcode;
 var statusofarticle = "";

 
        function bindtable() { 
        	
            var message = $('#message');
            var tr = $('#rounded-corners').find('tr');
            <%if(!userDTO.getUserCustomer().equalsIgnoreCase("elsevierbookseries")){%>
            tr.bind('click', function(event) {
            	values=[];
                tr.removeClass('row-highlight');
                var tds = $(this).addClass('row-highlight').find('td');
                

                $.each(tds, function(index, item) {

                  values.push(item.innerHTML);
                
                });
                fetch_itemcode(values[1]);
                if("<%=roleid%>"=="RM1010"){
                	stagename=values[2];
                }else if("<%=roleid%>"=="RM1015"){
                	stagename=values[3];
                }
                else if("<%=roleid%>"=="RM1007"){
                	stagename=values[2];
                }
                atitle=values[7];
                statusofarticle = fetch_statusofarticle(values[9]);
               
                if("<%=roleid.equalsIgnoreCase("RM1015")%>"=="false")
                {
                	 showToolfields();
         		}
                if(stagename == "MASTER_COPY_EDITOR" || stagename=="PROOF_COLLATION"){


                	if("<%=roleid.equalsIgnoreCase("RM1010")%>"=="true")
                    {
						
                		$('.MsgNoArticleSelected').hide();
                		$('.PDFLeftContainer').show();
                		$('.PDFEdit').addClass('PDFEditFull');
                		$('.showStyleGuide').show();
                		$('.StyleGuide').show();
                		$('#changestagespan').hide();
                		$('.TitleContainer').addClass('S200Indicator');
                		$('.sHundred').html('');
                		$('.sHundred').html('<img src="<%=request.getContextPath() %>/authoringtool/gui/images/s200_btn.png">');
                		//$('.Step4').hide();
                		//$('.Step5').hide();
                		$('.left').removeClass('PDFEditFull');
						$('.EditorOuterContainer').show();
                		$('.EditorContainer').show();
                		//$('.ArticleLoader').show();
                   		$('.StyleGuide').show();
                   		$('.tabs_btn').show();
                   	
                   		$('.RightPanel_btn').show();

                	
                		
             		}
                	
                
                	
                }
                else if(stagename == "COPY_EDITOR"){


                	if("<%=roleid.equalsIgnoreCase("RM1010")%>"=="true")
                    {
	                	$('.PDFLeftContainer').show();
	                	$('.MsgNoArticleSelected').hide();
	                	$('.showStyleGuide').hide();
	                	$('#changestagespan').hide();
	                	$('.PDFEdit').hide();
	                	$('.TitleContainer').removeClass('S200Indicator');
	                	$('.sHundred').html('');
                		$('.sHundred').html('<img src="<%=request.getContextPath() %>/authoringtool/gui/images/s100_btn.png">');
                		$('.Step4').show();
                		$('.Step5').show();

                		$('.left').removeClass('PDFEditFull');
						$('.EditorOuterContainer').show();
                		$('.EditorContainer').show();
                		$('.ArticleLoader').show();
                   		$('.StyleGuide').show();
                   		$('.StyleGuideBtn').show();
                   		
                   		$('.tabs_btn').show();
                   		
                   		$('.RightPanel_btn').show();

                	



                		
                    }
                } else if(stagename == "AUTO_STRUCTURING" || stagename == "AUTO_STRUCTURING_FAIL"){


                	if("<%=roleid.equalsIgnoreCase("RM1010")%>"=="true")
                    {
	                	$('.PDFLeftContainer').show();
	                	$('.MsgNoArticleSelected').hide();
	                	$('.showStyleGuide').show();
	                	$('#changestagespan').hide();
	                	$('.PDFEdit').hide();
	                	$('.TitleContainer').removeClass('S200Indicator');
	                	$('.sHundred').html('');
                		$('.sHundred').html('<img src="<%=request.getContextPath() %>/authoringtool/gui/images/s100_btn.png">');
                		$('.Step4').show();
                		$('.Step5').show();
                		$('.left').removeClass('PDFEditFull');
						$('.EditorOuterContainer').show();
                		$('.EditorContainer').show();
                		$('.ArticleLoader').show();
                   		$('.StyleGuide').show();
                   		$('.tabs_btn').show();
                   		
                   		$('.RightPanel_btn').show();

                   		
                   		$('#load_proofcentral').hide();
                   		$('#load_p100').hide();
                   		$('#load_vnc').hide();


                		
                    }
                }


                else if(stagename == "QC"){


                	if("<%=roleid.equalsIgnoreCase("RM1010")%>"=="true")
                    {
                		$('#changestagespan').show();

                		$('.RightPanel_btn').show();
                		
	                	
                    }
                }
                else if(stagename == "AUTHOR_REVISION"){


                	if("<%=roleid.equalsIgnoreCase("RM1007")%>"=="true")
                    {
                		showarticle();
	                	
                    }
                }
                
                
            });
            <%}%>

        }
        function fetch_itemcode(val){
        	
        	var matched_content;
        	var queryLinkPattern = /<a(.*?)>(.*?)<\/a>/gi;
        	while ((matched_content = queryLinkPattern.exec(val))!= null) 
        	{
        		itemcode=matched_content[2];
        		
        	}
            }

  function fetch_statusofarticle(val){
        	
        	var matched_content;
        	var statusPattern = /<span>([^<]*?)<\/span>/gi;
        	while ((matched_content = statusPattern.exec(val))!= null) 
        	{
        		status=matched_content[1];
        		
        	}
        	return status;
            }


function displaypdfinpdfboxafterinterval(pdfpath){

	

	 var path="pdfmaster/web/pdfviewer.jsp?pdfpath="+pdfpath;
		var iframepath= "<%=request.getContextPath()%>/"+path+"?random="+new Date().getTime();
		$('#load_pdf').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"pdfframe\" id=\"pdfframe\">');


		$('.PDFLeftContainer').show();
		$('#load_pdf').show();
		$('.PDFEdit').show();
		$('.PDFEdit').addClass('PDFEditFull');
		$('.PDFEdit').removeClass('PDFEdit');
		$('.MsgNoArticleSelected').hide();
	
}


  
function displaypdfinpdfbox(pdfpath){
	 window.setTimeout(function(){displaypdfinpdfboxafterinterval(pdfpath);},5000);
}

  
    </script>
    
   
   <script type="text/javascript">
		function searchtable() {
			grid = $('#rounded-corners');
			var option;
			// handle search fields key up event
			$('#search-term').keyup(function(e) { 

				var search_option = $('#search_option').val();
				if(search_option == "1") {

					option="2";
				}
				
				else if(search_option == "2") {

					option="1";
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

var casescount = 0;
function collapsegrid(){
	
	
	if(casescount % 2 == 0){
		
		$('#datagrid_table').fadeOut(500);
		
	}
	else{
		$('#datagrid_table').fadeIn(500);

		}
	casescount = casescount+1;
	
	
}

function changestageofarticle(){
	if(itemcode!=null && itemcode!=""){

		$('#common_box').html("");
		$('#common_box').html("<table><tr><td>Change Stage ::</td><td> <select id = \"stagecombo\" style=\"display: block;\" onchange=\"setstage();\"><option value=\"NA\">-----------</option><option value=\"ST1004\">COPY_EDITOR</option></select></td></tr></table>");
		showboxtab();
	}else{
		
		fail_notice("some error occurred!!! (Please select an chapter)");

		}
	
}

function setstage(){
	var stageid = $('#stagecombo').val(); 

	if(stageid == "ST1004")
	{
		category="PSE";
		sendMessageToFMS(itemcode,"INFORMSTAGEBACKTOCE");
		
	}else if(stageid == "ST1024"){
		category="GRAPHICS";
		sendMessageToFMS(itemcode,"ALLOCATETOGRAPHICSFORFX");
		
	}

	<% if(customer_account.equalsIgnoreCase("elsevierbookseries")){%>

	updatechapterstage("ST1004");
	<%}else{%>
	
	setstageofarticle(stageid, category);
	<%}%>
	
	
}

function setstageofarticle(stageid, category){

	var filename=itemcode;
	$.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/setstageofarticle.jsp",
		  data: "filename="+filename+"&stageid="+stageid+"&category="+category ,
		  success: function(msg){
			  load_table_again();
		  }
		});


}
	</script>
</head>
<body>


<input type="text" id="hiddenstatus" name="hiddenstatus" style="display: none;" />
<div id="datagrid_table" style="height:80px;overflow:auto">

</div>
<div class="datagrid-mask-msg" id="mask" style="display: none; left:750px;">Processing, please wait ...</div>
</body>
</html>