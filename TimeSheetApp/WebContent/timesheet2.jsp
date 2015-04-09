<%@ page import="timesheet.Projects" language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


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
<script type="text/javascript" src="${pageContext.request.contextPath}//plugins/jquery.timepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}//plugins/jquery.timepicker.css">
    
    
    
    <!-- JavaScript for current Page -->
<script type="text/javascript">
	//var isPopulated = false;	// ensures code doesn't re-execute and repopulate
	<%

	request.getSession(true);
	if(session.getAttribute("UserName")== null)
	response.sendRedirect("login.jsp");
	
	Projects user1 = new Projects("mas1234");
	
	%>
    $(document).ready(function () {
        // Populates dates below days on document load
       // alert("Document Ready Function Run");	// Lets us know everytime the DOM is reloaded
        
        // Hides all rows with the class attribute (all rows with project codes have a class attribute)
/*         $("tr").each(function(index) {
        	if($(this).attr("class"))
            	$(this).hide();
        }); */
       
        $(".start_time").each(function(index) {
        	$(this).children().hide();			// hides all nested start_time elements in start time cell
        });
        
        $(".end_time").each(function(index) {
        	$(this).children().hide();			// hides all nested end_time elements in end time cell
        	}); 
        
        $(".start_1").show();
        $(".end_1").show();

        
        
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
        
        // Populates  Drop Down Menu from projCodesMenu ArrayList
        (function populateDropDownMenu() {
         	//alert("isPopulated : " + isPopulated);
         	//if (isPopulated == true) 
        	//	return;
            <% 
            for (int i = 0; i < user1.projCodesMenu.size(); i ++) {
           		String temp = user1.projCodesMenu.get(i);
        	%>
        	// i needs to be added by 1 in the option tag because it starts at 1 and not 0
            $("#project").append("<option value=<%=i + 1%>><%=temp%></option>");
        	<%
            }
            %>
            //isPopulated = true;
            //alert("isPopulated is now " + isPopulated);
        }) ();
    	/* Added 3/17/15 */
        // Populates drop down menu (id = project) with projects from "projCodesMenu" Java class
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

	// Commented out for the good of humanity. Too complicated. 
	////////////////////////////////////////////////////////////////////
<%--     <%= "	var addProject = function (selectedProject) { " + 
    		"alert('called addProject');" + 
    		"var index = selectedProject.selectedIndex;" + 
    		"alert('a');" + 
    		"var projectCode = selectedProject.options[index].innerHTML;" +
    	    "alert('b');" + 
            "var x = document.getElementById('project').value;" +
    		"alert('c');" +
            "window.location.replace('timesheet.jsp?project='+projectCode);	// posts 'projectCode' variable in URL so we can pass JS variable to Java" 
    %>
            <% 
            String theProjectCode = request.getParameter("project"); 
    		System.out.println("Project Selected : " + theProjectCode);
    		user1.addProject(theProjectCode);
    		%> --%>
    //////////////////////////////////////////////////////////////////////
    
    
	var addProject = function (selectedProject) {

		//alert("called addProject");
		var index = selectedProject.selectedIndex;
		var projectCode = selectedProject.options[index].innerHTML;

		$("."+projectCode).show();	// Displays row with project code that was selected
		// Hides option tag in Drop Down Menu after selection
		$("option").each(function(index) {
			if (this.innerHTML == projectCode)
				$(this).hide();
		});
        //var x = document.getElementById("project").value;
<%--         window.location.replace("timesheet.jsp?project="+projectCode);	// posts "projectCode" variable in URL so we can pass JS variable to Java
        
		<% String theProjectCode = request.getParameter("project");
		System.out.println("Project Selected : " + theProjectCode);
		user1.addProject(theProjectCode);
 		 %>
 		 
		var test = document.getElementById("project");
        while (test.firstChild) {
        	test.removeChild(test.firstChild);
        } --%>
        
<%-- 		<%
        for (int i = 0; i < user1.projCodesMenu.size(); i ++) {
        		String temp = user1.projCodesMenu.get(i);
     	%>
     	// it needs to be added by 1 in the option tag because it starts at 1 and not 0
         	$("#project").append("<option value=<%=i + 1%>><%=temp%></option>");
     	<%
         }
		%> --%>
    }
		//getTableHTML(message);
		
/*         if (x == "Project 1") {
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
/*     var selectColumn = function (btn) {
        var selectedDay = btn.innerHTML;    // finds out which button was pressed

        // checks to see if any project has been selected
        $("." + selectedDay).each(function (index) {
            if ($(this).parent().parent().hasClass("selected")) {

                // Deselects all columns 
                $("." + selectedDay).each(function () {
                    $(this).css("background", "white");       // was #EEEEEE
                });

                // Selects clicked on column only 
                $(":input").removeClass("selectedDay");    // removes any previously selected days
                $(this).removeClass("unselectedDay").addClass("selectedDay");
                $(this).css("background", "#0CF25D");   // makes it green
                return;
            }
        });
    } */
    
    var showTimes = function(btn) {
        var day = btn.innerHTML;    // finds out which button was pressed

        $(".start_time").each(function(index) {
        	$(this).children().hide();			// hides all nested start_time elements in start time cell
        });
        
        $(".end_time").each(function(index) {
        	$(this).children().hide();			// hides all nested end_time elements in end time cell
        	}); 
        
        if (day == "Sun"){
        	$(".start_0").show();
        	$(".end_0").show();
        }
        else if (day == "Mon"){
        	$(".start_1").show();
        	$(".end_1").show();
        }
        else if (day == "Tues"){
        	$(".start_2").show();
        	$(".end_2").show();
        }
        else if (day == "Wed"){
        	$(".start_3").show();
        	$(".end_3").show();
        }
        else if (day == "Thurs"){
        	$(".start_4").show();
        	$(".end_4").show();
        }
        else if (day == "Fri"){
        	$(".start_5").show();
        	$(".end_5").show();
        }
        else if (day == "Sat"){
        	$(".start_6").show();
        	$(".end_6").show();
        }
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
         <li><a href="addproj.jsp">Projects</a></li>
        <li><a href="#">About Us</a></li>
      </ul>
          
          <input type="text" id="revision" size ="5" >
          
   
      
      
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
            <th><button onclick="showTimes(this)">Sun</button></th>
            <!--The button inner HTML below corresponds to JS code in selectColumn method-->
            <th><button onclick="showTimes(this)">Mon</button></th>
            <th><button onclick ="showTimes(this)">Tues</button></th>
            <th><button onclick="showTimes(this)">Wed</button></th>
            <th><button onclick="showTimes(this)">Thurs</button></th>
            <th><button onclick="showTimes(this)">Fri</button></th>
            <th><button onclick="showTimes(this)">Sat</button></th>
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
			<% for (int project = 0; project < user1.weeklyProjects.size(); project++) {
				//THE TABLE ROW STRUCTURE (11 TOTAL CELLS [9 LABELS & 14 INPUT BOXES])### %>
				<tr id ="<%=user1.weeklyProjects.get(project).getProjectCode()%>">
				
				<!--  ***PROJECT CODE (1 CELL)*** -->
				<td><label><%=user1.weeklyProjects.get(project).getProjectCode()%></label></td>
				
				<!--  ***START TIME (1 CELL)*** [one input box].show() based on today's date from java class or getDate().getDay() -->
				
				<td class="start_time">
					<input type="text" class="start_0" disabled value="<%=user1.weeklyProjects.get(project).getStartTime(0)%>"/>	<!-- Sunday -->
					<%for (int day = 1; day < 6; day++) { %>
						<input type="text" class="start_<%=day %>" value="<%=user1.weeklyProjects.get(project).getStartTime(day)%>" />		<!-- Monday to Friday -->
					<%}%>
					<input type="text" class="start_6" disabled value="<%=user1.weeklyProjects.get(project).getStartTime(6)%>"/>	<!-- Saturday -->
				</td>
				
				<!-- ***END TIME (1 CELL)*** [one input box].show() based on today's date from java class or getDate().getDay() -->
	
				<td class="end_time">
					<input type="text" class="end_0" disabled value="<%=user1.weeklyProjects.get(project).getEndTime(0)%>" />  <!-- Sunday -->
					<%for (int day = 1; day < 6; day++) { %>
						<input type="text" class="end_<%=day %>" value="<%=user1.weeklyProjects.get(project).getEndTime(day)%>" />	<!-- Monday to Friday -->
					<%}%>
					<input type="text" class="end_6" disabled value="<%=user1.weeklyProjects.get(project).getEndTime(6)%>"/> <!-- Saturday -->
				</td>
				
				
				<!--  ***TOTAL HOURS (7 CELLS)*** -->
				
				<td class="total_0"> <label><%=user1.weeklyProjects.get(project).getDailyTotalHours(0)%> </label> </td> <!-- [DISABLED]	//SUNDAY  -->
				<%for (int day = 1 ; day < 6; day++) { %>
					<td class="total_day"> <label><%=user1.weeklyProjects.get(project).getDailyTotalHours(day)%> </label></td>	<!-- //MONDAY-FRIDAY -->
				<%} %>
				<td class="total_6"> <label><%=user1.weeklyProjects.get(project).getDailyTotalHours(6)%> </label></td> <!-- [DISABLED]	//SATURDAY -->
					
				<!-- ***WEEKLY TOTAL HOURS (1 CELL)*** -->
				
				<td><label><%=user1.weeklyProjects.get(project).getWeeklyTotalHours() / 2%> </label></td> 		<!-- //SUNDAY-SATURDAY -->
			<%}%>
			</tr>
		</tbody>
<%--         <tbody>
        	<%for (int i = 0; i < user1.projCodesMenu.size(); i++)
        		{ %>
            	<tr class="<%=user1.projCodesMenu.get(i)%>">
            		<td><%=user1.projCodesMenu.get(i)%></td>		<!-- Displays project code name (ex: abc6) from DB in first cell of row -->
            		
            		<!-- 5 startTime input tags (are hidden)-->
            		<td class="startTime"><input style="width: 60px" value=""/></td>
            		<td class="startTime"><input style="width: 60px" value=""/></td>
            		<td class="startTime"><input style="width: 60px" value=""/></td>
            		<td class="startTime"><input style="width: 60px" value=""/></td>
            		<td class="startTime"><input style="width: 60px" value=""/></td>

            		
            		<!-- 5 endTime input tags (are hidden)-->
            		<td class="endTime"><input style="width: 60px" value=""/></td>
            		<td class="endTime"><input style="width: 60px" value=""/></td>
            		<td class="endTime"><input style="width: 60px" value=""/></td>
            		<td class="endTime"><input style="width: 60px" value=""/></td>
            		<td class="endTime"><input style="width: 60px" value=""/></td>


            		<!-- cells in table for days Sunday to Saturday -->
            		<td><input style="width: 60px" value="" disabled/></td>
            		<td><input style="width: 60px" value=""/></td>
            		<td><input style="width: 60px" value=""/></td>
            		<td><input style="width: 60px" value=""/></td>
            		<td><input style="width: 60px" value=""/></td>
            		<td><input style="width: 60px" value=""/></td>
            		<td><input style="width: 60px" value="" disabled/></td>
            		
            	</tr>
			<%
        		}
       		%>
        </tbody> --%>
        <tfoot>
	    	<td>
				<select id ="project" onchange="addProject(this)">
				</select>
            </td> 
        </tfoot>
      </table>
      		<!--  /////////////////////////////////////////////////////////////////////////////// -->

      		<!-- this starts button div -->
      		
      		
	<div class="form-group" >        
		<div class="col-sm-offset-1 col-sm-2">
      
        <button type="submit" class="btn btn-lg btn-info btn-block">Submit</button>
        </div>
        
       	<div class="col-sm-offset-1 col-sm-2">
 			<button type="submit" class="btn btn-lg btn-info btn-block">Save</button>
     	 </div>
			      
      	<div>
      		<div class="col-sm-offset-1 col-sm-2">
      		<a href="#" class="btn btn-info btn-lg">
    		<span class="glyphicon glyphicon-fast-backward"></span>
 			</a>	
	      	</div>
		</div>
     
     
  		<div>
  			<div class="col-sm-offset-1 col-sm-2">
    	  <a href="#" class="btn btn-info btn-lg">
        	<span class="glyphicon glyphicon-fast-forward"></span> 
    		 </a>
  			</div>
  		</div>
      
      </div>
      
      		
    </div>
      </div>   
  </div><!-- ends center page -->

       </div>
         <div class="panel panel-default" id="footer">
		<p> IST 440 Group 1 Spring 2015 </p>
		<p> Professor: Taghi Ozbeki </p>	
		</div>


</body>
</html>