<!DOCTYPE html>
<html lang="en">
<head>
    <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
    <%@ page import = "java.io.*,java.util.*,java.sql.*"%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="css/bootstrap4.css">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>
    <link href="img/favicon.ico" rel="icon" type="image/png" />
    <title>Notes</title>
    <style>
        body{
            /* background-color: #111; */
            /* widows: 100%; */
            overflow-x: hidden;
        }
    </style>
</head>
<body>
    
    <%
        String user="";
        if(session.getAttribute("user")!= null)
          user = session.getAttribute("user").toString();
        else
          response.sendRedirect("http://localhost:8080/wt");

        String[] id = new String[100];
        String[] title = new String[100];
        String[] owner = new String[100];
        String[] content = new String[100];
        int i = 0;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/notes","root","");
            Statement st = con.createStatement();
            Statement st1 = con.createStatement();
            ResultSet rs = st.executeQuery("select * from share where user='"+user+"'");
            ResultSet rs1;
            while(rs.next()){
                rs1 = st1.executeQuery("select * from notes where id="+rs.getInt("noteid"));
                while(rs1.next()){
                    id[i] = Integer.toString(rs1.getInt("id"));
                    title[i] = rs1.getString("title");
                    owner[i] = rs1.getString("user");
                    content[i] = rs1.getString("content");
                    i++;  
                }
            }
        }
        catch(Exception e){
            out.println(e);
        }

    %>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #333;">
        <a class="navbar-brand" href="home.jsp"><b><%=user%></b></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
      
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item">
              <a class="nav-link" href="home.jsp">Home </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="bin.jsp">Recycle Bin <span class="sr-only">(current)</span> </a>
            </li>
            <li class="nav-item active">
              <a class="nav-link" href="shared.jsp">Shared </a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Extra
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="wind.html">About</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Something else here</a>
              </div>
            </li>
          </ul>
              <a class="nav-link" href="http://localhost:8080/wt/servlets/servlet/logout">Logout</a>
        </div>
      </nav>

<div class="row mt-5">
    <div class="col-4">
        <div class="list-group" id="list-tab" role="tablist">
            <%
                for(int j=0;j<i;j++){
            %>
                <a class="list-group-item list-group-item-action" style="height: 3em;overflow: hidden" id="note<%=id[j]%>" data-toggle="list" href="#expand<%=id[j]%>" role="tab" aria-controls="<%=id[j]%>"><b><%=title[j]%></b><span style="margin-left:20px;line-height: 1.7;"><%=owner[j]%></span></a>
            <%
                }
            %>
        </div>
    </div>
    <div class="col-8">
      <div class="tab-content" id="nav-tabContent">
        <%
            for(int j=0;j<i;j++){
        %>
            <div class="tab-pane fade m-3" id="expand<%=id[j]%>" role="tabpanel" aria-labelledby="note<%=id[j]%>">
                <%=content[j]%>
            </div>
        <%
            }
        %>
        </div>
    </div>
</div>
<script>

    function clickBtn(noteid,ch){
        $.ajax({
                type: "GET",
                url: "http://localhost:80/wt/"+ch,
                dataType: "jsonp",
                data: {
                    user: '<%=user%>',
                    id: noteid,
                },
                cache: false
            });
            setTimeout(()=>{window.location.reload()},300)
    }
</script>
</body>
</html>