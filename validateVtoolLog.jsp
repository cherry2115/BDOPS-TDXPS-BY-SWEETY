
<%@ page import="td.xbp.delegate.Delegate" %>
<%@ page import="td.xbp.delegate.DelegateImpl" %>

<% 
Delegate delegate = new DelegateImpl();  
String filename=request.getParameter("filename");
String category=request.getParameter("category");

String result = (String)delegate.delegate("GenericAdvisor", "validateVtoolLog", filename ,category);
out.print(result);	

%>