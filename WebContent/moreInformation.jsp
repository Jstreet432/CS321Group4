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
    ArrayList<Integer> ids = new ArrayList<>();
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
  <h1><%=std.get(num-1) %></h1>
  <img src="<%=images.get(num-1)%>" alt="W3Schools.com" style="width:350px;height:350px;">
  <h2>Ingredients</h2>
  <% for (int i = 0; i < allIng.get(num-1).size(); i++){%>
  	<p><%=allIng.get(num-1).get(i)%></p>
  <%}%>
  <h2>Steps</h2>
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
  %>
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