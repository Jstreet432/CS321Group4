package recipePackage;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Servlet implementation class RecipeServlet
 */
@WebServlet("/recipeServlet")
public class RecipeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RecipeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String recipes = request.getParameter("yourRecipe");
		String url = "https://www.food2fork.com/api/search?key=c3ee9156f881ed0fb0321b80ea7039ff&q=";
		// Writing Logic
		ArrayList<String> list = new ArrayList<String>();
		String[] array = recipes.split(" ");
		for (int i = 0; i < array.length; i++) {
			list.add(array[i]);
		}
		
		StringBuilder s = new StringBuilder(url);
		for (int i = 0; i < list.size(); i++) {
			s.append(list.get(i) + "%20");
		}
		URL obj = new URL(s.toString());
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
		// optional default is GET
		con.setRequestMethod("GET");
		// add request header
		con.setRequestProperty("User-Agent", "Mozilla/5.0");
		
		int responseCode = con.getResponseCode();
		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer res = new StringBuffer();
		while ((inputLine = in.readLine()) != null) {
			res.append(inputLine);
		}
		in.close();

		// converting string to json object
		JSONObject myResponse = new JSONObject(res.toString());
		// getting the array of recipes from the json object
		JSONArray arr = myResponse.getJSONArray("recipes");
		// creating an arraylist to store the object of each recipe
		ArrayList<JSONObject> innerObject = new ArrayList<>();
		for (int i = 0; i < arr.length(); i++) {
			// adding all the recipe objects
			innerObject.add(arr.getJSONObject(i));
		}
		// stroring array to hold all the titles of each recipe
		ArrayList<String> titles = new ArrayList<String>();
		for (int i = 0; i < innerObject.size(); i++) {
			// appending title of each recipe to the titles arraylist
			titles.add(innerObject.get(i).getString("title"));
		}
		StringBuilder str = new StringBuilder();
		for (int i = 0; i < titles.size(); i++) {
			str.append(titles.get(i) + "\n");
		}
		PrintWriter writer = response.getWriter();
		writer.println("" + str.toString() + "");
		writer.close();
	}

}














