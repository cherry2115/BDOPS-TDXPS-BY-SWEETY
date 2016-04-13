<%@ page import="td.xbp.delegate.Delegate" %>
<%@ page import="td.xbp.delegate.DelegateImpl" %>

<% 
Delegate delegate = new DelegateImpl();  
String bookN=request.getParameter("bookN");
String clOrdId=request.getParameter("clOrdId");
String ordId=request.getParameter("ordId");
String updatedOrNot = "no";

String result = (String)delegate.delegate("GenericAdvisor", "validateConverions", bookN ,clOrdId,ordId);


if(result.equalsIgnoreCase("yes")){
	
	String result1 = (String)delegate.delegate("GenericAdvisor", "validateFinalSubmit", bookN ,clOrdId,ordId);
	updatedOrNot = result1; 
	if(result1.equalsIgnoreCase("yes")){
		String result2 = (String)delegate.delegate("GenericAdvisor", "updateTrackingStatus", bookN ,clOrdId,ordId);
		updatedOrNot = result2; 
	}else{
		updatedOrNot ="no"; 
	}
	out.print(updatedOrNot);
	
}else{
	out.print("no");
}https://marketplace.eclipse.org/content/jvm-monitor


%>
