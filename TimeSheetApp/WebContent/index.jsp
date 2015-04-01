
<%@page import="org.apache.catalina.ant.SessionsTask"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>



</head>
<body>
<%@ page import="java.sql.*"%>
<%@ page import= "java.sql.Connection" %>
<%@ page import= "java.sql.DriverManager" %>
<%@ page import="javax.swing.*" %>

<%

	String UserName = request.getParameter("username");
	String PassWord = request.getParameter("password");
	//if(username.equals("mas6462") && password.equals("pass"))
	//{
		//session.setAttribute("username", username);
		//System.out.println("Success");
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String connectionUrl = "jdbc:sqlserver://oz-ist-iissql.abington.psu.edu;" + 
                "database=ist440grp1sp15;" + 
                "user=ist440grp1sp15;" + 
                "password=ist440grp1sp15"; 
Connection con;
try {
	con = DriverManager.getConnection(connectionUrl);
    // Create and execute an SQL statement that returns some data.  
  	//String SQL = "SELECT * FROM timesheet.login where UserName = 'mas6462'";
    
    
   	String SQL = ("SELECT username_ts, password_ts From timesheet.employees Where username_ts='" + UserName + "' and password_ts='" + PassWord + "'");
    Statement stmt = con.createStatement();  
    ResultSet rs = stmt.executeQuery(SQL); 
    if(rs.next())
		    {
		    session=request.getSession();
    		session.setAttribute("UserName", UserName);
		   	System.out.println("Welcome: " + UserName);
		    System.out.println("Connected.");
		    System.out.println(rs.getString(1));
		    response.sendRedirect("welcome.jsp");
		  
		   
		    
		    }
		    else
		    {
		    	 String error= " Your UserName or Password is incorrect Please try again. ";
		    			
		    			
		    			//System.out.println(error);
		    			
		    			//response.sendRedirect("login.jsp");
		    			
		    			//String option[] ={"OK", "CANCEL"};
		    			//int status = JOptionPane.showOptionDialog(null, error, "Login Error", JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE, null, option, option[0]);
		    			//if(//status==JOptionPane.OK_OPTION)
		    			if(UserName == null || UserName =="")
		    			{
		    				response.sendRedirect("login.jsp");
		    			}
		    			else
		    			{
		    				response.sendRedirect("welcome.jsp");
		    			}

		    }
 
	}
	catch (SQLException e) 
			{
			// TODO Auto-generated catch block
			e.printStackTrace();
		
		
			} 



%>



 
</body>
</html>