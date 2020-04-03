<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%
  String owner = request.getParameter("owner");
  String id = request.getParameter("id");
  String user = request.getParameter("user");

  try{
      Class.forName("com.mysql.jdbc.Driver");
      Connection con = DriverManager.getConnection("jdbc:mysql://localhost/notes","root","");
      Statement st = con.createStatement();
      ResultSet r = st.executeQuery("select * from login where email='"+user+"'");
      if(r.next())
      {
        int x = st.executeUpdate("insert into share values ('"+owner+"','"+id+"','"+user+"')");        
        out.println("success");
    }else{
        out.println("invalid user");
    }

  }catch(Exception e){
      out.println(e);
  }
%>