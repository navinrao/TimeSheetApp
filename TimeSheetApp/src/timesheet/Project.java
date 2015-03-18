package timesheet;

import java.util.Date;

public class Project {
	String projCode; // must be a valid project code
	Date[] startTime = new Date[5]; // will be constructed as null
	Date[] endTime = new Date[5]; // will be constructed as null
	double[] dailyTotalHours = new double[5]; // total daily hours between startTime[day] & endTime[day]
	double weeklyTotalHours = 0; // total hours for each day of the week
	int day; //index for arrays used in methods (0-Monday, 1-Tuesday, 2-Wednesday, 3-Thursday, 4-Friday
	
	public Project (String theProjCode) {
		projCode = theProjCode; // sets the instance variable to a valid project code
		for (int d = 0; d < 5; startTime[d] = null, endTime[d] = null, dailyTotalHours[d] = 0, d++) {
			
		} // for all days of week initializes startTime & endTime as null and dailyTotalHours as 0
		// add SQL Database Connection to populate all data from existing timesheet_history table records
	}
	public String getProjCode() {
		return projCode;
	}
	
	public void setStartTime (int theDay, Date theStartTime) {
		startTime[theDay] = theStartTime;
	}
	
	public Date getStartTime (int theDay) {
		return startTime[theDay];
	}
	
	public void setEndTime (int theDay, Date theEndTime) {
		endTime[theDay] = theEndTime;
	}
	
	public Date getEndTime (int theDay) {
		return endTime[theDay];
	}
	
	public void setDailyTotalHours (int theDay) {
		dailyTotalHours[theDay] = (double) (endTime[theDay].getTime() - startTime[theDay].getTime()); // will need to be adjusted to reflect HOURS as a decimal rather than the predefined getTime value units
	}
	
	public double getDailyTotalHours (int theDay) { // may need to be converted to String for HTML element
		return dailyTotalHours[theDay];
	}
	
	public double getWeeklyTotalHours () { // may need to be converted to String for HTML element
		for (int d = 0; d < 5; weeklyTotalHours += dailyTotalHours[d], d++) {}
		return weeklyTotalHours;
	}	 
}
