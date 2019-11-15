<%@ page import ="java.net.HttpURLConnection, 
				java.net.URL, 
				org.json.JSONArray, 
				org.json.JSONObject,
				java.io.BufferedReader,
				java.io.InputStreamReader,
				recipePackage.RecipeServlet" %>

<%!
	
	JSONObject recipeJSON;
	JSONObject instructJSON;
%>
<%
	String recipeUrl = "https://api.spoonacular.com/recipes/"+ 324694 +"/information?includeNutrition=false&apiKey=0f4e3ea15e7f4738bf0a2a9666d4a757";
	String instructUrl = "https://api.spoonacular.com/recipes/"+324694+"/analyzedInstructions?apiKey=0f4e3ea15e7f4738bf0a2a9666d4a757";
	recipeJSON = RecipeServlet.apiRequest(recipeUrl);
	instructJSON = RecipeServlet.apiRequest(instructUrl);
%>

<html>
<head>
<title><%= recipeJSON.getString("title")%></title>
</head>
<body>
	<h1> <%= recipeJSON.getString("title") %> </h1>
	<img src=<%= recipeJSON.getString("image").trim() %> alt = "failed to find img">
	<p> </p>
	
</body>
</html>