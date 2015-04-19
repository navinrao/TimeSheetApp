
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

/
<%@ page import="java.sql.*"%>
<%@ page import= "java.sql.Connection" %>
<%@ page import= "java.sql.DriverManager" %>
<%@ page import="javax.swing.*" %>
<%@ page import= "java.security.*" %>

<%
	

String UserName = request.getParameter("username");
String PassWord = request.getParameter("password");
String empID;

request.getSession(true);
session = request.getSession();
session.setAttribute("UserName", UserName);
if(session.getAttribute("UserName")!=null)
{



Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
String connectionUrl = "jdbc:sqlserver://oz-ist-iissql.abington.psu.edu;" + 
        "database=ist440grp1sp15;" + 
        "user=ist440grp1sp15;" + 
        "password=ist440grp1sp15"; 
Connection con;try {
	
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
	System.out.println(generatedPassword);
    

	
	con = DriverManager.getConnection(connectionUrl);
    // Create and execute an SQL statement that returns some data.  
  	//String SQL = "SELECT * FROM timesheet.login where UserName = 'mas6462'";
    
    
   	String SQL = ("SELECT username_ts, password_ts, employee_id From timesheet.employees Where username_ts='" + UserName + "' and password_ts='" + generatedPassword + "'");
    Statement stmt = con.createStatement();  
    ResultSet rs = stmt.executeQuery(SQL); 
    if(rs.next())
		    {
		
    		String databaseUsername = rs.getString("username_ts");
    		String databasePassword = rs.getString("password_ts");
    		if(databaseUsername.equals(UserName) && databasePassword.equals(generatedPassword))
    			{	    

		    		
				   	System.out.println("Welcome: " + UserName);
				    System.out.println("Connected.");
				    System.out.println(databaseUsername);
				    empID = rs.getString("employee_id");
				    System.out.println(empID);
				   
				    //response.sendRedirect("welcome.jsp");
				    
		   
    			}
    		rs.close();
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
else
	{
	response.sendRedirect("login.jsp");
	}
%>



	
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome Page</title>


		
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		
		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/welcome.css">


</head>
<body>

		<!-- code for pop up box -->
<!-- <script Language="javaScript">alert("Welcome")</script> -->

<img src="${pageContext.request.contextPath}/Images/logo.jpg" alt="logo" style="width:175px;height:125px">



<table id="session"  >
	<tr>
				<td>
					<!--  <span class="label label-default col-m-8" >Signed in as</span> -->
					<h4>Signed in <span class="label label-default"> <%=session.getAttribute("UserName") %>  </span ></h4 >
				</td>
		
			<td><!-- session state for user -->
				<!--  <input type="text" class="form-control" aria-describedby="basic-addon1" value="<%=session.getAttribute("UserName") %>" readonly > -->
			
			</td>

			<td>
				<form method="post" action="logout.jsp">
				<button type="submit" class="btn-group  btn-group-xs" >Logout</button>
				</form>
			</td>
		
		
		</tr>
	
</table>



<nav class="navbar navbar-info">
  <div class="container-fluid">
    <div class="navbar-header">
    
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li class="active"><a href="welcome.jsp">Home</a></li>
        <li><a href="timesheet.jsp">Time Sheet</a></li>
        <li><a href="NewEmp.jsp">New Employee</a></li>
        <li><a href="addproj.jsp">Projects</a></li>
        <li><a href="#">About Us</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container">
  <div class="jumbotron">
  
		  <!-- Here is the center of the page -->
			    <h1 >Welcome to Dynamic Solution</h1>      
			    <p>Please select from the menu what you would like to do.</p>      
		
 </div><!-- ends center page -->
  </div>
         <div class="panel panel-default" id="footer">
		<p> IST 440 Group 1 Spring 2015 </p>
		<p> Professor: Taghi Ozbeki </p>	
		</div>
<script type="text/javascript">

 
 
 </script> 

</body>
</html>
