import javax.servlet.*;
import javax.servlet.http.*;
import java.text.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class cookie extends HttpServlet {  
    public void doGet(HttpServletRequest request, HttpServletResponse response)  
          throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        String cou="";

        // response.setHeader("Access-Control-Allow-Origin", "*");
        // response.setHeader("Access-Control-Allow-Methods", "POST, GET, PUT, OPTIONS, DELETE, PATCH");
        // response.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");

        // String uname = request.getParameter("uname");
        String uname = "Cookie user";
        HttpSession session=request.getSession(); 
        // session.setAttribute("usrname",uname);   ${usrname}
        out.println(uname);


         try{
        // Class.forName("com.mysql.jdbc.Driver");
        // Connection con = DriverManager.getConnection("jdbc:mysql://localhost/login?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC","root","");
        // Statement st = con.createStatement();
        // ResultSet x = st.executeQuery("select count(title) from posts where username='"+uname+"'");     
        // x.next();
        Cookie ck = new Cookie("postcount","this is a cookie");
        ck.setMaxAge(300);
        response.addCookie(ck);

        // out.print(x.getString(1));
        // out.println(uname);

         }catch(Exception e){
        out.println(e);
        }
        Cookie c[] = request.getCookies();

        for(Cookie cookie:c){
            if(cookie.getName().equals("postcount"))
                cou = cookie.getValue();
        }

        // request.setAttribute("message", cou);
        out.println("existing cookie"+cou);
        // request.getRequestDispatcher("/profile.jsp").forward(request, response);
                
    }
} 