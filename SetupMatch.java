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

@WebServlet("/SetupMatch")
public class SetupMatch extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
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
			PreparedStatement st = con.prepareStatement("insert into Matches(team1,team2,sport,status,score,matchDate,matchTime) values(?,?,?,\"Requested\",\"None\",?,?)");
			st.setString(1,user);
			st.setString(2,opponent);
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
			e.printStackTrace(); 
		}
	}
}
