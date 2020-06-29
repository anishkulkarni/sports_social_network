<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="login.css" />
<title>Dash</title>
</head>
<body>
<%@
page import="java.sql.*"
%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from Player where username=?;");
	st.setString(1,user);
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		String name = resultSet.getString("name");
		String dob = resultSet.getString("dateOfBirth");
		String email = resultSet.getString("email");
		String phone = resultSet.getString("phone");
		out.println("<table class=\"table table-hover\"><tr><td>Username</td><td>"+user+"</td></tr><tr><td>Name</td><td>"+name+"</td></tr><tr><td>Email</td><td>"+email+"</td></tr><tr><td>Phone</td><td>"+phone+"</td></tr><tr><td>Date of Birth</td><td>"+dob+"</td></tr></table>");
	}
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
/*try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select user1 from FriendRequests where user2=?;");
	st.setString(1,user);
	ResultSet resultSet = st.executeQuery();
	while(resultSet.next())
	{
		String friend = resultSet.getString("user1");
		out.println("<form action=\"addFriend\" method=\"post\"><input type=\"text\" name=\"username\" readonly value=\""+friend+"\"></input><input type=\"submit\" value=\"Add Friend\">");
	}
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select team1,sport,matchDate,matchTime from Matches where team2=? and status=\"Requested\";");
	st.setString(1,user);
	ResultSet resultSet = st.executeQuery();
	while(resultSet.next())
	{
		String friend = resultSet.getString("team1");
		String sport = resultSet.getString("sport");
		String matchDate = resultSet.getString("matchDate");
		int matchTime = resultSet.getInt("matchTime");
		out.println("<form action=\"addMatch\" method=\"post\">Name:<input type=\"text\" name=\"username\" readonly value=\""+friend+"\"></input><br>Sport:<input type=\"text\" name=\"sport\" readonly value=\""+sport+"\"></input><br>Date:<input type=\"text\" name=\"date\" readonly value=\""+matchDate+"\"></input><br>Time:<input type=\"text\" name=\"time\" readonly value=\""+matchTime+"\"></input><br><input type=\"submit\" value=\"Accept Match\">");
	}
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}*/
%>
<form method="link" action="logout.jsp">
    <input class="btn btn-lg btn-primary btn-block" type="submit" value="Logout"/>
</form>
<form method="post" action="broadcastMatch.jsp">
    <input class="btn btn-lg btn-primary btn-block" type="submit" value="Broadcast Match Request"/>
</form>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from acceptMatch where player1 <> ?;");
	st.setString(1,user);
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		out.print("<br><h3>Broadcasted Matches</h3>");
	}
	do
	{
		int id = resultSet.getInt("matchId");
		String name = resultSet.getString("player1");
		String sport = resultSet.getString("sportName");
		String venue = resultSet.getString("venueName");
		String date = resultSet.getString("matchDate");
		String time = resultSet.getString("matchTime");
		out.println("<form method=\"post\" action=\"acceptMatch\">matchId:<input type=\"text\" name=\"matchId\" value=\""+id+"\">Opponent:<input type=\"text\" name=\"opponent\" value=\""+name+"\" readonly>Sport: <input type=\"text\" name=\"sport\" value=\""+sport+"\" readonly>Venue: <input type=\"text\" name=\"venue\" value=\""+venue+"\" readonly>Date: <input type=\"text\" name=\"date\" value=\""+date+"\" readonly>Time: <input type=\"text\" name=\"time\" value=\""+time+"\" readonly><input type=\"submit\" value=\"Accept\"/></form>");
	}while(resultSet.next());
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from Matches where player1=? and status=\"accepted\";");
	st.setString(1,user);
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		out.print("<br><h3>Upcoming Matches</h3>");
	}
	do
	{
		int id = resultSet.getInt("matchId");
		String name = resultSet.getString("player2");
		String sport = resultSet.getString("sportName");
		int venue = resultSet.getInt("venueId");
		String date = resultSet.getString("matchDate");
		String time = resultSet.getString("matchTime");
		out.println("<form method=\"post\" action=\"finishMatch\">matchId:<input type=\"text\" name=\"matchId\" value=\""+id+"\">Opponent:<input type=\"text\" name=\"opponent\" value=\""+name+"\" readonly>Sport: <input type=\"text\" name=\"sport\" value=\""+sport+"\" readonly>Venue: <input type=\"text\" name=\"venue\" value=\""+venue+"\" readonly>Date: <input type=\"text\" name=\"date\" value=\""+date+"\" readonly>Time: <input type=\"text\" name=\"time\" value=\""+time+"\" readonly>Winner: <input type=\"text\" name=\"winner\" value=\"\"/>Score: <input type=\"text\" name=\"score\" value=\"\"/><input type=\"submit\" value=\"Finish\"/></form>");
	}while(resultSet.next());
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from Matches where player1=? and status=\"finished\";");
	st.setString(1,user);
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		out.print("<br><h3>Completed Matches</h3>");
	}
	do
	{
		int id = resultSet.getInt("matchId");
		String name = resultSet.getString("player2");
		String sport = resultSet.getString("sportName");
		int venue = resultSet.getInt("venueId");
		String date = resultSet.getString("matchDate");
		String time = resultSet.getString("matchTime");
		String winner = resultSet.getString("winner");
		String score = resultSet.getString("score");
		out.println("<form>matchId:<input type=\"text\" name=\"matchId\" value=\""+id+"\">Opponent:<input type=\"text\" name=\"opponent\" value=\""+name+"\" readonly>Sport: <input type=\"text\" name=\"sport\" value=\""+sport+"\" readonly>Venue: <input type=\"text\" name=\"venue\" value=\""+venue+"\" readonly>Date: <input type=\"text\" name=\"date\" value=\""+date+"\" readonly>Time: <input type=\"text\" name=\"time\" value=\""+time+"\" readonly>Winner: <input type=\"text\" name=\"winner\" value=\""+winner+"\"readonly/>Score: <input type=\"text\" name=\"score\" value=\""+score+"\"readonly/></form>");
	}while(resultSet.next());
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from Matches where player2=? and status=\"finished\";");
	st.setString(1,user);
	ResultSet resultSet = st.executeQuery();
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
		out.println("<form>matchId:<input type=\"text\" name=\"matchId\" value=\""+id+"\">Opponent:<input type=\"text\" name=\"opponent\" value=\""+name+"\" readonly>Sport: <input type=\"text\" name=\"sport\" value=\""+sport+"\" readonly>Venue: <input type=\"text\" name=\"venue\" value=\""+venue+"\" readonly>Date: <input type=\"text\" name=\"date\" value=\""+date+"\" readonly>Time: <input type=\"text\" name=\"time\" value=\""+time+"\" readonly>Winner: <input type=\"text\" name=\"winner\" value=\""+winner+"\"readonly/>Score: <input type=\"text\" name=\"score\" value=\""+score+"\"readonly/></form>");
	}
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from statistics where userId=?;");
	st.setString(1,user);
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		out.print("<h2>Statistics</h2>");
	}
	do
	{
		String sport = resultSet.getString("sportName");
		out.print("<h3>"+sport+"</h3>");
		int wins = resultSet.getInt("wins");
		int losses = resultSet.getInt("losses");
		int noResults = resultSet.getInt("noResults");
		out.println("Wins: "+wins+"Losses: "+losses+"No Results: "+noResults);
	}while(resultSet.next());
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
%>
</body>
</html>