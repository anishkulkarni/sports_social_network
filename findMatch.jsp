<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="login.css" />
</head>
<body>
 <div class="wrapper">
    <form class="form-signin" action="SetupMatch" method="post">       
      <h2 class="form-signin-heading">Enter Details</h2>
      <br>
      <input type="text" class="form-control" name="username" placeholder="Opponent Username" required="" autofocus="" />
      <br>
      <input type="text" class="form-control" name="sport" placeholder="Sport" required=""/>
      <br>
      <input type="text" class="form-control" name="date" placeholder="Date" required=""/>
      <br>
      <input type="text" class="form-control" name="time" placeholder="Time (24h)" required=""/>
      <br>
      <button class="btn btn-lg btn-primary btn-block" type="submit">Create</button> 
    </form>
  </div>
</body>
</html>