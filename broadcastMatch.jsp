<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@
page import="java.sql.*"
%>
<form method="post" action="broadcastMatch">
<label for="sport">Choose Sport</label>
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
<label for="venue">Choose Sport</label>
 <select name="venue">
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
</select>
<input type="text" name="date" placeholder="Date"/>
<input type="text" name="time" placeholder="Time"/>
<input type="submit" value="submit"/>
</form>
</body>
</html>