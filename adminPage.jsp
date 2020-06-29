<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Admin Page</title>
</head>
<body>
<h1>Admin Page</h1>
<%@
page import="java.sql.*"
%>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from Venue;");
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		out.println("<h2>Current Venues:</h2>");
	}
	do
	{
		String name = resultSet.getString("name");
		out.println("<h3>"+name+"</h3>");
	}while(resultSet.next());
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
%>
<br>
<h2>Add New Venue</h2>
<form method="post" action="addVenue">
<input type="text" name="vname" placeholder="Venue Name"/>
<input type="text" name="vlocation" placeholder="Venue Location"/>
<input type="submit" value="submit"/>
</form>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from Sport;");
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		out.println("<h2>Current Sports:</h2>");
	}
	do
	{
		String name = resultSet.getString("name");
		out.println("<h3>"+name+"</h3>");
	}while(resultSet.next());
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
%>
<h2>Add New Sport</h2>
<form method="post" action="addSport">
<input type="text" name="sname" placeholder="Sport Name"/>
<input type="submit" value="submit"/>
</form>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select * from resources order by sportName;");
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		out.println("<h2>Current Resources:</h2>");
	}
	out.print("<table class=\"table-striped table-bordered w-50 m-5 p-5\">");
	do
	{
		String sport = resultSet.getString("sportName");
		String title = resultSet.getString("resTitle");
		String link = resultSet.getString("resLink");
		out.println("<tr><td>"+sport+"</td><td>"+title+"</td><td><a href="+link+">click here</a></td></tr>");
	}while(resultSet.next());
	out.print("</table>");
	st.close(); 
	con.close();
}
catch (Exception e)
{
	e.printStackTrace(); 
}
%>
<br>
<h2>Add New Resource</h2>
<form method="post" action="addResource">
<select name="sport">
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
</select>
<input type="text" name="title" placeholder="Resource Title"/>
<input type="text" name="link" placeholder="Resource Link"/>
<input type="submit" value="submit"/>
</form>
<br>
<br>
<form method="link" action="logout.jsp">
    <input class="button" type="submit" value="Logout"/>
</form>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");  
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
	String user = (String)session.getAttribute("username");
	PreparedStatement st = con.prepareStatement("select userId, statistics.sportName, statistics.level from statistics inner join (select sportName, max(level) as level from statistics group by sportName) as maximums on statistics.sportName=maximums.sportName and statistics.level=maximums.level;");
	ResultSet resultSet = st.executeQuery();
	if(resultSet.next())
	{
		out.println("<h2>Leaderboard:</h2>");
	}
	do
	{
		String name = resultSet.getString("userId");
		String sport = resultSet.getString("sportName");
		int level = resultSet.getInt("level");
		out.println("<h3>"+sport+"</h3><h5>Player: "+name+"<br>Level: "+level+"</h5>");
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