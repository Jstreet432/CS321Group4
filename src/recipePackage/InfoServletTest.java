package recipePackage;

import org.junit.Before;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

public class InfoServletTest{

    private HttpServletRequest request = mock(HttpServletRequest.class);
    private HttpServletResponse response = mock(HttpServletResponse.class);

    @org.junit.jupiter.api.Test
    void testDoGet() throws ServletException, IOException {
        InfoServlet testServ = new InfoServlet();
        try{
            // Set mock request
            when(request.getParameter("username")).thenReturn("Test");
            when(request.getParameter("password")).thenReturn("Me");

            // Set mock response
            StringWriter stringWriter = new StringWriter();
            PrintWriter writer = new PrintWriter(stringWriter);
            when(response.getWriter()).thenReturn(writer);

            testServ.doGet(request, response);
        }catch(Exception e){
            System.out.println("Error is: " + e);
        }
    }

    @org.junit.jupiter.api.Test
    void testDoPost() throws IOException {
        InfoServlet testServ = new InfoServlet();
        try {
            // Set mock request
            when(request.getParameter("username")).thenReturn("Test");
            when(request.getParameter("password")).thenReturn("Me");

            // Set mock response
            StringWriter stringWriter = new StringWriter();
            PrintWriter writer = new PrintWriter(stringWriter);
            when(response.getWriter()).thenReturn(writer);

            testServ.doPost(request, response);
        } catch (Exception e) {
            System.out.println("Error is: " + e);
        }
    }
}