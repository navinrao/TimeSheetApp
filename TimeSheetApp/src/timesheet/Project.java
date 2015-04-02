package timesheet;

import java.sql.Time;

public class Project {
	public final String projectCode; // must be a valid project code
	public Time[] startTime = new Time[7]; // will be constructed as null
	public Time[] endTime = new Time[7]; // will be constructed as null
	public double[] dailyTotalHours = new double[7]; // total hours for a project during each day between startTime[day] & endTime[day]
	public boolean[] isRecord = new boolean[7]; // indicates data was retrieved from database so user cannot change
	public double weeklyTotalHours = 0; // total hours for all days of the week
	public int day; // day of the week index for all project data related arrays (0-Sunday, 1-Monday, 2-Tuesday, 3-Wednesday, 4-Thursday, 5-Friday, 6-Saturday)
	
	public Project (String theProjCode) {
		projectCode = theProjCode; // sets the instance variable to a valid project code
		for (day = 0; day < 7; dailyTotalHours[day] = 0, isRecord[day] = false, day++) {}
	}
	
	public String getProjectCode() {
		return projectCode;
	}

	public Time getStartTime (int theDay) {
		return startTime[theDay];
	}

	public void setStartTime (int theDay, Time theTime) {
		startTime[theDay] = theTime;
	}
	public Time getEndTime (int theDay) {
		return endTime[theDay];
	}
	
	public void setEndTime (int theDay, Time theTime) {
		endTime[theDay] = theTime;
	}
	
	public void calculateDailyTotalHours (int theDay) {
                dailyTotalHours[theDay] = (double) (getEndTime(theDay).getTime() - getStartTime(theDay).getTime()) / 360000.0;
	}

	public double getDailyTotalHours (int theDay) {
                return dailyTotalHours[theDay];
	}
	
	public void setDailyTotalHours (int theDay, double theTotalHours) {
                dailyTotalHours[theDay] = theTotalHours;
	}
	
	public double getWeeklyTotalHours () { // 0 thru 6 OR Sunday Monday Tuesday Wednesday Thursday Friday Saturday
		return weeklyTotalHours;
    }
    
	public void setWeeklyTotalHours () { // 0 thru 6 OR Sunday Monday Tuesday Wednesday Thursday Friday Saturday
        for (day = 0; day < 6; weeklyTotalHours += dailyTotalHours[day], day++) {}
	}
	
    public void setIsRecord (int theDay) {
            isRecord[theDay] = true;
    }
    
    public boolean getIsRecord (int theDay) {
            return isRecord[theDay];
    }
}
