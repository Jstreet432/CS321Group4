<%@page import="java.util.ArrayList"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%> 

<!DOCTYPE html> 
<html> 
  <head> 
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
   <title>Recipe List (Results)</title> 
   <link href="recipeView.css" rel="stylesheet">
  </head> 
  
  <body> 
	<div class="menu">
   <a href="info.jsp">Website Information</a><a href="index.jsp">Home</a>
  	</div>

	<br>
     <center><h1>Recipe List</h1></center>
     <br>
          <table bgcolor="white" border ="1" width="500" style="border:1px solid black;margin-left:auto;margin-right:auto;" style="text-align:center;" style="background-color: #FFFFFF;"> 
         <tr bgcolor="Green"> 
          <th><center><b>Recipe ID</b></center></th> 
          <th><center><b>Image</b></center></th>
          <th><center><b>Recipe Name</b></center></th>
          <th><center><b>Popularity</b></center></th> 
          <th><center><b>More Information</b></center></th>
         </tr> 

        <%ArrayList<String> std = (ArrayList<String>)request.getAttribute("recipes");
        ArrayList<Integer> likes = (ArrayList<Integer>)request.getAttribute("likes");
        ArrayList<String> images = (ArrayList<String>)request.getAttribute("images");
        ArrayList<Integer> ingredientsNeeded = (ArrayList<Integer>)request.getAttribute("needIngredients");
        ArrayList<ArrayList<String>> allIng = (ArrayList<ArrayList<String>>) request.getAttribute("allIng");
        ArrayList<Integer> ids = (ArrayList<Integer>) request.getAttribute("IDs");
       	session.setAttribute("allIng", allIng);
       	session.setAttribute("image", images);
       	session.setAttribute("title", std);
       	session.setAttribute("ID", ids);
        int i = 1;
        for(int j = 0, k = 0, z = 0, a = 0; j < std.size() && k < likes.size() && z < images.size() && a < ingredientsNeeded.size(); j++, k++, z++, a++){%> 
            <tr> 
                <td><center><%=i%></center></td>
                <td><img src="<%=images.get(z)%>" alt="W3Schools.com" style="width:140px;height:140px;"></td>
                <td><center><%=std.get(j)%></center></td> 
                <td><center><%=likes.get(k)%></center></td>
                <td>
                
                <form action="moreInformation.jsp">
                <input type="hidden" name="hiddenValue" value="<%=i %>">
        		<input type="submit" value="Get Information" style="background-color: LightGreen">
    			</form>
                
                </td>
            </tr> 
            <%i++;%>
            <%}%> 
        </table>  <br><br><hr/> 
    </body> 
</html> 



    