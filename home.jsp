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
        textarea{
            border: none;
        }
        textarea:focus{
            outline: none;
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
        String user = request.getParameter("user");
    %>
    <nav class="navbar navbar-expand-lg navbar-dark" style="background-color: #333;">
        <a class="navbar-brand" href="home.jsp?user=<%=user%>"><b><%=user%></b></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
      
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
              <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Link</a>
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
          <textarea id="text-cont" rows="5"></textarea>
          <div class="row">
          <div class="col-sm-11"></div>
          <div class="col-sm-1">
            <button class="btn-primary" onclick="save()" style="width:100px;">Save</button>
        </div>
      </div>
    </div>
    </div>
      <div class="row">
        <div class="col-sm-12" style="margin-top:30px">
          <form method="POST" action="http://localhost:80/projects/wt/add.php">
          <div class="row">
          <div class="col-sm-0">
              <input type="text" value="<%=user%>" name="user" hidden>
          </div>
            <div class="col-sm-11">
              <input class="form-control mr-sm-2" name="content" type="search" placeholder="Search" aria-label="Search">
            </div>
            <div class="col-sm-1">  
              <button class="btn btn-warning my-2 my-sm-0" type="submit">Add</button>
            </div>
          </div>
          </form>
        </div>
        <%
           /* String[] bg = {"bg-primary","bg-secondary","bg-success","bg-danger","bg-warning","bg-info","bg-light","bg-dark"};
            String label = "Label";
            String title = "Title";
            String content = "Some quick example text to build on the card title and make up the bulk of the cards content.Some quick example text to build on the card title and make up the bulk of the cards content.Some quick example text to build on the card title and make up the bulk of the cards content.";

            for(int i=0;i<8;i++)
            {
                out.println("<div class=\"col-lg-3 col-md-4 col-sm-6 my-card\">\n<a data-toggle=\"collapse\" href=\"#collapseExample\" role=\"button\" onclick=\"setExpand(\'"+content+"',"+i+")\" aria-expanded=\"false\" aria-controls=\"collapseExample\">\n<div class=\"card "+(bg[i]=="bg-light"?"text-dark":"text-white")+" "+bg[i]+"\" style=\"max-width: 18rem;max-height: 14.4rem\">\n<div class=\"card-header\">"+label+"</div>\n<div class=\"card-body\"><h5 class=\"card-title\">"+title+"</h5><p class=\"card-text\">"+content+"</p></div></div></a></div>");
            }*/
              try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost/notes","root","Mysql@123");
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

                  out.println("<div class=\"col-lg-3 col-md-4 col-sm-6 my-card\">\n<a data-toggle=\"collapse\" href=\"#collapseExample\" role=\"button\" onclick=\"setExpand(\'"+content+"',"+i+")\" aria-expanded=\"false\" aria-controls=\"collapseExample\">\n<div class=\"card "+(bg[i]=="bg-light"?"text-dark":"text-white")+" "+bg[i]+"\" style=\"max-width: 18rem;max-height: 14.4rem\">\n<div class=\"card-header\">"+label+"</div>\n<div class=\"card-body\"><h5 class=\"card-title\">"+title+"</h5><p class=\"card-text\">"+content+"</p></div></div></a></div>");
                  i = (i<8)?i+1:0;
                  //out.println(id+" | "+title+" | "+label+" | "+content+"\n");                  
                }}
                catch(Exception e){
                   out.println(e);
                }
        %>
<script>
    var now;
    function setExpand(s,i){
        // document.getElementById('fullcont').innerHTML=s;
        document.getElementById('text-cont').value=s;
        now=i;
    }
    function save(){
        //save at index now
    }
    function addNote(){
      $.ajax({
                type: "GET",
                url: "http://localhost:80/projects/wt/add.php",
                dataType: "jsonp",
                data: {
                    user: '<%=user%>',
                    content: document.getElementById('new').value,
                },
                cache: false,
                success: function (html) {
                  alert(html);
                    // if(!html.match('Failed')){
                        // window.location.href="http://localhost:80/projects/wt/index.html";
                        // window.location.href="home.jsp?user="+a[0];
                    // }else{
                    //     alert(html.trim());
                    // }
                }
            });
    }
</script>
</body>
</html>

<%-- INSERT INTO `notes` (`user`, `title`, `date`, `content`) VALUES ('Adharsh', 'No title', current_timestamp(), 'Third note') --%>