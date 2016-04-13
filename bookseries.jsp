<!DOCTYPE html PUBLIC >
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="td.xbp.model.UserDTO"%>
<%@ page import="td.xbp.model.BdusersDTO" %>
<%
  
  String getProtocol=request.getScheme();
  String getDomain=request.getServerName();
  String getPort=Integer.toString(request.getServerPort());
  
  String getPath = getProtocol+"://"+getDomain+":"+getPort+"/";
  String getPathwithoutport = getProtocol+"://"+getDomain+"/";
  
  String getPathwithoutnewport = getProtocol+"://"+getDomain+":8086/";
  
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Thomson Digital :: TD-XPS</title>
<link href="<%=request.getContextPath() %>/authoringtool/gui/css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/authoringtool/gui/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/authoringtool/gui/css/jquery.countdown.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/authoringtool/gui/css/hint.css">

<!--[if IE 7]>
  <link rel="stylesheet" href="css/font-awesome-ie7.min.css">
<![endif]-->

<script type="text/javascript" src="<%=request.getContextPath() %>/authoringtool/gui/js/progressbar.js"></script>

	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/authoringtool/gui/css/progressbar.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/authoringtool/gui/skins/default/progressbar.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/authoringtool/gui/skins/jquery-ui-like/progressbar.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/authoringtool/gui/skins/tiny-green/progressbar.css">	

<!--New Progressbar / -->

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/ce.js"></script>
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>


<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type='text/javascript' src='<%=request.getContextPath() %>/authoringtool/gui/js/jquery.droppy.js'></script>

<script src="<%=request.getContextPath() %>/authoringtool/js/generalFormChecks.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/authoringtool/popup-window.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/authoringtool/popup-window.js"></script>


<script type="text/javascript" src="<%=request.getContextPath() %>/signin/onlinecontribution/editor/jscripts/tiny_mce/tiny_mce.js"></script>

<script src="http://172.16.0.53:8080/sproxy/sproxy?cmd=script&doc=wsc&schema=118"></script>
<%
String name="tdxps";
// UserDTO userDTO =   (UserDTO)session.getAttribute("userDTO");
BdusersDTO userDTO = (BdusersDTO)session.getAttribute("userDTO");

String	customer_account="";
String displayname = "";
String role = "";
if(userDTO !=null)   
{ 
	name=userDTO.getEmpName();
	customer_account = userDTO.getUserCustomer();
// 	displayname = userDTO.getDisplayname();
	
	role = userDTO.getRole().toUpperCase();
	
	if(role.equalsIgnoreCase("SYSTEM ADMINISTRATOR")){
		role = "SYSTEM ADMIN";
		
	}
}   
else  
	{%>
<script>
window.location.href="<%=request.getContextPath() %>/signin/login/login.jsp?user=0&pass=1";

</script>
<%
	}   
%>


<script type="text/javascript">

//-------plugin for file menu ------//

tinymce.create('tinymce.plugins.ExamplePlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'filemenu':  
	 var c = cm.createMenuButton('filemenu', {
	 title : 'File',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/1.jpg',
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 
	var sub; 
	 m.add({title : 'New',onclick : function() {  
	 tinyMCE.activeEditor.execCommand('mceNewDocument', false, 'New');  
	}});  
	 m.add({title : 'Open', onclick : function() 
	 	{     
			 open_f();
	 	}});   
	 m.add({title : 'Import word Document', onclick : function() 
		 {     
			tinyMCE.activeEditor.execCommand('mcePasteWord', false, 'Import word Document');  
		 }}); 
	 m.add({title : 'SaveAs ',onclick : function() 
		 {     
		 if ( $.browser.msie ) {
			 document.editor.sub.click();
			 }
		 else if( $.browser.mozilla){
			 
			  filesaver();

			  }
		 }});
	 m.add({title : 'Print', onclick : function() 
		 {     
			tinyMCE.activeEditor.execCommand('mcePrint', false, 'Print');  
		 }});                      
     });                                 
       return c;      
      }        
    return null;      
       } });  
tinymce.PluginManager.add('example', tinymce.plugins.ExamplePlugin); 
//-------End of plugin for file menu ------//

//------- plugin for customised list button ------//

tinymce.create('tinymce.plugins.custlistPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'custlist':  
	 var c = cm.createMenuButton('custlist', {
	 title : 'Customised list',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/jscripts/tiny_mce/plugins/liststyle/img/liststyle.gif', 
	 icons : false  , 
	 onclick : function () {  
		generatePopupforCustomisedlist();
  		}     
	  });                     
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('custlist', tinymce.plugins.custlistPlugin); 
//------- end of plugin for list button ------//



//------- plugin for tts_speech button ------//

tinymce.create('tinymce.plugins.Tts_startPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'tts_start':  
	 var c = cm.createMenuButton('tts_start', {
	 title : 'Start Speech',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/play.jpg', 
	 icons : false  , 
	 onclick : function () {  
		alert();
  		}     
	  });                     
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('tts_start', tinymce.plugins.Tts_startPlugin); 
//------- end of plugin for tts_speech button ------//

//------- plugin for TOC button ------//

tinymce.create('tinymce.plugins.tocPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'toc':  
	 var c = cm.createMenuButton('toc', {
	 title : 'Generate TOC',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/tableofcontent.png', 
	 icons : false  , 
	 onclick : function () {  
		 generateIdForTOC();
  		}     
	  });                     
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('toc', tinymce.plugins.tocPlugin); 
//------- end of plugin for TOC button ------//

//-------plugin for wiley tools menu ------//
tinymce.create('tinymce.plugins.WileyToolsPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'WileyTools':  
	 var c = cm.createMenuButton('WileyTools', {
	 title : 'Tools',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/Tools.jpg',  
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 

	 m.add({title : 'Apply Punctuation', onclick : function() {  
		 callStructureEngineForWiley("applypunctuation");
		}});   
		
     });                                   
       return c;      
      }        
    return null;      
       } });  
tinymce.PluginManager.add('WileyTools', tinymce.plugins.WileyToolsPlugin); 
//-------end of plugin for wiley tools menu ------//


//------- plugin for mathFlow button ------//
tinymce.create('tinymce.plugins.mathFlowPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'mathFlow':  
	 var c = cm.createMenuButton('mathFlow', {
	 title : 'Math Flow',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/math.png', 
	 icons : false  , 
	 onclick : function () {  
		 
		 openMathML();
  }     
	  });
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('mathFlow', tinymce.plugins.mathFlowPlugin); 
//-------End of plugin for mathFlow button ------//
//------- plugin for savenew button ------//
tinymce.create('tinymce.plugins.savenewPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'savenew':  
	 var c = cm.createMenuButton('savenew', {
	 title : 'Save',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/save.png', 
	 icons : false  , 
	 onclick : function () {  
		 
		saveedfile();
  }     
	  });
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('savenew', tinymce.plugins.savenewPlugin); 
//-------End of plugin for mathFlow button ------//
//------- plugin for qc button ------//
tinymce.create('tinymce.plugins.QCPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'QC':  
	 var c = cm.createMenuButton('QC', {
	 title : 'Copy editing checks',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/qc.png', 
	 icons : false  , 
	 onclick : function () {  
		 qcCommonTool();
	 }	
	 });
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('QC', tinymce.plugins.QCPlugin); 
//-------End of plugin for qc button ------//
//------- plugin for QCREF button ------//
tinymce.create('tinymce.plugins.QCREFPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'QCREF':  
	 var c = cm.createMenuButton('QCREF', {
	 title : 'Copy editing checks(References)',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/qcref.png', 
	 icons : false  , 
	 onclick : function () {  
		 qcReferenceTool();
  }     
	  });
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('QCREF', tinymce.plugins.QCREFPlugin); 
//-------End of plugin for qc button ------//
//------- plugin for sqc button ------//
tinymce.create('tinymce.plugins.SQCPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'SQC':  
	 var c = cm.createMenuButton('SQC', {
	 title : 'Pre copy editing checks',
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/qcpre.png', 
	 icons : false  , 
	 onclick : function () {  
		sqcTool();
  }     
	  });
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('SQC', tinymce.plugins.SQCPlugin); 
//-------End of plugin for sqc button ------//

//------- plugin for pubmed button ------//
tinymce.create('tinymce.plugins.pubmedPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'pubmed':  
	 var c = cm.createMenuButton('pubmed', {
	 title : 'Pubmed',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/pubmed.png', 
	 icons : false  , 
	 onclick : function () {  
		 view_pubmed();
  }     
	  });
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('pubmed', tinymce.plugins.pubmedPlugin); 
//-------End of plugin for pubmed button ------//


//-------plugin for edit menu ------//
tinymce.create('tinymce.plugins.EditPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'editmenu':  
	 var c = cm.createMenuButton('editmenu', {
	 title : 'Edit',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/2.jpg',  
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 
	var sub; 
	 m.add({title : 'Undo',onclick : function() {  
	 tinyMCE.activeEditor.execCommand('Undo', false, 'Undo');  
	}});  
	 m.add({title : 'Redo',onclick : function() 
	 {     
	tinyMCE.activeEditor.execCommand('Redo', false, 'Redo');  
	    }});   
	 m.add({title : 'Cut', onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('Cut', false, 'Cut');  
		    }}); 
	 m.add({title : 'Copy', onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('Copy', false, 'Copy');  
		    }});
	 m.add({title : 'Paste', onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('Paste', false, 'Paste');  
		    }});          
	 m.add({title : 'Select All', onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('SelectAll', false, 'Select All');  
		    }});     
	 m.add({title : 'Find', onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('mceSearch', false, 'Find');  
		    }});                
     });                                  
       return c;      
      }        
    return null;      
       } });  

tinymce.PluginManager.add('editmenu', tinymce.plugins.EditPlugin); 
//-------end of plugin for edit menu ------//

//-------plugin for view menu ------//
tinymce.create('tinymce.plugins.ViewPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'viewmenu':  
	 var c = cm.createMenuButton('viewmenu', {
	 title : 'View',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/3.jpg', 
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 
	var sub; 
	 m.add({title : 'Xhtml View', onclick : function() 
	 {     
	tinyMCE.activeEditor.execCommand('mceCodeEditor', false, 'Xhtml View');  
	    }});   
	 m.add({title : 'Popout/Collapse',onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('mceFullScreen', false, 'Popout'); 
		
		    }});  
	 m.add({title : 'Show Paragraph Markers',onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('mceVisualChars', false, 'Show Paragraph Markers'); 
		
		    }});                          
     });                                    
       return c;      
      }        
    return null;      
       } });  
tinymce.PluginManager.add('viewmenu', tinymce.plugins.ViewPlugin); 
//-------end of plugin for view menu ------//

//-------plugin for insert menu ------//
tinymce.create('tinymce.plugins.InsertPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'insertmenu':  
	 var c = cm.createMenuButton('insertmenu', {
	 title : 'Insert',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/Ins.jpg',  
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 
	var sub; 
	 m.add({title : 'Insert Hyperlink', onclick : function() {  
	 tinyMCE.activeEditor.execCommand('mceLink', false, 'Insert Hyperlink');  
	}});  

	 m.add({title : 'Remove Hyperlink', onclick : function() 
	 {     
	tinyMCE.activeEditor.execCommand('unlink', false, 'Remove Hyperlink');  
	    }});   
	
	 m.add({title : 'Insert Image', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceImage', false, 'Insert Image');  
		}});  
		 m.add({title : 'Insert Symbol', onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('mceCharMap', false, 'Insert Symbol');  
		    }});   
		 m.add({title : 'Insert Horizontal Rule', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('mceAdvancedHr', false, 'Insert Horizontal Rule');  
			    }});   
		 m.add({title : 'Insert Date', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('mceInsertDate', false, 'Insert Date/Time');  
			    }});       
		 m.add({title : 'Insert Time', onclick : function() {  
			 tinyMCE.activeEditor.execCommand('mceInsertTime', false, 'Insert Time');  
			}});   
		 m.add({title : 'Insert Math Equation', onclick : function() 
			 {     
				 openMathML();
			    }});   
			 m.add({title : 'Insert ISM', onclick : function() 
				 {     
				 ism();
				    }});  

			 m.add({title : 'Insert Exam Questions', onclick : function() 
				 {     
				 insert_exam_questions();
				    }});  
			 m.add({title : 'Insert Exam answers', onclick : function() 
				 {     
				 insert_exam_answers();
				    }});  
			    
			 m.add({title : 'Insert Tags', onclick : function() 
				 {     
				 insert_tagging();
				    }});  
			 m.add({title : 'Insert Utilities', onclick : function() 
				 {     
				 insert_utils();
				    }});   
			 m.add({title : 'Insert MMC', onclick : function() 
				 {     
				 insert_mmc();
				    }}); 
			
			 m.add({title : 'Insert linking styles', onclick : function() 
				 {     
				 insert_linking_styles();
				    }}); 
			 
			 
			   m.add({title : 'Insert SPONSOR', onclick : function() 
					 {     
			    	insert_sponser();
					    }});
			 m.add({title : 'Insert Endnote', onclick : function() 
				 {     
				 insert_endnote();
				    }});   
			 m.add({title : 'Insert Query', onclick : function() 
				 {     
				 insertquery();
				    }});  
			 m.add({title : 'Insert Appendix', onclick : function() 
				 {     
				 insert_appendix();
				    }});  
			 m.add({title : 'Insert Author Endmark', onclick : function() 
				 {     
				 insert_author_endmark();
				    }});  
			 m.add({title : 'Insert Textbox Endmark', onclick : function() 
				 {     
				 insert_textbox_endmark();
				    }}); 
			 m.add({title : 'Insert Graphical Abstract', onclick : function() 
				 {     
				 insertGraphicalHighlights();
				    }});         
			 m.add({title : 'Insert Appendix output label', onclick : function() 
				 {     
				 insertappendixoutputlabel();
				    }});         
     });                                 
       return c;      
      }        
    return null;      
       } });  
tinymce.PluginManager.add('insertmenu', tinymce.plugins.InsertPlugin); 

//-------end of plugin for insert menu ------//

//------- plugin for placeholder button ------//
tinymce.create('tinymce.plugins.placeholderPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'placeholder':  
	 var c = cm.createMenuButton('placeholder', {
	 title : 'Insert Place Holder',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/icn_tags.png', 
	 icons : false  , 
	 onclick : function () {  
		insert_place_holder();
  }     
	  });
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('placeholder', tinymce.plugins.placeholderPlugin); 
//-------End of plugin for placeholder button ------//

//-------plugin for format menu ------//
tinymce.create('tinymce.plugins.FormatPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'formatmenu':  
	 var c = cm.createMenuButton('formatmenu', {
	 title : 'Format',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/fmt.jpg',  
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 
	var sub; 
	 m.add({title : 'Bold',onclick : function() {  
	 tinyMCE.activeEditor.execCommand('Bold', false, 'Bold');  
	}});  
	 m.add({title : 'Italic', onclick : function() 
	 {     
	tinyMCE.activeEditor.execCommand('Italic', false, 'Italic');  
	    }});   
	 m.add({title : 'Underline', onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('Underline', false, 'Underline');  
		    }});
	 m.add({title : 'Align Left', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('JustifyLeft', false, 'Align Left');  
		}});  
		 m.add({title : 'Align Center', onclick : function() 
		 {     
		tinyMCE.activeEditor.execCommand('JustifyCenter', false, 'Align Center');  
		    }});   
		 m.add({title : 'Align Right', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('JustifyRight', false, 'Align Right');  
			    }});   
		 m.add({title : 'Align Full', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('JustifyFull', false, 'Align Full');  
			    }});     
		 m.add({title : 'Unordered List', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('InsertUnorderedList', false, 'Unordered List');  
			    }});  
		 m.add({title : 'Ordered List', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('InsertOrderedList', false, 'Ordered List');  
			    }}); 
		 m.add({title : 'Decrease Indent', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('Outdent', false, 'Decrease Indent');  
			    }});  
		 m.add({title : 'Increase Indent', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('Indent', false, 'Increase Indent');  
			    }});   
		 m.add({title : 'Superscript', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('superscript', false, 'Superscript');  
			    }});   
		 m.add({title : 'Subscript', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('subscript', false, 'Subscript');  
			    }});   
		 m.add({title : '80% Grey', onclick : function() 
			 {     
			applygrey();
			    }});   
		 m.add({title : 'Remove Formatting', onclick : function() 
			 {     
			tinyMCE.activeEditor.execCommand('RemoveFormat', false, 'Remove Formatting');  
			    }});   
     });                                 
       return c;      
      }        
   	 return null;      
       } });  
tinymce.PluginManager.add('formatmenu', tinymce.plugins.FormatPlugin); 
//-------end of plugin for format menu ------//

//-------plugin for tools menu ------//
tinymce.create('tinymce.plugins.ToolsPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'toolsmenu':  
	 var c = cm.createMenuButton('toolsmenu', {
	 title : 'Tools',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/Tools.jpg',  
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 
			var sub; 
			var sub1; 
			// changes for removing applets from the auto structure
			 sub = m.addMenu({title : 'Auto Structure'}); 
	 sub1 = sub.addMenu({title : 'Autoreference'}); 
	 sub1.add({title : 'Author Etal 6', onclick : function() { 

		 applyAutoReference(6);
			
	  }}); 
	 sub1.add({title : 'Author Etal 3', onclick : function() { 

		 applyAutoReference(3);
					
			  }}); 
	 sub1.add({title : 'Author Etal 1', onclick : function() { 

		 applyAutoReference(1);
					
			  }}); 
	 sub1.add({title : 'None', onclick : function() { 

		 applyAutoReference(100);		
			  }}); 
	 sub2 = sub.addMenu({title : 'Structured Autoreference'}); 
	 sub2.add({title : 'Author Etal 6', onclick : function() { 

		 callStructureEngine("etalProcessorBy6");
			
	  }}); 
	 sub2.add({title : 'Author Etal 3', onclick : function() { 

		 callStructureEngine("etalProcessorBy3");
					
			  }}); 
	 sub2.add({title : 'Author Etal 1', onclick : function() { 

		 callStructureEngine("etalProcessorBy1");
					
			  }}); 
	 sub2.add({title : 'None', onclick : function() { 

		 callStructureEngine("etalProcessor");
			  }});
	  
			 sub.add({title : 'Sort(Style 2)', onclick : function() { 

				 callStructureEngine("referenceSorting");
							
					  }}); 
			 sub.add({title : 'Sort(Style 5)', onclick : function() { 

				 callStructureEngine("referenceSortingStyle5");
							
					  }}); 
			 sub.add({title : 'Uncited Reference', onclick : function() { 

				 callStructureEngineUncitedreference("addUncitedReferences");
							
					  }}); 
			 sub.add({title : 'Style(5 to 2)', onclick : function() { 

				 callStructureEngine("style5to2");
							
					  }}); 
			 sub.add({title : 'Identical Reference', onclick : function() { 

				 callStructureEngine("removeIdenticalReferences");
							
					  }}); 
			 sub.add({title : 'Style 5', onclick : function() { 

				 callStructureEngine("addUncitedReferencesStyle5");
							
					  }}); 
			 sub.add({title : 'Style 2', onclick : function() { 

				 callStructureEngine("addUncitedReferencesStyle2");
							
					  }});
			  
			 sub = m.addMenu({title : 'Reorder Elements'}); 
			 sub.add({title : 'Float Elements', onclick : function() { 

				 callStructureEngine("renumberFloat");
					
			  }}); 
			 sub.add({title : 'Equations', onclick : function() { 

				 callStructureEngine("renumberEquations");
							
					  }}); 
			 sub.add({title : 'Endnotes', onclick : function() { 

				 callStructureEngine("renumberEndnotes");
							
					  }}); 
			 sub.add({title : 'References', onclick : function() { 

				 callStructureEngine("renumberReferences");
					//add method name
							
					  }});
			 sub = m.addMenu({title : 'Label Swapper'}); 
			 sub.add({title : 'Swap Labels', onclick : function() { 

				 callStructureEngine("labelSwapper");
					
			  }}); 
			
			 m.add({title : 'Spell Check', onclick : function() {  
			 tinyMCE.activeEditor.execCommand('mceIESpell', false, 'Spell Check');  
			}});   
			 m.add({title : 'Change Case', onclick : function() {  
				 changecase_short();
				}});   
			 m.add({title : 'Auto Label ', onclick : function() {  
				 autolabel();
				}});     
			 m.add({title : 'Apply styles', onclick : function() {  
				 open_custom_style_pop();
				}});  
			 m.add({title : 'Validate URL', onclick : function() {  
				 validateurlintinymce();
				}});  
			 m.add({title : 'Remove queries', onclick : function() {  
				 removequeries();
				}}); 
			 m.add({title : 'StyleSheet Viewer', onclick : function() {  
				 viewStyleSheetofParticularJournal();
				}});  
				
		     });                                   
		       return c;      
		      }        
		    return null;      
		       } });  
tinymce.PluginManager.add('toolsmenu', tinymce.plugins.ToolsPlugin); 
//-------end of plugin for tools menu ------//

//-------plugin for table menu ------//
tinymce.create('tinymce.plugins.TablesPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'tablemenu':  
	 var c = cm.createMenuButton('tablemenu', {
	 title : 'Table',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/Table.jpg',
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 
	var sub; 
	 m.add({title : 'Insert Table', onclick : function() {  
	 tinyMCE.activeEditor.execCommand('mceInsertTable', false, 'Insert Table');  
	}});   
	 m.add({title : 'Delete Table', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableDelete', false, 'Delete Table');  
		}}); 
	 m.add({title : 'Delete Column', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableDeleteCol', false, 'Delete Table');  
		}}); 
	 m.add({title : 'Delete Row', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableDeleteRow', false, 'Delete Row');  
		}}); 
	 m.add({title : 'Insert Row Before', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableInsertRowBefore', false, 'Insert Row Before');  
		}}); 
	 m.add({title : 'Insert Row After', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableInsertRowAfter', false, 'Insert Row After');  
		}}); 
	 m.add({title : 'Insert Column Before', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableInsertColBefore', false, 'Insert Column Before');  
		}}); 
	 m.add({title : 'Insert Column After', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableInsertColAfter', false, 'Insert Column After');  
		}}); 
	 m.add({title : 'Split Merged Table Cells', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableSplitCells', false, 'Split Merged Table Cells');  
		}}); 
	 m.add({title : 'Merge Table Cells', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableMergeCells', false, 'Merge Table Cells');  
		}}); 
	 m.add({title : 'Table Row Properties', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableRowProps', false, 'Table Row Properties');  
		}}); 
	 m.add({title : 'Table Cell Properties', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('mceTableCellProps', false, 'Table Cell Properties');  
		}}); 
	 m.add({title : 'Table Alignment', onclick : function() {  
		 table_align_pop();
		}});
     });                                     
       return c;      
      }        
    return null;      
       } });  
tinymce.PluginManager.add('tablemenu', tinymce.plugins.TablesPlugin); 
//-------end of plugin for table menu ------//

//-------plugin for track menu ------//
tinymce.create('tinymce.plugins.TrackPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'trackmenu':  
	 var c = cm.createMenuButton('trackmenu', {
	 title : 'Track Changes',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/TC.jpg',
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 
	var sub; 
	 m.add({title : 'Enable Track Changes', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('ice_toggleshowchanges', false, 'Enable Track Changes');  
		 tinyMCE.activeEditor.execCommand('ice_togglechanges', false, 'Enable Track Changes');  
	}});   
	 m.add({title : 'Accept Changes', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('iceaccept', false, 'Accept Changes');  
	}});   
	 m.add({title : 'Reject Changes', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('icereject', false, 'Reject Changes');  
	}});   
	 m.add({title : 'Accept All Changes', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('iceacceptall', false, 'Accept All Changes');    
		}});
	 m.add({title : 'Reject All Changes', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('icerejectall', false, 'Reject All Changes');    
		}});		
	 m.add({title : 'Show Track Changes', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('ice_toggleshowchanges', false, 'Show Track Changes');  
		}}); 
	 m.add({title : 'Disable Track Changes', onclick : function() {  
		 tinyMCE.activeEditor.execCommand('ice_toggleshowchanges', false, 'Disable Track Changes');  
		 tinyMCE.activeEditor.execCommand('ice_togglechanges', false, 'Disable Track Changes');    
		}}); 
     });                                    
       return c;      
      }        
    return null;      
       } });  
tinymce.PluginManager.add('trackmenu', tinymce.plugins.TrackPlugin); 
//-------end of plugin for track menu ------//
                                             
//-------plugin for open button ------//                                                                                                                                                                                                                                                                                                                                                                                                 
tinymce.create('tinymce.plugins.OpenPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'open':  
	 var c = cm.createMenuButton('open', {
	 title : 'open',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/open_file.png', 
	 icons : false  , 
	 onclick : function () {  
		 open_f();
      }     
	  });
       return c;      
      }        
    return null;      
       } });  
tinymce.PluginManager.add('open', tinymce.plugins.OpenPlugin); 
//-------end of plugin for open button ------//



//-------plugin for ce menu ------//
tinymce.create('tinymce.plugins.CEPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'cemenu':  
	 var c = cm.createMenuButton('cemenu', {
	 title : 'CE Features',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/CE.jpg',  
	 icons : false   
	  });
	 c.onRenderMenu.add(function(c, m) { 
	var sub; 
		  sub = m.addMenu({title : 'Change Case'}); 
		  sub.add({title : 'Lower case', onclick : function() { 
		lowercase(); 
		  }}); 
		  sub.add({title : 'Upper Case', onclick : function() { 
				uppercase();
				}});  
		  sub.add({title : 'Title Case', onclick : function() { 
				 titlecase();
				}});  
		  sub.add({title : 'Sentence Case', onclick : function() { 
				 sentencecase();
				}});  
		sub = m.addMenu({title : 'Text Based'}); 
		sub.add({title : 'CE Routine Checks 1', onclick : function() { 
			CEroutineChecks1();
			 }}); 
		sub.add({title : 'CE Routine Checks 2', onclick : function() { 
			CEroutineChecks2();
			 }});
		//sub.add({title : 'Insert thin Space before and after operators', onclick : function() { 
			//addThinSpaceBeforeOperators();
			//}}); 

		// sub.add({title : 'Remove space in bold/italic', onclick : function() { 
			// nospaceinboldoritalic();
			//		 }}); 
		 sub.add({title : 'Close Up H,C with number of H,C', onclick : function() { 
			 closeUpHandC();
			 }});
		 //sub.add({title : 'xps ref linking', onclick : function() { 
			// xps_reflinking();
			// }});
		// sub.add({title : 'Close up Initials', onclick : function() { 
			//closeUpInitials();
			// }});
		 sub.add({title : 'Remove bold style from table and figure caption', onclick : function() { 
				figTableCaptionBoldtoNormal();
				}}); 
			sub.add({title : 'Insert space before and after inline equation', onclick : function() { 
				spaceBeforeorAfterMath();
				}});
		 sub.add({title : 'Delete space', onclick : function() { 
				delete_space_specialchars();
				}});
		 	sub.add({title : 'Double Punctuation', onclick : function() { 
		 		doublePunctuation();
				}});
		 	
		 	sub.add({title : 'Double Spaces', onclick : function() { 
		 		doubleSpaces();
				}});
		 	//sub.add({title : 'Check Corresponding Author', onclick : function() { 
				//CheckCorrespondingAuthor();
				//}});

		 	sub.add({title : '1C-NMR ', onclick : function() { 
				superScriptNumber();
				}});

		 	sub.add({title : 'Correct H1 text', onclick : function() { 
				correctText();
				}});
		 	sub.add({title : 'en-Rules(-OCH3, -CH2CH3) ', onclick : function() { 
				enRules();
				}});
		 	sub.add({title : 'NOESY,COSY(H-H,H-C)', onclick : function() { 
				noesyCosy();
				}});
		 	
		sub.add({title : 'Replacing Comma', onclick : function() { 
		replace_comma();
		 }});
		sub.add({title : 'Replace Lambda', onclick : function() { 
		changeLamda();
		  }});
		sub.add({title : 'Thousand separator', onclick : function() { 
			thousand_sep();
			  }});
		 sub.add({title : 'Replacing nOe', onclick : function() { 
		 replace_nOe();
	 	 }});
		 //sub.add({title : 'Insert Grant Sponser', onclick : function() { 
		// insertgs();
		// }});
		// sub.add({title : 'Insert Grant Number', onclick : function() { 
		// insertgn();
		// }});
		// sub.add({title : 'Insert Role', onclick : function() { 
		// insertrl();
		// }});
  		 sub.add({title : 'Insert comments tag', onclick : function() { 
  	  	insertcomment();
  		 }});   
	 	
		sub.add({title : 'Arc Second', onclick : function() { 
		arc_sec();
		}});  
		sub.add({title : 'Arc Minute', onclick : function() { 
		arc_min();
		}});  
		sub.add({title : 'superscript degree', onclick : function() { 
		superscript1();
		}}); 
		sub.add({title : 'Hyphen to minus', onclick : function() { 
			hyphentominus();
			}}); 
		sub.add({title : 'Insert full stop at para , table caption and figure caption end', onclick : function() { 
			fullstopatparaend();
			}}); 
		/*sub.add({title : 'Full stop at fig caption end', onclick : function() { 
			fullstopatfigcaptionend();
			}});  
		 sub.add({title : 'full stop at table caption end', onclick : function() { 
			 fullstopattablecaptionend();
				 }});*/
		sub.add({title : 'super-sub script', onclick : function() { 
		suptosub();
		}});  
	
		sub.add({title : ' UV_Hyphen', onclick : function() { 
		uv_hyphen();
		}}); 
	
		sub.add({title : ' S.I Units ', onclick : function() { 
		callall();
		}}); 
		//sub.add({title : 'Treatment of MS', onclick : function() { 
		//feature73();
		//}});

		sub.add({title : 'Degree to DegreeC for FRENCH', onclick : function() { 
			convertDegreeToDegreeCForFR();
		}});
		sub.add({title : 'Decimal Dot to Comma for FRENCH', onclick : function() { 
			convertDecimalDotToCommaForFR();
		}}); 
		sub.add({title : 'Thinspace Before Percentage for FRENCH', onclick : function() { 
			thinSpaceBeforePercentageForFR();
		}}); 
		sub.add({title : 'Check subscript superscript FRENCH', onclick : function() { 
			charactersNotAllowedInSuperscriptSubscript();
		}});
		sub.add({title : 'Change accent(A) FOR FRENCH', onclick : function() { 
			checkForAccentLetterFr();
		}});		
		sub.add({title : 'Check Letter N, P, X, IN FRENCH', onclick : function() { 
			checkingLetterN_P_X();
		}}); 				  			
     });                               
       return c;      
      }        
    return null;      
       } });  
tinymce.PluginManager.add('cemenu', tinymce.plugins.CEPlugin);
//-------end of plugin for ce menu ------//
 
var spellcheckevent = "false";
//var WSCCorePath = "http://172.16.0.53:8080/sproxy/sproxy?cmd=script&doc=wsc&plugin=tinymce3";
   function setup() {
	tinyMCE.init({
		// General options
		
		mode : "textareas",
		theme : "advanced",
		//skin: "lightgray",
		editor_deselector : "mceNoEditor",
		plugins : plugins,
		 auto_focus : "elm1",
		 oninit : makeeditordisableinauthorrole,
		
		 //max_chars : 100,
		 //max_chars_indicator : "lengthBox",
		
		// Theme options
		height : "604",
		width: "100%",

		wsc_popup_title :"Custom Popup Title",
		wsc_lang :"en_US",
		wsc_top: 218,
		wsc_left: 5,

		wsc_onFinish: function(){ 
		spellcheckevent = "true";
		}, 
		wsc_onCancel: function(){ 
		spellcheckevent = "false";
		},
		
		//theme_advanced_blockformats : 'article,section,figure,aside,pre',
		//theme_advanced_buttons1 : theme_advanced_buttons1,
		theme_advanced_buttons1 : theme_advanced_buttons1,
		theme_advanced_buttons2 : theme_advanced_buttons2,
		theme_advanced_buttons3 : theme_advanced_buttons3,
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,
		schema : "html5",
		//tinyautosave_oninit: "configAutoSave",		
		tinyautosave_interval_seconds: 20,
		custom_elements: "sahil,gn1",
		content_css : cssfile,
		
		// Drop lists for link/image/media/template dialogs
		template_external_list_url : "<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/lists/template_list.js",
		external_link_list_url : "lists/link_list.js",
		external_image_list_url : "<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/lists/image_list.js",
		media_external_list_url : "<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/lists/media_list.js",
		extended_valid_elements: "p[*],span[*],delete[*],insert[*],a[*]",
		
			ice: {
				user: { name: '<%=name%>', id: 11},
				//preserveOnPaste: 'p,a[href],i,em,b,span[*]',
				//deleteTag: 'delete',
				//insertTag: 'insert'
			},
			
			formats : custom_style,

        	style_formats : style,
        	
        	convert_urls : false,
         	

//********************
	// entities : '382,zacute,253,yacute,225,aacute', 

	 entity_encoding : "numeric",

//***************************

	 setup : function(ed) {  

				//peform this action every time a key is pressed
				 ed.onKeyUp.add(function(ed, e) {
					 <% if(userDTO.getRoleid().equalsIgnoreCase("RM1007")){%>
				if(!exactviewcharflag){
				
					 var  tinylen, htmlcount;
					
				 tinylen = getStats('content').chars;
			
				//setting up the text string that will display in the path area
				 //htmlcount = "You have exceeded the limit of  : " + tinylen + "/" + tinymax;
				 //if the user has exceeded the max turn the path bar red.
				 
				 if (tinylen>tinymax) {
					htmlcount = "You have exceeded the limit of "+wordslimit+" words";
				  htmlcount = "<span style='font-weight:bold; color: #f00;'>" + htmlcount + "</span>";
				  tinymce.DOM.setHTML(tinymce.DOM.get(tinyMCE.activeEditor.id + '_path_row'), htmlcount);  
				  alert("You have exceeded the limit of "+wordslimit+" words");
				 }
				 
				 //tinyMCE.editors["mytextarea1"].settings.charLimit = 3000; 
				 //this line writes the html count into the path row of the active editor
				 //tinymce.DOM.setHTML(tinymce.DOM.get(tinyMCE.activeEditor.id + '_path_row'), htmlcount);  
				 
				}
				<% }%>
				 });



				ed.onInit.add(function(ed) {

					
					 ed.addShortcut('ctrl+e','insert tagging', insert_tagging, this);
					 ed.addShortcut('ctrl+s','save file', saveedfile, this);
					 ed.addShortcut('ctrl+q','Superscript', sup, this);
					 ed.addShortcut('ctrl+w','Subscript', sub, this);
					 ed.addShortcut('ctrl+l','google_tool', google_tool, this);
					 ed.addShortcut('ctrl+t','table_align_pop', table_align_pop, this);
					 ed.addShortcut('ctrl+5','insertquery', insertquery, this);
					 ed.addShortcut('ctrl+n','insert_thin_space', insert_thin_space, this);
					 ed.addShortcut('ctrl+shift+7','insert_appendix', insert_appendix, this);
					 ed.addShortcut('ctrl+m','changecase_short', changecase_short, this);
					 ed.addShortcut('ctrl+k','insert_EnDash', insert_EnDash, this);
					 ed.addShortcut('ctrl+j','insert_endnote', insert_endnote, this);
					 ed.addShortcut('ctrl+d','insert_author_endmark', insert_author_endmark, this);
					 ed.addShortcut('ctrl+p','autolabel', autolabel, this);
					 ed.addShortcut('ctrl+o','insertGraphicalHighlights', insertGraphicalHighlights, this);
					 ed.addShortcut('ctrl+1','insert_PN', insert_PN, this);
					 ed.addShortcut('ctrl+2','insert_PL', insert_PL, this);
					 ed.addShortcut('ctrl+3','removeFormatting', removeFormatting, this);
					 ed.addShortcut('ctrl+4','sqcTool', sqcTool, this);
					 ed.addShortcut('ctrl+7','insertappendixoutputlabel',insertappendixoutputlabel, this);
					 ed.addShortcut('ctrl+6','mceVisualBlocks','mceVisualBlocks', this);
					 ed.addShortcut('ctrl+8','insertmultiply',insert_multiply, this);
					 ed.addShortcut('ctrl+9','insert_minus',insert_minus, this);
					 ed.addShortcut('ctrl+0','applyautoreferencebynone',applyautoreferencebynone, this);
					 ed.addShortcut('ctrl+shift+1','applystylecountry',applystylecountry, this);
					 ed.addShortcut('ctrl+shift+2','applystylecity',applystylecity, this);
					 ed.addShortcut('ctrl+shift+3','applystylestate',applystylestate, this);
					 ed.addShortcut('ctrl+shift+4','applystylesmallcaps',applystylesmallcaps, this);
					 ed.addShortcut('ctrl+shift+5','insert_place_holder',insert_place_holder, this);
					 ed.addShortcut('ctrl+shift+6','insert_linking_styles',insert_linking_styles, this);
					// ed.addShortcut('ctrl+shift+7','applycasesincontent',applycasesincontent, this);
					 
					 <% if(userDTO.getRoleid().equalsIgnoreCase("RM1007")){%>	 
					 //bind method c to restrict user to enter text after the limit has crossed.
					var t = this;
					t.editor = ed;
					ed.onKeyUp.add(c, t);					
					<% }%>
								//var t = this;
								//ed.onNodeChange.add(d,t);
					
                });
				ed.onDblClick.add(function(ed, e) {

					doubleclickonmathsimage("<%=request.getContextPath()%>", "<%=getPath%>");

			//	 alert("e.target.parentNode:::"+(e.target.parentNode).className);
			//	 alert("e.target.className::::"+e.target.className);
			//	 alert("e.target.nodeName::::"+e.target.nodeName);
			//	 alert("id::: "+ed.dom.getAttrib(ed.selection.getNode(), 'id'));
				 
					 //if ((e.target.nodeName == 'SPAN' && e.target.className == 'xps_ndreflinking')|| (e.target.nodeName == 'SPAN' && e.target.className == 'xps_floatlinking') || (e.target.nodeName == 'SPAN' && e.target.className == 'xps_afloatlinking') )
					 //{  
					 	//var id= ed.dom.getAttrib(ed.selection.getNode(), 'id').split("#");
					 	//scrollToCitation(id[1]);
					 //}
			     });

				  
			  ed.onKeyPress.add(function(ed, e) {  

			

				}	          
	       );  
			},	          
		       
		template_replace_values : {
			username : "Thomson digital",
			staffid : "59596"
		}
	});
}
</script>

<script>
function d(){
	alert(tinymce.DOM.get(tinyMCE.activeEditor.id + '_path_row').innerHTML);
}
function scrollToCitation(id) {
	tinyMCE.activeEditor.selection.select(tinyMCE.activeEditor.getDoc().getElementById(id));
	tinyMCE.activeEditor.getDoc().getElementById(id).scrollIntoView();

}

function scrolls(id) {
	tinyMCE.activeEditor.selection.select(tinyMCE.activeEditor.getDoc().getElementById(id));
	tinyMCE.activeEditor.getDoc().getElementById(id).scrollIntoView();
	//tinyMCE.get('elm1').focus();
	//var node=tinyMCE.activeEditor.dom.select('p.ta')[0];
	
	//alert("node   "+node);
	//alert(tinyMCE.activeEditor.selection.select(tinyMCE.activeEditor.dom.select('span.ta')[0]));
	////////////////////tinyMCE.activeEditor.selection.select(tinyMCE.activeEditor.dom.select('span.ta')[0]);
	//alert(tinyMCE.activeEditor.selection.getContent());
	/*
	<p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p><p><span class="test" > this is sample</span></p>
	
	*/
	//var ed = tinymce.activeEditor;
	//ed.getWin().scrollTo(0, ed.dom.getPos(ed.dom.select('p.h1')[0]).y);
	//ed.selection.select(ed.dom.select('p.h1')[0]);


}
function open_custom_style_pop() { 
	
	var open_custom_style_pop=window.open('<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/autocomplete_pop/applystyles.jsp','open_custom_style_pop','width=200,height=300');
	
}

function insert_tagging() { 
	
	var taggging_pop='<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/insert_tagging.jsp';

$('#common_box').load(taggging_pop, function() {
		
	showboxtab();
	});
	
}
function insert_linking_styles() { 
	
	var linking_stylespath = '<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/insert_linking_styles.jsp';


$('#common_box').load(linking_stylespath, function() {
		
		showboxtab();
		});
	
}
function saveedfile(){

	 if ( $.browser.msie ) {
		 document.editor.sub.click();
		 }
	 else if( $.browser.mozilla){
		 
		  filesaver();

		  }
	
}
function view_pubmed(){
	$('#common_box').html("");
	$('#common_box').html("<table><tr><td><input type=\"text\" id=\"pubmed\" /></td><td><input type=\"button\" id=\"pubmedbutton\" class=\"pdf_view\" onclick=\"open_pubmed()\" value=\"Search\"/></td></tr></table>");
		
		showboxtab();
		
}
function open_pubmed() { 
	var searchText = $('#pubmed').val();
	
	var pubmed_pop=window.open('<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/pubmed.jsp?searchText='+searchText,'pubmed_tool','width=1000,height=300,scrollbars=yes');
	
}

function google_tool() { 
	
	var selectedText = tinyMCE.activeEditor.selection.getContent({format : 'text'});
	var google_tool_pop=window.open('<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/google.jsp?selectedText='+selectedText,'google_tool','width=400,height=300,scrollbars=yes');
	
	
}

function table_align_pop() { 
	
	var table_align_path='<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/table_align_pop.jsp';

$('#common_box').load(table_align_path, function() {
		
		showboxtab();
		});
}

function insert_appendix() { 
	
	var appendix_path = '<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/appendix.jsp';
	$('#common_box').load(appendix_path, function() {
		
		showboxtab();
		});
}

function generatePopupforCustomisedlist() { 

	var filepath="<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/generatePopupforCustomisedlist.jsp";
	
	$('#logstitle').html("");
	$('#logstitle').html("Custom List");
	$('#log_list').html("");
	$('#log_list').load(filepath, function() {
		
		$('.down').toggleClass();
		$('.log_list').slideToggle();
	});
	
}
function insert_endnote() { 
	
	var endpath='<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/insend.jsp';

$('#common_box').load(endpath, function() {
		
		showboxtab();
		});
}	

function insert_mmc(){
	var mmcpath='<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/mmc.jsp';


	$('#common_box').load(mmcpath, function() {
		
		showboxtab();
		});
}
function insert_sponser(){
	var insert_sponserpath = '<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/insertsponsers.jsp';

	$('#common_box').load(insert_sponserpath, function() {
		
		showboxtab();
		});
	
}
function changecase_short(){
	var changecasepath = '<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/changecase.jsp';

	$('#common_box').load(changecasepath, function() {
		
		showboxtab();
		});
	
}

function getLangOfArticle(){

	var editorcontent=tinyMCE.activeEditor.getContent();
	var star_pattern = /<div id="xps_meta">((\*)+(.*?))<\/div>/ig;
	var lang_pattern = /(Lang: ([a-zA-Z]+)<br \/>)/;
	try {		
		while ((matched_content = star_pattern.exec(editorcontent)) != null) {
			if (lang_pattern.test(matched_content[1])) {
				var lang=lang_pattern.exec(matched_content[1]);
				return lang[2];
			}
		}
	}catch (e) {
		return "error";
	}	
	
	
}
function insertquery(){

	var lang = getLangOfArticle();
	var filepath="<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/<%=customer_account%>_insertquery.jsp?language="+lang;

	$('#query_box').html("");
	$('#query_box').load(filepath, function() {
		showquerytab();
		success_notice("Please insert query...");
	});

}
function insert_utils(){
	var utilspath='<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/utils.jsp';

	$('#common_box').load(utilspath, function() {
		
		showboxtab();
		});
	
}
function autolabel(){
	var autolabelpath = '<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/autolabel.jsp';
		$('#common_box').load(autolabelpath, function() {
		
		showboxtab();
		});
} 
function ism(){
	var ismpath='<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/ism.jsp';

	$('#common_box').load(ismpath, function() {
			
		showboxtab();
		});

	
}
function faqwindow(){
	var myWindow4=window.open('<%=request.getContextPath()%>/signin/onlinecontribution/editor/faq/faqwindow.html','faqwindow','width=800px,height=400px,top=300px,left=300px,scrollbars=1');
}
function updateReference(elementChanged)
{
	tinyMCE.activeEditor.selection.setContent(elementChanged);
}



//------start of shortcuts method ---------//
	function sup(){
		var supkey=document.getElementById('supkey').value;
		if(supkey=="0"){
		tinyMCE.activeEditor.execCommand('Superscript');
		document.getElementById('supkey').value="2";
		}
		else if(supkey=="1"){
			 tinyMCE.activeEditor.execCommand('Subscript');
			 tinyMCE.activeEditor.execCommand('Superscript');
			 document.getElementById('supkey').value="2";
		}
		else if(supkey=="2"){
			 tinyMCE.activeEditor.execCommand('Superscript');
			 document.getElementById('supkey').value="0";
		}
	}
	function sub(){
		var supkey=document.getElementById('supkey').value;
		if(supkey=="0"){
		var ed = tinyMCE.activeEditor.execCommand('Subscript');
		document.getElementById('supkey').value="1";
		
		}
		else if(supkey=="2"){
			 tinyMCE.activeEditor.execCommand('Superscript');
			 tinyMCE.activeEditor.execCommand('Subscript');
			 document.getElementById('supkey').value="1";
		}
		else if(supkey=="1"){
			 tinyMCE.activeEditor.execCommand('Subscript');
			 document.getElementById('supkey').value="0";
		}
		
	}


	//------end of shortcuts method ---------//
	</script>
<script>
		     function show(){
		    	 document.getElementById('Design').style.display="none";
			     document.getElementById('Xhtml').style.display="block";
			     
		     }
		     function hide(){
		    	 document.getElementById('Design').style.display="block";
			     document.getElementById('Xhtml').style.display="none";
			     
		     }
		     function hide1(){
		    	 document.getElementById('Design').style.display="none";
			     document.getElementById('Xhtml').style.display="block";
			     
		     }
		     
		     </script>
		  <script>
//-------method for saving file using iframes------//

function savefile(f) {
	var text= tinyMCE.activeEditor.getContent();
	if ( $.browser.msie ) {
 	f = f.elements;
 	var w = window.frames.w;
 	if( !w ) {
  	w = document.createElement( 'iframe' );
  	w.id = 'w';
  	w.style.display = 'none';
  	document.body.insertBefore( w, null );
  	w = window.frames.w;
  	if( !w ) {
   	w = window.open( '', '_temp', 'width=100,height=100' );
   	if( !w ) {
    window.alert( 'Sorry, the file could not be created.' ); return false;
   	}
  	}
 	}
 	var d = w.document,
  	ext = f.ext.options[f.ext.selectedIndex];//,
  	var name1;
  	if(openfilenamepath1==null){name1=name = f.filename.value.replace( /\//g, '\\' ) + ext.text;}
  	else{ name1=openfilenamepath1.replace( /\//g, '\\' ) + ext.text;}
 	d.open( 'text/plain', 'replace' );
 	d.charset = ext.value;
 	if( ext.text==='.txt' ) {
  	d.write(text);
  	d.close();
 	} else {  //  '.html'
  	d.close();
 	var txt= d.body.innerHTML = '\r\n' + text+ '\r\n';  
 	}
 	if(d.execCommand( 'SaveAs', null, name1 ) ){
 	} else {
 	}
 	w.close();
 	return false;

	}
}


function filesaver(){
	var text= tinyMCE.activeEditor.getContent();
	try {
	    netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
	 } catch (e) {
	    alert("Permission to save file was denied.Please contact system administrator :: ERROR is :: "+e);
	 }
	var nsIFilePicker = Components.interfaces.nsIFilePicker;

	var fp = Components.classes["@mozilla.org/filepicker;1"]
		           .createInstance(nsIFilePicker);
	fp.init(window, "Dialog Title", nsIFilePicker.modeSave);
	fp.appendFilters(nsIFilePicker.filterAll | nsIFilePicker.filterText);

	var rv = fp.show();
	if (rv == nsIFilePicker.returnOK || rv == nsIFilePicker.returnReplace) {
	  var file = fp.file;
	  // Get the path as string. Note that you usually won't 
	  // need to work with the string paths.
	  var path = fp.file.path;
	 
	  // work with returned nsILocalFile...

	  writeToFile(fp.file.path, text); 
	  return false;
	}
	else{
		 return false;
		}

	}
	
function writeToFile(filename, data) {
    try {
       netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");
    } catch (e) {
       alert("Permission to save file was denied.Please contact system administrator :: ERROR :: "+e);
    }
    var file = Components.classes["@mozilla.org/file/local;1"]
       .createInstance(Components.interfaces.nsILocalFile);
    file.initWithPath( filename );
    if ( file.exists() == false ) {
       
       file.create( Components.interfaces.nsIFile.NORMAL_FILE_TYPE, 420 );
    }
    var outputStream = Components.classes["@mozilla.org/network/file-output-stream;1"]
       .createInstance( Components.interfaces.nsIFileOutputStream );
  
    // Open flags 
    var PR_RDONLY  =     0x01
    var PR_WRONLY  =     0x02
    var PR_RDWR    =     0x04
    var PR_CREATE_FILE = 0x08
    var PR_APPEND  =     0x10
    var PR_TRUNCATE=     0x20
    var PR_SYNC    =     0x40
    var PR_EXCL    =     0x80
  
     //outputStream.init( file, PR_RDWR | PR_CREATE_FILE | PR_APPEND, 420, 0 );
    outputStream.init(file,0x20 | 0x02,00004,null);
    var result = outputStream.write( data, data.length );
    outputStream.close();
    return false;
 }
//-------end of method for saving file using iframes------//

</script>

<SCRIPT type="text/javascript">

   
//------- method for open mathml------//
function openMathML(){

	
if(itemcode!=null && itemcode!=""){
	
		var filename=itemcode;
		var result =returnFunction(filename);
		
		if(result){
		result = findNReplaceInMathFromMathEditorToTinymce(result);	
		var splitTerm=result.split("<math");
		var hashCode=splitTerm[0]+".gif";
		result="<math"+splitTerm[1];
		var inst = tinyMCE;
		var resultMath=document.getElementById('text3').value=result;
		var imgData='<img class="TDMathEditor" alt="'+resultMath+'"  src="<%=getPath%>temp/files/'+filename+'/mathimage/'+hashCode+'" />';
		var newStr=imgData;
		tinyMCE.activeEditor.execCommand('mceInsertContent', true,imgData);
		}
				

	}
	else{
		fail_notice("some error occurred!!! (Please select an chapter)");

		}
	
 }
function returnFunction(filename){
	return showModalDialog("<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/mathneweditor.jsp?filename="+ filename,'mywin1','status:false;resizable=yes;dialogWidth:1000px;dialogHeight:600px');
}



//-------end of method for open mathml------//

function getJournalTitleType(){
	var editorcontent = tinyMCE.activeEditor.getContent();		

	var star_pattern = /<div id=\"xps_meta\">((\*)+(.*?))<\/div>/g;
	var jtexpanded = /<br \/>Journal Title\(Expanded\)<br \/>/gi;
	var jtAbbreviated = /<br \/>Journal Title\(Abbreviated\)<br \/>/gi;
	var jtAbbreviatedwdot = /<br \/>Journal Title\(Abbreviated without dot\)<br \/>/gi;
	var matched_content;
	var JournalTitleType ="";
	try {
		while ((matched_content = star_pattern.exec(editorcontent)) != null) {
		
			if(jtexpanded.test(matched_content[1])){
				
				JournalTitleType = "Expanded";
				
				}

			else if(jtAbbreviated.test(matched_content[1])){

				JournalTitleType = "Abbreviated";
				
			

				}
			else if(jtAbbreviatedwdot.test(matched_content[1])){

				JournalTitleType = "Abbreviated without dot";
			
				

				}

		}

	
		return JournalTitleType;
		
	}catch(e){
		
	}
}

function getAtitle(){
	var editorcontent = tinyMCE.activeEditor.getContent();		

	var star_pattern = /<div id=\"xps_meta\">((\*)+(.*?))<\/div>/g;
	var atitlepattern = /<br \/>Without article title<br \/>/gi;
	
	var matched_content;
	var aTitle ="";
	try {
		while ((matched_content = star_pattern.exec(editorcontent)) != null) {
		
			if(atitlepattern.test(matched_content[1])){
				
				aTitle = "Without article title";
				
			}
		}

	
		return aTitle;
		
	}catch(e){
		
	}
}


	
function applyAutoReference(etalID){
	var selectedText = tinyMCE.activeEditor.selection.getContent();
	var JournalTitleType = getJournalTitleType();
	var aTitle = getAtitle();
	$.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/signin/onlinecontribution/editor/processautostructure/autoreference.jsp",
		  data: "editorcontent="+encodeURIComponent(selectedText)+"&etalID="+etalID+"&JournalTitleType="+JournalTitleType+"&aTitle="+aTitle ,
		  success: function(msg){
		
			  tinyMCE.activeEditor.selection.setContent(msg.replace("<p></p>"));
			  
		  }
		});

}
function callStructureEngine(structureChamber){

	var flag=false;
	var selectedText =tinyMCE.activeEditor.selection.getContent();
	
	if(selectedText==""||selectedText==null){
		flag=true;
		selectedText=tinyMCE.activeEditor.getContent();
		}	
	
	$.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/signin/onlinecontribution/editor/processautostructure/structureengine.jsp",
		  data: "editorcontent="+encodeURIComponent(selectedText)+"&structureChamber="+structureChamber ,
		  success: function(msg){
			  if(msg.search("There are identical reference label")>-1){
				  alert(msg);
			  }				  
			  else{
				  if(flag==true){
					  tinyMCE.activeEditor.setContent(msg);
					  }
				  else
					{
					  tinyMCE.activeEditor.selection.setContent(msg);
				  	}
			  }  
			  
		  }
		});
}
function callStructureEngineUncitedreference(structureChamber){
	var selectedText = tinyMCE.activeEditor.getContent();
	
	$.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/signin/onlinecontribution/editor/processautostructure/structureengine.jsp",
		  data: "editorcontent="+encodeURIComponent(selectedText)+"&structureChamber="+structureChamber ,
		  success: function(msg){
			  tinyMCE.activeEditor.setContent(msg);
			 
			  window.setTimeout('conversion()',2000);
		  }
		});
	
	// window.setTimeout('conversion()',2000);

}
function getJIDForContent(){

	var selectedText = tinyMCE.activeEditor.getContent();
	var star_pattern = /((<p>)|(<div id=\"xps_meta\">))((\*)+(.*?))((<\/p>)|(<\/div>))/g;
	var jid_aidRegex = /<br \/>([^<]*)? [0-9]+<br \/>/g;
	var matched_content;
	var jid_aid;
	
	try{
		while ((matched_content = star_pattern.exec(selectedText)) != null) {
			
			while ((jid_aid = jid_aidRegex.exec(matched_content[0])) != null) {
				
					return jid_aid[1];
				}
				
				
		}
		}catch(e){alert(""+e);}

	
}

function callStructureEngineForWiley(structureChamber){
	var selectedText = tinyMCE.activeEditor.getContent();
	var jid = getJIDForContent();
	
	$.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/signin/onlinecontribution/editor/processautostructure/wileystructureengine.jsp",
		  data: "editorcontent="+encodeURIComponent(selectedText)+"&structureChamber="+ structureChamber+"&jid="+ jid ,
		  success: function(msg){
		
			  tinyMCE.activeEditor.setContent(msg.replace("<p></p>",""));
			  
		  }
		});

}

//------- method for opening file------//
var openfilenamepath1;	    
function open_f(){
	document.getElementById('open').click();

	}
function load_file(){

	var line="";
	
	if ( $.browser.msie ) {
		path=document.getElementById('open').value;
		openfilenamepath1 = path.replace(/^.*[\\\/]/, '').replace(/.htm/, '') ;
		if(path){
		var fso = new ActiveXObject("Scripting.FileSystemObject");
		var newLine = fso.OpenTextFile(path);
		line = newLine.ReadAll() ;
		newLine.Close();
	 }
	}
		  else if( $.browser.mozilla){
			  
		 var f = document.getElementById('open').files[0];
	
         if (f) {
       
           var r = new FileReader();
           r.onload = function(e) { 
               
        	   line = e.target.result;
        	
			}
			
           r.readAsText(f);
         } else {
        	 fail_notice("Error !!! Failed to load the file");

              }
         
       }
	window.setTimeout(function(){
		tinyMCE.activeEditor.setContent("");
		tinyMCE.activeEditor.focus();
		tinyMCE.activeEditor.execCommand('mceInsertContent', false,line);



		},1000);
}

//-------end of method for opening file------//
</script>
<script type="text/javascript">

//-------method for insertcomment-----//
function insertcomment() { 
	var selectedText = tinyMCE.activeEditor.selection.getContent();
	var rs='&#65279;&lt;comment&gt;' + selectedText +"&lt;/comment&gt;&#65279;";
	var s=tinyMCE.activeEditor.selection.setContent(rs);
}
//-------end of method for insertcomment-----//

	window.status="TD-XPS...";


	

</script>
	



    <script type="text/javascript">
function sendmsgtolog(){
	var content=document.getElementById("message_content").innerHTML;
	var curr_msg=document.getElementById("current_msg").value;
	var updatedContent = "<div class=message><p>"+curr_msg+"</p><p><strong>Admin</strong></p></div>";
	var finalcontent=content+updatedContent;
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
			
			document.getElementById("message_content").innerHTML="";
			document.getElementById("message_content").innerHTML=ajaxRequest.responseText;
			document.getElementById("current_msg").value="";
		}
	}
	
	ajaxRequest.open("post", "<%=request.getContextPath()%>/authoringtool/getMsgBoxContent.jsp?content="+finalcontent, true);
	
	ajaxRequest.send(null); 
}
function load_tinymce(){

setup();
show();

}
var content;
function loadcontent(){
	if (tinyMCE.activeEditor == null){
		window.setTimeout('loadcontent()',1000);
		}else{
			
			tinyMCE.get('elm1').focus();
			tinyMCE.get('elm1').setContent(content);

			viewStyleSheetofParticularJournal();

			//generateIdForTOC();
		
		
		}
}
function load_article_in_tinymce(filepath){

	
	//$('#progressBar').show();
	//progressBar(10, $('#progressBar'));
	 $.ajax({
		
		  type: "POST",
		  url: filepath,
		  
		  beforeSend:function(xhr) {
              xhr.overrideMimeType('text/html; charset=ISO-8859-1');
          //    progressBar(30, $('#progressBar'));
              },
		 
		  statusCode: {
			  
		404: function() {
			
			// $('#progressBar').hide();
			// progressBar(0, $('#progressBar'));
			 fail_notice("Article not found on the server. You need to start a fresh article");
		
			    },
	 	200: function(msg) {
			    	
					  content=msg;
			
					  window.setTimeout('loadcontent();',1000);
					
							
							success_notice("The article has been loaded successfully!!!");
							// progressBar(100, $('#progressBar'));
							 //$('#progressBar').hide();
							// progressBar(0, $('#progressBar'));
						    }
			  }
		});

// setInterval(function(){i=0;if(i<99){progressBar(i, $('#progressBar'));i=i+1;}},1000); 
	
}

	function publishFile(filepath)
		{
		
		 $('#progressBar').show();
		 $.ajax({
				
			  type: "POST",
			  url: filepath,
			  statusCode: {
				    404: function() {
			 progressBar(0, $('#progressBar'));
			 fail_notice("File not found on the server or is still under processing...");
			 $('#progressBar').hide();
			
				    },
		 	200: function(msg) {
				    	
				    	success_notice("Please wait ...");
				    	window.open(filepath);
				    	progressBar(100, $('#progressBar'));
				    	$('#progressBar').hide();
				    	progressBar(0, $('#progressBar'));
				    	
							    }
				  }
			});
		 setInterval(function(){i=0;if(i<99){progressBar(i, $('#progressBar'));i=i+1;}},1000); 
		}

	function publishMSSFile(filepath)
	{
		
		
	 $.ajax({
			
		  type: "POST",
		  url: filepath+"?random="+new Date().getTime(),
		  statusCode: {
			    404: function() {
		
		fail_notice("File not found on the server or is still under processing...");
	
		
			    },
	 	200: function(msg) {
			  
			    	success_notice("Please wait ...");
			    	
			    	$('#log_list').html("");
			    	$('#log_list').load(filepath, function() {
			    	
			    		success_notice("Log retrieved successfully");
			    	
					});
			   
						    }
			  }
		});
	}

	function loadstylesinslider()
	{
		var filepath="<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/autocomplete_pop/autoc.jsp";
		
		$('#styles_div').html("");
		$('#styles_div').load(filepath, function() {
		
			init1();
			
    		
		});
	
	}
	function loadlogsinslider(filepath)
	{
		alert(path);
		$('#log_list').html("");
		
	
		$('#log_list').load(filepath, function(response, status, xhr) {
			if (status == "error") {
				success_notice("logs not found on the server");
				
				}else{
					
					showlogstab();
    				success_notice("logs retrieved successfully");
				}
		});
	}

	function publishAuthorContent(filepath)
	{

		$('#progressBar').show();
		
		var zipserverpath="<%=getPath%>temp/files/authorattchments/"+filepath+".zip";
	 $.ajax({
			
		  type: "POST",
		  url: zipserverpath,
		  statusCode: {
			    404: function() {
		
			progressBar(0, $('#progressBar'));
			$('#progressBar').hide();
		 fail_notice("File not found on the server or is still under processing...");
		
			    },
	 	200: function(msg) {
			    	
				
			    	success_notice("Please wait ...");
			    	
			    	window.open(zipserverpath,'zipfileauthor','width=270px,height=240px, top=730,left=0,scrollbars=1');

					progressBar(100, $('#progressBar'));
					$('#progressBar').hide();
						    }
			  }
		});
	 setInterval(function(){i=0;if(i<99){progressBar(i, $('#progressBar'));i=i+1;}},1000); 
	}
	
function showalert(){
	$('.alert').delay(1000).slideDown().promise().done(function(){
		 $('.alert').delay(5000).slideUp()
		});
	
}
function success_notice(message){

	$('#alert_para').removeClass('warning');
	$('#alert_para').removeClass('success');

	$('#alert_para').addClass('success');
	$('#alert_para').html(message);
	showalert();
	
}
function fail_notice(message){

	$('#alert_para').removeClass('warning');
	$('#alert_para').removeClass('success');

	$('#alert_para').addClass('warning');
	$('#alert_para').html(message);
	showalert();
	
}
function warning_notice(message){

	$('#alert_para').removeClass('warning');
	$('#alert_para').removeClass('success');

	$('#alert_para').addClass('warning');
	$('#alert_para').html(message);
	showalert();
	
}
function error_notice(message){

	$('#alert_para').removeClass('warning');
	$('#alert_para').removeClass('success');

	$('#alert_para').addClass('warning');
	$('#alert_para').html(message);
	showalert();
	
}
function error_notice_pdf(message){
	$('#alert_para').removeClass('warning');
	$('#alert_para').removeClass('success');

	$('#alert_para').addClass('warning');
	
	$('#alert_para').html(message);
	showalert();
	
}
function manage_task(){
	if(key=="0"){
		insert_query_intoDB();
	}

	
}


function manage_clientspecific_tasks(){

	if(((<%=userDTO.getRoleid().equalsIgnoreCase("RM1010")%> || <%=userDTO.getRoleid().equalsIgnoreCase("RM1011")%> ) <%-- && <%=userDTO.getCustomerid().equalsIgnoreCase("C1001")%> --%>)){

		manage_user('authoringtool/finaltable/reviewarticletable.jsp');
		
	}
	else if(((<%=userDTO.getRoleid().equalsIgnoreCase("RM1010")%> || <%=userDTO.getRoleid().equalsIgnoreCase("RM1011")%> ) <%-- && <%=userDTO.getCustomerid().equalsIgnoreCase("C1012")%> --%>)){
		manage_fms_oup();
		
	}
	else{
		$('#task_mgr').hide();
		$('#task_mgr_list').hide();
		$('#faq').show();// for faq window to be loaded in author view only
		manage_user('authoringtool/finaltable/reviewarticletable.jsp');
		
		}

	
	
}
</script>

	<script type="text/javascript">
/* <![CDATA[ */
$(document).ready(function(){
	
	manage_clientspecific_tasks();
	$("#tabs li").click(function() {
		//	First remove class "active" from currently active tab
		$("#tabs li").removeClass('active');

		//	Now add class "active" to the selected/clicked tab
		$(this).addClass("active");

		//	Hide all tab content
		$(".tab_content").hide();

		//	Here we get the href value of the selected tab
		var selected_tab = $(this).find("a").attr("href");

		//	Show the selected tab content
		$(selected_tab).fadeIn();

		//	At the end, we add return false so that the click on the link is not executed
		return false;
	});
});
/* ]]> */
 
</script>


<script type="text/javascript">

function showtooltip(id, message, side){

	var nextMsgOptions = {
			msg: "Red Theme",
			side: side, 		
			CSSClass: "nextMsg-RedTheme",
			width: 250
		}
	var options = $.extend({}, nextMsgOptions, { msg: message, CSSClass: "nextMsg-DarkTheme", minDuration: -1 });
	$("#"+id+"").nextMsg(options);

	
}
function showrolewisetooltip(){
	if((<%=userDTO.getRoleid().equalsIgnoreCase("RM1007")%>) <%-- && (<%=userDTO.getCustomerid().equalsIgnoreCase("C1001")%>) --%>){
		$(".nextMsg").hide();
		 window.setTimeout('openqueriesautomatically();',2000);
	}

	
}





function openqueriesautomatically(){

		
		if(stagename==""|| stagename==null){
			 warning_notice("please select article again");
				
			}
		else if(stagename.toUpperCase()=="AUTHOR_REVISION"){

		showtooltip("logstooltip", "Please reply to the queries by clicking on the query link", "topMiddle");
		view_comments();

	}
}



function showrolewisetooltip_queryview(){
	if((<%=userDTO.getRoleid().equalsIgnoreCase("RM1007")%>) <%-- && (<%=userDTO.getCustomerid().equalsIgnoreCase("C1001")%>) --%>){
		$(".nextMsg").hide();
		$("#logstitle").html('Query List');
		showtooltip("comment_box_tooltip", "Please reply to the query that you have selected", "topMiddle");
		showReplyCommentsBox();
		
	}

	
}

function guideUserThroughRemainingsteps(){

	$(".nextMsg").hide();
	setTimeout(function(){$(".subpanel").show();showtooltip("insertcomments", "you can insert comments from here", "leftMiddle");},1000);
	setTimeout(function(){$(".subpanel").hide();$(".nextMsg").hide()},3000);
    setTimeout(function(){showtooltip("uploadattachment_list", "you can upload attachments from here", "topMiddle");},3000);
	setTimeout(function(){$(".nextMsg").hide()},5000);
	setTimeout(function(){$(".subpanel").show();showtooltip("submitfinalarticlesauthor", "you can finally submit article from here", "leftMiddle");},6000);
	setTimeout(function(){$(".subpanel").hide();$(".nextMsg").hide();},10000);

}


function getCheckListAfterQueryReply(){
	if((<%=userDTO.getRoleid().equalsIgnoreCase("RM1007")%>) <%-- && (<%=userDTO.getCustomerid().equalsIgnoreCase("C1001")%>) --%>){
	$(".nextMsg").hide();
	var content = "<table class=\"GridStyle\"><tr><td><span class=\"icon-check\"> Loading article.</span></td></tr><tr><td><span class=\"icon-check\"> Reply to queries</span></td></tr><tr><td><span class=\"icon-desktop\"> Insert Comments</span></td></tr><tr><td><span class=\"icon-desktop\"> Upload attachments</span></td></tr><tr><td>Are you done with replying all queries? If so take a quick <a href=\"#\" onclick=\"guideUserThroughRemainingsteps();\">tour</a> on next steps.</td> </tr></table>";
	$("#comment_box").hide();
	$("#checklist_div").show();
	$("#checklist_div").html(content);
	
	}
}
	


	function displaycetasks(path){

		if((<%=userDTO.getRoleid().equalsIgnoreCase("RM1010")%>) <%-- && (<%=userDTO.getCustomerid().equalsIgnoreCase("C1001")%>) --%>){

			loadlogsinslider(path);

			generateIdForTOC();

			
		}
	}

	
</script>
<script type="text/javascript">

function showlogstab(){
	
	
	$('.logsContainer').toggle('slide', {direction: 'right'}, 500);				
	$('.styleContainer').fadeOut();	
	$('.QueryContainer').fadeOut();	
		
}

function showquerytab(){
	 $('.QueryContainer').toggle('slide', {direction: 'right'}, 500);
		$('.logsContainer').fadeOut();		
		$('.styleContainer').fadeOut();	
	
}

function showboxtab(){

	$('.BoxContainer').toggle('slide', {direction: 'right'}, 500);
}

function showstyleguidetab(){
	$('#progressBar').show();
	progressBar(10, $('#progressBar'));
	
	progressBar(50, $('#progressBar'));

	viewStyleSheetofParticularJournal();		
	// $('.PDFEditFull').addClass('PDFEdit');
	 //$('.PDFEditFull').removeClass('PDFEditFull');
	//progressBar(70, $('#progressBar'));

		$('.PDFEdit').addClass('PDFEditFull');
		$('.PDFEdit').removeClass('PDFEdit');
		$('#load_pdf').hide();
		$('.StyleGuide').show();
		$('#progressBar').hide();
		//progressBar(100, $('#progressBar'));
		//$('#progressBar').hide();
}

$(document).ready(function () {
	
  
	$('.logsContainer').hide();
	$('.QueryContainer').hide();	
	$('.BoxContainer').hide();	
	$('.alert').hide();
	$('.PDFLeftContainer').hide();
	
	
	
$(function(){ 

	//$('.alert').delay(1000).slideDown().promise().done(function(){
	 //$('.alert').delay(1000).slideUp()
	//});
});

	$('.showArticle').click(function () {
		$('.MsgNoArticleSelected').hide();
        $('.PDFLeftContainer').show();
		
    });
	
	$('.showPDFVIew').click(function () {
		//$('.right').hide();
        $('.PDFEdit').addClass('PDFEditFull');
	});
	
	$('.showNormalVIew').click(function () {
		//$('.right').hide();
        $('.PDFEdit').removeClass('PDFEditFull');
	});
	
	$('.styleContainer').hide();
	$('.ActionContainer').hide();
	
    $('.logs').click(function () {
        $('.logs_content').toggle(200);
    });
	
	$('.showAction').click(function () {				
        $('.ActionContainer').toggle('slide', {direction: 'top'}, 500);				
    });
	
	$('.showLogs').click(function () {				
       // $('.logsContainer').toggle('slide', {direction: 'right'}, 500);				
		//$('.styleContainer').fadeOut();	
		//$('.QueryContainer').fadeOut();	

		showlogstab();				
    });
	
	$('.closeButton').click(function () {				
        $(this).parent().toggle('slide', {direction: 'right'}, 500);				
    });
	
	$('.showStyle').click(function () {				
        $('.styleContainer').toggle('slide', {direction: 'right'}, 500);
		$('.logsContainer').fadeOut();		
		$('.QueryContainer').fadeOut();	
    });
	
	
	$('.showQuery').click(function () {				
       // $('.QueryContainer').toggle('slide', {direction: 'right'}, 500);
		//$('.logsContainer').fadeOut();		
		//$('.styleContainer').fadeOut();	
		showquerytab();
    });	
	
	$('.showBox').click(function () {				
        //$('.BoxContainer').toggle('slide', {direction: 'right'}, 500);
		showboxtab();
    });			

	$('.showStyleGuide').click(function () {

		showstyleguidetab();
       
		
	});
	
	
	    //$(function(){
			//$('.table_grid').jScrollPane();
		//});                  

// $('html').click(function() {
//   $('.ActionContainer').hide();
//});

});
</script>
<script type="text/javascript">
$(document).ready(function () {
	$('#nav').droppy({trigger: 'click'});

	
	$('.popupButton').click(function () {				
        $(this).parent().slideUp();	
					
    });

});
</script>
<script>
$(function() {
$( "#resizable" ).resizable();
});
</script>

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
		//empty_tdpmsrdiv();
		$('#slider').html("");
		var path="<%=request.getContextPath()%>/"+jsp_name+"?random="+new Date().getTime();
		
		$('#content_div').load(path, function() {
			});
	}

	function manage_pdfview(jsp_name){
		$('#progressBar').show();
		progressBar(20, $('#progressBar'));
		
		var path= "<%=request.getContextPath()%>/"+jsp_name+"?random="+new Date().getTime();
		
		progressBar(50, $('#progressBar'));
		
		$('#load_pdf').html('<iframe src='+path+' width="100%" height="100%" name=\"pdfframe\" id=\"pdfframe\">');
		
		progressBar(100, $('#progressBar'));
		$('#progressBar').hide();
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
		$('#content_div').html('<iframe src=\"http:\/\/172.16.0.43:8081\/FMSNEW/login.go?loginID=<%=userDTO.getEmpName()%>&password=<%=userDTO.getEmpPassword()%>&browser=S7&src=TDXPS\" width="100%" height="800" name=\"fmsframe\" id=\"fmsframe\">');
		
	}
	function manage_fms_oup(){
		empty_div();
		empty_editordiv();
		empty_tdpmsrdiv();
		$('#slider').html("");
		$('#content_div').html('<iframe src=\"http:\/\/10.2.48.66:8081\/FMS2USER/login.go?loginID=<%=userDTO.getEmpName()%>&password=<%=userDTO.getEmpPassword()%>&opt_qc=NO&c_dept=0&src=TDXPS\" width="100%" height="800" name=\"fmsframe\" id=\"fmsframe\">');
		
		}
	
	
	function manage_editor(jsp_name){

		tinyMCE.execCommand('mceRemoveControl', true, 'elm1');
	
		empty_editordiv();
		var path="<%=request.getContextPath()%>/"+jsp_name;
		
		
		$('#load_editor').load(path, function() {
			
			setup();
			
			show();
			
			});
		
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

 function addslidertomenu(){
		var content = "<div class=\"header\" id=\"one-header\" >Logs</div><div class=\"content\" id=\"one-content\"><div class=\"text\" id=\"1\">  </div></div><div class=\"header\" id=\"two-header\">Apply Styles</div><div class=\"content\" id=\"two-content\">  <div class=\"text\" id=\"2\">   </div></div>";
		$('#slider').html("");
		$('#slider').html(content);
		slider.init('slider',0);
     }

var typeofpdfopened;
 function autoopen3DFile(markername,type){
		if(markername=="MNT_ELSEVIER_JOURNAL_IJID_1753_103"){type="main";}

		
		if(markername=="MNT_ELSEVIER_JOURNAL_APSUSC_25939_102"){

		if(type=="g"){	

			type="r";

			}

		



			}

		
	 typeofpdfopened = type;

	 
		$.ajax({
			  type: "POST",
			  url: "<%=request.getContextPath()%>/authoringtool/processcontent/createmarkerFor3D.jsp",
			  data: "markername="+markername+"&type="+type,
			  success: function(msg){
			
				  //success_notice("Please wait ...");			  
				  
			  }
			});
	}
	 
 function refreshpdfqc(){

var category;

if(typeofpdfopened=="main"){category=""}
else if(typeofpdfopened=="g"){category="g"}
else if(typeofpdfopened=="r"){category="r"}

	 var aid = getaid(itemcode);
		var pdfserverpath="<%=getPath%>temp/files/"+itemcode+"/"+aid+category+".pdf";
	
	 	
	 	var path="pdfmaster/web/pdfviewer.jsp?pdfpath="+pdfserverpath;
	 	var iframepath= "<%=request.getContextPath()%>/"+path+"?random="+new Date().getTime();
	 	$('#load_pdf').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"cleanproofframe\" id=\"cleanproofframe\">');
	 	
	 	$('#load_pdf').show();
	 	$('.PDFEdit').addClass('PDFEditFull');
	 	$('.PDFLeftContainer').show();		
	 	$('.PDFEdit').removeClass('PDFEdit');
	 	$('.StyleGuide').hide();
	 	
	 }

 function setMetroPath(stageid){
		
		//copy editor
		 if(stageid=="ST1004")
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

		 //auto astructuring
		 else if(stageid=="ST1011")
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
		 
		 else if(stageid=="ST1022")
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
		 
		 else if(stageid=="ST1005")
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
		 else if(stageid=="ST1009")
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
		 else if(stageid=="ST1006")
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
		 else if(stageid=="ST1026")
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
		 else if(stageid=="ST1036")
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

function opencapguide(){

	var capguidepdfpath = "<%=request.getContextPath()%>/pdfmaster/files/capguide.pdf";
	
	var path="pdfmaster/web/pdfviewer.jsp?pdfpath="+capguidepdfpath;
	var iframepath= "<%=request.getContextPath()%>/"+path+"?random="+new Date().getTime();
	$('#load_pdf').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"capguideframe\" id=\"capguideframe\">');
	
	$('#load_pdf').show();
	$('.PDFEdit').addClass('PDFEditFull');
	$('.PDFLeftContainer').show();		
	$('.PDFEdit').removeClass('PDFEdit');
	$('.StyleGuide').hide();

}


function openextranet(){
var extranetpath = "http://application:8080/extranet/ExtranetCalender.jsp";

	var iframepath= extranetpath+"?random="+new Date().getTime();
	$('#load_pdf').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"extranetframe\" id=\"extranetframe\">');
	
	$('#load_pdf').show();
	$('.PDFEdit').addClass('PDFEditFull');
	$('.PDFLeftContainer').show();		
	$('.PDFEdit').removeClass('PDFEdit');
	$('.StyleGuide').hide();


	
}


function displayp100checklist(){

	$('#common_box').html('');

	var path="<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/checklist/p100.html";
	$('#common_box').html('<iframe src='+path+' width="100%" height="95%" scrolling="no" name=\"p100checklistbox\" id=\"p100checklistbox\">');
	showboxtab();
	
}
	</script>



</head>

<body>
<div class="popup"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/loading.gif" style="display: none;"  width="155" height="132" /></div>
<!--wrapper  -->
<div class="alert">
	<div class="popupButton"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/close_btn.png" width="8" height="8"></div>
  <p id="alert_para" class=""></p>
</div>

<div class="wrapper"> 

 <!--header  -->
  <div class="header">
    <div class="alertBar">
      <p><i class="icon-alert"></i>Alert For New Task can slide down here, and it will be hide after 10 Second </p>
    </div>
    <div class="Logo fl"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/logo.png" width="130" height="49" alt="TD-XPS "></div>
    <div class="UserDetail fr">
      <ul>
        <li><a href="<%=request.getContextPath() %>/signin/login/login.jsp?user=0&pass=1">Logout</a><i class="icon-off icon-1x"></i></li>
      </ul>
    </div>
    
    <!--header / --></div>
<div class="clear"></div>

 <div class="content">
 
	<div id="progressBar" class="default" style="display: none;"><div></div></div>
 
 <%--for demo s100_button.ng is replaced with g100.png --%>
 <div class="ProgreesBarContent">
        	<div class="sHundred"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/s100_btn.png" ></div>
            <div class="ProgreesBar">
          <!--   <div id="step1div" class="Step1 green">1<span>CNU</span></div>
                <div  id="step2div" class="Step2 yellow">2<span>AUTO STRUCTURING</span></div>
                <div  id="step3div" class="Step3 red">3<span>COPY EDITOR</span></div>
                <div  id="step4div" class="Step4 red">4<span>PAGINATION</span></div>
                <div  id="step5div" class="Step5 red">5<span>QC</span></div>
                <div  id="step6div" class="Step6 red">6<span>MASTER COPY EDITOR</span></div>  -->
                
                <div id="step1div" class="Step1 yellow"><span class="hint--top" data-hint="CAL DAT">1</span></div>
                <div  id="step2div" class="Step2 red"><span class="hint--top" data-hint="CAL XML">2</span></div>
                <div  id="step3div" class="Step3 red"><span class="hint--top" data-hint="DISPATCH">3</span></div>
               <!--  <div  id="step4div" class="Step4 red"><span class="hint--top" data-hint="PAGINATION">4</span></div>
                <div  id="step5div" class="Step5 red"><span class="hint--top" data-hint="QC">5</span></div>
                <div  id="step6div" class="Step6 red"><span class="hint--top" data-hint="MASTER COPY EDITOR">6</span></div>  -->
                 
            </div>
            <div class="timer"><span id="countdown"></span></div>
            <div class="clear"></div>
        </div>
 
 
 </div>
 
 <div class="checkout_popup">
 <div class="Dashboard" id="content_div">
      
    </div>
    
    <div class="TitleContainer">
      <div class="Title">Review Article</div>
      <div class="Icon_main">
      <div class="full_screen"> <input name="" type="button" id="checklistp100" class="submit" onclick="displayp100checklist();" style="display: none;" value="checklist "></div>
        <div class="full_screen"> <input name="" type="button" class="submit" onclick="displaycitrixlogin();" value="citrix "></div>
       <!--  <div class="full_screen"><a href="#"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/question.png" width="22" height="21"></a></div> -->
         <div class="full_screen"><a href="javascript:void(0)" class="styles" id="changestagespan" style="display: none;" onclick="changestageofarticle();">Change stage</a></div>
        <div class="clear"></div>
      </div>
      <div class="clear"></div>
    </div>
 
 <div class="left editor fl">
 <div class="MsgNoArticleSelected">Please select an chapter.</div>
      <div class="PDFLeftContainer"  style="background:#ffffff;">
       
        <!--Style Guide-->
        <div class="StyleGuide fl">
        <div class="closeButton"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/close_btn.png" alt="Close"></div>
        <div id="styleguide">
        
        
        </div>
        
        
          </div>
          <div class="PDFEdit fr " id="load_pdf"> 
          
          
          </div>
          
          <div class="clear"></div>
        <div class="tabs_btn">
         <input name="refreshpdf" id="refreshpdf" type="button" class="pdf_view" style="display: none;" onclick="refreshpdfqc();" value="Refresh PDF">
        <input name="extranet" id="extranet" type="button" class="pdf_view" onclick="openextranet();" value="Extranet">
        <input name="capguide" id="capguide" type="button" class="pdf_view" onclick="opencapguide();" value="Capguide">
<!--         <input name="pdfview" id="pdfview" type="button" class="pdf_view" onclick="refreshpdfonroles();" value="DTD"> -->
         <input name="diff_pdf" id="diff_pdf" type="button" class="pdf_view" style="display: none;" onclick="opencleanpdf();" value="Diff PDF">
        <input name="stylesheet" id="stylesheet" type="button" class="StyleGuideBtn showStyleGuide" value="Stylesheet">
        
          <input name="logsbutton" id="logsbutton" type="button" class="logs showLogs" value="Logs">
          <input name="querybutton" id="querybutton" type="button" class="query showQuery" value="Query">
          <input name="stylebutton" id="stylebutton" type="button" class="styles showStyle" value="Styles">
          
          <input name="" type="button" class="Comment" value="" onclick="if(navigator.userAgent.toLowerCase().indexOf('opera') != -1 && window.event.preventDefault) window.event.preventDefault();this.newWindow = window.open('<%=getPathwithoutnewport%>tdxpslivesupport/client.php?locale=en&url='+escape(document.location.href)+'&referrer='+escape(document.referrer), 'webim', 'toolbar=0,scrollbars=0,location=0,status=1,menubar=0,width=640,height=480,resizable=1');this.newWindow.focus();this.newWindow.opener=window;return false;" target="_blank" href="<%=getPathwithoutnewport%>tdxpslivesupport/client.php?locale=en">
        </div>
        <div class="clear"></div>
          
          
        </div>
        <!--Style Guide // --> 
        
        <!--logs-->
        <div class="logsContainer fl">
        <div class="closeButton"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/close_btn.png" alt="Close"></div>
          <div class="logs_slide">
            <div class="logs_title">Logs</div>
            <div class="logs_guide" id="log_list">
              NO LOGS FOUND...
            </div>
          </div>
        </div>
        <!--logs // --> 
          <!--Query-->
        <div class="QueryContainer fl">
        <div class="closeButton"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/close_btn.png" alt="Close"></div>
          <div class="logs_slide">
            <div class="logs_title">Query</div>
            <div class="logs_guide" id="query_box">
              Please select insert query...
            </div>
          </div>
        </div>
        <!--Query // -->
        
        
        <!--Styles-->
        <div class="styleContainer fl">
        <div class="closeButton"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/close_btn.png" alt="Close"></div>
          <div class="logs_slide">
            <div class="logs_title">Styles</div>
            <div class="logs_guide" id="styles_div">
              
            </div>
          </div>
        </div>
        <!--Styles // -->
        <!--Common Box-->
        <div class="BoxContainer fl">
        <div class="closeButton"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/close_btn.png" alt="Close"></div>
          <div class="logs_slide">
            <div class="logs_title">Box</div>
            <div class="logs_guide" id="common_box"> 
            
             EMPTY BOX...
            </div>
          </div>
        </div>
        <!--Common Box // -->
        

      </div>
      
      <div class="EditorOuterContainer right fl ">
      <div class="EditorContainer">
      <div> <input name="" type="button" id="submitproofcentral" class="styles" value="Submit to Proof Central" onclick="submitarticletocentralproof();" style="display: none;">
      </div>
      
      
        <div class="EditorMenu">
        
       <%@ include file="/signin/onlinecontribution/editor/editor_files/edmenu.jsp"%>
        
        
          <div class="clear"></div>
        </div>
      </div>
      <div class="ArticleLoader" id="load_editor"></div>
      
      <div class="proofcentralLoader" id="load_proofcentral"></div>
      
       <div class="vncLoader" id="load_vnc" style="display: none;"></div>
       
       <div class="p100Loader" id="load_p100" style="display: block;"></div>
      
       <div class="uploader" id="load_uploadwidget"></div>
      
      
    </div>
 
 <div class="RightPanel_btn">
     
      <!-- <input name="" src="<%=request.getContextPath() %>/authoringtool/gui/images/pdf_view.png" type="image" class="Pdf_view" onclick="generateontheflypdf();">-->
      
      <div class="ActionBtn showAction">Action</div>
      <div class="ActionContainer" >
        <ul>
         <li id="viewcomments" style="display: none;"><a href="#" onclick="view_comments();" >View Comments</a></li>
            	<li id="insertcomments" style="display: none;"><a href="#" onclick="get_query();">Insert Comments</a></li>
            	<li id="submitarticle" style="display: none;" ><a href="#" onclick="submit_article();">Submit Article</a></li>
            	<li id="conversion" style="display: none;" ><a href="#" onclick="calluncitedreferenceandconversion();">Conversion</a></li>
            	<li id="submitfinalarticle" style="display: none;" ><a href="#" onclick="validateVToolLogBeforeSubmission_s5();">Submit Final Article</a></li>
            	<li id="submitfinalarticles100" style="display: none;" ><a href="#" onclick="validateVToolLogBeforeSubmission_s100();">Submit Final Article</a></li>
            	<li id="submitfinalarticlebyme" style="display: none;" ><a href="#" onclick="validateVToolLogBeforeSubmission_ME();">Submit Final Article(M.E.)</a></li>
                <li id="submitfinalarticlesauthor" style="display: none;" ><a href="#" onclick="final_submit_article_author();">Submit this Article</a></li>
                <li id="submitfinalarticlesme" style="display: none;" ><a href="#" onclick="final_submit_article_me();">Conversion(M.E.)</a></li>
                <li id="submitfinalarticlesqc_datsetapproval" style="display: none;" ><a href="#" onclick="final_submit_article_qc_datasetapproval();">Final submit</a></li>
                <li id="submitfinalarticlesqc" style="display: none;" ><a href="#" onclick="final_submit_article_qc();">Submit Article(Q.C.)</a></li>
  				<li id="uploadcorrectedpdf" style="display: none;" ><a href="#" onclick="uploadcorrectedpdf();">Submit Pdf</a></li>
  				<li id="submitfordelivery" style="display: none;" ><a href="#" onclick="submitfordelivery_me();">Submit For Delivery</a></li>

        </ul>
      </div>
    </div>
    <div class="clear"></div> 
    </div>
 
 
 
  </div>
<!--wrapper / -->
</div>
<div id="toc" style="display: none;"></div>
<script src="<%=request.getContextPath() %>/authoringtool/gui/js/jquery.countdown.js"></script>
		<script src="<%=request.getContextPath() %>/authoringtool/gui/js/script.js"></script>
		
		    <script type="text/javascript" src="<%=request.getContextPath() %>/authoringtool/gui/js/jquery.fullscreen-min.js"></script>
		
		
		<script type="text/javascript">
    
    $(function() {
    
   
    $(document).bind("fullscreenchange", function(e) {
       console.log("Full screen changed.");
       $("#status").text($(document).fullScreen() ? 
           "Full screen enabled" : "Full screen disabled");
    });
    
    $(document).bind("fullscreenerror", function(e) {
       console.log("Full screen error.");
     
    });
    
    });
    
    </script>



</body>
</html>





