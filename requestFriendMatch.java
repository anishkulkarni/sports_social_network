

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/requestFriendMatch")
public class requestFriendMatch extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		res.setContentType("text/html");
		PrintWriter pw=res.getWriter();
		HttpSession session=req.getSession();
        String user = (String)session.getAttribute("username");
        String name = req.getParameter("name");
        String sport = req.getParameter("sport");
        String venue = req.getParameter("venue");
        String date = req.getParameter("date");
        String time = req.getParameter("time");
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");
			PreparedStatement st1 = con.prepareStatement("select venueId from Venue where name=?");
			st1.setString(1,venue);
			ResultSet rs = st1.executeQuery();
			rs.next();
			int venueId=rs.getInt("venueId");
			st1.close();
			PreparedStatement st = con.prepareStatement("insert into Matches(player1,player2,matchDate,matchTime,sportName,venueId,status) values(?,?,?,?,?,?,?)");
			st.setString(1,user);
			st.setString(2,name);
			st.setString(3,date);
			st.setString(4,time);
			st.setString(5,sport);
			st.setInt(6,venueId);
			st.setString(7,"friendrequested");
			st.executeUpdate();
			st.close(); 
			con.close();
			req.getRequestDispatcher("home2.jsp").forward(req, res);
		} 
		catch (Exception e)
		{ 
			pw.print(e.getMessage());
			e.printStackTrace(); 
		}
	}

}
