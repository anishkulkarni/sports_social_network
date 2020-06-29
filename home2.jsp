<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Home</title>

  <!-- Bootstrap core CSS -->
  <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0/dist/Chart.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

  <!-- Custom fonts for this template -->
  <link href="https://fonts.googleapis.com/css?family=Saira+Extra+Condensed:500,700" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Muli:400,400i,800,800i" rel="stylesheet">
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="css/resume.min.css" rel="stylesheet">

</head>

<body id="page-top">
<%@
page import="java.sql.*"
%>
<%!
String name = null;
String dob = null;
String email = null;
String phone = null;
String user = null;
String sport = null;
String venue = null;
String date = null;
String time = null;
int venueId=0;
int wins[]= new int[10];
int losses[]= new int [10];
int noResults[]= new int[10];
String sports[] = new String[10];
int count=0;
%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from Player where username=?;");
	st.setString(1,user);
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		name = resultSet.getString("name");
		dob = resultSet.getString("dateOfBirth");
		email = resultSet.getString("email");
		phone = resultSet.getString("phone");
		//out.println("<table class=\"table table-hover\"><tr><td>Username</td><td>"+user+"</td></tr><tr><td>Name</td><td>"+name+"</td></tr><tr><td>Email</td><td>"+email+"</td></tr><tr><td>Phone</td><td>"+phone+"</td></tr><tr><td>Date of Birth</td><td>"+dob+"</td></tr></table>");
	}
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
%>
 <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top" id="sideNav">
    <a class="navbar-brand js-scroll-trigger" href="#about">
      <span class="d-block d-lg-none"></span>
      <span class="d-none d-lg-block">
        <h4 class="mb-0"><%out.print(user); %></h4>
      </span>
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#about">About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#broadcasted">Broadcasted Matches</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#upcoming">Upcoming Matches</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#completed">Completed Matches</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#statistics">Statistics</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#statistics_graphs">Statistics Graphs</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#newmatch">New Match</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#addfriend">Add Friend</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#friendrequests">Friend Requests</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#friends">Friends</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#friendrequestmatches">Friend Requested Matches</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="#resources">Resources</a>
        </li>
        <li class="nav-item">
          <a class="nav-link js-scroll-trigger" href="logout.jsp">Sign Out</a>
        </li>
      </ul>
    </div>
  </nav>
  <div class="container-fluid p-0">

    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="about">
      <div class="w-100">
        <h1 class="mb-0">Name<br><%out.print(name);%>
        </h1>
	<br>
        <div class="subheading mb-5">Email<br><%out.print(email);%></div>
        <div class="subheading mb-5">Birth Date<br><%out.print(dob); %>
        </div>
        <div class="subheading mb-5">Phone<br><%out.print(phone);%>
        </div>
      </div>
    </section>

    <hr class="m-0">

    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="broadcasted">
	<div class="card-columns">
	<%
	try
	{
		Class.forName("com.mysql.jdbc.Driver");  
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
		String user = (String)session.getAttribute("username");
		PreparedStatement st = con.prepareStatement("select * from acceptMatch where player1 <> ?;");
		st.setString(1,user);
		ResultSet resultSet = st.executeQuery();
		while(resultSet.next())
		{
			int id = resultSet.getInt("matchId");
			name = resultSet.getString("player1");
			sport = resultSet.getString("sportName");
			venue = resultSet.getString("venueName");
			date = resultSet.getString("matchDate");
			time = resultSet.getString("matchTime");
			PreparedStatement st2 = con.prepareStatement("select level from statistics where sportName=? and userId=?;");
			st2.setString(1,sport);
			st2.setString(2,name);
			ResultSet rs2 = st2.executeQuery();
			rs2.next();
			int level = rs2.getInt("level");
			out.println("<div class=\"card p-3\"><form method=\"post\" action=\"acceptMatch\"><table><tr><td>matchId</td><td><input class=\"border-0\" type=\"text\" name=\"matchId\" value=\""+id+"\"></td></tr><tr><td>Opponent</td><td><input class=\"border-0\" type=\"text\" name=\"opponent\" value=\""+name+"\" readonly></td></tr><tr><td>Opponent level</td><td>"+level+"</td></tr><tr><td>Sport</td><td><input class=\"border-0\" type=\"text\" name=\"sport\" value=\""+sport+"\" readonly></td></tr><td>Venue</td><td><input class=\"border-0\" type=\"text\" name=\"venue\" value=\""+venue+"\" readonly></td></tr><tr><td>Date</td><td><input class=\"border-0\" type=\"text\" name=\"date\" value=\""+date+"\" readonly></td></tr><tr><td>Time</td><td><input class=\"border-0\" type=\"text\" name=\"time\" value=\""+time+"\" readonly></td></tr><tr><td align=\"center\"><input type=\"submit\" value=\"Accept\"/></td></tr></table></form></div>");
		}
		st.close(); 
		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace(); 
	}
	%>
	</div>
    </section>

    <hr class="m-0">

    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="upcoming">
     <div class="card-columns">
<%
			try
			{
				Class.forName("com.mysql.jdbc.Driver");  
				Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
				String user = (String)session.getAttribute("username");
				PreparedStatement st = con.prepareStatement("select * from Matches where player1=? and status=\"accepted\";");
				st.setString(1,user);
				ResultSet resultSet = st.executeQuery();
				while(resultSet.next())
				{
					int id = resultSet.getInt("matchId");
					String name = resultSet.getString("player2");
					String sport = resultSet.getString("sportName");
					int venue = resultSet.getInt("venueId");
					String date = resultSet.getString("matchDate");
					String time = resultSet.getString("matchTime");
					out.println("<div class=\"card p-3\"><form method=\"post\" action=\"finishMatch\"><table><tr><td>matchId</td><td><input class=\"border-0\" type=\"text\" name=\"matchId\" value=\""+id+"\"></td></tr><tr><td>Opponent</td><td><input class=\"border-0\" type=\"text\" name=\"opponent\" value=\""+name+"\" readonly></td></tr><tr><td>Sport</td><td><input class=\"border-0\" type=\"text\" name=\"sport\" value=\""+sport+"\" readonly></td></tr><tr><td>Venue</td><td><input class=\"border-0\" type=\"text\" name=\"venue\" value=\""+venue+"\" readonly></td</tr><tr><td>Date</td><td><input class=\"border-0\" type=\"text\" name=\"date\" value=\""+date+"\" readonly></td></tr><tr><td>Time</td><td><input class=\"border-0\" type=\"text\" name=\"time\" value=\""+time+"\" readonly></td></tr><tr><td>Winner</td><td><input type=\"text\" name=\"winner\" value=\"\"/></td></tr><tr><td>Score</td><td><input type=\"text\" name=\"score\" value=\"\"/></td></tr><tr><td><input type=\"submit\" value=\"Finish\"/></td></tr></table></form></div>");
				}
				st.close(); 
				con.close();
			}
			catch (Exception e)
			{
				e.printStackTrace(); 
			}
%> 
	</div>
    </section>

    <hr class="m-0">

    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="completed">
      <div class="card-columns">
      <%
      try
      {
      	Class.forName("com.mysql.jdbc.Driver");  
      	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
      	String user = (String)session.getAttribute("username");
      	PreparedStatement st = con.prepareStatement("select * from Matches where player1=? and status=\"finished\";");
      	st.setString(1,user);
      	ResultSet resultSet = st.executeQuery();
      	while(resultSet.next())
      	{
      		int id = resultSet.getInt("matchId");
      		String name = resultSet.getString("player2");
      		String sport = resultSet.getString("sportName");
      		int venue = resultSet.getInt("venueId");
      		String date = resultSet.getString("matchDate");
      		String time = resultSet.getString("matchTime");
      		String winner = resultSet.getString("winner");
      		String score = resultSet.getString("score");
      		out.println("<div class=\"card p-3\"><form><table><tr><td>matchId</td><td><input class=\"border-0\" type=\"text\" name=\"matchId\" value=\""+id+"\"></td></tr><tr><td>Opponent</td><td><input class=\"border-0\" type=\"text\" name=\"opponent\" value=\""+name+"\" readonly></td></tr><tr><td>Sport</td><td><input class=\"border-0\" type=\"text\" name=\"sport\" value=\""+sport+"\" readonly></td></tr><tr><td>Venue</td><td><input class=\"border-0\" type=\"text\" name=\"venue\" value=\""+venue+"\" readonly></td></tr><tr><td>Date</td><td><input class=\"border-0\" type=\"text\" name=\"date\" value=\""+date+"\" readonly></td></tr><tr><td>Time</td><td><input class=\"border-0\" type=\"text\" name=\"time\" value=\""+time+"\" readonly></td></tr><tr><td>Winner</td><td><input class=\"border-0\" type=\"text\" name=\"winner\" value=\""+winner+"\"readonly/></td></tr><tr><td>Score</td><td><input class=\"border-0\" type=\"text\" name=\"score\" value=\""+score+"\"readonly/></td></tr></table></form></div>");
      	}
      	st.close();
      	st = con.prepareStatement("select * from Matches where player2=? and status=\"finished\";");
      	st.setString(1,user);
      	resultSet = st.executeQuery();
      	while(resultSet.next())
      	{
      		int id = resultSet.getInt("matchId");
      		String name = resultSet.getString("player1");
      		String sport = resultSet.getString("sportName");
      		int venue = resultSet.getInt("venueId");
      		String date = resultSet.getString("matchDate");
      		String time = resultSet.getString("matchTime");
      		String winner = resultSet.getString("winner");
      		String score = resultSet.getString("score");
      		out.println("<div class=\"card p-3\"><form><table><tr><td>matchId</td><td><input class=\"border-0\" type=\"text\" name=\"matchId\" value=\""+id+"\"></td></tr><tr><td>Opponent</td><td><input class=\"border-0\" type=\"text\" name=\"opponent\" value=\""+name+"\" readonly></td></tr><tr><td>Sport</td><td><input class=\"border-0\" type=\"text\" name=\"sport\" value=\""+sport+"\" readonly></td></tr><tr><td>Venue</td><td><input class=\"border-0\" type=\"text\" name=\"venue\" value=\""+venue+"\" readonly></td></tr><tr><td>Date</td><td><input class=\"border-0\" type=\"text\" name=\"date\" value=\""+date+"\" readonly></td></tr><tr><td>Time</td><td><input class=\"border-0\" type=\"text\" name=\"time\" value=\""+time+"\" readonly></td></tr><tr><td>Winner</td><td><input class=\"border-0\" type=\"text\" name=\"winner\" value=\""+winner+"\"readonly/></td></tr><tr><td>Score</td><td><input class=\"border-0\" type=\"text\" name=\"score\" value=\""+score+"\"readonly/></td></tr></table></form></div>");
      	}
      	st.close(); 
      	con.close();
      }
      catch (Exception e)
      {
      	e.printStackTrace(); 
      }
      %>
	</div>
    </section>
	<%
	try
	{
		Class.forName("com.mysql.jdbc.Driver");  
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
		String user = (String)session.getAttribute("username");
		PreparedStatement st = con.prepareStatement("select * from statistics where userId=?;");
		st.setString(1,user);
		ResultSet resultSet = st.executeQuery();
		int count=0;
		while(resultSet.next())
		{
			String sport = resultSet.getString("sportName");
			int win = resultSet.getInt("wins");
			int loss = resultSet.getInt("losses");
			int noResult = resultSet.getInt("noResults");
			wins[count]=win;
			losses[count]=loss;
			noResults[count]=noResult;
			sports[count]=sport;
			count++;
		}
		count--;
		st.close(); 
		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace(); 
	}
	%>
    <hr class="m-0">

    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="statistics">
    <div class="card-columns">
    <%
    try
	{
		Class.forName("com.mysql.jdbc.Driver");  
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
		String user = (String)session.getAttribute("username");
		PreparedStatement st = con.prepareStatement("call stats(?);");
		st.setString(1,user);
		ResultSet resultSet = st.executeQuery();
		while(resultSet.next())
		{
			String sport = resultSet.getString("sportName");
			int wins = resultSet.getInt("wins");
			int losses = resultSet.getInt("losses");
			int noResults = resultSet.getInt("noResults");
			int level = resultSet.getInt("level");
			out.println("<div class=\"card\"><table margin=5 padding=5 cellpadding=\"10\"><tr colspan=2><td><h4>"+sport+"</h4></td></tr><tr colspan=2><td><h4>Level "+level+"</h4></td></tr><tr><td>Wins</td><td>"+wins+"</td></tr><tr><td>Losses</td><td>"+losses+"</td></tr><tr><td>No Results</td><td>"+noResults+"</td></tr></table></div>");
		}
		st.close(); 
		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace(); 
	}
	%>
	</div>
    </section>
    
    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="statistics_graphs">
    <div class="card-columns">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    <%
    try
	{
		Class.forName("com.mysql.jdbc.Driver");  
		Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
		String user = (String)session.getAttribute("username");
		PreparedStatement st = con.prepareStatement("select name from Sport;");
		ResultSet resultSet = st.executeQuery();
		while(resultSet.next())
		{
			String name = resultSet.getString("name");
			try
			{
				PreparedStatement st2 = con.prepareStatement("select * from statistics where userId=? and sportName=?;");
				st2.setString(1,user);
				st2.setString(2,name);
				ResultSet resultSet2 = st2.executeQuery();
				while(resultSet2.next())
				{
					int wins = resultSet2.getInt("wins");
					int losses = resultSet2.getInt("losses");
					int noResults = resultSet2.getInt("noResults");
					out.print("<div class=\"card\">");
					out.print("<h3>"+name+"</h3>");
					out.print("<canvas id=\"myChart"+name+"\"></canvas>");
				    out.print("<script>var ctx = document.getElementById(\"myChart"+name+"\").getContext('2d');var myChart = new Chart(ctx,{type: 'pie',data: {labels: [\"Wins\",\"Losses\",\"No Results\"],datasets: [{backgroundColor: [\"#2ecc71\",\"#3498db\",\"#95a5a6\",],data: ["+wins+","+losses+","+noResults+"]}]}});</script>");
					out.print("</div>");
				}
				st2.close();
			}
			catch (Exception e)
			{
				e.printStackTrace(); 
			}
		}
		st.close();
		con.close();
	}
	catch (Exception e)
	{
		e.printStackTrace(); 
	}
    //out.print("<script>var ctx = document.getElementById(\"myChart\").getContext('2d');var myChart = new Chart(ctx,{type: 'pie',data: {labels: [\"Wins\",\"Losses\",\"No Results\"],datasets: [{backgroundColor: [\"#2ecc71\",\"#3498db\",\"#95a5a6\",],data: [5,7,9]}]}});</script>");
    %>
    </div>
    </section>
    
    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="newmatch">
    <div class="card-columns">
    <div class="card">
    	<form method="post" action="broadcastMatch">
    	<table cellpadding="10">
    	<tr><td>
		<label for="sport">Choose Sport</label></td>
		 <td><select name="sport">
		 <%
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			String user = (String)session.getAttribute("username");
			PreparedStatement st = con.prepareStatement("select * from Sport;");
			ResultSet resultSet = st.executeQuery();
			while(resultSet.next())
			{
				String name = resultSet.getString("name");
				out.println("<option>"+name+"</option>");
			}
			st.close(); 
			con.close();
		}
		catch (Exception e)
		{
			e.printStackTrace(); 
		}
		%>
		</select></td></tr>
		<tr><td>
		<label for="venue">Choose Sport</label></td>
		<td><select name="venue">
		 <%
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			String user = (String)session.getAttribute("username");
			PreparedStatement st = con.prepareStatement("select * from Venue;");
			ResultSet resultSet = st.executeQuery();
			while(resultSet.next())
			{
				String name = resultSet.getString("name");
				out.println("<option>"+name+"</option>");
			}
			st.close(); 
			con.close();
		}
		catch (Exception e)
		{
			e.printStackTrace(); 
		}
		%>
		</select></td></tr>
		<tr>
		<td>Date</td>
		<td><input type="text" name="date" placeholder="Date"/></td></tr>
		<tr><td>Time</td><td><input type="text" name="time" placeholder="Time"/></td></tr>
		
		<tr><td><input type="submit" value="submit"></input></td></tr>
		</table>
		</form>
		</div>
		</div>
		</section>
		<section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="addfriend">
   		<div class="card-columns">
   		<div class="card">
   		<form action="friendRequest" method="post">
   		<table>
   		<tr>
   		<td colspan=2>
      	<h2 class="form-signin-heading">Enter Details</h2>
      	</td>
      	</tr>
      	<br>
      	<tr>
      	<td>
      	Friend Username
      	</td>
      	<td>
      	<input type="text" class="form-control" name="username" placeholder="Friend Username" required="" autofocus="" />
      	</td>
      	</tr>
      	<tr>
      	<td colspan=2>
      	<input type="submit" value="Send Request"></input>
      	</td>
      	</tr>
      	</table>
    	</form>
   		</div>
	    </div>
	    </section>
	    
	    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="friendrequests">
	    <div class="card-columns">
	    <%
	    try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			String user = (String)session.getAttribute("username");
			PreparedStatement st = con.prepareStatement("select player1 from friendRequest where player2=?;");
			st.setString(1,user);
			ResultSet resultSet = st.executeQuery();
			while(resultSet.next())
			{
				String friend = resultSet.getString("player1");
				out.println("<div class=\"card\"><form method=\"post\" action=\"addFriend\"><table cellpadding=\"10\"><tr><td>Name</td><td><input type=\"text\" name=\"friend\" value=\""+friend+"\" readonly></td></tr><tr><td><input type=\"submit\" value=\"Accept\"></td></tr></table></form></div>");
			}
			st.close(); 
			con.close();
		}
		catch (Exception e)
		{
			e.printStackTrace(); 
		}
	    %>
	    </div>
	    </section>
	    
	    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="friends">
	    <div class="card-columns">
	    <%
	    try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			String user = (String)session.getAttribute("username");
			PreparedStatement st = con.prepareStatement("select player1 from friend where player2=?;");
			st.setString(1,user);
			ResultSet resultSet = st.executeQuery();
			while(resultSet.next())
			{
				String friend = resultSet.getString("player1");
				out.print("<div class=\"card\"><form method=\"post\" action=\"requestFriendMatch\">");
				out.print("<table class=\"table\">");
				out.print("<tr><td colspan=2><h2><input type=\"text\" name=\"name\" value=\""+friend+"\"></h2></td></tr>");
				out.print("<tr><td>Sport</td><td><select name=\"sport\">");
				PreparedStatement st2 = con.prepareStatement("select name from Sport");
				ResultSet rs2 = st2.executeQuery();
				while(rs2.next())
				{
					String name = rs2.getString("name");
					out.print("<option>"+name+"</option>");
				}
				out.print("</select></td></tr>");
				out.print("<tr><td>Venue</td><td><select name=\"venue\">");
				st2.close();
				st2 = con.prepareStatement("select name from Venue");
				rs2 = st2.executeQuery();
				while(rs2.next())
				{
					String name = rs2.getString("name");
					out.print("<option>"+name+"</option>");
				}
				st2.close();
				out.print("</select></td></tr>");
				out.print("<tr><td>Date</td><td><input type=\"text\" name=\"date\" placeholder=\"Date\"/></td></tr>");
				out.print("<tr><td>Time</td><td><input type=\"text\" name=\"time\" placeholder=\"Time\"/></td></tr>");
				out.print("<tr><td colspan=2><input type=\"submit\" value=\"Submit\"/></td></tr>");
				out.print("</table>");
				out.print("</form></div>");
			}
			st.close();
			st = con.prepareStatement("select player2 from friend where player1=?;");
			st.setString(1,user);
			resultSet = st.executeQuery();
			while(resultSet.next())
			{
				String friend = resultSet.getString("player2");
				out.print("<div class=\"card\"><form method=\"post\" action=\"requestFriendMatch\">");
				out.print("<table class=\"table\">");
				out.print("<tr><td colspan=2><h2><input type=\"text\" name=\"name\" value=\""+friend+"\"></h2></td></tr>");
				out.print("<tr><td>Sport</td><td><select name=\"sport\">");
				PreparedStatement st2 = con.prepareStatement("select name from Sport");
				ResultSet rs2 = st2.executeQuery();
				while(rs2.next())
				{
					String name = rs2.getString("name");
					out.print("<option>"+name+"</option>");
				}
				out.print("</select></td></tr>");
				out.print("<tr><td>Venue</td><td><select name=\"venue\">");
				st2.close();
				st2 = con.prepareStatement("select name from Venue");
				rs2 = st2.executeQuery();
				while(rs2.next())
				{
					String name = rs2.getString("name");
					out.print("<option>"+name+"</option>");
				}
				st2.close();
				out.print("</select></td></tr>");
				out.print("<tr><td>Date</td><td><input type=\"text\" name=\"date\" placeholder=\"Date\"/></td></tr>");
				out.print("<tr><td>Time</td><td><input type=\"text\" name=\"time\" placeholder=\"Time\"/></td></tr>");
				out.print("<tr><td colspan=2><input type=\"submit\" value=\"Submit\"/></td></tr>");
				out.print("</table>");
				out.print("</form></div>");
			}
			st.close(); 
			con.close();
		}
		catch (Exception e)
		{
			e.printStackTrace(); 
		}
	    %>
	    </div>
	    </section>
	    
	    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="friendrequestmatches">
	    <div class="card-columns">
	    <%
	    try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			String user = (String)session.getAttribute("username");
			PreparedStatement st = con.prepareStatement("select * from Matches where status=\"friendrequested\" and player2=?;");
			st.setString(1,user);
			ResultSet resultSet = st.executeQuery();
			while(resultSet.next())
			{
				int id = resultSet.getInt("matchId");
				name = resultSet.getString("player1");
				sport = resultSet.getString("sportName");
				venueId = resultSet.getInt("venueId");
				date = resultSet.getString("matchDate");
				time = resultSet.getString("matchTime");
				PreparedStatement st2 = con.prepareStatement("select level from statistics where sportName=? and userId=?;");
				st2.setString(1,sport);
				st2.setString(2,name);
				ResultSet rs2 = st2.executeQuery();
				rs2.next();
				int level = rs2.getInt("level");
				out.println("<div class=\"card p-3\"><form method=\"post\" action=\"acceptMatch\"><table><tr><td>matchId</td><td><input class=\"border-0\" type=\"text\" name=\"matchId\" value=\""+id+"\"></td></tr><tr><td>Opponent</td><td><input class=\"border-0\" type=\"text\" name=\"opponent\" value=\""+name+"\" readonly></td></tr><tr><td>Opponent level</td><td>"+level+"</td></tr><tr><td>Sport</td><td><input class=\"border-0\" type=\"text\" name=\"sport\" value=\""+sport+"\" readonly></td></tr><td>Venue</td><td><input class=\"border-0\" type=\"text\" name=\"venue\" value=\""+venueId+"\" readonly></td></tr><tr><td>Date</td><td><input class=\"border-0\" type=\"text\" name=\"date\" value=\""+date+"\" readonly></td></tr><tr><td>Time</td><td><input class=\"border-0\" type=\"text\" name=\"time\" value=\""+time+"\" readonly></td></tr><tr><td align=\"center\"><input type=\"submit\" value=\"Accept\"/></td></tr></table></form></div>");
			}
			st.close(); 
			con.close();
		}
		catch (Exception e)
		{
			e.printStackTrace(); 
		}
	    %>
	    </div>
	    </section>
	    
	    <section class="resume-section p-3 p-lg-5 d-flex align-items-center" id="resources">
	    <div class="card-columns">
	    <%
	    try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			String user = (String)session.getAttribute("username");
			PreparedStatement st = con.prepareStatement("select * from resources;");
			ResultSet resultSet = st.executeQuery();
			while(resultSet.next())
			{
				String sport = resultSet.getString("sportName");
				String title = resultSet.getString("resTitle");
				String link = resultSet.getString("resLink");
				out.println("<div class=\"card\"><h4><table class=\"table\"><tr><td>Sport</td><td>"+sport+"</td></tr><tr><td>Title</td><td>"+title+"</td></tr><tr><td>Link</td><td><a href=\""+link+"\">Click Here</a></td></tr></table></h4></div>");
			}
			st.close(); 
			con.close();
		}
		catch (Exception e)
		{
			e.printStackTrace(); 
		}
	    %>
	    </div>
	    </section>

</div>

  <!-- Bootstrap core JavaScript -->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom scripts for this template -->
  <script src="js/resume.min.js"></script>
</body>

</html>