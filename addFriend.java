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

@WebServlet("/addFriend")
public class addFriend extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		response.setContentType("text/html");
		HttpSession session=request.getSession(false);
		String user = (String)session.getAttribute("username");
		String friend = request.getParameter("friend");
	    try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			PreparedStatement st = con.prepareStatement("insert into friend values(?,?)");
			st.setString(1,user);
			st.setString(2,friend);
			st.executeUpdate();
			st = con.prepareStatement("delete from friendRequest where player1=? and player2=?");
			st.setString(1,friend);
			st.setString(2,user);
			st.executeUpdate();
			st.close();
			con.close();
			response.sendRedirect("home2.jsp");
		} 
		catch (Exception e)
		{
			e.printStackTrace(); 
		}
	}
}
