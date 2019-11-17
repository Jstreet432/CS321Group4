<%@ page import ="java.net.HttpURLConnection, 
				java.net.URL, 
				org.json.JSONArray, 
				org.json.JSONObject,
				java.io.BufferedReader,
				java.io.InputStreamReader,
				recipePackage.RecipeServlet,
				java.util.ArrayList" %>
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
    std = (ArrayList<String>)session.getAttribute("title");
  
    ArrayList<Integer> ids = new ArrayList<Integer>();
    ids = (ArrayList<Integer>) session.getAttribute("ID");
    
    String url = "https://api.spoonacular.com/recipes/"+ids.get(num-1)+"/analyzedInstructions?apiKey=0f4e3ea15e7f4738bf0a2a9666d4a757";
	URL obj = new URL(url);
	HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	// optional default is GET
	con.setRequestMethod("GET");
	// add request header
	con.setRequestProperty("User-Agent", "Mozilla/5.0");
	
	int responseCode = con.getResponseCode();
	BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
	String inputLine;
	StringBuffer responses = new StringBuffer();
	while ((inputLine = in.readLine()) != null) {
		System.out.println(inputLine);
		responses.append(inputLine);
	}
	in.close();
	JSONArray jsonArr = new JSONArray(responses.toString());
	boolean stepsFound = true;
	JSONArray stepObj = new JSONArray();
	try{
		stepObj = ((JSONObject)jsonArr.get(0)).getJSONArray("steps");
	}
	catch(Exception e){
		stepsFound = false;
	}
  %>
  <center><font color="white" size = "5"><br><b><%=std.get(num-1) %></b><br><br></font></center> <%--PRINTS THE NAME OF THE RECIPE--%>
  <img src="<%=images.get(num-1)%>" alt="W3Schools.com" style="width:350px;height:350px;" class="center">
  
  <br><center><font color="white"><b>Ingredients:</b>
  <% for (int i = 0; i < allIng.get(num-1).size(); i++){%>
  	<p><center><%=allIng.get(num-1).get(i)%></center></p><%}%>

  <br><center><font color="white"><b>Instructions:</b></center>
  <%
  	String stepsOut = "";
  	if(stepsFound){
	  	for(int i = 0;i < stepObj.length();i++){
	  		JSONObject currentStep = (JSONObject)stepObj.get(i);
	  		stepsOut += "\t"+currentStep.getInt("number")+") " +currentStep.getString("step")+ "<br/>";
	  	}
  	}
  	else{
  		stepsOut += "Hmmm we couldn't find the steps for this recipe, try checking the link below.";
  	}
  	out.print(stepsOut);
  %></font></center>
  
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
