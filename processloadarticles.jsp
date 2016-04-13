<%@ page import="td.xbp.delegate.Delegate" %>
<%@ page import="td.xbp.delegate.DelegateImpl" %>
<%@ page import="td.xbp.dao.model.LoadArticleInfo" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="td.xbp.model.UserDTO" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<% 
Map httpsession = ActionContext.getContext().getSession();
UserDTO userDTO =  (UserDTO)httpsession.get("userDTO");
Delegate delegate = new DelegateImpl();   
List<LoadArticleInfo> loadArticleInfoList = (List)delegate.delegate("GenericAdvisor", "load_articles", userDTO );

StringBuilder contentBuilder = new StringBuilder();
contentBuilder.append("<table id=\"one-column-emphasis\" >")
		.append("<thead>")
		.append("<tr>")
		.append("<th scope=\"col\">")
    	.append("JOURNAL")
    	.append("</th>")
		.append("<th scope=\"col\">")
		.append("AID")
		.append("</th>")
		.append("<th scope=\"col\"  class=\"hidecol\">")
		.append("STAGEID")
		.append("</th>")
		.append("<th scope=\"col\">")
		.append("STAGE")
		.append("</th>")
    	
    	.append("<th scope=\"col\" class=\"hidecol\">")
    	.append("RAWMATERIALCUST")
    	.append("</th>")
    	.append("<th scope=\"col\"  class=\"hidecol\">")
    	.append("PRIORITY")
    	.append("</th>")
    	.append("<th scope=\"col\"  class=\"hidecol\">")
    	.append("JOURNALID")
    	.append("</th>")
    	.append("<th scope=\"col\">")
    	.append("TITLE")
    	.append("</th>")
    	.append("<th scope=\"col\">")
    	.append("START DATE")
    	.append("</th>")
  		.append("<th scope=\"col\">")
    	.append("END DATE")
    	.append("</th>")
  		
    	.append("</tr>")
		.append("</thead>")
		.append("<tbody>");
	for(LoadArticleInfo loadArticleInfo : loadArticleInfoList){
		
		contentBuilder.append("<tr>")
		.append("<td>")
		.append(loadArticleInfo.getJournalname())
		.append("</td>")
		.append("<td>")
		.append(loadArticleInfo.getITEMCODE())
		.append("</td>")
		.append("<td  class=\"hidecol\">")
		.append(loadArticleInfo.getSTAGEID())
		.append("</td>")
		.append("<td >")
		.append(loadArticleInfo.getStagename())
		.append("</td>")
		
		.append("<td class=\"hidecol\">")
		.append(loadArticleInfo.getRAWMATERIALCUST())
		.append("</td>")
		.append("<td  class=\"hidecol\">")
		.append(loadArticleInfo.getPRIORITY())
		.append("</td>")
		.append("<td  class=\"hidecol\">")
		.append(loadArticleInfo.getJOURNALID())
		.append("</td>")
		.append("<td>")
		.append(loadArticleInfo.getTitle())
		.append("</td>")
		.append("<td>")
		.append(loadArticleInfo.getStartdate())
		.append("</td>")
		.append("<td>")
		.append(loadArticleInfo.getEnddate())
		.append("</td>")
		.append("</tr>");
	}
	
	contentBuilder.append("</tbody>")
	.append("</table>");
	
	out.print(contentBuilder.toString());
	
%>