<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<%
	
		request.getSession(true);
		if(session.getAttribute("UserName")== null)
		response.sendRedirect("login.jsp");
		
	%>
		




<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		
		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/read.css">






<title>Read</title>
</head>
<body>
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
      </ul>
    </div>
  </div>
</nav>
<%@ page import="java.sql.*"%>
<%@ page import= "java.sql.Connection" %>
<%@ page import= "java.sql.DriverManager" %>
<%@ page import="javax.swing.*" %>

	<!-- table to handle display -->
	
	
	    <form action="expire.jsp" method="post">
	    <table class="success">
	    <tr>
	    	<td>
	    		Record Id:<input type="text" name="record"/>
	    	</td>
	    		<td>
	    			Comments:<input type="textarea"  size="125"  name="comments"/>
	    		</td>	
		    </tr>
		    	<tr>
			    	<td>
			    		<button type="submit" class="btn btn-primary">Submit</button>
			    	</td>
			    	
		    	</tr>
	    </table>
	    </form>
		    
	
<table border="2" style="background-color: #4BB0CC;" width="auto" >
<% 

			
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
    
    String empId = (String)session.getAttribute("Employee_ID");
   	String SQL = ("SELECT employee_id,history_id, start_time, end_time, project_code, weekday_date, comments  FROM timesheet.history  WHERE employee_id='" + empId + "' AND expiration_date IS null" );
    Statement stmt = con.createStatement();  
    ResultSet rs = stmt.executeQuery(SQL); 
    while(rs.next())
		    {
		     //session=request.getSession();
    		//session.setAttribute("UserName", UserName);
		   // System.out.println("Welcome: " + UserName);
		    System.out.println("Connected.");
		    System.out.println(rs.getString("employee_id"));
		    System.out.println(rs.getString("history_id"));
		    System.out.println(rs.getString("start_time"));
		    System.out.println(rs.getString("end_time"));
		    System.out.println(rs.getString("project_code"));
		    System.out.println(rs.getString("weekday_date"));
		   	
			String st = rs.getString("start_time");
			String[] start = st.split(":");
			
			String en = rs.getString("start_time");
			String[] end = en.split(":");
		    
 %>
		
		
		    <table class="success"> 
		    
		    <tr class="success">
		    	<th>Emp ID</th>
		    	<th>Record ID</th>
		    	<th>Start</th>
		    	<th>End</th>
		    	<th>Proj Code</th>
		    	<th>Week Day</th>
		    	<th>Comments</th>
		    	
		    </tr  >   
		    <tr   class="success">
		    <td ><input type="text" name="empid" value="<%=rs.getString("employee_id")%>" readonly></td>
		    <td><input type="text" name="empid" value="<%=rs.getString("history_id")%>"readonly></td>
		    <td><input type="text" name="empid" value="<%=start[0] + ":" + start[1]%>"readonly></td>
		   	<td><input type="text" name="empid" value="<%=end[0] + ":" + end[1]%>"readonly></td>
		    <td><input type="text" name="empid" value="<%=rs.getString("project_code")%>"readonly></td>
		    <td><input type="text" name="empid" value="<%=rs.getString("weekday_date")%>"readonly></td>
		    <td><input type="text" name="empid" value="<%=rs.getString("comments")%>"readonly></td>
		    
		    </tr>
				
		    </table>
		    
		  
		    
		    
		    	
		    <%
		    
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