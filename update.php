<?php

    
$con=mysqli_connect("localhost","root","","notes");

// if(isset($_POST['user'])){
    $temp = str_replace("'","\'",$_POST['title']);
    $t = str_replace('"','\"',$temp);
    $temp = str_replace("'","\'",$_POST['content']);
    $c = str_replace('"','\"',$temp);
    $user = $_POST['user'];
    $id = $_POST['id'];
    // session_start();
    $sql = "update notes set content='".$c."', title='".$t."' where id=".$id;
    $result = mysqli_query($con,$sql);
    if($result){
        // echo 'success '.$sql;
        header("Location:http://localhost:8080/wt/home.jsp");
        // $_SESSION["uname"] = $uname;
    }else{
        echo 'failed '.$sql;
    }


?>