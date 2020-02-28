<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%@ page import = "java.io.*,java.util.*,java.sql.*"%>

<%
  String user = request.getParameter("user");
  String pass = request.getParameter("pass");
  try{
      Class.forName("com.mysql.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost/notes","root","Mysql@123");
      Statement st = con.createStatement();
      ResultSet r = st.executeQuery("select * from login where username='"+user+"' and password='"+pass+"'");
      if(r.next()){
%>
        <%=user%>
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