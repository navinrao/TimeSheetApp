
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
		session.getAttribute("UserName");
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
			/* 	
			String SQL = "INSERT INTO timesheet.employees(employee_id, first_name, middle_name, last_name, ssn, dob, gender,"
					+ "manager_id, job_title_id, username_ts, password_ts, hire_date, term_date, create_date, delete_date)"
					+"VALUES('" + empId + "', '" + first + "', '" + middle + "', '" + last + "', '" + social + "', '" + date_birth + "', '" + oreintation + "', '" + man_Id + "', '" + emp_title + "', '" + user_name + "', '" + generatedPassword + "', '" + date_hire + "', '" + date_term + "', '" + create_date + "', '" + del_date + "');";
					 */
					
		//stmt.executeUpdate(SQL);
		//System.out.println("Record for " + first + last + "has been added: ");
		//response.sendRedirect("NewEmp.jsp");
			
		 //String msg = " A record for " + first + last + " has been created" ; 		
	
	
		//JOptionPane option = new JOptionPane(msg, JOptionPane.PLAIN_MESSAGE );
		//JDialog dia = option.createDialog(null, "Record Create");
		//dia.setAlwaysOnTop(true);
		//dia.show();
		/* if(option.equals(JOptionPane.YES_OPTION));
		{
			
				response.sendRedirect("welcome.jsp");
		}
	 */ 
	 
		String SQL = "SELECT employee_id, username_ts FROM timesheet.employees where employee_id='" + empId + "'AND username_ts='" + user_name + "'";	 
		Statement stmt = con.createStatement();  
		ResultSet rs = stmt.executeQuery(SQL); 
		int count = 0;
	 		if(rs.next())
	 		{
	 			count = count +1;
	 			System.out.println(rs.getString(1));
	 			System.out.println(count);
	 			rs.close();
	 		}
			 		if(count == 1)
			 		{
			 			System.out.println("the count is 1");
			 			JOptionPane option = new JOptionPane("Already Exist", JOptionPane.PLAIN_MESSAGE );
			 			JDialog dia = option.createDialog(null, "Create Fail");
			 			dia.setAlwaysOnTop(true);
			 			dia.show();
			 			response.sendRedirect("NewEmp.jsp");
			 		}
	 	 	else
	 		{
	 			
	 					SQL = "INSERT INTO timesheet.employees(employee_id, first_name, middle_name, last_name, ssn, dob, gender,"
	 					+ "manager_id, job_title_id, username_ts, password_ts, hire_date, term_date, create_date, delete_date)"
	 					+"VALUES('" + empId + "', '" + first + "', '" + middle + "', '" + last + "', '" + social + "', '" + date_birth + "', '" + oreintation + "', '" + man_Id + "', '" + emp_title + "', '" + user_name + "', '" + generatedPassword + "', '" + date_hire + "', '" + date_term + "', '" + create_date + "', '" + del_date + "');";
	 					 
						//SQL =  "INSERT INTO dbo.testing(employee_id, username)VALUES('abc123', 'ADMIN')";
	 					stmt.executeUpdate(SQL);
	 					// System.out.println("insert statement");
	 					 rs.close();
	 		} 
	 	
	 	
}

	
		catch (NullPointerException e) 
				{
					System.out.println(e);
				}
		
		catch (SQLException e) 
				{
				// TODO Auto-generated catch block
				e.printStackTrace();
				} 

	}
else
	{//end of if for sessions
	response.sendRedirect("login.jsp");
	}
%>

</body>
</html>