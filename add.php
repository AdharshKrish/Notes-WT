<?php

    $con=mysqli_connect("localhost","root","","notes");

    // if(isset($_POST['user'])){
        $user = $_POST['user'];
        $inter = str_replace("'","\'",$_POST['content']);
        $c = str_replace('"','\"',$inter);
        // session_start();
        $sql = "insert into notes (user, date, content) VALUES ('".$user."', date_format(now(),'%r %d/%m/%Y'), '".$c."')";

        $result = mysqli_query($con,$sql);
        if($result){
            header("Location:http://localhost:8080/wt/home.jsp");
            // $_SESSION["uname"] = $uname;
        }else{
            echo 'failed';
        }
    // }

?>