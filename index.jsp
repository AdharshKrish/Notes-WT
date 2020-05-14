<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Notes</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap4.css">
    <script src="js/jquery.js"></script>
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script> -->
    <link href="https://fonts.googleapis.com/css?family=Oswald|Krona+One|Akronim|Odibee+Sans&display=swap" rel="stylesheet">
    <link href="img/favicon.ico" rel="icon" type="image/png" />
<style>
  body{
    background: #ffe4b1;
    overflow-x: hidden;
  }
signup .input{
    border: 1px solid #888;
    border-radius: 3px;
    padding: 5px;
    width:405px;
    margin:10px 0;
  background-color: #fcf2e1;
}
signup .input::placeholder{
    color: #ccc;
}
signup button{
    width:200px;
    height: 40px;
    border: 1px solid #888;
    border-radius: 5px;
    margin: 10px 0;
    color: white;
    min-width: 194px;
    padding: 7px 20px;
    font-family: Arial;
    font-weight: 750;
    background: linear-gradient(#67ae55, #578843);
    background-color: #69a74e;
    box-shadow: inset 0 1px 1px #a4e388;
    border-color: #3b6e22 #3b6e22 #2c5115;
}
signup h6{
    color: #888;
}
signup .radio{
    margin: 20px 0 20px 20px;
}
h1{
  /* font-family: 'Krona One'; */
  font-family: 'Akronim';
  font-size: 70px;
  /* font-weight: 600; */
}
login input{
  height:25px;
  background-color: #ffe4b1;
  border:1px solid #000;
  margin-right: 10px;
  padding:3px;
  /* border-radius: 10px; */
}
login label{
  font-size: 12px;
}
login{
  font-size: 12px;
}
#time{
  font-family: 'Odibee Sans';
  position: absolute;
  top:35px;
  left:3vw;
}
.col-time{
  position: relative;
} 
@media screen and (max-width: 770px) {
  #login-img{
    display: none;
  }
  #time{
    top:30px;
    margin-left:55vw;
  }
  signup .input{
    width:200px;
  }
  .col-time{
    position: static;
  }
}
@media screen and (max-width: 570px) {
  signup .input{
    width:200px;
  }
}
</style>
</head>
<body> 
    <div class="row" style="background-color: orange;padding-top: 10px;position: relative;">
        <div class="col-lg-2 col-md-5 col-sm-12" style="padding-left:40px;color:#0000ff">
          <h1>Notes</h1>
        </div>
          <div class="col-lg-3 col-md-7 col-sm-12 col-time" style="height:1px">
            <time id="time"></time>
            <%
if(session.getAttribute("user")!= null)
{
Cookie ck = new Cookie("lastlog",session.getAttribute("user").toString());
ck.setMaxAge(60*60*24*7);
response.addCookie(ck);
response.sendRedirect("http://localhost:8080/wt/home.jsp");
}
String cook = "";
Cookie c[] = request.getCookies();
for(Cookie cookie:c){  
  if(cookie.getName().equals("lastlog")){      
    cook = cookie.getValue();
  }
}
            %>
          </div>
        <div class="col-lg-7 col-md-12 col-sm-12" style="padding:10px 0 10px 80px">
            <login style="position:relative;left:15vw">
              <!-- <form method="GET" action="localhost:8080/wt/servlets/servlet/session"> -->
              <div class="row">
                <div class="col-xl-3 col-lg-12">
                Email<br> <input type="text" name="user" value="<%=cook%>" class="ensen" id="input0" >
                </div>
              <div class="col-xl-5 col-lg-12">
                Password<br> <input type="password" name="pass" class="ensen" id="input1">
                <input type="button" onclick="login()" value="login">
              </div>
              <div class="col-12" style="margin-top:10px;">
                <%
                  if(cook!="")
                  {
                    out.println("Last logged in user is "+cook);
                  }
                %>
                </div>
            </div>
            </login>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6 col-md-4" id="login-img" style="padding: 100px 100px;">
          <img src="img/sticky-notes.png" style="height:25vw" alt="">
        </div>
        <div class="col-lg-6 col-md-8" style="padding-left:40px">
        <signup style="position:relative;top:50px;">
            <h2>Create an account</h2>
          <form action="http://localhost:8080/wt/register.jsp">
            <input class="input" style="width: 200px;" type="text" name="fname" placeholder="First Name">
            <input class="input" style="width: 200px;" type="text" name="lname" placeholder="Last Name"><br>
            <input class="input" type="text" name="email" placeholder="Email address"><br>
            <input class="input" type="password" name="pass" placeholder="New password"><br>
            <h6>Birthday</h6>
            <input type="date" class="input" name="dob" name="birthday">
            <h6>Gender</h6>
            <input class="radio" type="radio" name="gender" value="male">Male</input>
            <input class="radio" type="radio" name="gender" value="female">Female</input>
            <input class="radio" type="radio" name="gender" value="custom">Custom</input><br>
            <button type="submit">Signup</button>
          </form>
        </signup>
    </div>
    </div>
</body>
<script>
    function login(){
        let a = new Array();
        for(var i=0; i<2;i++)
            a[i] = document.getElementById('input'+i).value;
        console.log(a[0]+a[1]);
        if(a[0] == "" || a[1] == "")
        {
            alert("please fill the fields");
        }else{
            $.ajax({
                type: "GET",
                url: "servlets/servlet/session",
                data: {
                    user: a[0],
                    pass: a[1],
                },
                cache: false,
                success: function (html) {
                    if(!html.match('Invalid user')){
                        window.location.href="index.jsp";
                    }else{
                        alert(html.trim());
                    }
                }
            });
        }
    }

    startTime();
    function startTime() {
    var d = new Date();
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    var date = "";
    var hours = d.getHours();
    var minutes = d.getMinutes();
    var second = d.getSeconds();
    var ampm = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    hours = hours ? hours : 12;
    minutes = minutes < 10 ? '0'+minutes : minutes;
    second = second <10? '0'+second:second;
    var strTime = hours + ':' + minutes +':' + second +' ' + ampm;
    date=months[d.getMonth()]+" "+d.getDate()+" "+d.getFullYear()+" | "+strTime;
    document.getElementById('time').innerHTML=date;
    var t = setTimeout(startTime, 500);
}
    

document.querySelectorAll('.ensen').forEach(input=>{
  input.addEventListener("keyup", function(event) {
    if (event.keyCode === 13) {
      event.preventDefault();
      login();
    }
  });
})

</script>
</html>
