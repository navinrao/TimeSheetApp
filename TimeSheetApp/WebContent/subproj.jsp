

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
<title>Submit Project</title>
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
 		int mang_id = Integer.parseInt(request.getParameter("man_id"));
		String proj_code = (String)request.getParameter("projCode");
		String eff_date = (String) request.getParameter("effDate");
		String exp_date = (String) request.getParameter("expDate");
		String proj_name = (String) request.getParameter("projname");
		//int proj_id = Integer.parseInt(request.getParameter("projid"));
		String proj_desc = (String) request.getParameter("projdesc");
 	
		//String proj_code ="abc1";
		//int proj_id = 7;
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	    String connectionUrl = "jdbc:sqlserver://oz-ist-iissql.abington.psu.edu;" + 
	            "database=ist440grp1sp15;" + 
	            "user=ist440grp1sp15;" + 
	            "password=ist440grp1sp15"; 
Connection con;


try {
	
	con = DriverManager.getConnection(connectionUrl);


		//String SQL = "SELECT project_id, project_name, project_code FROM timesheet.projects where project_id='" + proj_id + "' project_name ='" + proj_name + "'project_code='"+ proj_code + "'";
		String SQL = "SELECT project_code, project_id From timesheet.projects where  project_code='" + proj_code + "' AND project_name='" + proj_name + "';" ;
		//String SQL = ("SELECT   project_code, project_id From timesheet.projects where project_id='" + proj_id+ "'" );
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
				JOptionPane option = new JOptionPane("Project " + proj_code + " Already Exist", JOptionPane.PLAIN_MESSAGE );
				JDialog dia = option.createDialog(null, "Create Fail");
				dia.setAlwaysOnTop(true);
				dia.show();
				session.getAttribute("UserName");
				response.sendRedirect("addproj.jsp");
			}
	else
			{
		
		
			SQL = "INSERT INTO timesheet.projects(manager_id, project_name, project_code, effective_date, expiration_date, project_description)"
			+"VALUES('" + mang_id + "', '" + proj_name + "', '" + proj_code + "', '" + eff_date + "', '" + exp_date + "', '" + proj_desc  + "');";

			JOptionPane option = new JOptionPane("Project " + proj_code + " Record Created", JOptionPane.PLAIN_MESSAGE );
			JDialog dia = option.createDialog(null, "Record Created");
			dia.setAlwaysOnTop(true);
			dia.show();
			session.getAttribute("UserName");
			response.sendRedirect("welcome.jsp");

				 
			//SQL =  "INSERT INTO dbo.testing(employee_id, username)VALUES('abc123', 'ADMIN')";
				stmt.executeUpdate(SQL);
				 //System.out.println("insert statement");
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
		{
			response.sendRedirect("login.jsp");
		}



%>












</body>
</html>