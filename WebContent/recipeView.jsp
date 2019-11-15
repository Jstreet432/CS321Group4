<%@page import="java.util.ArrayList"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<!DOCTYPE html> 
<html> 
  <head> 
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
   <title>Recipe List</title> 
  </head> 
  <body> 
      <center><h1>Recipe List</h1></center> 
      <table border ="1" width="500" align="center"> 
         <tr bgcolor="Green"> 
          <th><center><b>Recipe ID</b></center></th> 
          <th><center><b>Image</b></center></th>
          <th><center><b>Recipe Name</b></center></th>
          <th><center><b>Popularity</b></center></th> 
          <th><center><b>More Information</b></center></th>
         </tr> 

        <%ArrayList<String> std =  
            (ArrayList<String>)request.getAttribute("recipes");
        ArrayList<Integer> likes =  
                (ArrayList<Integer>)request.getAttribute("likes");
        ArrayList<String> images = (ArrayList<String>)request.getAttribute("images");
        ArrayList<Integer> ingredientsNeeded = (ArrayList<Integer>)request.getAttribute("needIngredients");
        ArrayList<ArrayList<String>> allIng = (ArrayList<ArrayList<String>>) request.getAttribute("allIng");
       	session.setAttribute("allIng", allIng);
       	session.setAttribute("image", images);
       	session.setAttribute("title", std);
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
        </table>  
        <hr/> 
    </body> 
</html> 