import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/addMatch")
public class addMatch extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{

	    PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		HttpSession session=request.getSession(false);
		String user = (String)session.getAttribute("username");
		String opponent = request.getParameter("username");
		String sport = request.getParameter("sport");
		String date = request.getParameter("date");
		String time = request.getParameter("time");
	    try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			PreparedStatement st = con.prepareStatement("update Matches set status=\"Accepted\" where team1=? and team2=? and sport=? and matchDate=? and matchTime=?");
			st.setString(1,opponent);
			st.setString(2,user);
			st.setString(3,sport);
			st.setString(4,date);
			st.setString(5,time);
			st.executeUpdate();
			st.close();
			con.close();
			response.sendRedirect("dash.jsp");
		} 
		catch (Exception e)
		{
			out.println(e.getMessage());
			e.printStackTrace();
		}
	}

}
