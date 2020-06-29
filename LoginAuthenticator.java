import java.io.IOException; 
import java.io.PrintWriter; 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement; 
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginAuthenticator") 
public class LoginAuthenticator extends HttpServlet
{ 
	private static final long serialVersionUID = 1L; 

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{ 
		String pass_actual=null;
		PrintWriter pw=res.getWriter();
		res.setContentType("text/html");
		String user=req.getParameter("username");
		String pass=req.getParameter("password");
		HttpSession session=req.getSession();
        session.setAttribute("username",user);
        try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			pw.println("Connected to database");
			PreparedStatement st = con.prepareStatement("select * from Player where username=?;");
			st.setString(1,user);
			ResultSet resultSet = st.executeQuery();
			if(resultSet.next())
			{
				pass_actual = resultSet.getString("password");
			}
			if(pass_actual.equals(pass))
			{
				if(user.equals("admin"))
				{
					req.getRequestDispatcher("adminPage.jsp").forward(req,res);
				}
				else
				{
					req.getRequestDispatcher("home2.jsp").forward(req, res);
				}
			}
			st.close(); 
			con.close();
		} 
		catch (Exception e)
		{ 
			pw.print(e.getMessage());
			e.printStackTrace(); 
		}
		pw.close();
	} 
} 
