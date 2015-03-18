package timesheet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//import database connection
//import java.util.Date;

public class Projects {
	public final String empID; // stores the current session's user's empID for database connection
	public ArrayList<Project> weeklyProjects  = new ArrayList<>(); // initializes a weeklyProjects ArrayList for the current user
	public ArrayList<String> projCodesMenu = new ArrayList<>(); // initializes a String ArrayList of available Project Codes accessible by the user via the timesheet.jsp interface Add Project dropdown menu
	
	public Projects (String theEmpID) {
		empID = theEmpID;		
		
		getConnection();
		// projCodesMenu.add(SELECT EACH PROJECT CODE FROM PROJECT CODE TABLE AVAILABLE TO EMPLOYEE ID)
		// must populate projCodesMenu from the database for the current user
		// possibly use a Scanner in = new Scanner(); in.Next() for each project code returned from select statement;
	}
	
	public void addProject(String theProjCode) {
		weeklyProjects.add(new Project(theProjCode));
		updateProjCodesMenu(theProjCode);
	}
	
	public void updateProjCodesMenu (String theProjCode) {
		for (int i = 0; i < projCodesMenu.size(); i++) {
			if (projCodesMenu.get(i).equals(theProjCode)) {
				System.out.println("Found code: " + projCodesMenu.get(i));
				projCodesMenu.remove(i);
				return;
			} // removes a used project code from the available project codes menu Array List for the timesheet.jsp interface Add Project dropdown menu
		}
		for (int z = 0; z < projCodesMenu.size(); z++) {
			System.out.println(projCodesMenu.get(z));
		}
	}
	
	public void getConnection() {
		String connectionUrl = "jdbc:sqlserver://oz-ist-iissql.abington.psu.edu;" + 
                "database=ist440grp1sp15;" +  "user=ist440grp1sp15;" + 
                "password=ist440grp1sp15"; 
			Connection con = null;
			Statement stmt = null;
			ResultSet rs = null;
			try {
			con = DriverManager.getConnection(connectionUrl);
			System.out.println("Connected."); 
			
			// Create and execute an SQL statement that returns some data.  
			String SQL = "SELECT UserName, PassWord FROM timesheet.login";  
			stmt = con.createStatement();  
			rs = stmt.executeQuery(SQL); 
			
			// Iterate through the data in the result set and display it.  
			while (rs.next())  
			{  
				System.out.println(rs.getString(1) + " " + rs.getString(2));  
			} 
			}
			catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			}
	}
}
