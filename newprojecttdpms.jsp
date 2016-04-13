<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<link href="<%=request.getContextPath() %>/authoringtool/finaltable/style.css" type="text/css" rel="stylesheet">
<body>
<table id="rounded-corner" summary="Project Management">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company">Project Information</th>
            <th scope="col" class="rounded-q1"></th>
            <th scope="col" class="rounded-q2"></th>
            <th scope="col" class="rounded-q3"></th>
           
        </tr>
    </thead>
        
    <tbody>
    	<tr>
        	<td>Project ID<font color="red">*</font></td>
            <td><select name="projectid" id="projectid" style="width:145px"><option value="1">1</option><option value="2">2</option> </select></td>
            <td>Customer Name</td>
            <td><input style="width:139px" type="text" id="customer_name" name="customer_name"/> </td>
            
        </tr>
        <tr>
        	<td>Project Title</td>
            <td><input type="text" style="width:139px" id="project_title" name="project_title"/> </td>
            <td></td>
            <td></td>
            
        </tr>
        <tr>
        	<td>JTN. NO.</td>
            <td><input style="width:139px" type="text" id="jtn_no" name="jtn_no"/> </td>
            <td></td>
            <td></td>
            
        </tr>
        <tr>
        	<td>Edition</td>
            <td><select name="edition" id="edition" style="width:145px"><option value="1">1</option><option value="2">2</option> </select></td>
            <td>Stage</td>
            <td><select name="stage" id="stage" style="width:145px"><option value="1">1</option><option value="2">2</option> </select></td>
            
        </tr>
    </tbody>
</table>
<table id="rounded-corner" summary="Specifications">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company">Specifications</th>
            <th scope="col" class="rounded-q1"></th>
            <th scope="col" class="rounded-q2"></th>
            <th scope="col" class="rounded-q3"></th>
            <th scope="col" class="rounded-q4"></th>
        </tr>
    </thead>
        
    <tbody>
    	<tr>
        	<td>Complexitiy Level<font color="red">*</font></td>
            <td><select style="width: 145px" name="complexitiylevel" id="complexitiylevel"><option value="simple">Simple</option><option value="complex">Complex</option> </select> </td>
            <td>Book Colors</td>
            <td><select style="width: 145px" name="bookcolors" id="bookcolors"><option value="red">Red</option><option value="blue">Blue</option> </select></td>
            <td></td>
        </tr>
        <tr>
        	<td>Pagination Platform<font color="red">*</font></td>
            <td><select style="width: 145px" name="paginationplatform" id="paginationplatform"><option value="3b2">3b2</option><option value="indesign">Indesign</option> </select></td>
            <td>Project Category<font color="red">*</font></td>
            <td><select style="width: 145px" name="projectcategory" id="projectcategory"><option value="3b2">3b2</option><option value="indesign">Indesign</option> </select></td>
            <td></td>
        </tr>
        <tr>
        	<td>Production Site<font color="red">*</font></td>
            <td><select style="width: 145px" name="productionsite" id="productionsite"><option value="1">1</option><option value="2">2</option> </select></td>
            <td>PII</td>
            <td><input style="width:139px" type="text" name="pii" id="pii"> </td>
            <td></td>
        </tr>
        <tr>
        	<td>DOI</td>
            <td><input style="width:139px" type="text" name="pii" id="pii"></td>
            <td>Volume Editor</td>
            <td><input style="width:139px" type="text" name="volumeeditor" id="volumeeditor"></td>
            <td></td>
        </tr>
        
        <tr>
        	<td>Volume Number</td>
            <td><input style="width:139px" type="text" name="volumenumber" id="volumenumber"></td>
            <td>Imprint</td>
            <td><input style="width:139px" type="text" name="imprint" id="imprint"></td>
            <td></td>
        </tr>
        
       
       <tr>
        	<td>Expected Year Of Publication</td>
            <td><select style="width: 145px" name="productionsite" id="productionsite"><option value="2011">2011</option><option value="2012">2012</option> </select></td>
            <td>Job Type</td>
            <td><input style="width:139px" type="text" name="jobtype" id="jobtype"></td>
            <td></td>
        </tr>
         
         
         <tr>
        	<td>Book Title</td>
            <td><input style="width:139px" type="text" name="booktitle" id="booktitle"></td>
            <td>Segment<font color="red">*</font></td>
            <td><select style="width: 145px" name="segment" id="segment"><option value="3b2">3b2</option><option value="indesign">Indesign</option> </select></td>
            <td></td>
        </tr>
        
        <tr>
        	<td>Sub Tilte</td>
            <td><input style="width:139px" type="text" name="subtitle" id="subtitle"></td>
            <td>Target Book Count</td>
            <td><input style="width:139px" type="text" name="tbookcount" id="tbookcount"></td>
            <td></td>
        </tr>
        
         <tr>
        	<td>Trim Size</td>
            <td><select style="width: 145px" name="trimsize" id="trimsize"><option value="1">1</option><option value="2">2</option> </select> </td>
            <td>Target Book Count</td>
            <td><input style="width:139px" type="text" name="tbookcount" id="tbookcount"></td>
            <td></td>
        </tr>
        
    </tbody>
</table>

</body>
</html>