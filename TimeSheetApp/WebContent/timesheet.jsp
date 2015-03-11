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
<title>Time Sheet</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/newemp.css">






<!-- Loads JQuery from Google CDN -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

    <!--Used for JQuery Timepicker-->
<script type="text/javascript" src="../plugins/jquery.timepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="../plugins/jquery.timepicker.css">
    
    
    
    <!-- JavaScript for current Page -->
<script type="text/javascript">

    $(document).ready(function () {
        // Populates dates below days on document load
        (function populateDates() {
            var today = new Date();     // holds the current date
            var dayOfTheWeek = today.getDay();  // holds the day of the week (from 0-6)
            var miliSeconds = today.getTime();  // holds the number of milliseconds from 1970 to now

            // Iterates through all date class elements to find current day of the week
            $('.date').each(function (index) {

                // date holds number of milliseconds from 1970 to this Sunday (beginning of the week)
                var date = new Date(miliSeconds - (dayOfTheWeek * 24 * 60 * 60 * 1000));
                var month = date.getMonth() + 1;    // Holds month, 0-indexed
                var dayOfMonth = date.getDate();    // holds date (ex: 17)
                this.innerHTML = (month + "/" + dayOfMonth);    // inserts date into HTML in table
                miliSeconds += 24 * 60 * 60 * 1000;             // adds one day to milliseconds to get next date
            });
        })();
    });

    /* Calculates the difference in time between two timepickers. This method is called when a timepicker time is changed*/
    var calculateTime = function () {

        // Verifies a project has been selected first
        if ($('.timepicker').parent().parent().hasClass("selected")) {
            // Gets input time values
            var valuestart = $('.selected > td > input.timepicker')[0].value;         // gets first timepicker under selected row
            var valuestop = $('.selected > td > input.timepicker')[1].value;         // gets second timepicker under selected row

            // exits calculateTime method if end time hasn't been selected yet
            if (valuestop == "")
                return;

            // Stores AM or PM
            var endTimeOfDay = valuestop.split(" ")[1];   // AM or PM
            var startTimeOfDay = valuestart.split(" ")[1];  // AM or PM

            // Gets Time without AM or PM
            var startTime = valuestart.split(" ")[0];    // time without AM or PM
            var endTime = valuestop.split(" ")[0];    // time without AM or PM

            // Stores hours
            var endHours = endTime.split(":")[0];
            var startHours = startTime.split(":")[0];

            if (endTimeOfDay == "PM" && endHours != "12")
                endHours = Number(endHours) + 12;   // ensures addition on numbers, not strings

            if (startTimeOfDay == "PM" && startHours != "12")
                startHours += 12;

            var hours = endHours - startHours;
            var minutes = endTime.split(":")[1] - startTime.split(":")[1];

            if (minutes < 0) {
                hours--;
                minutes += 60;
            }
            var hoursWorked = hours + (minutes / 60);
            var foundSelectedDay = $('.selectedDay');
            foundSelectedDay.val(hoursWorked);
        }
    }

	// Function adds projects and corresponding rows to the timesheet
    var addProject = function () {

        var x = document.getElementById("project").value;
        if (x == "Project 1") {
        	document.getElementById("proj1").disabled = true;
        	getTableHTML(x);
        }
        else if (x == "Project 2") {
        	document.getElementById("proj2").disabled = true;
        	getTableHTML(x);
        }
        else if (x == "Project 3") {
        	document.getElementById("proj3").disabled = true;
        	getTableHTML(x);
        }
        //reinitialize timepicker (necessary)
        $('.timepicker').timepicker({
            minTime: '6:00am', interval: 15, change: function (time) {
                calculateTime();
            }
        });
    }
    //<!-- Inserts a new row for new project -->
    var getTableHTML = function (name) {
        $(".table > tbody:last").append("<tr class='unselected'> <td><button class='projBtn' onclick=selectRow(this)>" + name + "</button></td>"
	    + "<td><input class='timepicker'></td><td><input class='timepicker'></td><td><input type='number' class='Sun' disabled></td>"
   	    + "<td><input type='number' class='Mon' disabled></td><td><input type='number' class='Tues'  disabled></td>"
   	    + "<td><input type='number' class='Wed'  disabled></td><td><input type='number' class='Thurs'  disabled>"
   	    + "</td><td><input type='number' class='Fri'  disabled ></td><td><input type='number' class='Sat'  disabled></td>"
   	    + "<td><input type='number' class='total'  disabled></td>");
    }
    /* Highlights specific row and adds "selected" class attribute */
    var selectRow = function (btn) {
        /* Deselects rows */
        $('.projBtn').parent().parent().css("background", "#EEEEEE");
        $('.projBtn').parent().parent().removeClass("selected").addClass("unselected");

        /* Selects row clicked on */
        $(btn).parent().parent().css("background", "#a4dbde");          // highlights "btn" which was clicked
        $(btn).parent().parent().removeClass("unselected").addClass("selected");

        $(":input").removeClass("selectedDay");    // removes any previously selected days (for timepicker)
    }
    /* If the user has selected a project, the day is selected for where the timepicker places hours worked */
    var selectColumn = function (btn) {
        var selectedDay = btn.innerHTML;    // finds out which button was pressed

        /* checks to see if any project has been selected*/
        $("." + selectedDay).each(function (index) {
            if ($(this).parent().parent().hasClass("selected")) {

                /* Deselects all columns */
                $("." + selectedDay).each(function () {
                    $(this).css("background", "white");       // was #EEEEEE
                })

                /* Selects clicked on column only */
                $(":input").removeClass("selectedDay");    // removes any previously selected days
                $(this).removeClass("unselectedDay").addClass("selectedDay");
                $(this).css("background", "#0CF25D");   // makes it green
                return;
            }
        });
    }
    </script>
				


</head>
<body>
<img src="${pageContext.request.contextPath}/Images/logo.jpg" alt="logo" style="width:175px;height:125px">

<table id="session" >
	<tr>
				<td>
					<!--  <span class="label label-default col-m-8" >Signed in as</span> -->
					<h4>Signed in <span class="label label-default"> <%=session.getAttribute("UserName") %>  </span ></h4 >
				</td>
		
			<td><!-- session state for user -->
				<!--  <input type="text" class="form-control" aria-describedby="basic-addon1" value="<%=session.getAttribute("UserName") %>" readonly > -->
			
			</td>
		
			<td>
				<form method="post" action="logout.jsp">
				<button type="submit" class="btn-group btn-group-xs" >Logout</button>
				</form>
			</td>
		
		
		</tr>
	
</table>



<nav class="navbar navbar-info">
  <div class="container-fluid">
    <div class="navbar-header">
    
    </div>
    <div>
      <ul class="nav navbar-nav">
        <li class="active"><a href="welcome.jsp">Home</a></li>
        <li><a href="timesheet.jsp">Time Sheet</a></li>
        <li><a href="NewEmp.jsp">New Employee</a></li>
         <li><a href="#">Profile</a></li>
        <li><a href="#">About Us</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container">
  <div class="jumbotron">
  
  <!-- Here is the center of the page -->
    
    <div class="table-responsive">          
      <table class="table">
        <thead>
          <tr>
            <th>Project Code</th>
            <th>Start</th>
            <th>End</th>
            <th><button onclick="selectColumn(this)">Sun</button></th>
            <!--The button inner HTML below corresponds to JS code in selectColumn method-->
            <th><button onclick="selectColumn(this)">Mon</button></th>
            <th><button onclick ="selectColumn(this)">Tues</button></th>
            <th><button onclick="selectColumn(this)">Wed</button></th>
            <th><button onclick="selectColumn(this)">Thurs</button></th>
            <th><button onclick="selectColumn(this)">Fri</button></th>
            <th><button onclick="selectColumn(this)">Sat</button></th>
            <th>TOTAL</th>
          </tr>
		  <tr>
			<th></th>
			<th></th>
			<th></th>
			<!--Holds the current dates. ID and class are used in JQuery-->
			<th id="0" class="date"></th>
			<th id="1" class="date"></th>
            <th id="2" class="date"></th>
            <th id="3" class="date"></th>
            <th id="4" class="date"></th>
            <th id="5" class="date"></th>
            <th id="6" class="date"></th>
		  </tr>
        </thead>
        <tbody>
        	<tr></tr>
        </tbody>
        <tfoot>
	    	<td>
				<select id ="project" onchange="addProject()">
				  <option value="">Project</option>
				  <option id="proj1" value="Project 1">Project 1</option>
				  <option id="proj2" value="Project 2">Project 2</option>
				  <option id="proj3" value="Project 3">Project 3</option>
				</select>
            </td>
            
           
            
        </tfoot>
        
        
      </table>
      		
      		<!-- this starts button div -->
      		
      		
      <div class="form-group" >        
      <div class="col-sm-offset-1 col-sm-2">
      
        <button type="submit" class="btn btn-lg btn-info btn-block">Submit</button>
        </div>
        <div class="col-sm-offset-1 col-sm-2">
        <button type="submit" class="btn btn-lg btn-info btn-block">Save</button>
      </div>
      </div>
      
      		
    </div>
      		
      		
                       
      
      </div>   
    
    
    

  </div><!-- ends center page -->

        
  
  </div>
         <div class="panel panel-default" id="footer">
		<p> IST 440 Group 1 Spring 2015 </p>
		</div>


</body>
</html>