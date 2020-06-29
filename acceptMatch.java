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

@WebServlet("/acceptMatch")
public class acceptMatch extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		res.setContentType("text/html");
		PrintWriter pw=res.getWriter();
		int mid = Integer.parseInt(req.getParameter("matchId"));
		HttpSession session=req.getSession();
        String user = (String)session.getAttribute("username");
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			PreparedStatement st = con.prepareStatement("update Matches set player2=? where matchId=?");
			st.setString(1,user);
			st.setInt(2,mid);
			st.executeUpdate();
			st.close(); 
			st = con.prepareStatement("update Matches set status=\"accepted\" where matchId=?");
			st.setInt(1,mid);
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
