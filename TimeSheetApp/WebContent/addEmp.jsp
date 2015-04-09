
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<%
	request.getSession(true);
	//if(session.getAttribute("UserName")== null)
	//response.sendRedirect("login.jsp");
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
<%@ page import= "java.security.*" %>


<%


if(session.getAttribute("UserName") != null)
	{
String empId = request.getParameter("empid");
String first = request.getParameter("fname");
String middle = request.getParameter("middle");
String last = request.getParameter("lname");

int social = Integer.parseInt(request.getParameter("ssn"));

String date_birth = request.getParameter("dob");
String oreintation = request.getParameter("gender");
int man_Id = Integer.parseInt(request.getParameter("manager"));
int emp_title = Integer.parseInt(request.getParameter("title"));
String user_name = request.getParameter("username");
String pass_word = request.getParameter("password");
String date_hire = request.getParameter("doh");
String date_term = request.getParameter("term");
String create_date = request.getParameter("create");
String del_date = request.getParameter("delete");


	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    String connectionUrl = "jdbc:sqlserver://oz-ist-iissql.abington.psu.edu;" + 
            "database=ist440grp1sp15;" + 
            "user=ist440grp1sp15;" + 
            "password=ist440grp1sp15"; 
Connection con;
try {
	
				
				//Begin to hash the new employee password
			    String generatedPassword = null; // create variable to store the hashed value of password
			    MessageDigest md = MessageDigest.getInstance("SHA1"); // creates an instance of message digest from java.security class
			    //Add password bytes to digest
			    md.update(pass_word.getBytes());
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
				System.out.println(generatedPassword); //variable used to pass hashed data into the database

	
	
	
	con = DriverManager.getConnection(connectionUrl);
	// Create and execute an SQL statement that returns some data.  
		//String SQL = "SELECT * FROM timesheet.login where UserName = 'mas6462'";
	
	//"SET IDENTITY_INSERT timesheet.employees ON " 
		String SQL = "INSERT INTO timesheet.employees(employee_id, first_name, middle_name, last_name, ssn, dob, gender,"
				+ "manager_id, job_title_id, username_ts, password_ts, hire_date, term_date, create_date, delete_date)"
				+"VALUES('" + empId + "', '" + first + "', '" + middle + "', '" + last + "', '" + social + "', '" + date_birth + "', '" + oreintation + "', '" + man_Id + "', '" + emp_title + "', '" + user_name + "', '" + generatedPassword + "', '" + date_hire + "', '" + date_term + "', '" + create_date + "', '" + del_date + "');";
				
				
	//String SQL = //"SET IDENTITY_INSERT timesheet.employees ON " + "INSERT INTO timesheet.employees(employee_id, create_date) VALUES(5, 2012-01-01)";			
	Statement stmt = con.createStatement();  
	//ResultSet rs = stmt.executeQuery(SQL); 
	stmt.executeUpdate(SQL);
	//System.out.println("Record for " + first + last + "has been added: ");
	//response.sendRedirect("NewEmp.jsp");
	

	
	 String confirm= " A record for " + first + last + " has been created" + "\n" + " Would you like to add another? " ; 		
	//response.sendRedirect("login.jsp");
		
		String option[] ={"OK", "NO"};
		int status = JOptionPane.showOptionDialog(null, confirm, "Add Record", JOptionPane.YES_NO_OPTION, JOptionPane.INFORMATION_MESSAGE, null, option, option[0]);
		if(status==JOptionPane.OK_OPTION)
		{
			response.sendRedirect("NewEmp.jsp");
		}
		else
		{
			response.sendRedirect("welcome.jsp");
		}
}

	

catch (SQLException e) 
		{
		// TODO Auto-generated catch block
		e.printStackTrace();
		} 

	}//end of if for sessions
	response.sendRedirect("login.jsp");
%>

</body>
</html>