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
<title>Thomson Digital :: TD-XPS</title><link href="<%=request.getContextPath() %>/authoringtool/gui/css/style.css" rel="stylesheet" type="text/css" />

<link rel="stylesheet" href="<%=request.getContextPath() %>/authoringtool/gui/css/font-awesome.min.css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/authoringtool/gui/css/jquery.countdown.css">
<script type="text/javascript" src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery-1.7.2.min.js"></script>

<!--[if IE 7]>
  <link rel="stylesheet" href="css/font-awesome-ie7.min.css">
<![endif]-->
<link rel="stylesheet" href="<%=request.getContextPath() %>/authoringtool/gui/css/jquery-ui.css" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/ce.js"></script>

<script type='text/javascript' src='<%=request.getContextPath() %>/authoringtool/gui/js/jquery-1.9.1.js'></script>
<script type='text/javascript' src='<%=request.getContextPath() %>/authoringtool/gui/js/jquery-ui.js'></script>

<script type="text/javascript" src="<%=request.getContextPath() %>/authoringtool/gui/i18n/jquery.i18n.properties.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/authoringtool/gui/i18n/i18n.js"></script>

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

//------- plugin for author temp save button ------//

tinymce.create('tinymce.plugins.authortempsavePlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'authortempsave':  
	 var c = cm.createMenuButton('authortempsave', {
	 title : 'Save',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/save.png', 
	 icons : false  , 
	 onclick : function () {  
		//save temp file for author

		saveAuthorContent();

			
  		}     
	  });                     
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('authortempsave', tinymce.plugins.authortempsavePlugin); 
//------- end of plugin for author temp save button ------//

//------- plugin for author upload button ------//

tinymce.create('tinymce.plugins.authoruploadPlugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'authorupload':  
	 var c = cm.createMenuButton('authorupload', {
	 title : 'Upload Attachments',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/upload.png', 
	 icons : false  , 
	 onclick : function () {  
		//upload for author

		 uploadattachmentauthor();
			
  		}     
	  });                     
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('authorupload', tinymce.plugins.authoruploadPlugin); 
//------- end of plugin for author upload button ------//


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

//------- plugin for level 1 index button ------//

tinymce.create('tinymce.plugins.indlevel1Plugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'indlevel1':  
	 var c = cm.createMenuButton('indlevel1', {
	 title : 'level 1',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/l1.png', 
	 icons : false  , 
	 onclick : function () {  
		//apply style xps_index_level1\
		 tinymce.activeEditor.formatter.apply("xps_index_level1");
  		}     
	  });                     
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('indlevel1', tinymce.plugins.indlevel1Plugin); 
//------- end of plugin for list button ------//
//------- plugin for level2index button ------//

tinymce.create('tinymce.plugins.indlevel2Plugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'indlevel2':  
	 var c = cm.createMenuButton('indlevel2', {
	 title : 'level 2',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/l2.png', 
	 icons : false  , 
	 onclick : function () {  
		//apply style xps_index_level2
		 tinymce.activeEditor.formatter.apply("xps_index_level2");
  		}     
	  });                     
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('indlevel2', tinymce.plugins.indlevel2Plugin); 
//------- end of plugin for list button ------//

//------- plugin for level3 index button ------//

tinymce.create('tinymce.plugins.indlevel3Plugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'indlevel3':  
	 var c = cm.createMenuButton('indlevel3', {
	 title : 'level 3',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/l3.png', 
	 icons : false  , 
	 onclick : function () {  
		//apply style xps_index_level3
		 tinymce.activeEditor.formatter.apply("xps_index_level3");
  		}     
	  });                     
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('indlevel3', tinymce.plugins.indlevel3Plugin); 
//------- end of plugin for level3 button ------//

//------- plugin for caselevel1  button ------//

tinymce.create('tinymce.plugins.caselevel1Plugin', { 
	createControl: function(n, cm) {    
	 switch (n) {   
	 case 'caselevel1':  
	 var c = cm.createMenuButton('caselevel1', {
	 title : 'Case level1',  
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/cl1.png', 
	 icons : false  , 
	 onclick : function () {  
		
		 tinymce.activeEditor.formatter.apply("xps_case_level1");
  		}     
	  });                     
   	return c;      
  }        
	return null;      
   } });  
tinymce.PluginManager.add('caselevel1', tinymce.plugins.caselevel1Plugin); 
//------- end of plugin for caselevel1 button ------//

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
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/qc.png', 
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
	 image : '<%=request.getContextPath() %>/signin/onlinecontribution/editor/editor_files/images/qc.png', 
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


function enabletrackchanges(){

	tinyMCE.activeEditor.execCommand('ice_start');
	
}


function ed1PreSave() {
	return confirm("Page/Window is refreshing. Do you want to autosave the document ?");
}
    function setup() {
	tinyMCE.init({
		// General options
		
		mode : "textareas",
		theme : "advanced",
		//skin: "lightgray",
		editor_deselector : "mceNoEditor",
		plugins : plugins,
		 auto_focus : "elm1",
		 //oninit : makeeditordisableinauthorrole,
		oninit:enabletrackchanges,
		 //max_chars : 100,
		 //max_chars_indicator : "lengthBox",
		
		// Theme options
		height : "600",
		width: "100%",

		wsc_popup_title :"Custom Popup Title",
		wsc_lang :"en_US",
		wsc_top: 180,
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
		theme_advanced_resizing : false,
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
	document.getElementById('pubmed').style.display="block";
	var interval = 1;  
	setInterval(function(){ 
		   if(interval == 60){   
			        /* if interval reaches 5 the user is inactive hide element/s */  
		  document.getElementById('pubmed').style.display="none";
		 
		    interval = 1;    
		           }  
             interval = interval+1;  
                 },1000); 
     $('#pubmed').bind('mousemove keypress click dblclick mouseenter mouseleave', function() { 
             /* on mousemove or keypressed show the hidden input (user active) */ 
            
                 //document.getElementById('pubmed').style.display="block";
                   interval = 1; }); 
}
function open_pubmed(searchText) { 
	
	
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
function insertquery(){


	var filepath="<%=request.getContextPath()%>/signin/onlinecontribution/editor/editor_files/<%=customer_account%>_insertquery.jsp";

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

	var selectedText = tinyMCE.activeEditor.selection.getContent();
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
		}catch(e){}

	
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

			//generateontheflypdf();
			
		
		}
}
function load_article_in_tinymce(filepath){

	
	$('#mask').show();
	 $.ajax({
		
		  type: "POST",
		  url: filepath,
		  
		  beforeSend:function(xhr) {
              xhr.overrideMimeType('text/html; charset=ISO-8859-1');
            
              },
		 
		  statusCode: {
			  
		404: function() {
			
			 $('#mask').hide();
			 fail_notice("Article not found on the server. You need to start a fresh article");
		
			    },
	 	200: function(msg) {
			    	
					  content=msg;
			
					  window.setTimeout('loadcontent();',1000);
					 
							$('#mask').hide();
							success_notice("The article has been loaded successfully!!!");
					  
						    }
			  }
		});
	
}

	function publishFile(filepath)
		{
	
		 $.ajax({
				
			  type: "POST",
			  url: filepath,
			  statusCode: {
				    404: function() {
			
			 fail_notice("File not found on the server or is still under processing...");
			
				    },
		 	200: function(msg) {
				    	success_notice("Please wait ...");
				    	window.open(filepath);
							    }
				  }
			});
		
		}

	function publishMSSFile(filepath)
	{

	 $.ajax({
			
		  type: "POST",
		  url: filepath,
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
		var zipserverpath="<%=getPath%>temp/files/authorattchments/"+filepath+".zip";
	 $.ajax({
			
		  type: "POST",
		  url: zipserverpath,
		  statusCode: {
			    404: function() {
		
		 fail_notice("File not found on the server or is still under processing...");
		
			    },
	 	200: function(msg) {
			    	success_notice("Please wait ...");
			    	window.open(zipserverpath,'zipfileauthor','width=270px,height=240px, top=730,left=0,scrollbars=1');
						    }
			  }
		});
	
	}
	
function showalert(){
	$('.alert').delay(1000).slideDown().promise().done(function(){
		 $('.alert').delay(1000).slideUp()
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
	else if(((<%=userDTO.getRoleid().equalsIgnoreCase("RM1010")%> || <%=userDTO.getRoleid().equalsIgnoreCase("RM1011")%> )<%--  && <%=userDTO.getCustomerid().equalsIgnoreCase("C1012")%> --%>)){
		manage_fms_oup();
		
	}
	else{
	
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
	if((<%=userDTO.getRoleid().equalsIgnoreCase("RM1007")%>)<%--  && (<%=userDTO.getCustomerid().equalsIgnoreCase("C1001")%>) --%>){
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
	$(document).ready(function(){
		
		$('.log_accordian h3').click(function(){
			$('.down').toggleClass();
			$('.log_list').slideToggle();
		});
	});


	function displaycetasks(path){

		if((<%=userDTO.getRoleid().equalsIgnoreCase("RM1010")%>) <%-- && (<%=userDTO.getCustomerid().equalsIgnoreCase("C1001")%>) --%>){

			loadlogsinslider(path);

			generateIdForTOC();

			
		}
	}

	function showarticle(){
		$('.MsgNoArticleSelected').hide();
        $('.PDFLeftContainer, .ArticleLoader').show();
	}

	function showquerytab(){
		 $('.QueryContainer').toggle('slide', {direction: 'right'}, 500);
			$('.logsContainer').fadeOut();		
			$('.styleContainer').fadeOut();	
		
	}
function showquery_comments(){
	
	view_comments();
	
}
	function showboxtab(){

		$('.BoxContainer').toggle('slide', {direction: 'right'}, 500);
	}
</script>
<script type="text/javascript">
        $(document).ready(function () {
			
          
			$('.logsContainer').hide();
			$('.alert').hide();
			$('.togglePdf').hide();
			$('.PDFLeftContainer').hide();
			$('.BoxContainer').hide();
			
			$('.showArticle').click(function () {
				$('.MsgNoArticleSelected').hide();
                $('.PDFLeftContainer, .ArticleLoader').show();
				
            });
			
			$('.ToggleContainer').click(function () {
				
				//$('.Authorleft').toggle();
                //$('.togglePdf').toggle();
                //$('.Authorleft').toggleClass('AuthorleftFull');
                
				//$('.AuthorRight').toggleClass('AuthorRighthide');


				$('.Authorleft').toggleClass('AuthorleftFull');
				//$('.AuthorRight').toggleClass('AuthorRighthide');
				$('.authortabs_btn').toggleClass('authortabs_btnhide');
				$('.AuthorRightPanel_btn').toggleClass('AuthorRightPanel_btnhide');
				
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
			$('.ActionContainerAuthor').hide();
			
            $('.logs').click(function () {
                $('.logs_content').toggle(200);
            });
			
			$('.showAction').click(function () {				
                $('.ActionContainerAuthor').toggle('slide', {direction: 'down'}, 500);				
            });
			
			$('.showLogs').click(function () {				
                $('.logsContainer').toggle('slide', {direction: 'right'}, 500);				
				$('.styleContainer').fadeOut();				
            });
			
			$('.closeButton').click(function () {				
                $(this).parent().toggle('slide', {direction: 'right'}, 500);				
            });
			
			$('.showStyle').click(function () {				
                $('.styleContainer').toggle('slide', {direction: 'right'}, 500);
				$('.logsContainer').fadeOut();		
            });
			
			$('.closeButtonPDF').click(function () {				
                 $('.PDFEdit').addClass('PDFEditFull');
				 $('.PDFEditFull').removeClass('PDFEdit');
				 $('.StyleGuide').hide();			
            });
			$('.showQuery').click(function () {				
				showquery_comments();
            });
			
			
			   // $(function(){
				//	$('.table_grid').jScrollPane();
				//});                  
      
			$('.showStyleGuide').click(function () {
			
                $('.PDFEditFull').addClass('PDFEdit');
				 $('.PDFEditFull').removeClass('PDFEditFull');
				 $('.StyleGuide').show();
			});

			
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
//$( "#resizable" ).resizable();
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
		
		$('#slider').html("");
		var path="<%=request.getContextPath()%>/"+jsp_name+"?random="+new Date().getTime();
		
		$('#content_div').load(path, function() {
			});
	}

	function manage_pdfview(jsp_name){
		
		var path= "<%=request.getContextPath()%>/"+jsp_name+"?random="+new Date().getTime();

		$('#load_pdf').html('<iframe src='+path+' width="100%" height="100%" name=\"pdfframe\" id=\"pdfframe\">');
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
function displaypdfaftersecond(){
	showarticle();

	
	displaypdfauthor();
	
}

function displaypdfauthor(){

	

	<% if(customer_account.equalsIgnoreCase("elsevierbookseries")){%>
	
	var pdfserverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/"+chapterid.replace('_00','')+".pdf?random="+new Date().getTime();
	 
	<%}else if(customer_account.equalsIgnoreCase("johnwileyjournal")){ %>

	var aid = getaid(itemcode);
	var pdfserverpath="<%=getPath%>temp/files/"+itemcode+"/"+aid+".pdf?random="+new Date().getTime();
	<% }else{ %>
	var aid = getaid(itemcode);
	var pdfserverpath="<%=getPath%>temp/files/"+itemcode+"/"+aid+".pdf?random="+new Date().getTime();
	<% }%>

		var path="pdfmaster/web/pdfviewer.jsp?pdfpath="+pdfserverpath;
		var iframepath= "<%=request.getContextPath()%>/"+path+"?random="+new Date().getTime();
		$('#load_pdf').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"pdfframe\" id=\"pdfframe\">');
		$('.PDFLeftContainer').show();
		$('.StyleGuide').hide();
		$('.PDFEdit').show();
		$('#load_pdf').show();
		    		
	
}
 function generateontheflypdfaftersecond(){
	
	 	exactview();
	 	
	 	showarticle();
	 
		window.setTimeout('generateontheflypdf()',2000);
	
		
	}

 var content;
 function loadcontentofbook(){
 	if (tinyMCE.activeEditor == null){
 		window.setTimeout('loadcontent()',1000);
 		}else{
 			
 			tinyMCE.get('elm1').focus();
 			tinyMCE.get('elm1').setContent(content);

 			if(stagename != "AUTHOR_REVISION"){
 				viewStyleSheetofParticularBookChapter();
 			}

 			if(stagename == "MASTER_COPY_EDITOR" || stagename=="PROOF_COLLATION"){
 				var pdfserverpath="<%=getPath%>temp/files/"+itemcode+"/"+itemcode+"_"+chapterid+"/"+chapterid+".pdf?random="+new Date().getTime();
 				
 			 	var path="pdfmaster/web/pdfviewer.jsp?pdfpath="+pdfserverpath;
 			 	var iframepath= "<%=request.getContextPath()%>/"+path+"?random="+new Date().getTime();
 			 	$('#load_pdf').html('<iframe src='+iframepath+' width="100%" height="100%" name=\"cleanproofframe\" id=\"cleanproofframe\">');
 			 	
 			 	$('#load_pdf').show();
 			 	$('.PDFEdit').addClass('PDFEditFull');
 			 	$('.PDFLeftContainer').show();		
 			 	$('.PDFEdit').removeClass('PDFEdit');
 			 	$('.StyleGuide').hide();
 			}
 		
 		
 		
 		}
 }

 function load_chapter_in_tinymce(filepath){

 	
 	 $.ajax({
 		
 		  type: "POST",
 		  url: filepath,
 		  
 		  beforeSend:function(xhr) {
              xhr.overrideMimeType('text/html; charset=ISO-8859-1');
          
              },
 		 
 		  statusCode: {
 			  
 		404: function() {
 		
 			 fail_notice("Chapter not found on the server. You need to start a fresh chapter");
 		
 			    },
 	 	200: function(msg) {
 			    	
 					  content=msg;
 			
 					  window.setTimeout('loadcontentofbook();',1000);
 					
 							
 							success_notice("The chapter has been loaded successfully!!!");
 							
 						    }
 			  }
 		});
 	
 }


//load I18N bundles
 jQuery(document).ready(function() {


 	if(localStorage.getItem("TDXPS_Lang")==null || localStorage.getItem("TDXPS_Lang")==""){
 		
 		// loadBundles("en");

 		}
 	else{

 		// loadBundles(localStorage.getItem("TDXPS_Lang"));

 		}

 	jQuery('#lang').change(function() {
 		var selection = jQuery('#lang option:selected').val();
 		//alert(selection);
 		loadBundles(selection != 'browser' ? selection : null);

 		
 		jQuery('#langBrowser').empty();
 		if(selection == 'browser') {
 			jQuery('#langBrowser').html('('+jQuery.i18n.browserLang()+')');
 		}
 	});

 });


 function loadBundles(lang) {

 	jQuery.i18n.properties({
 	    name:'Messages', 
 	    path:'<%=request.getContextPath() %>/authoringtool/gui/i18n/bundle/', 
 	    mode:'both',
 	    language:lang, 
 	    callback: function() {

 		     // update fields according to the locale...

 		    tdxps.setLocale();

 	    }
 	});
 }



 function saveAuthorContent(){
	 filename = itemcode;
	 exactview();
	 var editorcontent=tinyMCE.activeEditor.getContent();
	 $.ajax({
		  type: "POST",
		  url: "<%=request.getContextPath()%>/authoringtool/processcontent/savetempfileforauthor.jsp",
		  data: "editorcontent="+encodeURIComponent(editorcontent)+"&filename="+filename+"&chapterid="+chapterid,
		  success: function(msg){
			success_notice("File saved successfully...");
		  }
		});
	 }



 function uploadattachmentauthor(){

		if(itemcode!=null && itemcode!=""){

			var serverpath = "files";


			<% if(customer_account.equalsIgnoreCase("elsevierbookseries")){%>
			
			var path="http://172.16.0.53:8086/upload/index.html?filename="+itemcode+"&type=book&chapterid="+chapterid+"&path="+serverpath+"&random="+new Date().getTime();
		
		<%} else{%>
		
		var path="http://172.16.0.53:8086/upload/index.html?filename="+itemcode+"&type=book&path="+serverpath+"&random="+new Date().getTime();
		
    	<%}%>


			
			
			$('#common_box').html('<iframe src='+path+' width="100%" height="95%" scrolling="no" name=\"dropbox\" id=\"dropbox\">');
			showboxtab();
		}
		else{
			fail_notice("some error occurred!!! (Please select an chapter)");

			}
		
	}
	
	</script>



</head>

<body>

<!--wrapper  -->
<div class="alert">
	<div class="popupButton"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/close_btn.png" width="8" height="8"></div>
  <p id="alert_para"></p>
</div>

<div class="wrapper"> 

 <!--header  -->
  <div class="header">
    <div class="alertBar">
      <p><i class="icon-alert"></i>Alert For New Task can slide down here, and it will be hide after 10 Second </p>
    </div>
    <div class="Logo fl"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/logo.png" width="130" height="49" alt="TD-XPS "></div>
    
     <div class="UserDetail fr">
    <p class="User"><a href="">Welcome <%=name.toUpperCase() %> (<%if(name.equalsIgnoreCase("paul")){%>PRODUCTION EDITOR<%}else if(name.equalsIgnoreCase("rigg")){%>PROOFREADER<%}else{%><%-- <%=userDTO.getRole() %> --%><%}%>)</a><a href="<%=getPath%>/temp/docs/help.exe">Help</a></p>
       
      <div class="clear"></div>
      <ul>      
        <li><a href="<%=request.getContextPath() %>/signin/login/login.jsp?user=0&pass=1">Logout</a><i class="icon-off icon-1x"></i></li>    
      </ul>
       <p class="LoginDetail">Last Login TIme : <span>04 : 25 AM</span></p>
    </div>
   
    <!--header / --></div>
<div class="clear"></div>

 <div class="content">
 
 <div id="progressBar" class="default" style="display: none;"><div></div></div>
 <div class="Dashboard" id="content_div">
      
    </div>
    
    <div class="TitleContainer authorIndicator">
      <div class="Title" id="dashboardtitle">Author proof</div>
      <div class="Icon_main">
      
        <div class="full_screen"><a href="#" onclick="$(document).toggleFullScreen();"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/full_screen_icon.png" width="22" height="21"></a></div>
        <div class="full_screen"><a href="#"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/question.png" width="22" height="21"></a></div>
         
        <div class="clear"></div>
      </div>
      <div class="clear"></div>
    </div>
 <div class="togglePdf ToggleContainer"> <img src="<%=request.getContextPath() %>/authoringtool/gui/images/toggle.png"></div>
<div class="Authorleft editor fl" id="resizable">
 <div class="MsgNoArticleSelected">Please select a chapter.</div>
      <div class="PDFLeftContainer"  style="background:#ffffff;">
       <p class="ar_title" style="border-left:#dddddd 1px solid; border-bottom:#dddddd 1px solid;">PDF<span class="fr pt-5" title="Toggle view"><img class="ToggleContainer" src="<%=request.getContextPath() %>/authoringtool/gui/images/left-toggle.png" width="23" height="10"></span></p>
        <!--Style Guide-->
      <div class="StyleGuide fl hide">
        <div class="closeButton"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/close_btn.png" alt="Close"></div>
         <div class="styleContent">
        <div id="styleguide">
        
        
        </div>
         </div>
        
          </div>
          
          
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
          
          
           <!--Styles-->
        <div class="styleContainer AuthorStyle fl">
        <div class="closeButton"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/close_btn.png" alt="Close"></div>
          <div class="logs_slide">
            <div class="logs_title">Comments</div>
            <div class="logs_guide" id="comments_div">
              
            </div>
          </div>
        </div>
        <!--Styles // -->
          
          
         
          <div class="PDFEditAuthor fl " id="load_pdf"> 
        		NO PDF FOUND...
         </div>
          
            <div class="clear"></div>
        <div class="authortabs_btn">
       <input  type="image" class="Pdf_view" value = "Quick View" style="display: none;" onclick="generateontheflypdfaftersecond();">
      <input name="displaypdfview" id="displaypdfview"  type="image" class="Pdf_view" value = "Pdf View" onclick="displaypdfaftersecond();">
          <input name="querybutton" id="querybutton" type="button" class="queryAuthor showQuery" value="Query">
            <input name="indexbutton" id="indexbutton" type="button" class="Pdf_view" value="Index" onclick="generatebookindex();"> 
            <!-- <input name="" type="button" class="Pdf_view" value="TOC" onclick="generateTableOfCases();"> -->
         <!--  <input name="" type="button" class="CommentAuthor showStyle" value="Comments"> -->
         <input name="" type="button" class="Comment" value="" onclick="if(navigator.userAgent.toLowerCase().indexOf('opera') != -1 && window.event.preventDefault) window.event.preventDefault();this.newWindow = window.open('<%=getPathwithoutnewport%>tdxpslivesupport/client.php?locale=en&url='+escape(document.location.href)+'&referrer='+escape(document.referrer), 'webim', 'toolbar=0,scrollbars=0,location=0,status=1,menubar=0,width=640,height=480,resizable=1');this.newWindow.focus();this.newWindow.opener=window;return false;" target="_blank" href="<%=getPathwithoutnewport%>tdxpslivesupport/client.php?locale=en">
        </div>
         
           <div class="clear"></div>
       
          
        </div>
     
        
       
        <!--Common Box-->
        <div class="BoxContainer AuthorStyle fl">
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
     
      <div class="EditorOuterContainer AuthorRight  fl ">
      <div class="EditorMenu hide" >
        
       <%@ include file="/signin/onlinecontribution/editor/editor_files/edmenu.jsp"%>
        
        
          <div class="clear"></div>
        </div>
      <div class="ArticleLoader" id="load_editor"><img src="<%=request.getContextPath() %>/authoringtool/gui/images/article.jpg"  alt="Article" ></div>
    </div>
 

    <div class="clear"></div> 
    </div>
 
 
  <div class="AuthorRightPanel_btn">
     
      <!--<input name="" src="<%=request.getContextPath() %>/authoringtool/gui/images/action.png" type="image" class="Action showAction">-->
       <div class="ActionBtn showAction">Action</div>
      <div class="ActionContainerAuthor" >
      
        <ul>
         <li id="viewcomments" style="display: none;"><a href="#" onclick="view_comments();" id="viewcommentshref" >View Comments</a></li>
            	<li id="insertcomments" style="display: none;"><a href="#" onclick="get_query();" id="insertcommentshref">Insert Comments</a></li>
            	<li id="submitarticle" style="display: none;" ><a href="#" onclick="submit_article();" id="submitarticlehref">Submit Chapter</a></li>
            	<li id="conversion" style="display: none;" ><a href="#" onclick="calluncitedreferenceandconversion();" id="conversionhref">Conversion</a></li>
            	<li id="submitfinalarticle" style="display: none;" ><a href="#" onclick="validateVToolLogBeforeSubmission_s5();" id="submitfinalarticlehref">Submit Final Chapter</a></li>
            	<li id="submitfinalarticles100" style="display: none;" ><a href="#" onclick="validateVToolLogBeforeSubmission_s100();" id="submitfinalarticles100href">Submit Final Chapter</a></li>
            	<li id="submitfinalarticlebyme" style="display: none;" ><a href="#" onclick="validateVToolLogBeforeSubmission_ME();" id="submitfinalarticlebymehref">Submit Final Chapter(M.E.)</a></li>
                <li id="submitfinalarticlesauthor" style="display: none;" ><a href="#" onclick="final_submit_article_author();" id="submitfinalarticlesauthorhref">Submit this Chapter</a></li>
                <li id="submitfinalarticlesme" style="display: none;" ><a href="#" onclick="final_submit_article_me();" id="submitfinalarticlesmehref">Submit this Chapter(M.E.)</a></li>
                <li id="submitfinalarticlesqc" style="display: none;" ><a href="#" onclick="final_submit_article_qc();" id="submitfinalarticlesqchref">Submit Final Chapter(Q.C.)</a></li>
  				<li id="uploadcorrectedpdf" style="display: none;" ><a href="#" onclick="uploadcorrectedpdf();">Submit Pdf</a></li>
  				<li id="submitfordelivery" style="display: none;" ><a href="#" onclick="submitfordelivery_me();">Submit For Delivery</a></li>

        </ul>
      </div>
    </div>
  </div>
<!--wrapper / -->


<div id="toc" style="display: none;"></div>

		
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
<script type="text/javascript" src="<%=request.getContextPath() %>/authoringtool/finaltable/jquery-1.7.2.min.js"></script>
</body>
</html>





