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
    <form class="form-signin" action="friendRequest" method="post">       
      <h2 class="form-signin-heading">Enter Details</h2>
      <br>
      <input type="text" class="form-control" name="username" placeholder="Friend Username" required="" autofocus="" />
      <button class="btn btn-lg btn-primary btn-block" type="submit">Send Request</button> 
    </form>
  </div>
</body>
</html>