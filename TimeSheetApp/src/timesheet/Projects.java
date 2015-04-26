package timesheet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

//import java.sql.Date;

public class Projects {
	public final String empID; // stores the current session's user's empID for database connection
	public int weeksInPast = 0;
	public int projCodeIndex = 0;
	public int dayOfWeekIndex = 0;
	public int totalRows= 0; // stores the total number of possible project code rows that need to be added to timesheet.jsp interface
	public int totalMenuOptions; // stores the total number of add project drop down menu options
	public ArrayList<Project> weeklyProjects  = new ArrayList<>(); // initializes a weeklyProjects ArrayList for the current user
	public ArrayList<String> projCodesMenu = new ArrayList<>(); // initializes a String ArrayList of unused Project Codes accessible by the user via the timesheet.jsp interface Add Project drop down menu
	public String weekBeginsOn; // stores the date representing the beginning of the target week for the timesheet.jsp
	public String weekEndsOn; // stores the date representing the ending of the target week for the timesheet.jsp
	public String dateLabels[] = new String[7]; // contains shorthand date labels
	public SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	public Date[] weekDates = new Date[7]; // stores the dates for every day within a week in the past
	public double[] dailySubTotalHours = new double[7]; // stores the sub total for the daily total hours of each project on a specific day
	public double weeklyGrandTotalHours = 0; // stores the grand total of hours for all days of the week within each project code
	public ArrayList<String> projCodesRow = new ArrayList<>();
	// CORRECT FOR LATER STAGES: public Projects (String theEmpID, Date theWeekBegins, Date theWeekEnds) {

	public Projects (String theEmpID) {
		this(theEmpID, 0);
	}

    public Projects (String theEmpID, int theWeeksInPast) {
        empID = theEmpID;
        weeksInPast = theWeeksInPast;

        // determines the date for every day within a past week
	    setCalendarWeekDates();	    
        setWeeklyProjectsHistory();
    }

	public void addProject (String theProjCode) {
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

	public void setCalendarWeekDates () {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        int daysAfterFirstDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - calendar.getFirstDayOfWeek();	    
	    calendar.add(Calendar.DATE, -daysAfterFirstDayOfWeek - (7 * weeksInPast));	    
	    weekBeginsOn = dateLabels[dayOfWeekIndex] = sdf.format(weekDates[dayOfWeekIndex] = calendar.getTime());
	    for (dayOfWeekIndex = 1; dayOfWeekIndex < 6; calendar.add(Calendar.DATE, 1), dateLabels[dayOfWeekIndex] = sdf.format(weekDates[dayOfWeekIndex] = calendar.getTime()), dayOfWeekIndex++){}
	    calendar.add(Calendar.DATE, 1);
	    weekEndsOn = dateLabels[dayOfWeekIndex] = sdf.format(weekDates[dayOfWeekIndex] = calendar.getTime());
	}

	// Gets data from the timesheet.history table and stores in all of the variables for each project in the weeklyProjects ArrayList

	public void setWeeklyProjectsHistory () {
		String connectionUrl = "jdbc:sqlserver://oz-ist-iissql.abington.psu.edu;" + "database=ist440grp1sp15;" +  "user=ist440grp1sp15;" + "password=ist440grp1sp15"; 
		Connection con = null;
		String SQL = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(connectionUrl);
			System.out.println("Connected."); 
			stmt = con.createStatement();

			SQL = "SELECT manager_id FROM timesheet.employees WHERE employee_id = '" + empID + "'";
			rs = stmt.executeQuery(SQL);
			int theManagerID = 0;

			while (rs.next()) {			
				theManagerID = rs.getInt("manager_id");
			}

			System.out.println("Manager ID: " + theManagerID);
			rs.close();

			// GETS PROJECT CODES ASSIGNED TO MANAGER ID WHO THE EMPLOYEE REPORTS TO
			SQL = "SELECT project_code FROM timesheet.projects WHERE manager_id = " + theManagerID;

			rs = stmt.executeQuery(SQL); 

			while (rs.next())  
			{			
				projCodesMenu.add(rs.getString("project_code"));
				totalRows++;
			}

			//projCodesRows = (ArrayList<String>) projCodesMe0nu.clone();
			rs.close();
			// Counts h0ow many different project codes an emp_id has records for in the timesheet history table
			// SQL = "SELECT COUNT(DISTINCT project_code) FROM [ist440grp1sp15].[timesheet].[history] WHERE employee_id = 'mas1234' AND expiration_date IS null AND weekday_date >= '2015-03-22' AND weekday_date < '2015-03-29'";

			String currentProject = null;		
			String nextProject = null;
			Time startTime;
			Time endTime;
			double totalHours;

			// Selects all timesheet history records for a specific employee ordered by project_code and again by weekday_date to properly populate the weeklyProjects ArrayList
			//SQL = "SELECT project_code, weekday_date, start_time, end_time, total_hours FROM timesheet.history WHERE employee_id = '" + empID + "' AND expiration_date IS null AND weekday_date >= '2015-03-22' AND weekday_date <= '2015-03-28' ORDER BY project_code, weekday_date";		
			SQL = "SELECT project_code, weekday_date, start_time, end_time, total_hours FROM timesheet.history WHERE employee_id = '" + empID + "' AND expiration_date IS null AND weekday_date >= '" + weekBeginsOn + "' AND weekday_date <= '" + weekEndsOn + "' ORDER BY project_code, weekday_date";
			//SQL = "SELECT project_code, weekday_date, start_time, end_time, total_hours FROM timesheet.history WHERE employee_id = '" + empID + "' AND expiration_date IS null" + " ORDER BY project_code, weekday_date";

			rs = stmt.executeQuery(SQL);		

			while (rs.next()) {
				nextProject = rs.getString("project_code");			
				dayOfWeekIndex = rs.getDate("weekday_date").getDay();
				startTime = rs.getTime("start_time");
				endTime = rs.getTime("end_time");
				totalHours = (double) rs.getFloat("total_hours");			
				// when the next project is not equal to the current project the next project is added as a new project to the weeklyProjects ArrayList and becomes the current project being populated
				if (!nextProject.equals(currentProject)) {
					addProject(nextProject);
					projCodeIndex++;
					currentProject = nextProject;
				}
				// System.out.print(nextProject);
				// adds timesheet.jsp history table data from all records for each day of the week for each project code
				System.out.println(dayOfWeekIndex);
				weeklyProjects.get(projCodeIndex-1).setStartTime(dayOfWeekIndex, startTime);
				System.out.print(weeklyProjects.get(projCodeIndex-1).getStartTime(dayOfWeekIndex));
				weeklyProjects.get(projCodeIndex-1).setEndTime(dayOfWeekIndex, endTime);
				System.out.print(weeklyProjects.get(projCodeIndex-1).getEndTime(dayOfWeekIndex));
				weeklyProjects.get(projCodeIndex-1).setDailyTotalHours(dayOfWeekIndex, totalHours);
				System.out.print(weeklyProjects.get(projCodeIndex-1).getDailyTotalHours(dayOfWeekIndex) + "\n");
				weeklyProjects.get(projCodeIndex-1).setIsRecord(dayOfWeekIndex);
			}
			rs.close();

			for (int pIndex = 0; pIndex < weeklyProjects.size(); weeklyProjects.get(pIndex).setWeeklyTotalHours(), pIndex++) {}

            setDailySubTotalHours();
            setWeeklyGrandTotalHours();
		}
		catch(SQLException se){
			//Handle errors for JDBC
			se.printStackTrace();
		}
		catch(Exception e){
			//Handle errors for Class.forName
			e.printStackTrace();
		}
		finally{
			//finally block used to close resources
			try{
				if(stmt!=null)
					con.close();
			}
			catch(SQLException se){
			}// do nothing
			try{
				if(con!=null)
					con.close();
			}
			catch(SQLException se){
				se.printStackTrace();
			}//end finally try
		}//end try
	}

    public void setDailySubTotalHours () {
		for (int day = 0; day < 7; dailySubTotalHours[day] = 0, day++) {} // initializes sub total hours at 0 for each day of the week
		for (int day = 1; day < 6; day++) {for (int pIndex = 0; pIndex < weeklyProjects.size(); dailySubTotalHours[day] += weeklyProjects.get(pIndex).getDailyTotalHours(day), pIndex++) {}}
	}

    public double getDailySubTotalHours (int theDay) {
		return dailySubTotalHours[theDay];
	}

    public void setWeeklyGrandTotalHours () {
        for (int pIndex = 0; pIndex < weeklyProjects.size(); weeklyGrandTotalHours += weeklyProjects.get(pIndex).getWeeklyTotalHours(), pIndex++) {}
    }

    public double getWeeklyGrandTotalHours () {
        return weeklyGrandTotalHours;
    }

    public String getDateLabels (int theDay) {
    	return dateLabels[theDay];
    }
}