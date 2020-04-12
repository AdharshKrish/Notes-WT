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
        .share-btn{
          width:max-content;
          position: absolute;
          bottom:20px;
          background-color: #00f;
          color: #fff;
          padding:5px 20px;
          border:1px solid #0000;
          border-radius: 5px
        }
        .share-btn:focus .share-in, .share-in:focus{
          outline: none;
          width: 200px;
          background-color: #fff;
          padding:7px 10px;
        }
        .share-btn:focus{
          outline: none;
        }
        .share-in{
          width: 0;
          border: 1px solid #00f;
          border-radius: 5px;
          padding:7px 0;
          transition: width .3s,padding .3s;
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
        <a class="navbar-brand" href="home.jsp"><b><%=user%></b></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
      
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link" href="home.jsp">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="bin.jsp">Recycle Bin</a>
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
            <!-- <li class="nav-item">
              <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
            </li> -->
          </ul>
              <a class="nav-link" href="http://localhost:8080/wt/servlets/servlet/logout">Logout</a>
              <!-- <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
          </form> -->
        </div>
      </nav>
      <!-- <div style="height:800px;width:100px;background-color: burlywood;"></div> -->
      
    <div class="collapse" id="collapseExample">
      <div class="card card-body" id="fullcont" style="position: relative;">
        <form method="POST" action="http://localhost:80/wt/update.php">
          <input type="hidden" value="<%=user%>" name="user">
          <input type="hidden" name="id" id="id-cont">
          <!-- <div class="row">
            <div class="col-11"> -->
              
              <button type="button" style="float:right;background-color: #f00;color: #fff;border:1px solid #0000;border-radius: 20%;" class="mb-3" onclick="deleteNote()" >
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#fff" width="32px" height="32px"><path d="M6 19c0 1.1.9 2 2 2h8c1.1 0 2-.9 2-2V7H6v12zM8 9h8v10H8V9zm7.5-5l-1-1h-5l-1 1H5v2h14V4z"/><path d="M0 0h24v24H0V0z" fill="none"/></svg>
              </button>
              <input name="title" class="add-note form-control" id="title-cont" placeholder="Title" style="font-weight: bold">
            <!-- </div>
            <div class="col-auto"> -->
            <!-- </div>
          </div> -->
          <textarea name="content" class="add-note form-control" id="text-cont" rows="5"></textarea>
          <!-- <div class="row">
          <div class="col-sm-11"></div>
          <div class="col-sm-1"> -->
          <button type="submit" style="float:right;background-color: #0c5;color: #fff;padding:5px 20px;border:1px solid #0000;border-radius: 5px">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="#fff" width="36px" height="36px"><path d="M0 0h24v24H0z" fill="none"/><path d="M17 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm-5 16c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm3-10H5V5h10v4z"/></svg>
          </button>     
        </form>
        <button type="button" class="share-btn">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="white" width="36px" height="36px"><path d="M0 0h24v24H0z" fill="none"/><path d="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92 1.61 0 2.92-1.31 2.92-2.92s-1.31-2.92-2.92-2.92z"/></svg>
          <input type="text" class="share-in">
        </button>
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
              <input class="form-control" id="new-note" name="content" placeholder="Enter new note content . . .">
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
                ResultSet rs = st.executeQuery("select * from notes where user='"+user+"' and deleted=0");
                String id,title,label,content;
                String[] bg = {"bg-primary","bg-secondary","bg-success","bg-danger","bg-warning","bg-info","bg-light","bg-dark"};
                int i = 0;
                while(rs.next()){

                  id = Integer.toString(rs.getInt("id"));
                  title = rs.getString("title");
                  label = rs.getString("date");
                  content = rs.getString("content");

        %>         
                 
        <div id="<%=id%>" class="col-lg-3 col-md-4 col-sm-6 my-card">
          <a data-toggle="collapse" href="#collapseExample" role="button" onclick='setExpand("<%=id%>")' aria-expanded="false" aria-controls="collapseExample">
            <div class='card <%=(bg[i]=="bg-light"?"text-dark":"text-white")+" "+bg[i]%>' style='max-width: 18rem;max-height: 14.4rem'>
              <div class="card-header"><%=label%></div>
              <div class="card-body">
                <h5 class="card-title"><%=title%></h5>
                <p class="card-text"><%=content%></p>
              </div>
            </div>
          </a>
        </div>
                 
        <%         
                  i = (i<7)?i+1:0;
                }
              }catch(Exception e){
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
            });
            setTimeout(()=>{window.location.reload()},100)
    }
    document.querySelector('#new-note').focus()

    document.querySelector('.share-btn').addEventListener('click',()=>{
      document.querySelector('.share-in').focus()
    })
    document.querySelector('.share-in').addEventListener("keyup", function(event){
      if (event.keyCode === 13){
        event.preventDefault();
        $.ajax({
          type: "POST",
          url: "share.jsp",
          data: {
            owner: '<%=user%>',
            id: document.getElementById('id-cont').value,
            user: event.target.value
          },
          cache: false,
          success: function (html) {
            if(html.match('success')){
              alert("shared with "+event.target.value)
              event.target.value="";
            }else{
              alert(html.trim())
            }
          }
        });
      }
    });

</script>
</body>
</html>

<!-- <%-- INSERT INTO `notes` (`user`, `title`, `date`, `content`) VALUES ('Adharsh', 'No title', current_timestamp(), 'Third note') --%> -->