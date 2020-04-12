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
        String[] label = new String[100];
        String[] content = new String[100];
        int i = 0;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/notes","root","");
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("select * from notes where user='"+user+"' and deleted=1");
            while(rs.next()){
                id[i] = Integer.toString(rs.getInt("id"));
                title[i] = rs.getString("title");
                label[i] = rs.getString("date");
                content[i] = rs.getString("content");
                i++;  
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
            <li class="nav-item active">
              <a class="nav-link" href="bin.jsp">Recycle Bin <span class="sr-only">(current)</span> </a>
            </li>
            <li class="nav-item">
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
                <a class="list-group-item list-group-item-action" style="height: 3em;overflow: hidden" id="note<%=id[j]%>" data-toggle="list" href="#expand<%=id[j]%>" role="tab" aria-controls="<%=id[j]%>"><b><%=title[j]%></b><span style="margin-left:20px;line-height: 1.7;"><%=content[j]%></span></a>
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
                <btn style="float:right;background-color: #f00;color: #fff;border:1px solid #0000;border-radius: 20%;margin:10px 20px;padding:5px" class="mb-3" onclick="clickBtn('<%=id[j]%>','permdel.php')" >
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#fff" width="36px" height="36px"><path d="M0 0h24v24H0V0z" fill="#f00"/><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zm2.46-7.12l1.41-1.41L12 12.59l2.12-2.12 1.41 1.41L13.41 14l2.12 2.12-1.41 1.41L12 15.41l-2.12 2.12-1.41-1.41L10.59 14l-2.13-2.12zM15.5 4l-1-1h-5l-1 1H5v2h14V4z"/><path d="M0 0h24v24H0z" fill="none"/></svg>
                </btn>
                <btn style="float:right;background-color: #00f;color: #fff;border:1px solid #0000;border-radius: 20%;margin:10px 20px;padding:5px" class="mb-3" onclick="clickBtn('<%=id[j]%>','restore.php')" >
                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#fff" width="36px" height="36px"><path d="M19 12v7H5v-7H3v7c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2v-7h-2zm-6 .67l2.59-2.58L17 11.5l-5 5-5-5 1.41-1.41L11 12.67V3h2z"/><path d="M0 0h24v24H0z" fill="none"/></svg>
                </btn>
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