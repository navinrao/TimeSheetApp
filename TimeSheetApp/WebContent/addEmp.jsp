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
<title>Add Employee</title>
</head>
<body>

<%@ page import="java.sql.*"%>
<%@ page import= "java.sql.Connection" %>
<%@ page import= "java.sql.DriverManager" %>
<%@ page import="javax.swing.*" %>


<%

int empId =Integer.parseInt(request.getParameter("empid"));
String first = request.getParameter("fname");
String middle = request.getParameter("middle");
String last = request.getParameter("lname");
String social = request.getParameter("ssn");
String date_birth = request.getParameter("dob");
String gender = request.getParameter("gender");
String man_Id = request.getParameter("manager");
String emp_title = request.getParameter("title");
String user_name = request.getParameter("username");
String pass_word = request.getParameter("password");
String date_hire = request.getParameter("doh");
String date_term = request.getParameter("term");
String create_date = request.getParameter("create");
String del_date = request.getParameter("delete");


System.out.println("fname");

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
	
	//"SET IDENTITY_INSERT timesheet.employees ON " 
		String SQL = "SET IDENTITY_INSERT timesheet.employees ON " + "INSERT INTO timesheet.employees(employee_id, first_name, middle_name, last_name, ssn, dob, gender,"
				+ "manager_id, job_title_id, username_ts, password_ts, hire_date, term_date, create_date, delete_date)"
				+"VALUES('" + empId + "', '" + first + "', '" + middle + "', '" + last + "', '" + social + "', '" + date_birth + "', '" + gender + "', '" + man_Id + "', '" + emp_title + "', '" + user_name + "', '" + pass_word + "', '" + date_hire + "', '" + date_term + "', '" + create_date + "', '" + del_date + "');";
	Statement stmt = con.createStatement();  
	//ResultSet rs = stmt.executeQuery(SQL); 
	stmt.executeUpdate(SQL);
}
catch (SQLException e) 
		{
		// TODO Auto-generated catch block
		e.printStackTrace();
	
	
		} 

%>





</body>
</html>