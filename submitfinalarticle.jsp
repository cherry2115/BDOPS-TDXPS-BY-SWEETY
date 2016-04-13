
<%@page import="td.xbp.jms.JMSProducer"%>
<%@page import="td.xbp.util.IdGenerator"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.Set"%><%@ page import="java.io.File" %>
<%@ page import="org.apache.commons.io.*" %>
<%@ page import="td.xbp.delegate.Delegate" %>
<%@ page import="td.xbp.delegate.DelegateImpl" %>
<%@ page import="java.util.Map" %>
<%@ page import="td.xbp.model.UserDTO" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%

Map httpsession = ActionContext.getContext().getSession();
UserDTO userDTO =  (UserDTO)httpsession.get("userDTO");
Delegate delegate = new DelegateImpl();   
String editorcontent=request.getParameter("editorcontent");
String filename=request.getParameter("filename");
String stagename=request.getParameter("stagename");
String tdxps_server_root_path = ResourceBundle.getBundle("pathbundle").getString("tdxps_server_root_path");

String apache_activemq_url = ResourceBundle.getBundle("pathbundle").getString("apache_activemq_url");
String tdxps_CEQ = ResourceBundle.getBundle("pathbundle").getString("tdxps_CEQ");


IdGenerator idGenerator = new IdGenerator();

editorcontent = idGenerator.removeParaId(editorcontent);

editorcontent = idGenerator.applyParaId(editorcontent);

editorcontent = idGenerator.applyMathId(editorcontent);
try{
	JMSProducer producer=new JMSProducer();
	if(stagename.equalsIgnoreCase("AUTO_STRUCTURING")|| stagename.equalsIgnoreCase("AUTO_STRUCTURING_FAIL")){
	
		
	// delete log files & write content of editor to server MNT folder
	
	File updateServerFile = new File(tdxps_server_root_path+"\\"+filename+"\\"+filename+".txt");
	
	FileUtils.writeStringToFile(updateServerFile, editorcontent);
	//update htm file for loading in editor
	File updateHTMServerFile = new File(tdxps_server_root_path+"\\"+filename+"\\"+filename+".htm");

	FileUtils.writeStringToFile(updateHTMServerFile, editorcontent);
	
	producer.sendMessage(apache_activemq_url, tdxps_CEQ, "PCE", filename);
	
	out.print(editorcontent);
	}
	else if(stagename.equalsIgnoreCase("COPY_EDITOR")){
		
		// write content of editor to server MNT folder
		File updateServerFile = new File(tdxps_server_root_path+"\\"+filename+"\\"+filename+".txt");
		FileUtils.writeStringToFile(updateServerFile, editorcontent);
		
		//update htm file for loading in editor
		File updateHTMServerFile = new File(tdxps_server_root_path+"\\"+filename+"\\"+filename+".htm");
		
		FileUtils.writeStringToFile(updateHTMServerFile, editorcontent);
		
		producer.sendMessage(apache_activemq_url, tdxps_CEQ, "CE", filename); 
	
		out.print(editorcontent);
		
		
	}
}
catch(Exception e){
	e.printStackTrace();
	
	out.print("fail");
	
}
	
%>