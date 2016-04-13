
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.io.File"%>
<%
String filename=request.getParameter("filename");


String indexing_marker_path = ResourceBundle.getBundle("pathbundle").getString("indexing_marker_path");
	
File markerfile=new File(indexing_marker_path+File.separator+filename+".ini");
markerfile.createNewFile();
out.print("success");
%>