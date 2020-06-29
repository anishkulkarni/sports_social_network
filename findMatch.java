import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/findMatch")
public class findMatch extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html");
		HttpSession session=request.getSession(false);
		String user=(String)session.getAttribute("username");
		String opponent=request.getParameter("username");
		String sport=request.getParameter("sport");
		String date=request.getParameter("date");
		String time=request.getParameter("time");
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			PreparedStatement st = con.prepareStatement("insert into Matches(team1,team2,sport,status,score,matchDate,matchTime) values()");
			st.setString(1,user);
			st.setString(2,fname);
			st.setString(3,lname);
			st.setString(4,email);
			st.setString(5,phone);
			st.setString(6,dob);
			st.setString(7,pass);
			st.executeUpdate();
			st = con.prepareStatement("insert into Team values(?,\"all\",0,0,0,0)");
			st.setString(1,user);
			st.executeUpdate();
			st.close(); 
			con.close();
			result.sendRedirect("dash.jsp");
		} 
		catch (Exception e)
		{
			e.printStackTrace(); 
		}
	}

}
