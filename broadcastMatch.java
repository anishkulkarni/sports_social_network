

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/broadcastMatch")
public class broadcastMatch extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		res.setContentType("text/html");
		PrintWriter pw=res.getWriter();
		String sport=req.getParameter("sport");
		String venue=req.getParameter("venue");
		String date=req.getParameter("date");
		String time=req.getParameter("time");
		HttpSession session=req.getSession(false);
        String user = (String)session.getAttribute("username");
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");
			PreparedStatement st = con.prepareStatement("select venueId from Venue where name=?;");
			st.setString(1,venue);
			ResultSet rs=st.executeQuery();
			rs.next();
			int vid=rs.getInt("venueId");
			st = con.prepareStatement("insert into Matches(matchDate,matchTime,status,sportName,venueId,player1) values(?,?,\"requested\",?,?,?);");
			st.setString(1,date);
			st.setString(2,time);
			st.setString(3,sport);
			st.setInt(4,vid);
			st.setString(5,user);
			st.executeUpdate();
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
