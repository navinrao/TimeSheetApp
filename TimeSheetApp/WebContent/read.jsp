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

	<!-- table to handle display -->
<table border="2" style="background-color: #4BB0CC;" width="auto" >
<% 
int empId=9;
			
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        String connectionUrl = "jdbc:sqlserver://oz-ist-iissql.abington.psu.edu;" + 
                "database=ist440grp1sp15;" + 
                "user=ist440grp1sp15;" + 
                "password=ist440grp1sp15"; 
Connection con;
try {
	con = DriverManager.getConnection(connectionUrl);
     // Create and execute an SQL statement that returns some data.  
    //  String SQL = "SELECT * FROM timesheet.login where UserName = 'mas6462'";
    
    
   	String SQL = ("SELECT * From timesheet.employees Where employee_id='" + empId + "'");
    Statement stmt = con.createStatement();  
    ResultSet rs = stmt.executeQuery(SQL); 
    if(rs.next())
		    {
		     //session=request.getSession();
    		//session.setAttribute("UserName", UserName);
		   // System.out.println("Welcome: " + UserName);
		    System.out.println("Connected.");
		    System.out.println(rs.getString(1));
		 
		    //response.sendRedirect("welcome.jsp");
		    
		    %>
		    
		    	    
		    <tr><td>Emp_id</td><td><input type="text" name="empid" value="<%=rs.getString("employee_id")%>"></td></tr>
		    <tr><td>First Name</td><td><input type="text" name="empid" value="<%=rs.getString("first_name")%>"></td></tr>
		    <tr><td>Last Name</td><td><input type="text" name="empid" value="<%=rs.getString("last_name")%>"></td></tr>
		    <tr><td>SSN</td><td><input type="text" name="empid" value="<%=rs.getString("ssn")%>"></td></tr>
		    <tr><td>Date Of Birth</td><td><input type="text" name="empid" value="<%=rs.getString("dob")%>"></td></tr>
		    <tr><td>Gender</td><td><input type="text" name="empid" value="<%=rs.getString("gender")%>"></td></tr>
		    <tr><td>Manager</td><td><input type="text" name="empid" value="<%=rs.getString("manager_id")%>"></td></tr>
		    <tr><td>User Name</td><td><input type="text" name="empid" value="<%=rs.getString("username_ts")%>"></td></tr>
		    <tr><td>Password</td><td><input type="text" name="empid" value="<%=rs.getString("password_ts")%>"></td></tr>
		    <tr><td>Hire Date</td><td><input type="text" name="empid" value="<%=rs.getString("hire_date")%>"></td></tr>
		    <%
		    
		    }
		    else
		    {
		    	String error = (" Login Error " + "\n" + " your Username or password is incorrect Please try again. ");
		    			System.out.println(error);
		    			//response.sendRedirect("NewEmp.jsp");
		    			
		    }
 
	}
	catch (SQLException e) 
			{
			// TODO Auto-generated catch block
			e.printStackTrace();
		
		
			} 
	
%><!-- Jsp:scriplet -->
</table>
</body>
</html>