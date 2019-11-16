package recipePackage;

// C:\Users\Megan\Desktop\Java\jdk-13.0.1_windows-x64_bin\jdk-13.0.1\bin
import java.io.BufferedReader;


import java.io.IOException;

import java.io.InputStreamReader;

import java.io.PrintWriter;

import java.net.HttpURLConnection;

import java.net.URL;

import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;


import org.json.JSONArray;
import org.json.JSONException;
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
		//String url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=0f4e3ea15e7f4738bf0a2a9666d4a757&ingredients=";
		String url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=5270476e47e0417c837da90092609dc2&ingredients=";
		// Writing Logic
		ArrayList<String> list = new ArrayList<String>();
		String[] array = recipes.split(" ");
		for (int i = 0; i < array.length; i++) {
			list.add(array[i]);
		}
		StringBuilder s = new StringBuilder(url);
		for (int i = 0; i < list.size(); i++) {
			s.append(list.get(i) + ",+");
		}
		s.append("&number=100");
		URL obj = new URL(s.toString());
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
		JSONArray jsonArr = null;
		try {
			jsonArr = new JSONArray(responses.toString());
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		ArrayList<String> titles = new ArrayList<String>();
		ArrayList<String> images = new ArrayList<String>();
		ArrayList<Integer> likes = new ArrayList<Integer>();
		ArrayList<Integer> needIngredients = new ArrayList<Integer>();
		
		ArrayList<String> strLikes = new ArrayList<String>();
		ArrayList<JSONArray> missedIngredients = new ArrayList<JSONArray>();
		
		for (int i = 0; i < jsonArr.length(); i++) {
			JSONObject object = null;
			try {
				object = (JSONObject)jsonArr.get(i);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// appending title of each recipe to the titles arraylist
			try {
				titles.add(object.getString("title"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				likes.add(object.getInt("likes"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				images.add(object.getString("image"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				needIngredients.add(object.getInt("usedIngredientCount"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				missedIngredients.add(object.getJSONArray("missedIngredients"));
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		ArrayList<ArrayList<String>> allIng = new ArrayList<ArrayList<String>>();
		for (int i = 0; i < missedIngredients.size(); i++) {
			ArrayList<String> ing = new ArrayList<String>();
			for (int j = 0; j < missedIngredients.get(i).length(); j++) {
				JSONObject abc = null;
				try {
					abc = (JSONObject)missedIngredients.get(i).get(j);
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				try {
					ing.add(abc.getString("original"));
				} catch (JSONException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			allIng.add(ing);
		}
		System.out.println();
		StringBuilder str = new StringBuilder();
		for (int i = 0; i < titles.size(); i++) {
			str.append(titles.get(i) + "\n");
		}
		String destination = "recipeView.jsp";
		RequestDispatcher requestDispatcher = request.getRequestDispatcher(destination);
		request.setAttribute("recipes", titles);
		request.setAttribute("likes", likes);
		request.setAttribute("images", images);
		request.setAttribute("needIngredients", needIngredients);
		if (allIng.size() > 0 && allIng != null)
			request.setAttribute("allIng", allIng);
		requestDispatcher.forward(request, response);

	}

}

