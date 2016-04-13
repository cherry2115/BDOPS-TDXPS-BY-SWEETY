
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="td.xbp.dao.model.LoadReviewBookArticle"%><%@ page import="td.xbp.delegate.Delegate" %>
<%@ page import="td.xbp.delegate.DelegateImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="td.xbp.model.UserDTO" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="td.xbp.dao.model.LoadReviewArticle" %>

<% 
String getProtocol=request.getScheme();
String getDomain=request.getServerName();
String getPort=Integer.toString(request.getServerPort());
String getPath = getProtocol+"://"+getDomain+":"+getPort+"/";


Map httpsession = ActionContext.getContext().getSession();
UserDTO userDTO =  (UserDTO)httpsession.get("userDTO");
Delegate delegate = new DelegateImpl();   
List<LoadReviewBookArticle> list = (List)delegate.delegate("GenericAdvisor", "getReviewBookArticles", userDTO );
String	type=null;
String typeid = null;

StringBuilder contentBuilder = new StringBuilder();

contentBuilder.append("<table id=\"rounded-corner\" >")
.append("<thead>")
.append("<tr>")
.append("<th scope=\"col\" class=\"hidecol\">")
.append("Bid")
.append("</th>")
.append("<th scope=\"col\">")
.append("Book")
.append("</th>")
.append("<th scope=\"col\">");
contentBuilder.append("Ch_Id")
.append("</th>")
.append("<th scope=\"col\">")
.append("Title")
.append("</th>")
.append("<th scope=\"col\">")
.append("Stage")
.append("</th>")
.append("<th scope=\"col\">")
.append("Input Date")
.append("</th>")
.append("<th scope=\"col\">")
.append("Due Date")
.append("</th>")
.append("<th scope=\"col\">")
.append("Launch Date")
.append("</th>")
.append("<th scope=\"col\" class=\"hidecol\">")
.append("StageID")
.append("</th>");


	contentBuilder.append("<th scope=\"col\">")
	.append("Outputs")
	.append("</th>")
	.append("<th scope=\"col\" id=\"s100log\">")
	.append("QCTool")
	.append("</th>");

contentBuilder.append("</tr>")
.append("</thead>")
.append("<tbody>");


for(LoadReviewBookArticle loadreviewbook : list){
	DateFormat df=new SimpleDateFormat("dd-MMM-yyyy");
	String inputdate=df.format(loadreviewbook.getInputDate());
	String launchdate=df.format(loadreviewbook.getLAUNCHDATE());
	String duedate=df.format(loadreviewbook.getDUEDATE());
	
	contentBuilder.append("<tr>")
	.append("<td class=\"hidecol\">")
	.append(loadreviewbook.getBookID())
	.append("</td>")
	.append("<td>")
	.append(loadreviewbook.getBookName())
	.append("</td>")
	.append("<td>")
	.append(loadreviewbook.getChapterID())
	.append("</td>")
	.append("<td><a href=\"#\" onclick=\"loadArticle('"+getPath+"temp/files/"+loadreviewbook.getChapterTitle()+"/"+loadreviewbook.getChapterTitle()+".htm')\" >")
	.append(loadreviewbook.getChapterTitle())
	.append("</a></td>")
	.append("<td>")
	.append(loadreviewbook.getSTAGENAME())
	.append("</td>")
	.append("<td>")
	.append(inputdate)
	.append("</td>")
	.append("<td>")
	.append(duedate)
	.append("</td>")
	.append("<td>")
	.append(launchdate)
	.append("</td>")
	.append("<td class=\"hidecol\">")
	.append(loadreviewbook.getStageID())
	.append("</td>");	
	contentBuilder.append("<td>")
	.append("<a onclick=\"javascript:publishFile('"+getPath+"temp/files/"+loadreviewbook.getChapterTitle()+"/tx1.zip')\" href=\"#\" ><img title=\"Publish XML\" src='"+request.getContextPath()+"/authoringtool/images/xmlicon.jpg' ></a></td>")
	.append("<td><a onclick=\"javascript:loadlogsinslider('"+getPath+"temp/files/"+loadreviewbook.getChapterTitle()+"/qclog.htm')\" href=\"#\" ><img title=\"QC Log File\" src='"+request.getContextPath()+"/authoringtool/images/file_extension_log.png' style=\"border: 0; width: 20px;height: 20px;\" ></a></td>");
}

contentBuilder.append("</tbody>")
.append("</table>");

	out.print(contentBuilder.toString());
	
%>