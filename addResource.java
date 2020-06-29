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

@WebServlet("/addResource")
public class addResource extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		try
		{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/ssn","root","root");
			String sport = (String)request.getParameter("sport");
			String title = (String)request.getParameter("title");
			String link = (String)request.getParameter("link");
			PreparedStatement st = con.prepareStatement("insert into resources values(?,?,?);");
			st.setString(1,sport);
			st.setString(2,title);
			st.setString(3,link);
			st.executeUpdate();
			st.close(); 
			con.close();
			request.getRequestDispatcher("adminPage.jsp").forward(request, response);
		}
		catch (Exception e)
		{
			e.printStackTrace(); 
		}
	}

}
