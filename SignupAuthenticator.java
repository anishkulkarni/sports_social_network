import java.io.IOException; 
import java.io.PrintWriter; 
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement; 
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ssn.Login; 

@WebServlet("/SignupAuthenticator") 
public class SignupAuthenticator extends HttpServlet
{ 
	private static final long serialVersionUID = 1L; 

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException 
	{
		res.setContentType("text/html");
		PrintWriter pw=res.getWriter();
		String user=req.getParameter("username");
		String name=req.getParameter("name");
		String email=req.getParameter("email");
		String phone=req.getParameter("phone");
		String dob=req.getParameter("dob");
		String pass=req.getParameter("password");
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");  
			PreparedStatement st = con.prepareStatement("insert into Player(username,password,name,dateOfBirth,email,phone) values(?,?,?,?,?,?);");
			st.setString(1,user);
			st.setString(2,pass);
			st.setString(3,name);
			st.setString(4,"1999-09-09");
			st.setString(4,dob);
			st.setString(5,email);
			st.setString(6,phone);
			st.executeUpdate();
			st.close(); 
			con.close();
			HttpSession session=req.getSession();
	        session.setAttribute("username",user);
			req.getRequestDispatcher("home2.jsp").forward(req, res);
		} 
		catch (Exception e)
		{ 
			pw.print(e.getMessage());
			e.printStackTrace(); 
		}
	} 
} 
