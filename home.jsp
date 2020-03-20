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
        
        .row{
            padding: 0 5vw;
            flex-wrap: wrap;
        }
        .my-card{
            padding-top: 30px;
            overflow: hidden;
        }
        .card-text{
            /* padding-bottom: 40px; */
            overflow: hidden;
        }
        a:hover{
            text-decoration: none;
        }
        .add-note{
          margin-bottom:10px;
          color:#000;
        }
        .add-note:focus{
          color:#000;
        }
        body{
            background-color: #111;
            widows: 100%;
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

    %>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #333;">
        <a class="navbar-brand" href="home.jsp?user=<%=user%>"><b><%=user%></b></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
      
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link" href="../examples/servlets/servlet/Ser">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="http://localhost:8080/wt/servlets/servlet/logout">Logout</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Labels
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="#">Action</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Another action</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Something else here</a>
              </div>
            </li>
            <!-- <li class="nav-item">
              <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
            </li> -->
          </ul>
          <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
          </form>
        </div>
      </nav>
      <!-- <div style="height:800px;width:100px;background-color: burlywood;"></div> -->
      
    <div class="collapse" id="collapseExample">
      <div class="card card-body" id="fullcont">
        <form method="POST" action="http://localhost:80/wt/update.php">
          <input type="hidden" value="<%=user%>" name="user">
          <input type="hidden" name="id" id="id-cont">
          <input name="title" class="add-note form-control" id="title-cont" placeholder="Title" style="font-weight: bold">
          <textarea name="content" class="add-note form-control" id="text-cont" rows="5"></textarea>
          <!-- <div class="row">
          <div class="col-sm-11"></div>
          <div class="col-sm-1"> -->
          <button class="btn-success" type="submit" style="width:8vw;font-size:1vw;margin-left:65vw;font-weight: bold;">Save</button>            
          <button class="btn-danger" type="button" onclick="deleteNote()" style="width:8vw;font-size:1vw;margin-left:3vw;font-weight: bold;">Delete</button>
        </form>
        <!-- </div>
      </div> -->
    </div>
    </div>
      <div class="row">
        <div class="col-sm-12" style="margin-top:30px">
          <form method="POST" action="http://localhost:80/wt/add.php">
          <div class="row">
          <div class="col-sm-0">
              <input type="text" value="<%=user%>" name="user" hidden>
          </div>
            <div class="col-sm-11">
              <input class="form-control" name="content" placeholder="Enter new note content . . .">
            </div>
            <div class="col-sm-1">  
              <button class="btn btn-warning" type="submit">Add</button>
            </div>
          </div>
          </form>
        </div>
        <%
              try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/notes","root","");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from notes where user='"+user+"'");
                String id,title,label,content;
                String[] bg = {"bg-primary","bg-secondary","bg-success","bg-danger","bg-warning","bg-info","bg-light","bg-dark"};
                int i = 0;
                while(rs.next()){

                  id = Integer.toString(rs.getInt("id"));
                  title = rs.getString("title");
                  label = rs.getString("date");
                  content = rs.getString("content");

                  out.println("<div id="+id+" class=\"col-lg-3 col-md-4 col-sm-6 my-card\">\n<a data-toggle=\"collapse\" href=\"#collapseExample\" role=\"button\" onclick=\"setExpand("+id+")\" aria-expanded=\"false\" aria-controls=\"collapseExample\">\n<div class=\"card "+(bg[i]=="bg-light"?"text-dark":"text-white")+" "+bg[i]+"\" style=\"max-width: 18rem;max-height: 14.4rem\">\n<div class=\"card-header\">"+label+"</div>\n<div class=\"card-body\"><h5 class=\"card-title\">"+title+"</h5><p class=\"card-text\">"+content+"</p></div></div></a></div>");
                  i = (i<7)?i+1:0;
                }}
                catch(Exception e){
                   out.println(e);
                }
        %>
<script>
    function setExpand(id){
        // let header = document.getElementById(id).getElementsByClassName('card-header')[0].innerHTML;
        let title = document.getElementById(id).getElementsByClassName('card-title')[0].innerHTML;
        let text = document.getElementById(id).getElementsByClassName('card-text')[0].innerHTML;
        document.getElementById('text-cont').value=text;
        document.getElementById('title-cont').value=title;
        document.getElementById('id-cont').value=id;
    }
    function deleteNote(){
      $.ajax({
                type: "GET",
                url: "http://localhost:80/wt/delete.php",
                dataType: "jsonp",
                data: {
                    user: '<%=user%>',
                    id: document.getElementById('id-cont').value,
                },
                cache: false
                  // alert(html);
                    // if(!html.match('Failed')){
                        // window.location.href="http://localhost:80/projects/wt/index.html";
                        // window.location.href="home.jsp?user=<%=user%>";
                    // }else{
                        // alert(html.trim());
                    // }
                 
            });
            window.location.href="home.jsp?user=<%=user%>";
    }
</script>
</body>
</html>

<!-- <%-- INSERT INTO `notes` (`user`, `title`, `date`, `content`) VALUES ('Adharsh', 'No title', current_timestamp(), 'Third note') --%> -->