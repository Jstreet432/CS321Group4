<%@page import="java.util.ArrayList"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<!DOCTYPE html> 
<html> 

  <head> 
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
   <title>More Recipe Information</title> 
   <link href="recipeView.css" rel="stylesheet">
  </head> 
  
  <body> 
	<div class="menu">
   <a href="info.jsp">Website Information</a><a href="index.jsp">Home</a>
	</div> 

 <div class = "container"><div class = "infobox2">
  <% int num = Integer.parseInt(request.getParameter("hiddenValue"));
  	 ArrayList<ArrayList<String>> allIng = new ArrayList<ArrayList<String>>();
  	 allIng = (ArrayList<ArrayList<String>>) session.getAttribute("allIng");
  	ArrayList<String> images = new ArrayList<String>();
  	images = (ArrayList<String>) session.getAttribute("image");
  	ArrayList<String> std = new ArrayList<String>();
    std = (ArrayList<String>)session.getAttribute("title");%>

  <center><font color="white" size = "5"><br><b><%=std.get(num-1) %></b><br><br></font></center> <%--PRINTS THE NAME OF THE RECIPE--%>
  <img src="<%=images.get(num-1)%>" alt="W3Schools.com" style="width:350px;height:350px;" class="center">
  
  <br><center><font color="white"><b>Ingredients:</b></center>
  <% for (int i = 0; i < allIng.get(num-1).size(); i++){%>
  	<p><center><%=allIng.get(num-1).get(i)%></center></p><%}%>

  <br><%String title = std.get(num - 1);
  	String[] titleSplit = title.split(" ");
  	StringBuilder str = new StringBuilder();
  	for (int i = 0; i < titleSplit.length; i++){
  		str.append(titleSplit[i] + "%20");
  	}
  	String newTitle = str.toString();%>
  <center><font color="white"><b>Recipe Link: </b><a href="https://www.google.com/search?q=<%=newTitle %>" style="color:Green;"><%=std.get(num-1) %></a></font></center>
  <br><br></div></div>
  </body>
  
</html>
