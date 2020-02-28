<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<html>
    <body style="background:#ffe4b1">
<%
  String email = request.getParameter("email");
  String pass = request.getParameter("pass");
  String fname = request.getParameter("fname");
  String lname = request.getParameter("lname");
  String dob = request.getParameter("dob");
  String gender = request.getParameter("gender");

  try{
      Class.forName("com.mysql.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost/notes","root","Mysql@123");
      Statement st = con.createStatement();
      int x = st.executeUpdate("insert into login values ('"+email+"','"+pass+"','"+fname+"','"+lname+"','"+dob+"','"+gender+"')");
      if(x!=0){
%>
        

      <div style="margin:100px 400px 0 400px;background: orange;">
      <br>
      <center><h3 style="margin-top: 50px"><%="Registration successful for user "+email%></h3><br>
      <!-- <img src="http://localhost:8000/Forum/tick.png" style="width:100px; height: 100px;margin-bottom:10px"><br><br> -->
      <button onclick="window.location.href='home.jsp?user=<%=email%>'" style="width:100px;height:30px;margin-bottom: 50px;border-radius:5px;background:#041341;color:white">Login</button><br><br>
      </center>
      </div>

<%
      }else{
%>
        <%="Failed"%>
<%
    }

  }catch(Exception e){
      out.println(e);
  }
%>
  </body>
</html>