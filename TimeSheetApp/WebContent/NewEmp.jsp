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
<title>Add Employee</title>
	
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		
		<!-- Optional theme -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		
		<!-- Latest compiled and minified JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
		
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/CSS/newemp.css">


</head>
<body>


<img src="${pageContext.request.contextPath}/Images/logo.jpg" alt="logo" style="width:175px;height:125px">

<table id="session" >
	<tr>
		<td>
			<span class="label label-default col-m-8" >Signed in as</span>
		
		</td>
		
		<td><!-- session state for user -->
			<input type="text" class="form-control" aria-describedby="basic-addon1" value="<%=session.getAttribute("UserName") %>" readonly > 
		
		</td>
		
		<td>
			<form method="post" action="logout.jsp">
			<button type="submit" class="btn btn-default" >Logout</button>
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
		  
 <form class="form-horizontal" role="form" action="addEmp.jsp" method="post" >
    <div class="form-group">
      <label class="control-label col-sm-2" for="empid">EmpID:</label>
      <div class="col-sm-5">
        <input type="number" class="form-control" name="empid" placeholder="Employee Id">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="fname">First Name:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="fname" placeholder="First Name">
      </div>
    </div>
  
  <div class="form-group">
      <label class="control-label col-sm-2" for="lname">Last Name:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="lname" placeholder="Last Name">
      
      </div>
    </div>
  
  
  <div class="form-group">
      <label class="control-label col-sm-2" for="init">Middle Name:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="middle" placeholder="Middle Name">
      </div>
    </div>
    
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="ssn">SSN:</label>
      <div class="col-sm-5">          
        <input type="number" class="form-control" name="ssn" placeholder="SSN">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="dob">Date Of Birth</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="dob" placeholder="Date of Birth">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="gender">Gender</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="gender" placeholder="Gender">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="manager">Manager Id:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="manager" placeholder="Manager Id">
      </div>
    </div>
  
  	<div class="form-group">
      <label class="control-label col-sm-2" for="title"> Title Id:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="title" placeholder="Employee Title">
      </div>
    </div>
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="username">User Name:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="username" placeholder="User Name">
      </div>
    </div>
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="password">PassWord:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="password" placeholder="PassWord">
      </div>
    </div>
    
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="doh">Date Of Hire:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="doh" placeholder="Date of Hire">
      </div>
    </div>
    
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="term">Date of Termination:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="term" placeholder="Termination" readonly>
      </div>
    </div>
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="create">Create Date:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="create" placeholder="Date Created">
      </div>
    </div>
    
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="delete">Delete Date:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="delete" placeholder="Deleted On" readonly>
      </div>
    </div>
    
    
   <!--   <div class="form-group"> -->
     <!--  <label class="control-label col-sm-2" for="emptype">Employee Type:</label> -->
       <!-- <div class="col-sm-5">          
        <!-- <input type="checkbox" class="checkbox-inline" id="sal" Value=""> Salary -->
        <!-- <input type="checkbox" class="checkbox-inline" id="hrly" Value=""> Hourly -->
        <!-- <input type="checkbox" class="checkbox-inline" id="prt" Value=""> Part Time -->
        <!-- <input type="checkbox" class="checkbox-inline" id="intrn" Value=""> Intern -->
      <!-- </div> -->
    <!-- </div> -->
    

    
  <!-- Button submit -->
  
     <div class="form-group" >        
      <div class="col-sm-offset-2 col-sm-10">
      
        <button type="submit" class="btn btn-primary">Submit</button>
      
      </div>
    </div>
    
    
 </form><!-- This ends the entire form that post up to server -->
  
		  
		  
		
		  </div><!-- ends center page -->

        
  
  </div>
         <div class="panel panel-default" id="footer">
		<p> IST 440 Group 1 Spring 2015 </p>
		</div>


</body>
</html>
