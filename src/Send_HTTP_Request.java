        
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Scanner;

import org.json.JSONArray;
import org.json.JSONObject;

public class Send_HTTP_Request {
	public static void main(String[] args) {
		try {
			String recipes = getRecipes(Send_HTTP_Request.call_me());
			System.out.println(recipes);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static ArrayList<String> call_me() throws Exception {
		String url = "https://www.food2fork.com/api/search?key=c3ee9156f881ed0fb0321b80ea7039ff&q=";
		// Writing Logic
		ArrayList<String> list = new ArrayList<String>();
		Scanner input = new Scanner(System.in);
		System.out.println("Enter your ingredient ");
		System.out.println("If you don't want to enter, press (n)");
		while (input.nextLine().equals("n") == false) {
			System.out.println("Enter your ingredient ");
			System.out.println("If you don't want to enter, press (n)");
			String ing = input.nextLine();
			String[] arr = ing.split(" ");
			for (int i = 0; i < arr.length; i++) {
				list.add(arr[i]);
			}
			if (ing.equals("n")) {
				break;
			}
		}
		input.close();
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
		StringBuffer response = new StringBuffer();
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();

		// converting string to json object
		JSONObject myResponse = new JSONObject(response.toString());
		// getting the array of recipes from the json object
		JSONArray arr = myResponse.getJSONArray("recipes");
		// creating an arraylist to store the object of each recipe
		ArrayList<JSONObject> innerObject = new ArrayList<JSONObject>();
		for (int i = 0; i < arr.length(); i++) {
			// adding all the recipe objects
			innerObject.add(arr.getJSONObject(i));
		}
		// storing array to hold all the titles of each recipe
		ArrayList<String> titles = new ArrayList<String>();
		for (int i = 0; i < innerObject.size(); i++) {
			// appending title of each recipe to the titles arraylist
			titles.add(innerObject.get(i).getString("title"));
		}
		return titles;
	}
	
	public static String getRecipes(ArrayList<String> titles) {
		StringBuilder str = new StringBuilder();
		for (int i = 0; i < titles.size(); i++) {
			str.append(titles.get(i) + "\n");
		}
		return str.toString();
	}
}

    