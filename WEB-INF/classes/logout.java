import javax.servlet.*;
import javax.servlet.http.*;
import java.text.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class logout extends HttpServlet 
{  

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        HttpSession session = request.getSession(true);

        session.invalidate();

        response.sendRedirect("http://localhost:8080/wt");
    }
}