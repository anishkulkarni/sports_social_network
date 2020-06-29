

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

@WebServlet("/finishMatch")
public class finishMatch extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		res.setContentType("text/html");
		PrintWriter pw=res.getWriter();
		int mid = Integer.parseInt(req.getParameter("matchId"));
		String winner = req.getParameter("winner");
		String score = req.getParameter("score");
		String opponent = req.getParameter("opponent");
		String sport = req.getParameter("sport");
		HttpSession session=req.getSession();
        String user = (String)session.getAttribute("username");
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			PreparedStatement st = con.prepareStatement("update Matches set winner=? where matchId=?");
			st.setString(1,winner);
			st.setInt(2,mid);
			st.executeUpdate();
			st.close(); 
			st = con.prepareStatement("update Matches set score=? where matchId=?;");
			st.setString(1,score);
			st.setInt(2,mid);
			st.executeUpdate();
			st.close(); 
			st = con.prepareStatement("update Matches set status=\"finished\" where matchId=?;");
			st.setInt(1,mid);
			st.executeUpdate();
			st.close();
			if(winner.equals(user))
			{
				st = con.prepareStatement("update statistics set wins=wins+1 where sportName=? and userId=?;");
				st.setString(1,sport);
				st.setString(2,user);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set losses=losses+1 where sportName=? and userId=?;");
				st.setString(1,sport);
				st.setString(2,opponent);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set streak=if(streak>0,streak+1,1) where userId=? and sportName=?;");
				st.setString(1,user);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set level=if(streak=5,level+1,level),streak=if(streak=5,0,streak) where userId=? and sportName=?;");
				st.setString(1,user);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set streak=if(streak<0,streak-1,-1) where userId=? and sportName=?;");
				st.setString(1,opponent);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set level=if(streak=-3,level-1,level),streak=if(streak=-3,0,streak) where userId=? and sportName=?;");
				st.setString(1,opponent);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
			}
			else if(winner.equals(opponent))
			{
				st = con.prepareStatement("update statistics set wins=wins+1 where sportName=? and userId=?;");
				st.setString(1,sport);
				st.setString(2,opponent);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set losses=losses+1 where sportName=? and userId=?;");
				st.setString(1,sport);
				st.setString(2,user);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set streak=if(streak>0,streak+1,1) where userId=? and sportName=?;");
				st.setString(1,opponent);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set level=if(streak=5,level+1,level),streak=if(streak=5,0,streak) where userId=? and sportName=?;");
				st.setString(1,opponent);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set streak=if(streak<0,streak-1,-1) where userId=? and sportName=?;");
				st.setString(1,user);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set level=if(streak=-3,level-1,level),streak=if(streak=-3,0,streak) where userId=? and sportName=?;");
				st.setString(1,user);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
			}
			else
			{
				st = con.prepareStatement("update statistics set noResults=noResults+1 where sportName=? and userId=?;");
				st.setString(1,sport);
				st.setString(2,opponent);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set noResults=noResults+1 where sportName=? and userId=?;");
				st.setString(1,sport);
				st.setString(2,user);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set streak=0 where userId=? and sportName=?;");
				st.setString(1,user);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
				st = con.prepareStatement("update statistics set streak=0 where userId=? and sportName=?;");
				st.setString(1,opponent);
				st.setString(2,sport);
				st.executeUpdate();
				st.close();
			}
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
