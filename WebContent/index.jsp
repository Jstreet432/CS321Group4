<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Reverse Recipes Home</title>
	<link rel="stylesheet" href="styles.css">
	<!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"> -->
</head>

<body>
 <div class="menu">
   <a href="info.jsp">Website Information</a>
  <a href="index.jsp">Home</a>
</div> 

 <div class="container">
  <div class="appName"><h1><span style="color: #ffffff;">Reverse Recipes</span></h1></div>
 </div> 

<div class="box">
<form action="recipeServlet" method="post">
	<input type="text" name="yourRecipe"  placeholder="  Enter a recipe or ingredients (separate by space)..." size="20">
    <input type="submit" value="SEARCH!" />
</form></div>

</body>
</html>