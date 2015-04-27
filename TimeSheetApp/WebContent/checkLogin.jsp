<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import= "java.sql.Connection" %>
<%@ page import= "java.sql.DriverManager" %>
<%@ page import="javax.swing.*" %>
<%@ page import= "java.security.*" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Authentication Page</title>
</head>
<body>

<%
	
	String UserName = request.getParameter("username");
	String PassWord = request.getParameter("password");
	
	if(UserName == null )
	{
		response.sendRedirect("login.jsp");	
	}
	
	else
	{
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	String connectionUrl = "jdbc:sqlserver://oz-ist-iissql.abington.psu.edu;" + 
	        "database=ist440grp1sp15;" + 
	        "user=ist440grp1sp15;" + 
	        "password=ist440grp1sp15"; 
	Connection con;

try {
	
	//String passwordToHash = "password";
    String generatedPassword = null;
    MessageDigest md = MessageDigest.getInstance("SHA1");
    //Add password bytes to digest
    md.update(PassWord.getBytes());
    //Get the hash's bytes
    byte[] bytes = md.digest();
    //This bytes[] has bytes in decimal format;
    //Convert it to hexadecimal format
    StringBuilder sb = new StringBuilder();
    for(int i=0; i< bytes.length ;i++)
    {
        sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
    }
    //Get complete hashed password in hex format
	generatedPassword = sb.toString();
	//System.out.println(generatedPassword);
	con = DriverManager.getConnection(connectionUrl);
    // Create and execute an SQL statement that returns some data.  
  	//String SQL = "SELECT * FROM timesheet.login where UserName = 'mas6462'";
   	String SQL = ("SELECT username_ts, password_ts, employee_id From timesheet.employees Where username_ts='" + UserName + "' and password_ts='" + generatedPassword + "'");
    Statement stmt = con.createStatement();  
    ResultSet rs = stmt.executeQuery(SQL); 
    System.out.println("connection ok");
    int count = 0;
    if(rs.next())
		    {
			 count = count + 1;
    		
    		}//end result set
    		if(count == 1)
    		{
        		
        		String databaseUsername = rs.getString("username_ts");
        		String databasePassword = rs.getString("password_ts");
        		String empID = rs.getString("employee_id");
        		System.out.println("I got the result set");
			 	System.out.println("I checked the database");
			 	request.getSession(true);
			 	session = request.getSession();
			 	session.setAttribute("weeksInPast", Integer.toString(0));
				session.setAttribute("UserName", databaseUsername);
				session.setAttribute("Employee_ID", empID);
			   	System.out.println("Welcome: " + databaseUsername);
			    System.out.println("Connected.");
			    System.out.println(databaseUsername);
			    System.out.println(empID);
			    response.sendRedirect("welcome.jsp");
    		}
    		else 
			{
				response.sendRedirect("login.jsp");
				System.out.println("incorrect credentials...back to start");
			}
  
	}

	catch (NullPointerException e) {
		System.out.println(e);
	}
	catch (NoSuchAlgorithmException e)	{
	    e.printStackTrace();
	}
	catch (SQLException e) 	{
			// TODO Auto-generated catch block
			e.printStackTrace();	
	} 
}

 %> 

</body>
</html>