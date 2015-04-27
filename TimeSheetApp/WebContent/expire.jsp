<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%@ page import="java.sql.*"%>
<%@ page import= "java.sql.Connection" %>
<%@ page import= "java.sql.DriverManager" %>
<%@ page import="javax.swing.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	
	int rec_id = Integer.parseInt(request.getParameter("record"));
	String com_id = request.getParameter("comments");
	//int rec = 1;
	
	//DateFormat date = new SimpleDateFormat("yyyy-MM-dd");
	//Date newdate = new Date();
	//String currentdate = date.format(newdate);
	
	new java.sql.Timestamp((new java.util.Date()).getTime());
	
	System.out.println(new java.sql.Timestamp((new java.util.Date()).getTime()));
	
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    String connectionUrl = "jdbc:sqlserver://oz-ist-iissql.abington.psu.edu;" + 
            "database=ist440grp1sp15;" + 
            "user=ist440grp1sp15;" + 
            "password=ist440grp1sp15"; 
Connection con;
try {
	
	con = DriverManager.getConnection(connectionUrl);


		//String SQL = "SELECT project_id, project_name, project_code FROM timesheet.projects where project_id='" + proj_id + "' project_name ='" + proj_name + "'project_code='"+ proj_code + "'";
		String SQL = "SELECT history_id, expiration_date  From timesheet.history WHERE  history_id='" + rec_id + "' AND expiration_date IS null";
		//String SQL = ("SELECT   project_code, project_id From timesheet.projects where project_id='" + proj_id+ "'" );
	Statement stmt = con.createStatement();  
	ResultSet rs = stmt.executeQuery(SQL); 
	int count = 0;
	if(rs.next())
	{
		count = count +1;
		System.out.println(rs.getString(1));
		System.out.println("the count is one " +count);
		rs.close();
	}
			if(count == 1)
				
			{
		

			SQL = "UPDATE timesheet.history SET expiration_date='" + new java.sql.Timestamp((new java.util.Date()).getTime()) +  "'," + "comments='" + com_id + " 'WHERE history_id='"+ rec_id + "'";
			System.out.println("update statement");

			JOptionPane option = new JOptionPane("Project " + rec_id + " Record Created", JOptionPane.PLAIN_MESSAGE );
			JDialog dia = option.createDialog(null, "Record Created");
			dia.setAlwaysOnTop(true);
			dia.show();
			session.getAttribute("UserName");
			response.sendRedirect("welcome.jsp");
			stmt.executeUpdate(SQL);
			rs.close(); 
			} else
			{
				{
					System.out.println("the count is 1");
					JOptionPane option = new JOptionPane("Project " + rec_id + " UPDATE", JOptionPane.PLAIN_MESSAGE );
					JDialog dia = option.createDialog(null, "Update Unsuccessful");
					dia.setAlwaysOnTop(true);
					dia.show();
					session.getAttribute("UserName");
					response.sendRedirect("read.jsp");
				}
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


%>



</body>
</html>