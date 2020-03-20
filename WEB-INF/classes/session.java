import javax.servlet.*;
import javax.servlet.http.*;
import java.text.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class session extends HttpServlet 
{  

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
        PrintWriter out = response.getWriter();
        String user = request.getParameter("user");
        String pass = request.getParameter("pass");
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/notes","root","");
            Statement st = con.createStatement();
            ResultSet r = st.executeQuery("select * from login where email='"+user+"' and password='"+pass+"'");
            if(r.next())
            {
                HttpSession session = request.getSession(true);
                session.setAttribute("user",user);
            }else
            {
                response.setContentType("text/html");
                out.println("Invalid user");
            }
        }catch(Exception e){
            out.println(e);
        }

    }
} 