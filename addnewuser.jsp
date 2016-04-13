
<%@page import="td.xbp.mail.Email"%>
<%@ page import="td.xbp.delegate.Delegate" %>
<%@ page import="td.xbp.delegate.DelegateImpl" %>
<%@ page import="java.util.Map" %>
<%@ page import="td.xbp.model.UserDTO" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>

<% 

String add_username=request.getParameter("add_username");
String add_password=request.getParameter("add_password");
String add_rolename=request.getParameter("edit_rolename");
String add_address1=request.getParameter("add_address1");
String add_address2=request.getParameter("add_address2");
String add_address3=request.getParameter("add_address3");
String add_address4=request.getParameter("add_address4");
String add_city=request.getParameter("add_city");
String add_state=request.getParameter("add_state");
String add_postalcode=request.getParameter("add_postalcode");
String add_country=request.getParameter("add_country");
String add_workphone=request.getParameter("add_workphone");
String add_extn=request.getParameter("add_extn");
String add_mobile=request.getParameter("add_mobile");
String add_homephone=request.getParameter("add_homephone");
String add_faxnumber=request.getParameter("add_faxnumber");
String add_email=request.getParameter("add_email");
String add_tollfreenumber=request.getParameter("add_tollfreenumber");



Map httpsession = ActionContext.getContext().getSession();
UserDTO userDTO =  (UserDTO)httpsession.get("userDTO");
// String emailquery="<html> <body> <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"676\"><tbody><tr><td align=\"left\" valign=\"top\"><img src=\"http://172.16.0.53:8080/TDXPSv1.1/authoringtool/images/Logo-4.jpg\" style=\"display: block;\" alt=\"\" height=\"150\" width=\"676\" /></td></tr></tbody></table><br /><table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"586\"><tbody><tr><td align=\"left\" valign=\"baseline\"><font style=\"font-family: Arial,Helvetica,sans-serif; font-size: 12px; color: #2b2b2b;\">Dear "+add_username+"</font><br /><img src=\"http://172.16.0.53:8080/TDXPSv1.1/authoringtool/images/divider.gif\" style=\"display: block;\" alt=\"\" height=\"19\" width=\"586\" /><br /></td></tr><tr><td>You have been added as a new user for the role of "+userDTO.getRole()+".<br />Your credentials are :<br />Username :"+add_username+"<br />Password :"+add_password+"</td></tr>                            </tbody></table>         <br />         <table border=\"0\" cellspacing=\"0\" width=\"100%\">             <tbody>                 <tr>                     <td align=\"center\" valign=\"middle\">                     <table align=\"center\" border=\"0\" cellpadding=\"20\" cellspacing=\"0\" width=\"586\">                         <tbody>                             <tr>                                 <td align=\"center\" bgcolor=\"#2b2b2b\" valign=\"top\"><font style=\"font-family: Arial,Helvetica,sans-serif; font-size: 12px; color: #ffffff;\"><a href=\"#\" style=\"color: #ffffff;\">wwww.tdxps.com</a> | Tel: 1-800-000-000 | Fax: 1-800-000-0000-000</font></td>                             </tr>                                                      </tbody>                     </table>                     </td>                 </tr>             </tbody>         </table>     </body></html>";
Email email=new Email();
String emailquery=email.getMailContentForNewUser(add_username,userDTO.getRole().toString(),add_password);

String emailfrom=userDTO.getName();
String cust_id = userDTO.getCustomerid();
	
	Delegate delegate = new DelegateImpl();   
	String result = (String)delegate.delegate("GenericAdvisor", "addNewUser", cust_id, add_username, add_password,add_rolename, add_address1, add_address2, add_address3, add_address4, add_city, add_state, add_postalcode, add_country,add_workphone,add_extn,add_mobile,add_homephone,add_faxnumber,add_email,add_tollfreenumber);

	if(result.equalsIgnoreCase("success")){
		out.print("success");
		
		String mailstatus = (String)delegate.delegate("MailAdvisor", "sendMail",add_email,"Welcome To TDXPS Family",emailquery,emailfrom);
	}
	else
		out.print("some error ");
%>