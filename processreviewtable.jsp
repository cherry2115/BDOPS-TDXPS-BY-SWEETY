
<%@page import="td.xbp.dao.model.ChapterBean"%>
<%@page import="td.xbp.dao.model.BookBean"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%><%@ page import="td.xbp.delegate.Delegate" %>
<%@ page import="td.xbp.delegate.DelegateImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="td.xbp.model.UserDTO" %>
<%@ page import="td.xbp.model.BdusersDTO" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="td.xbp.dao.model.LoadReviewArticle" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>

<% 

String getProtocol=request.getScheme();
String getDomain=request.getServerName();
String getPort=Integer.toString(request.getServerPort());
String getPath = getProtocol+"://"+getDomain+":"+getPort+"/";
int divcount=0;

String tdxps_server_root_path = ResourceBundle.getBundle("pathbundle").getString("tdxps_server_root_path");
String tdxps_BDOPS_server_path = ResourceBundle.getBundle("pathbundle").getString("tdxps_BDOPS_server_path");
Map httpsession = ActionContext.getContext().getSession();
// UserDTO userDTO =  (UserDTO)httpsession.get("userDTO");
BdusersDTO userDTO = (BdusersDTO)session.getAttribute("userDTO");
Delegate delegate = new DelegateImpl();   



StringBuilder contentBuilder = new StringBuilder();

contentBuilder.append("<table id=\"rounded-corners\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"showArticle\" width=\"100%\">");

// for elsevier journals 
if(userDTO.getUserCustomer().equalsIgnoreCase("ELSEVIERJOURNAL") || userDTO.getUserCustomer().equalsIgnoreCase("johnwileyjournal"))
{
	List<LoadReviewArticle> list = (List)delegate.delegate("GenericAdvisor", "getReviewArticles", userDTO );
	//for pse view
	if(userDTO.getRoleid().equalsIgnoreCase("RM1010"))
	{
		
		contentBuilder.append("<tr>");
		contentBuilder.append("<th id=\"businesstype_msg\">");
		contentBuilder.append("JOURNAL");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"category_msg\">");
		contentBuilder.append("AID/ISSUE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"psestage_msg\">");
		contentBuilder.append("PSE&nbsp;STAGE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"graphicsstage_msg\">");
		contentBuilder.append("GRAPHICS&nbsp;STAGE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\">");
		contentBuilder.append("FX&nbsp;STATUS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\">");
		contentBuilder.append("CE&nbsp;FX&nbsp;STATUS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\">");
		contentBuilder.append("ME&nbsp;FX&nbsp;STATUS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\">");
		contentBuilder.append("JTITLE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"startdate_msg\">");
		contentBuilder.append("STARTDATE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"enddate_msg\">");
		contentBuilder.append("ENDDATE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"originals_msg\">");
		contentBuilder.append("ORIGINALS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"pceoutputs_msg\">");
		contentBuilder.append("PCE&nbsp;OUTPUTS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"ceoutputs_msg\">");
		contentBuilder.append("CE&nbsp;OUTPUTS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"dslogs_msg\">");
		contentBuilder.append("DS&nbsp;LOGS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"pdfoutput_msg\">");
		contentBuilder.append("PDF&nbsp;OUTPUTS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"upload_msg\">");
		contentBuilder.append("UPLOAD");
		contentBuilder.append("</th>");
			
			for(LoadReviewArticle loadreviewarticle : list){
				
				String PSE_STAGEID = "";
				String GRAPHICS_STAGEID = "";
				if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1011")){
					
					PSE_STAGEID = "AUTO_STRUCTURING";
					
					
				}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1022")){
					PSE_STAGEID = "CNU_FAIL";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1021")){
					PSE_STAGEID = "CNU_PASS";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1023")){
					PSE_STAGEID = "AUTO_STRUCTURING_FAIL";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1004")){
					PSE_STAGEID = "COPY_EDITOR";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1009")){
					PSE_STAGEID = "QC";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1005")){
					PSE_STAGEID = "PROOF_COLLATION";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1026")){
					PSE_STAGEID = "PAGINATION";
				}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1006")){
					PSE_STAGEID = "AUTHOR_REVISION";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1035")){
					PSE_STAGEID = "P100_AUTOPAGE";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1036")){
					PSE_STAGEID = "P100_QC";
				}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1037")){
					PSE_STAGEID = "S100_DATASET_CREATING";
				}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1038")){
					PSE_STAGEID = "S100_DATASET_CREATED";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1039")){
					PSE_STAGEID = "P100_DATASETCREATION";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1040")){
					PSE_STAGEID = "P100_DATASETCREATED";
				}
				else{
					PSE_STAGEID = "N/A";
				}
				if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1024")){
					GRAPHICS_STAGEID = "GRAPHICS";
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1028")){
					GRAPHICS_STAGEID = "IGQC";
				}
				else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1029")){
					GRAPHICS_STAGEID = "IGQC_FAIL";
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1030")){
					GRAPHICS_STAGEID = "OGQC";
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1031")){
					GRAPHICS_STAGEID = "OGQC_FAIL";
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1032")){
					GRAPHICS_STAGEID = "FX";
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1033")){
					GRAPHICS_STAGEID = "FX_FAIL";
				}else{
					GRAPHICS_STAGEID = "N/A";
				}
				
				
				
				
				contentBuilder.append("<tr>");
				
				contentBuilder.append("<td>");
				contentBuilder.append(loadreviewarticle.getJOURNALNAME());
				contentBuilder.append("</td>");
				
				if(PSE_STAGEID.equalsIgnoreCase("QC")){
					
					contentBuilder.append("<td><a href=\"#\" onclick=\"autoopen3DFile('"+loadreviewarticle.getITEMCODE()+"','g');setMetroPath('"+loadreviewarticle.getPSE_STAGEID()+"');displayQC('"+loadreviewarticle.getITEMCODE()+"');\" >");
					contentBuilder.append(loadreviewarticle.getITEMCODE());
					contentBuilder.append("</a></td>");
					
					
				}
				else if(PSE_STAGEID.equalsIgnoreCase("P100_QC")){
					contentBuilder.append("<td><a href=\"#\" onclick=\"setMetroPath('"+loadreviewarticle.getPSE_STAGEID()+"');loadp100content('"+loadreviewarticle.getITEMCODE()+"');\" >");
					contentBuilder.append(loadreviewarticle.getITEMCODE());
					contentBuilder.append("</a></td>");
					
				}
				else{
					contentBuilder.append("<td><a href=\"#\" onclick=\"setMetroPath('"+loadreviewarticle.getPSE_STAGEID()+"');loadArticle('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+loadreviewarticle.getITEMCODE()+".htm','"+PSE_STAGEID+"','"+loadreviewarticle.getITEMCODE()+"');\" >");
					contentBuilder.append(loadreviewarticle.getITEMCODE());
					contentBuilder.append("</a></td>");
					
				}
			
				
				contentBuilder.append("<td>");
				contentBuilder.append(PSE_STAGEID);
				contentBuilder.append("</td>");
				
				
				
				if(PSE_STAGEID.equalsIgnoreCase("P100_QC")){
				
				contentBuilder.append("<td>");
				contentBuilder.append("N/A");
				contentBuilder.append("</td>");
				
				}else{ 
					contentBuilder.append("<td>");
					contentBuilder.append(GRAPHICS_STAGEID);
					contentBuilder.append("</td>");
				}
				
				contentBuilder.append("<td class=\"hidecol\">");
				contentBuilder.append(loadreviewarticle.getFX_STATUS());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td class=\"hidecol\">");
				contentBuilder.append(loadreviewarticle.getPSE_CE_FX_STATUS());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td class=\"hidecol\">");
				contentBuilder.append(loadreviewarticle.getPSE_ME_FX_STATUS());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td class=\"hidecol\">");
				contentBuilder.append(loadreviewarticle.getTITLE());
				contentBuilder.append("</td>");
				
				
				contentBuilder.append("<td>");
				contentBuilder.append(loadreviewarticle.getSTARTDATE());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td>");
				contentBuilder.append(loadreviewarticle.getENDDATE());
				contentBuilder.append("</td>");
				
				String[] arr = loadreviewarticle.getITEMCODE().split("_");
				String jid = arr[3];
				String aid = arr[4];
				
				if(PSE_STAGEID.equalsIgnoreCase("P100_QC")){
				
				contentBuilder.append("<td>");
				contentBuilder.append("N/A");
				contentBuilder.append("</td>");
				
				}else{
					contentBuilder.append("<td>");
					contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+aid+"_org.doc')\" href=\"#\" ><img title=\"Original doc file\" src='"+request.getContextPath()+"/authoringtool/gui/images/word.png' width=\"18\" height=\"19\" ></a>&nbsp;");
					contentBuilder.append("</td>");
					
				}
				
				if(PSE_STAGEID.equalsIgnoreCase("P100_QC")){
				
				contentBuilder.append("<td>");
				contentBuilder.append("N/A");
						
				contentBuilder.append("</td>");
				}else{
					contentBuilder.append("<td>");
					
					contentBuilder.append("<a onclick=\"javascript:loadlogsinslider('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/msslog.html')\" href=\"#\" ><img title=\"MSS Log File\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
							
					contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/pce.zip')\" href=\"#\" ><img title=\"S5(pce.xml)\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\" ></a>&nbsp;");
					
					contentBuilder.append("<a onclick=\"javascript:launchs5vtoolwindow();\" href=\"#\" ><img title=\"S5 Log File\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>");
					
					//contentBuilder.append("<a onclick=\"javascript:launchsdatasetlog('"+loadreviewarticle.getITEMCODE()+"');\" href=\"#\" ><img title=\"S5 Dataset Log\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>");
					
					contentBuilder.append("</td>");
					
					
					
				}
				
				if(PSE_STAGEID.equalsIgnoreCase("P100_QC")){
				contentBuilder.append("<td>");
				
				contentBuilder.append("N/A");
				
				contentBuilder.append("</td>");
				}else{
					contentBuilder.append("<td>");
					
					contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/tx1.zip')\" href=\"#\" ><img title=\"Download CE XML\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\"></a>&nbsp;");
					
					contentBuilder.append("<a onclick=\"javascript:launchs100vtoolwindow();\" href=\"#\" ><img title=\"CE(tx1 VTool Log)\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
					
					//contentBuilder.append("<a onclick=\"javascript:launchs100datasetlog('"+loadreviewarticle.getITEMCODE()+"');\" href=\"#\" ><img title=\"S100 Dataset Log\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>");
					
					
					//contentBuilder.append("<a  onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+loadreviewarticle.getITEMCODE()+"_epub2.epub');\" href=\"#\" ><img title=\"Download EPUB\" src='"+request.getContextPath()+"/authoringtool/gui/images/interner_icon.png'  width=\"22\" height=\"15\"></a>");
					
					File file = new File(tdxps_server_root_path+loadreviewarticle.getITEMCODE()+"/proofcentral.ini");
					
					if(file.exists()){
						contentBuilder.append("<a onclick=\"javascript:launchs200vtoolwindow();\" href=\"#\" ><img title=\"ME(Edit Summary Log)\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
					}
					contentBuilder.append("</td>");
					
				}
				
				contentBuilder.append("<td>");
				
				if(PSE_STAGEID.equalsIgnoreCase("P100_DATASETCREATED")|| PSE_STAGEID.equalsIgnoreCase("P100_DATASETCREATION")){
				
				contentBuilder.append("<a onclick=\"javascript:launchp100datasetlog('"+loadreviewarticle.getITEMCODE()+"');\" href=\"#\" ><img title=\"P100 Dataset Log\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>");
				
				
				}else{
					
					contentBuilder.append("N/A");
					
				}
				contentBuilder.append("</td>");
				
				
				
				
				contentBuilder.append("<td>");
				
				
				
				if(PSE_STAGEID.equalsIgnoreCase("QC")){
					
					//contentBuilder.append("<a onclick=\"javascript:downloadpdfworkpackettovm('"+loadreviewarticle.getITEMCODE()+"')\" href=\"#\" ><img title=\"Download pdf workpacket\" src='"+request.getContextPath()+"/authoringtool/gui/images/zip_icon.png' width=\"18\" height=\"19\"'></a>&nbsp;");
					
					
					
					contentBuilder.append("<a onclick=\"javascsript:autoopen3DFile('"+loadreviewarticle.getITEMCODE()+"','main');displaypdfinpdfbox('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+aid+".pdf')\" href=\"#\" ><img title=\"Download aid.pdf\" src='"+request.getContextPath()+"/authoringtool/gui/images/pdf_icon.png' width=\"18\" height=\"19\" ></a>&nbsp;");
					
					contentBuilder.append("<a onclick=\"javascsript:autoopen3DFile('"+loadreviewarticle.getITEMCODE()+"','g');displaypdfinpdfbox('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+aid+"g.pdf')\" href=\"#\" ><img title=\"Download aidg.pdf\" src='"+request.getContextPath()+"/authoringtool/gui/images/pdf_icon.png' width=\"18\" height=\"19\" ></a>&nbsp;");
					
					contentBuilder.append("<a onclick=\"autoopen3DFile('"+loadreviewarticle.getITEMCODE()+"','r');javascsript:displaypdfinpdfbox('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+aid+"r.pdf')\" href=\"#\" ><img title=\"Download aidh.pdf\" src='"+request.getContextPath()+"/authoringtool/gui/images/pdf_icon.png' width=\"18\" height=\"19\" ></a>&nbsp;");
					
				}else if(PSE_STAGEID.equalsIgnoreCase("P100_QC")){
				
					contentBuilder.append("N/A");
					
				}else{
					
					contentBuilder.append("N/A");
					//contentBuilder.append("<a onclick=\"javascsript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+loadreviewarticle.getITEMCODE()+"_original.pdf')\" href=\"#\" ><img title=\"Download original PDF\" src='"+request.getContextPath()+"/authoringtool/gui/images/pdf_icon.png' width=\"18\" height=\"19\" ></a>&nbsp;");
					
				}
				
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td>");
				
				
				
				
				if(PSE_STAGEID.equalsIgnoreCase("QC")){
					
					contentBuilder.append("<input name=\"\" type=\"button\" class=\"submit\" onclick=\"RunExe('"+loadreviewarticle.getITEMCODE()+"');\" value=\"Upload\">");
					
				}else if(PSE_STAGEID.equalsIgnoreCase("P100_QC")){
				
					contentBuilder.append("N/A");
					
				}else{
					contentBuilder.append("<input name=\"\" type=\"button\" class=\"submit\" onclick=\"uploadcorrectedpdfbypse();\" value=\"Upload\">");
					
				}
				
				
				
				contentBuilder.append("</td>");
				
				
				
			}
		
		
	}
	
	//for author view 
	
	else if(userDTO.getRoleid().equalsIgnoreCase("RM1007"))
	{
		
		contentBuilder.append("<tr>");
		contentBuilder.append("<th id=\"businesstype_msg\">");
		contentBuilder.append("JOURNAL");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"category_msg\">");
		contentBuilder.append("AID");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"psestage_msg\">");
		contentBuilder.append("PSE&nbsp;STAGE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\" id=\"graphicsstage_msg\">");
		contentBuilder.append("GRAPHICS&nbsp;STAGE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\">");
		contentBuilder.append("FX&nbsp;STATUS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\">");
		contentBuilder.append("CE&nbsp;FX&nbsp;STATUS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\">");
		contentBuilder.append("ME&nbsp;FX&nbsp;STATUS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\">");
		contentBuilder.append("JTITLE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th>");
		contentBuilder.append("TIME&nbsp;REMAINING");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"startdate_msg\">");
		contentBuilder.append("STARTDATE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"enddate_msg\">");
		contentBuilder.append("ENDDATE");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\" id=\"pceoutputs_msg\">");
		contentBuilder.append("PCE&nbsp;OUTPUTS");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th class=\"hidecol\" id=\"ceoutputs_msg\">");
		contentBuilder.append("CE&nbsp;OUTPUTS");
		contentBuilder.append("</th>");
		
		//contentBuilder.append("<th id=\"pdfoutput_msg\">");
		//contentBuilder.append("PDF&nbsp;OUTPUTS");
		//contentBuilder.append("</th>");
		
		for(LoadReviewArticle loadreviewarticle : list){
			
			String PSE_STAGEID = "";
			String GRAPHICS_STAGEID = "";
			if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1011")){
				
				PSE_STAGEID = "AUTO_STRUCTURING";
				
				
			}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1022")){
				PSE_STAGEID = "CNU_FAIL";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1021")){
				PSE_STAGEID = "CNU_PASS";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1023")){
				PSE_STAGEID = "AUTO_STRUCTURING_FAIL";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1004")){
				PSE_STAGEID = "COPY_EDITOR";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1009")){
				PSE_STAGEID = "QC";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1005")){
				PSE_STAGEID = "PROOF_COLLATION";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1006")){
				PSE_STAGEID = "AUTHOR_REVISION";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1026")){
				PSE_STAGEID = "PAGINATION";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1006")){
				PSE_STAGEID = "AUTHOR_REVISION";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1035")){
				PSE_STAGEID = "P100_AUTOPAGE";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1036")){
				PSE_STAGEID = "P100_QC";
			}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1037")){
				PSE_STAGEID = "S100_DATASET_CREATING";
			}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1038")){
				PSE_STAGEID = "S100_DATASET_CREATED";
			}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1039")){
				PSE_STAGEID = "P100_DATASETCREATION";
			}
			else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1040")){
				PSE_STAGEID = "P100_DATASETCREATED";
			}
			else{
				PSE_STAGEID = "N/A";
			}
			if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1024")){
				GRAPHICS_STAGEID = "GRAPHICS";
			}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1028")){
				GRAPHICS_STAGEID = "IGQC";
			}
			else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1029")){
				GRAPHICS_STAGEID = "IGQC_FAIL";
			}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1030")){
				GRAPHICS_STAGEID = "OGQC";
			}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1031")){
				GRAPHICS_STAGEID = "OGQC_FAIL";
			}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1032")){
				GRAPHICS_STAGEID = "FX";
			}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1033")){
				GRAPHICS_STAGEID = "FX_FAIL";
			}else{
				GRAPHICS_STAGEID = "N/A";
			}
			
			String[] arr = loadreviewarticle.getITEMCODE().split("_");
			String jid = arr[3];
			String aid = arr[4];
			
			
			contentBuilder.append("<tr>");
			contentBuilder.append("<td>");
			contentBuilder.append(loadreviewarticle.getJOURNALNAME());
			contentBuilder.append("</td>");
			
			//contentBuilder.append("<td><a href=\"#\" onclick=\"loadArticle('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+loadreviewarticle.getITEMCODE()+".htm');\" >");
			
			contentBuilder.append("<td><a href=\"#\" onclick=\"loadArticle('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+loadreviewarticle.getITEMCODE()+".htm','"+PSE_STAGEID+"','"+loadreviewarticle.getITEMCODE()+"');displaypdfaftersecond();\" >");
			//contentBuilder.append(jid+"_"+aid);
			
			contentBuilder.append(loadreviewarticle.getITEMCODE());
			contentBuilder.append("</a></td>");
			
			contentBuilder.append("<td>");
			contentBuilder.append(PSE_STAGEID);
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td class=\"hidecol\">");
			contentBuilder.append(GRAPHICS_STAGEID);
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td class=\"hidecol\">");
			contentBuilder.append(loadreviewarticle.getFX_STATUS());
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td class=\"hidecol\">");
			contentBuilder.append(loadreviewarticle.getPSE_CE_FX_STATUS());
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td class=\"hidecol\">");
			contentBuilder.append(loadreviewarticle.getPSE_ME_FX_STATUS());
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td class=\"hidecol\">");
			contentBuilder.append(loadreviewarticle.getTITLE());
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td>");
			contentBuilder.append(new Date().getHours()+"::"+ new Date().getMinutes()+"::"+ new Date().getSeconds());
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td>");
			contentBuilder.append(loadreviewarticle.getSTARTDATE());
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td>");
			contentBuilder.append(loadreviewarticle.getENDDATE());
			contentBuilder.append("</td>");
			
			
			
			
			
			contentBuilder.append("<td class=\"hidecol\">");
			contentBuilder.append("<a onclick=\"javascript:loadlogsinslider('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/msslog.html')\" href=\"#\" ><img title=\"MSS Log File\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
					
			contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/pce.zip')\" href=\"#\" ><img title=\"S5(pce.xml)\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\" ></a>&nbsp;");
			
			contentBuilder.append("<a onclick=\"javascript:launchs5vtoolwindow();\" href=\"#\" ><img title=\"S5 Log File\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>");
			
			contentBuilder.append("</td>");
			
			
			contentBuilder.append("<td class=\"hidecol\">");
			
			contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/tx1.zip')\" href=\"#\" ><img title=\"Download CE XML\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\"></a>&nbsp;");
			
			contentBuilder.append("<a onclick=\"javascript:launchs100vtoolwindow();\" href=\"#\" ><img title=\"CE(tx1 VTool Log)\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			contentBuilder.append("<a  href=\"#\" ><img title=\"Download EPUB\" src='"+request.getContextPath()+"/authoringtool/gui/images/interner_icon.png'  width=\"22\" height=\"15\"></a>");
			
			contentBuilder.append("</td>");
			
			
			//contentBuilder.append("<td>");
			
			//contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+loadreviewarticle.getITEMCODE()+"_pdfpacket.zip')\" href=\"#\" ><img title=\"Download pdf workpacket\" src='"+request.getContextPath()+"/authoringtool/gui/images/zip_icon.png' width=\"18\" height=\"19\"'></a>&nbsp;");
			
			//contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+loadreviewarticle.getITEMCODE()+"_markedpdf.pdf')\" href=\"#\" ><img title=\"Download marked PDF\" src='"+request.getContextPath()+"/authoringtool/gui/images/pdf_icon.png' width=\"18\" height=\"19\" ></a>&nbsp;");
			
			//contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+loadreviewarticle.getITEMCODE()+"_authorpdfpacket.zip')\" href=\"#\" ><img title=\"Download corrected PDF\" src='"+request.getContextPath()+"/authoringtool/gui/images/pdf_icon.png' width=\"18\" height=\"19\" ></a>&nbsp;");
			
			//contentBuilder.append("</td>");
			
			
			
		}
	
		
	}
	
	//graphics view
	
	else if(userDTO.getRoleid().equalsIgnoreCase("RM1015") )
	{
		
			contentBuilder.append("<tr>");
			contentBuilder.append("<th>");
			contentBuilder.append("JOURNAL");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th>");
			contentBuilder.append("AID/ISSUE");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th>");
			contentBuilder.append("PSE&nbsp;STAGE");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th>");
			contentBuilder.append("GRAPHICS&nbsp;STAGE");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th class=\"hidecol\">");
			contentBuilder.append("FX&nbsp;STATUS");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th class=\"hidecol\">");
			contentBuilder.append("CE&nbsp;FX&nbsp;STATUS");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th class=\"hidecol\">");
			contentBuilder.append("ME&nbsp;FX&nbsp;STATUS");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th class=\"hidecol\">");
			contentBuilder.append("JTITLE");
			contentBuilder.append("</th>");
			
			//contentBuilder.append("<th>");
			//contentBuilder.append("TIME&nbsp;REMAINING");
			//contentBuilder.append("</th>");
			
			contentBuilder.append("<th>");
			contentBuilder.append("STARTDATE");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th>");
			contentBuilder.append("ENDDATE");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th>");
			contentBuilder.append("DOWNLOAD");
			contentBuilder.append("</th>");
			
			contentBuilder.append("<th>");
			contentBuilder.append("ACTION");
			contentBuilder.append("</th>");
			
			
			
			for(LoadReviewArticle loadreviewarticle : list){
				
				String PSE_STAGEID = "";
				String GRAPHICS_STAGEID = "";
				if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1011")){
					
					PSE_STAGEID = "AUTO_STRUCTURING";
					
					
				}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1022")){
					PSE_STAGEID = "CNU_FAIL";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1021")){
					PSE_STAGEID = "CNU_PASS";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1023")){
					PSE_STAGEID = "AUTO_STRUCTURING_FAIL";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1004")){
					PSE_STAGEID = "COPY_EDITOR";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1009")){
					PSE_STAGEID = "QC";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1005")){
					PSE_STAGEID = "PROOF_COLLATION";
				}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1026")){
					PSE_STAGEID = "PAGINATION";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1006")){
					PSE_STAGEID = "AUTHOR_REVISION";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1035")){
					PSE_STAGEID = "P100_AUTOPAGE";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1036")){
					PSE_STAGEID = "P100_QC";
				}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1037")){
					PSE_STAGEID = "S100_DATASET_CREATING";
				}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1038")){
					PSE_STAGEID = "S100_DATASET_CREATED";
				}else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1039")){
					PSE_STAGEID = "P100_DATASETCREATION";
				}
				else if(loadreviewarticle.getPSE_STAGEID().equalsIgnoreCase("ST1040")){
					PSE_STAGEID = "P100_DATASETCREATED";
				}
				else{
					PSE_STAGEID = "N/A";
				}
				if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1024")){
					GRAPHICS_STAGEID = "GRAPHICS";
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1028")){
					GRAPHICS_STAGEID = "IGQC";
				}
				else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1029")){
					GRAPHICS_STAGEID = "IGQC_FAIL";
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1030")){
					GRAPHICS_STAGEID = "OGQC";
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1031")){
					GRAPHICS_STAGEID = "OGQC_FAIL";
				}
				else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1032")){
					GRAPHICS_STAGEID = "FX";
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1033")){
					GRAPHICS_STAGEID = "FX_FAIL";
				}
				else{
					GRAPHICS_STAGEID = "N/A";
				}
				
				
				
				
				contentBuilder.append("<tr>");
				
				contentBuilder.append("<td>");
				contentBuilder.append(loadreviewarticle.getJOURNALNAME());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td><a href=\"#\" onclick=\"publishFile('"+getPath+"temp/graphicsinput/"+loadreviewarticle.getITEMCODE()+".zip');manage_uploaddropbox_aftersecond();\" >");
				contentBuilder.append(loadreviewarticle.getITEMCODE());
				contentBuilder.append("</a></td>");
				
				contentBuilder.append("<td>");
				contentBuilder.append(PSE_STAGEID);
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td>");
				contentBuilder.append(GRAPHICS_STAGEID);
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td class=\"hidecol\">");
				contentBuilder.append(loadreviewarticle.getFX_STATUS());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td class=\"hidecol\">");	
				contentBuilder.append(loadreviewarticle.getPSE_CE_FX_STATUS());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td class=\"hidecol\">");
				contentBuilder.append(loadreviewarticle.getPSE_ME_FX_STATUS());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td class=\"hidecol\">");
				contentBuilder.append(loadreviewarticle.getTITLE());
				contentBuilder.append("</td>");
				
				//contentBuilder.append("<td>");
				//contentBuilder.append(new Date().getHours()+"::"+ new Date().getMinutes()+"::"+ new Date().getSeconds());
				//contentBuilder.append("</td>");
				
				contentBuilder.append("<td>");
				contentBuilder.append(loadreviewarticle.getSTARTDATE());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td>");
				contentBuilder.append(loadreviewarticle.getENDDATE());
				contentBuilder.append("</td>");
				
				contentBuilder.append("<td>");
				contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewarticle.getITEMCODE()+"/"+loadreviewarticle.getITEMCODE()+"_markedpdf.pdf')\" href=\"#\" ><img title=\"Download marked PDF\" src='"+request.getContextPath()+"/authoringtool/gui/images/pdf_icon.png' width=\"18\" height=\"19\" ></a>&nbsp;");
				
				
				if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1029")){
					
					contentBuilder.append("<a href=\"#\" onclick=\"publishFile('"+getPath+"temp/graphicsinput/"+loadreviewarticle.getITEMCODE()+"_igqc.zip');\" ><img title=\"Download IGQC packet\" src='"+request.getContextPath()+"/authoringtool/gui/images/zip_icon.png' width=\"18\" height=\"19\"></a>");
					
				}else if(loadreviewarticle.getGRAPHICS_STAGEID().equalsIgnoreCase("ST1031")){
					
					contentBuilder.append("<a href=\"#\" onclick=\"publishFile('"+getPath+"temp/graphicsinput/"+loadreviewarticle.getITEMCODE()+"_ogqc.zip');\" ><img title=\"Download OGQC packet\" src='"+request.getContextPath()+"/authoringtool/gui/images/zip_icon.png' width=\"18\" height=\"19\"></a>");
					
				}
				
				
				
				contentBuilder.append("</td>");
				
				
				contentBuilder.append("<td>");
				contentBuilder.append("<input name=\"\" type=\"button\" class=\"submit\" onclick=\"validategraphics();\" value=\"Submit\">");
				contentBuilder.append("</td>");
				
			
				
				
				
			}
		
		
	}
	
	
	
	
}
// for elsevier book series
else if(userDTO.getUserCustomer().equalsIgnoreCase("elsevierbookseries"))
{
	List<BookBean> bean = (List)delegate.delegate("GenericAdvisor", "getReviewBooks", userDTO );
	
	String tempBookID = "";
// 	String[] listOfArticles={"ABPEL","ABPG","ASME","BMC","FLOW","SEG","COL"};
	
	List<String> listOfArticles =  new ArrayList<String>(Arrays.asList(new String[]{"ABPEL","ABPG","ASME","BMC","FLOW","SEG","COL"}));
	List<String> listOfIssues =  new ArrayList<String>(Arrays.asList(new String[]{"AIP","APA","BMG","BPG","ELS","MIF","OUP","SPR","SEGI"}));
	
	
	
	
	
	int count =0;
	
	//for pse view
	if(userDTO.getRoleid().equalsIgnoreCase("RM1010"))
	{
		
		contentBuilder.append("<tr>");
		contentBuilder.append("<th id=\"businesstype_msg\">");
		contentBuilder.append("BOOK");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"category_msg\">");
		contentBuilder.append("BOOK&nbsp;ID");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"chaptertitle_msg\">");
		contentBuilder.append("Issue");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"startdate_msg\">");
		contentBuilder.append("Order&nbsp;Date");
		contentBuilder.append("</th>");
		
		/* contentBuilder.append("<th id=\"enddate_msg\">");
		contentBuilder.append("End&nbsp;Date");
		contentBuilder.append("</th>");
		contentBuilder.append("<th id=\"psestage_msg\">");
		contentBuilder.append("Stage");
		contentBuilder.append("</th>"); */
		
		contentBuilder.append("<th id=\"logs_msg\">");
		contentBuilder.append("Logs");
		contentBuilder.append("</th>");
		
		for(BookBean bookbean: bean){
			
			
			String articleORIssue = "";
			
			if(listOfArticles.contains(bookbean.getPflow())){
				articleORIssue = "ARTICLE";
			}else if(listOfIssues.contains(bookbean.getPflow())){
				articleORIssue = "JOURNAL-ISSUE";
			}
			
			String BookId = bookbean.getBOOKID();
			String pathForDat = tdxps_BDOPS_server_path+""+bookbean.getFlow()+"\\CAR\\"+bookbean.getPflow()+"\\"+bookbean.getMonthYear()+"\\Batch_"+bookbean.getBatch()+"\\"+bookbean.getBOOKID()+"\\"+bookbean.getBOOKNAME()+"\\"+articleORIssue+"_"+bookbean.getClOrderId()+"_"+bookbean.getBOOKNAME()+".dat";
			System.out.println("*****path for DAT file and Folder *******************" + pathForDat);
			
			count++;
			
			if(tempBookID.trim().length()==0){
				contentBuilder.append("<tr>");

				contentBuilder.append("<td>");
				contentBuilder.append(bookbean.getBOOKNAME());
				contentBuilder.append("</td>");
				contentBuilder.append("<td colspan=\"7\">");
				
				
				
// 				contentBuilder.append("<ul id=\"navigation\" class=\"navigation\"><li><a href=\"javascript:void(0);\" onclick=\"javascript:setItemcodeOnBookClick('"+BookId+"');$('#displaytdpms').show();$('#submitfinalforindexingforbooks').show();$('#submitfinalforauthorforbooks').show();\" >"+bookbean.getFlow()+"_"+bookbean.getBOOKID()+"</a><ul>");
				
				//Book Id row creation
				System.out.println("BookID "+BookId);
			}
			
			/* if(tempBookID.trim().length()!=0 && !BookId.equalsIgnoreCase(tempBookID)){
			
				contentBuilder.append("</ul></li></ul></td></tr>");
				contentBuilder.append("<tr>");

				contentBuilder.append("<td>");
				contentBuilder.append(bookbean.getBOOKNAME());
				contentBuilder.append("</td>");
				contentBuilder.append("<td colspan=\"7\">");
				contentBuilder.append("<ul id=\"navigation\" class=\"navigation\"><li><a href=\"javascript:void(0)\" onclick=\"javascript:setItemcodeOnBookClick('"+BookId+"');$('#displaytdpms').show();$('#submitfinalforindexingforbooks').show();$('#submitfinalforauthorforbooks').show();\">"+bookbean.getFlow()+"_"+bookbean.getBOOKID()+"</a><ul>");
				System.out.println("BookID "+BookId);
			} */
			
			contentBuilder.append("<li><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" class=\"showArticle\">");
			contentBuilder.append("<tr>");
			contentBuilder.append("<td width=\"15%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\" onclick=\"loadBook('"+getPath+"temp/"+bookbean.getBOOKID()+"/"+bookbean.getBOOKNAME()+"/"+articleORIssue+"_"+bookbean.getClOrderId()+"_"+bookbean.getBOOKNAME()+".dat','"+bookbean.getBatch()+"','"+bookbean.getBOOKID()+"','"+bookbean.getFlow()+"','"+bookbean.getBOOKNAME()+"','"+bookbean.getMonthYear()+"','"+bookbean.getClOrderId()+"','"+bookbean.getPflow()+"','"+articleORIssue+"');\">"+bookbean.getFlow()+"_"+bookbean.getBOOKID()+"_"+bookbean.getPflow()+"_"+ bookbean.getBatch()+"_"+bookbean.getBOOKNAME()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"23%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getCHAPTERTITLE()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"17%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getLAUNCHDATE()+"</a>");
			contentBuilder.append("</td>");
			
			/* contentBuilder.append("<td width=\"20%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getDUEDATE()+"</a>");
			contentBuilder.append("</td>");
			
			
			contentBuilder.append("<td width=\"13%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getSTAGENAME()+"</a>");
			contentBuilder.append("</td>"); */
			
			contentBuilder.append("<td width=\"15%\">");
			
			contentBuilder.append("<a onclick=\"javascript:loadlogsinslider('"+getPath+"temp/"+bookbean.getBOOKID()+"/"+bookbean.getBOOKNAME()+"/"+"main.html')\" href=\"#\" ><img title=\"MSS Log File\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			
			
			/* if(bookbean.getSTAGENAME().equalsIgnoreCase("AUTO_STRUCTURING")){
				contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/tx1.zip')\" href=\"#\" ><img title=\"Download S5 XML\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\"></a>&nbsp;");
				
				contentBuilder.append("<a onclick=\"javascript:launchbookvtoolwindow('"+BookId+"','"+bookbean.getCHAPTERID()+"');\" href=\"#\" ><img title=\"S5(tx1 QA Log)\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
				
			}else{ */
				contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/tx1.zip')\" href=\"#\" ><img title=\"Download CE XML\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\"></a>&nbsp;");
				
				contentBuilder.append("<a onclick=\"javascript:launchbookvtoolwindow('"+BookId+"','"+getPath+"temp/"+bookbean.getBOOKID()+"/"+bookbean.getBOOKNAME()+"/"+articleORIssue+"_"+bookbean.getClOrderId()+"_"+bookbean.getBOOKNAME()+"_Errorlog.html');\" href=\"#\" ><img title=\"CE(tx1 QA Log)\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
				
			/* } */
			
// 			contentBuilder.append("<a class=\"blinks\" onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/"+BookId+"_"+bookbean.getCHAPTERID()+"_epub2.epub');\" href=\"#\" ><img title=\"Download epub2\" src='"+request.getContextPath()+"/authoringtool/images/epub.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
// 			contentBuilder.append("<a class=\"blinks\" onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/"+BookId+"_"+bookbean.getCHAPTERID()+"_epub3.epub');\" href=\"#\" ><img title=\"Download epub3\" src='"+request.getContextPath()+"/authoringtool/images/epub.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			
			contentBuilder.append("");
			contentBuilder.append("</td>");
			
			contentBuilder.append("</tr>");
			contentBuilder.append("</table>");
			contentBuilder.append("</li>");
			
			if(count==bean.size()){
				contentBuilder.append("</ul></li></ul></td></tr>");
			}
			
			tempBookID = BookId;
		}
	}
	
	//for author view
	if(userDTO.getRoleid().equalsIgnoreCase("RM1007"))
	{
		
		contentBuilder.append("<tr>");
		contentBuilder.append("<th>");
		contentBuilder.append("BOOK");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th>");
		contentBuilder.append("BOOK&nbsp;ID");
		contentBuilder.append("</th>");
		
		for(BookBean bookbean: bean){
			
			String BookId = bookbean.getBOOKID();
			
			count++;
			
			if(tempBookID.trim().length()==0){
				contentBuilder.append("<tr>");

				contentBuilder.append("<td>");
				contentBuilder.append(bookbean.getBOOKNAME());
				contentBuilder.append("</td>");
				contentBuilder.append("<td colspan=\"7\">");
				contentBuilder.append("<ul id=\"navigation\" class=\"navigation\"><li><a href=\"javascript:void(0);\" onclick=\"javascript:javascript:void(0);\" >"+bookbean.getBOOKID()+"</a><ul>");
				
				//Book Id row creation
				System.out.println("BookID "+BookId);
			}
			
			if(tempBookID.trim().length()!=0 && !BookId.equalsIgnoreCase(tempBookID)){
			
				contentBuilder.append("</ul></li></ul></td></tr>");
				contentBuilder.append("<tr>");

				contentBuilder.append("<td>");
				contentBuilder.append(bookbean.getBOOKNAME());
				contentBuilder.append("</td>");
				contentBuilder.append("<td colspan=\"7\">");
				contentBuilder.append("<ul id=\"navigation\" class=\"navigation\"><li><a href=\"javascript:void(0)\">"+bookbean.getBOOKID()+"</a><ul>");
				System.out.println("BookID "+BookId);
			}
			
			contentBuilder.append("<li><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" class=\"showArticle\">");
			contentBuilder.append("<tr>");
			contentBuilder.append("<td width=\"20%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\" onclick=\"loadBook('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/"+BookId+"_"+bookbean.getCHAPTERID()+".htm','"+bookbean.getSTAGENAME()+"','"+BookId+"','"+bookbean.getCHAPTERID()+"','"+bookbean.getCHAPTERTITLE()+"','"+bookbean.getSTAGEID()+"');\">"+bookbean.getCHAPTERID()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"40%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getCHAPTERTITLE()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"20%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getSTAGENAME()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"10%\">");
			contentBuilder.append("");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"10%\">");
			
			//contentBuilder.append("<a onclick=\"javascript:loadlogsinslider('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/msslog.html')\" href=\"#\" ><img title=\"MSS Log File\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			//contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/tx1.zip')\" href=\"#\" ><img title=\"Download CE XML\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\"></a>&nbsp;");
			
			//contentBuilder.append("<a onclick=\"javascript:launchbookvtoolwindow('"+BookId+"','"+bookbean.getCHAPTERID()+"');\" href=\"#\" ><img title=\"CE(tx1 VTool Log)\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			
			contentBuilder.append("");
			contentBuilder.append("</td>");
			
			contentBuilder.append("</tr>");
			contentBuilder.append("</table>");
			contentBuilder.append("</li>");
			
			if(count==bean.size()){
				contentBuilder.append("</ul></li></ul></td></tr>");
			}
			
			tempBookID = BookId;
		}
	}
	
	
	
}


//For BDOPS
else if(userDTO.getUserCustomer().equalsIgnoreCase("BDOPS"))
{
	List<BookBean> bean = (List)delegate.delegate("GenericAdvisor", "getReviewBooks", userDTO );
	
	String tempBookID = "";
	int count =0;
	
	//for pse view
	if(userDTO.getRoleid().equalsIgnoreCase("RM1010"))
	{
		
		contentBuilder.append("<tr>");
		contentBuilder.append("<th id=\"businesstype_msg\">");
		contentBuilder.append("BOOK");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"category_msg\">");
		contentBuilder.append("BOOK&nbsp;ID");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"chaptertitle_msg\">");
		contentBuilder.append("Ìssue");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th id=\"startdate_msg\">");
		contentBuilder.append("C Date");
		contentBuilder.append("</th>");
		
/* 		contentBuilder.append("<th id=\"enddate_msg\">");
		contentBuilder.append("End&nbsp;Date");
		contentBuilder.append("</th>");
		contentBuilder.append("<th id=\"psestage_msg\">");
		contentBuilder.append("Stage");
		contentBuilder.append("</th>"); */
		
		contentBuilder.append("<th id=\"logs_msg\">");
		contentBuilder.append("Logs");
		contentBuilder.append("</th>");
		
		for(BookBean bookbean: bean){
			
			String BookId = bookbean.getBOOKID();
			
			count++;
			
			if(tempBookID.trim().length()==0){
				contentBuilder.append("<tr>");

				contentBuilder.append("<td>");
				contentBuilder.append(bookbean.getBOOKNAME());
				contentBuilder.append("</td>");
				contentBuilder.append("<td colspan=\"7\">");
				contentBuilder.append("<ul id=\"navigation\" class=\"navigation\"><li><a href=\"javascript:void(0);\" onclick=\"javascript:setItemcodeOnBookClick('"+BookId+"');$('#displaytdpms').show();$('#submitfinalforindexingforbooks').show();$('#submitfinalforauthorforbooks').show();\" >"+bookbean.getBOOKID()+"</a><ul>");
				
				//Book Id row creation
				System.out.println("BookID "+BookId);
			}
			
			if(tempBookID.trim().length()!=0 && !BookId.equalsIgnoreCase(tempBookID)){
			
				contentBuilder.append("</ul></li></ul></td></tr>");
				contentBuilder.append("<tr>");

				contentBuilder.append("<td>");
				contentBuilder.append(bookbean.getBOOKNAME());
				contentBuilder.append("</td>");
				contentBuilder.append("<td colspan=\"7\">");
				contentBuilder.append("<ul id=\"navigation\" class=\"navigation\"><li><a href=\"javascript:void(0)\" onclick=\"javascript:setItemcodeOnBookClick('"+BookId+"');$('#displaytdpms').show();$('#submitfinalforindexingforbooks').show();$('#submitfinalforauthorforbooks').show();\">"+bookbean.getBOOKID()+"</a><ul>");
				System.out.println("BookID "+BookId);
			}
			
			contentBuilder.append("<li><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" class=\"showArticle\">");
			contentBuilder.append("<tr>");
			contentBuilder.append("<td width=\"15%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\" onclick=\"loadBook('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/"+BookId+"_"+bookbean.getCHAPTERID()+".dat','"+bookbean.getSTAGENAME()+"','"+BookId+"','"+bookbean.getCHAPTERID()+"','"+bookbean.getCHAPTERTITLE()+"','"+bookbean.getSTAGEID()+"');\">"+bookbean.getCHAPTERID()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"23%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getCHAPTERTITLE()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"17%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getINPUTDATE()+"</a>");
			contentBuilder.append("</td>");
			
			/* contentBuilder.append("<td width=\"20%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getDUEDATE()+"</a>");
			contentBuilder.append("</td>"); */
			
			
			contentBuilder.append("<td width=\"13%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getSTAGENAME()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"15%\">");
			
			contentBuilder.append("<a onclick=\"javascript:loadlogsinslider('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/msslog.html')\" href=\"#\" ><img title=\"MSS Log File\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			
			
			if(bookbean.getSTAGENAME().equalsIgnoreCase("AUTO_STRUCTURING")){
				contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/tx1.zip')\" href=\"#\" ><img title=\"Download S5 XML\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\"></a>&nbsp;");
				
				contentBuilder.append("<a onclick=\"javascript:launchbookvtoolwindow('"+BookId+"','"+bookbean.getCHAPTERID()+"');\" href=\"#\" ><img title=\"S5(tx1 QA Log)\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
				
			}else{
				contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/tx1.zip')\" href=\"#\" ><img title=\"Download CE XML\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\"></a>&nbsp;");
				
				contentBuilder.append("<a onclick=\"javascript:launchbookvtoolwindow('"+BookId+"','"+bookbean.getCHAPTERID()+"');\" href=\"#\" ><img title=\"CE(tx1 QA Log)\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
				
			}
			
			contentBuilder.append("<a class=\"blinks\" onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/"+BookId+"_"+bookbean.getCHAPTERID()+"_epub2.epub');\" href=\"#\" ><img title=\"Download epub2\" src='"+request.getContextPath()+"/authoringtool/images/epub.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			contentBuilder.append("<a class=\"blinks\" onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/"+BookId+"_"+bookbean.getCHAPTERID()+"_epub3.epub');\" href=\"#\" ><img title=\"Download epub3\" src='"+request.getContextPath()+"/authoringtool/images/epub.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			
			contentBuilder.append("");
			contentBuilder.append("</td>");
			
			contentBuilder.append("</tr>");
			contentBuilder.append("</table>");
			contentBuilder.append("</li>");
			
			if(count==bean.size()){
				contentBuilder.append("</ul></li></ul></td></tr>");
			}
			
			tempBookID = BookId;
		}
	}
	
	//for author view
	if(userDTO.getRoleid().equalsIgnoreCase("RM1007"))
	{
		
		contentBuilder.append("<tr>");
		contentBuilder.append("<th>");
		contentBuilder.append("BOOK");
		contentBuilder.append("</th>");
		
		contentBuilder.append("<th>");
		contentBuilder.append("BOOK&nbsp;ID");
		contentBuilder.append("</th>");
		
		for(BookBean bookbean: bean){
			
			String BookId = bookbean.getBOOKID();
			
			count++;
			
			if(tempBookID.trim().length()==0){
				contentBuilder.append("<tr>");

				contentBuilder.append("<td>");
				contentBuilder.append(bookbean.getBOOKNAME());
				contentBuilder.append("</td>");
				contentBuilder.append("<td colspan=\"7\">");
				contentBuilder.append("<ul id=\"navigation\" class=\"navigation\"><li><a href=\"javascript:void(0);\" onclick=\"javascript:javascript:void(0);\" >"+bookbean.getBOOKID()+"</a><ul>");
				
				//Book Id row creation
				System.out.println("BookID "+BookId);
			}
			
			if(tempBookID.trim().length()!=0 && !BookId.equalsIgnoreCase(tempBookID)){
			
				contentBuilder.append("</ul></li></ul></td></tr>");
				contentBuilder.append("<tr>");

				contentBuilder.append("<td>");
				contentBuilder.append(bookbean.getBOOKNAME());
				contentBuilder.append("</td>");
				contentBuilder.append("<td colspan=\"7\">");
				contentBuilder.append("<ul id=\"navigation\" class=\"navigation\"><li><a href=\"javascript:void(0)\">"+bookbean.getBOOKID()+"</a><ul>");
				System.out.println("BookID "+BookId);
			}
			
			contentBuilder.append("<li><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"100%\" class=\"showArticle\">");
			contentBuilder.append("<tr>");
			contentBuilder.append("<td width=\"20%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\" onclick=\"loadBook('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/"+BookId+"_"+bookbean.getCHAPTERID()+".htm','"+bookbean.getSTAGENAME()+"','"+BookId+"','"+bookbean.getCHAPTERID()+"','"+bookbean.getCHAPTERTITLE()+"','"+bookbean.getSTAGEID()+"');\">"+bookbean.getCHAPTERID()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"40%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getCHAPTERTITLE()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"20%\">");
			contentBuilder.append("<a href=\"javascript:void(0)\">"+bookbean.getSTAGENAME()+"</a>");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"10%\">");
			contentBuilder.append("");
			contentBuilder.append("</td>");
			
			contentBuilder.append("<td width=\"10%\">");
			
			//contentBuilder.append("<a onclick=\"javascript:loadlogsinslider('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/msslog.html')\" href=\"#\" ><img title=\"MSS Log File\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			//contentBuilder.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+BookId+"/"+BookId+"_"+bookbean.getCHAPTERID()+"/tx1.zip')\" href=\"#\" ><img title=\"Download CE XML\" src='"+request.getContextPath()+"/authoringtool/gui/images/xml_icon.png' width=\"18\" height=\"19\"></a>&nbsp;");
			
			//contentBuilder.append("<a onclick=\"javascript:launchbookvtoolwindow('"+BookId+"','"+bookbean.getCHAPTERID()+"');\" href=\"#\" ><img title=\"CE(tx1 VTool Log)\" src='"+request.getContextPath()+"/authoringtool/gui/images/log.png' width=\"20\" height=\"20\" ></a>&nbsp;");
			
			
			contentBuilder.append("");
			contentBuilder.append("</td>");
			
			contentBuilder.append("</tr>");
			contentBuilder.append("</table>");
			contentBuilder.append("</li>");
			
			if(count==bean.size()){
				contentBuilder.append("</ul></li></ul></td></tr>");
			}
			
			tempBookID = BookId;
		}
	}
	
	
	
}

contentBuilder.append("</table>");





	out.print(contentBuilder.toString());
	
%>