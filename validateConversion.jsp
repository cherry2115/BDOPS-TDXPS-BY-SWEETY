<%@ page import="td.xbp.delegate.Delegate" %>
<%@ page import="td.xbp.delegate.DelegateImpl" %>

<% 
Delegate delegate = new DelegateImpl();  
String bookN=request.getParameter("bookN");
String clOrdId=request.getParameter("clOrdId");
String ordId=request.getParameter("ordId");

String result = (String)delegate.delegate("GenericAdvisor", "validateConverions", bookN ,clOrdId,ordId);

if(result==null || result.isEmpty()){
	out.print("null");
}else{
	out.print(result);	
}
	
%>
