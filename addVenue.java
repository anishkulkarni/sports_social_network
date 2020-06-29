

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

@WebServlet("/addVenue")
public class addVenue extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException
	{
		res.setContentType("text/html");
		PrintWriter pw=res.getWriter();
		String name=req.getParameter("vname");
		String loc=req.getParameter("vlocation");
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			PreparedStatement st = con.prepareStatement("insert into Venue(name,location) values(?,?);");
			st.setString(1,name);
			st.setString(2,loc);
			st.executeUpdate();
			st.close(); 
			con.close();
			req.getRequestDispatcher("adminPage.jsp").forward(req,res);
		} 
		catch (Exception e)
		{ 
			pw.print(e.getMessage());
			e.printStackTrace(); 
		}
	}

}
