
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.ResourceBundle"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Set"%>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.io.*" %>
<%@ page import="td.xbp.delegate.Delegate" %>
<%@ page import="td.xbp.delegate.DelegateImpl" %>
<%@ page import="java.util.Map" %>

<%

Delegate delegate = new DelegateImpl();   

String filename=request.getParameter("filename");
String stagename=request.getParameter("stagename");
String editorcontent=request.getParameter("editorcontent");
String tdxps_server_root_path = ResourceBundle.getBundle("pathbundle").getString("tdxps_server_root_path");
String FMS_s5_dataset_in_path = ResourceBundle.getBundle("pathbundle").getString("FMS_s5_dataset_in_path");
String FMS_s5_dataset_out_path = ResourceBundle.getBundle("pathbundle").getString("FMS_s5_dataset_out_path");
String FMS_s5_dataset_marker_path = ResourceBundle.getBundle("pathbundle").getString("FMS_s5_dataset_marker_path");
String FMS_s5_dataset_in_marker_path = ResourceBundle.getBundle("pathbundle").getString("FMS_s5_dataset_in_marker_path");


Pattern UncitedRefPat = Pattern.compile("<(span) id=\"QRY1\" class=\"QRY1\">&lt;!--&lt;query&gt;(.*?)&lt;/query&gt;--&gt;</\\1>");

Matcher UncitedRefmat = UncitedRefPat.matcher(editorcontent);

String gr2 = "";
if(UncitedRefmat.find()){

	gr2 = UncitedRefmat.group(2);
	
}
System.out.println("group 2 ::: "+gr2);
String resultoutput = (String)delegate.delegate("GenericAdvisor", "insert_review_query", "U1123", filename, gr2, "QRY1" );



try{

File marker=new File(FMS_s5_dataset_marker_path+"\\"+filename+".marker");
marker.createNewFile();
System.out.println("FMS_s5_dataset_marker_path ::"+marker);

String result = (String)delegate.delegate("GenericAdvisor", "changeStageOfArticle", filename ,stagename ,"C1001");

out.print("success");
}
catch(Exception e){
	e.printStackTrace();
	out.print("fail");
	
}




%>