<%@page import="java.util.ArrayList"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<!DOCTYPE html> 
<html> 
  <head> 
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
   <title>Recipe Information</title> 
  </head> 
  <body bgcolor = "LightGreen"> 
  
  <% int num = Integer.parseInt(request.getParameter("hiddenValue"));
  	 ArrayList<ArrayList<String>> allIng = new ArrayList<ArrayList<String>>();
  	 allIng = (ArrayList<ArrayList<String>>) session.getAttribute("allIng");
  	ArrayList<String> images = new ArrayList<String>();
  	images = (ArrayList<String>) session.getAttribute("image");
  	ArrayList<String> std = new ArrayList<String>();
    std = (ArrayList<String>)session.getAttribute("title");
  %>
  <h1><%=std.get(num-1) %></h1>
  <img src="<%=images.get(num-1)%>" alt="W3Schools.com" style="width:350px;height:350px;">
  <h2>Ingredients</h2>
  <% for (int i = 0; i < allIng.get(num-1).size(); i++){%>
  	<p><%=allIng.get(num-1).get(i)%></p>
  <%}%>
  <h2>Link to Recipe</h2>
  <%String title = std.get(num - 1);
  	String[] titleSplit = title.split(" ");
  	StringBuilder str = new StringBuilder();
  	for (int i = 0; i < titleSplit.length; i++){
  		str.append(titleSplit[i] + "%20");
  	}
  	String newTitle = str.toString();
  %>
  <a href="https://www.google.com/search?q=<%=newTitle %>"><%=std.get(num-1) %></a>
  </body>
</html>