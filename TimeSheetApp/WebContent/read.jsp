<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<%
	
		//request.getSession(true);
		//if(session.getAttribute("UserName")== null)
		//response.sendRedirect("login.jsp");
	%>
		




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Read</title>
</head>
<body>

<%@ page import="java.sql.*"%>
<%@ page import= "java.sql.Connection" %>
<%@ page import= "java.sql.DriverManager" %>
<%@ page import="javax.swing.*" %>

<% 
int empId =Integer.parseInt(request.getParameter("empid"));

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
    
    
   	String SQL = ("SELECT * From timesheet.employees Where employee_id='" + empId + "'");
    Statement stmt = con.createStatement();  
    ResultSet rs = stmt.executeQuery(SQL); 
    if(rs.next())
		    {
		   // session=request.getSession();
    		//session.setAttribute("UserName", UserName);
		   	//System.out.println("Welcome: " + UserName);
		    System.out.println("Connected.");
		    System.out.println(rs.getString(1));
		 
		    //response.sendRedirect("welcome.jsp");
		    
		   
		    
		    }
		    else
		    {
		    	String error = (" Login Error " + "\n" + " your Username or password is incorrect Please try again. ");
		    			System.out.println(error);
		    			response.sendRedirect("NewEmp.jsp");
		    			
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