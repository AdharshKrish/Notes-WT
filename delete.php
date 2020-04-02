<?php
    $con=mysqli_connect("localhost","root","","notes");
    $user = $_GET['user'];
    $id = $_GET['id'];
    $sql = "update notes set deleted=1 where id=".$id;
    // $sql = "delete from notes where id=".$id;
    $result = mysqli_query($con,$sql);
    if($result){
        echo 'done';
        // header("Location:http://localhost:8080/wt/home.jsp?user=".$user);
        // $_SESSION["uname"] = $uname;
    }else{
        echo 'failed';
    }


?>