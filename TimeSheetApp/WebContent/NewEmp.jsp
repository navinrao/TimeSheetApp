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

	
		<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="http://jqueryvalidation.org/files/dist/jquery.validate.min.js"></script>
		<script type="text/javascript" src="http://jqueryvalidation.org/files/dist/additional-methods.min.js"></script>

</head>
<body>


<img src="${pageContext.request.contextPath}/Images/logo.jpg" alt="logo" style="width:175px;height:125px">

<table id="session" >
	<tr>
				<td>
					<!--  <span class="label label-default col-m-8" >Signed in as</span> -->
					<h4>Signed in <span class="label label-default"> <%=session.getAttribute("UserName") %>  </span ></h4 >
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
        <li><a href="timesheet2.jsp">Time Sheet</a></li>
        <li><a href="NewEmp.jsp">New Employee</a></li>
        <li><a href="addproj.jsp">Projects</a></li>
        <li><a href="#">About Us</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container">
  <div class="jumbotron">
  
		  <!-- Here is the center of the page -->
		  
 <form class="form-horizontal" onSubmit="return checkblanks()"  action="addEmp.jsp" method="post" >
    <div class="form-group">
      <label class="control-label col-sm-2" for="empid">EmpID:</label>
      <div class="col-sm-5">
        <input type="text"  id="emp_id" class="form-control" name="empid" 
        	pattern="(?=.*\d)(?=.*[a-z]).{6,8}"  title="Field must be 7 character long and must begin with 3 letters">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="fname">First Name:</label>
      <div class="col-sm-5">          
        <input type="text" id="emp_fname"  class="form-control" name="fname" >
      </div>
    </div>
  
  <div class="form-group">
      <label class="control-label col-sm-2" for="lname">Last Name:</label>
      <div class="col-sm-5">          
        <input type="text"  id="emp_lname" class="form-control" name="lname">
      
      </div>
    </div>
  
  
  <div class="form-group">
      <label class="control-label col-sm-2" for="init">Middle Name:</label>
      <div class="col-sm-5">          
        <input type="text"  id="emp_init" class="form-control" name="middle">
      </div>
    </div>
    
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="ssn">SSN:</label>
      <div class="col-sm-5">          
        <input type="text"  id="emp_ssn" class="form-control" name="ssn" 
        	pattern="([0-9]).{8,10}" title="Must be numbers without - ">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="dob">Date Of Birth</label>
      <div class="col-sm-5">          
        <input type="text"   id="emp_dob"class="form-control" name="dob" 
        	pattern="\d{4}-\d{1,2}-\d{1,2}" title ="Enter DoB as yyyy-mm-dd">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="gender">Gender</label>
      <div class="col-sm-5">          
        <input type="text" id="emp_gen" class="form-control" name="gender" 
        		pattern="([m,f,o]).{0,2}" title="Must be m, f, or o - ">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="manager">Manager Id:</label>
      <div class="col-sm-5">          
        <input type="text" id="emp_manId" class="form-control" name="manager"
        		pattern="([1,2,3]).{0,2}" title="Must be 1, 2, or 3 - ">
      </div>
    </div>
  
  	<div class="form-group">
      <label class="control-label col-sm-2" for="title"> Title Id:</label>
      <div class="col-sm-5">          
        <input type="text" id="emp_title" class="form-control" name="title" 
        	pattern="([1,2,3]).{0,2}" title="Must be 1, 2, or 3 - ">
      </div>
    </div>
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="username">User Name:</label>
      <div class="col-sm-5">          
        <input type="text" id="emp_Uname" class="form-control" name="username" >
      </div>
    </div>
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="password">PassWord:</label>
      <div class="col-sm-5">          
        <input type="text" id="emp_pword"class="form-control" name="password" 
         	pattern=".{4,6}" title="between 4 and 6 characters">
      </div>
    </div>
    
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="doh">Date Of Hire:</label>
      <div class="col-sm-5">          
        <input type="text" id="emp_doh"class="form-control" name="doh" 
        	pattern="\d{4}-\d{1,2}-\d{1,2}" title ="Enter DoB as yyyy-mm-dd">
      </div>
    </div>
    
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="term">Date of Termination:</label>
      <div class="col-sm-5">          
        <input type="text"  class="form-control" name="term" placeholder="Termination" readonly>
      </div>
    </div>
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="create">Create Date:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="create"
        	pattern="\d{4}-\d{1,2}-\d{1,2}" title ="Enter DoB as yyyy-mm-dd">
      </div>
    </div>
    
    
        <div class="form-group">
      <label class="control-label col-sm-2" for="delete">Delete Date:</label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" name="delete" placeholder="Deleted On" readonly>
      </div>
    </div>
    

    
  <!-- Button submit -->
  
     <div class="form-group" >        
      <div class="col-sm-offset-2 col-sm-10">
      
        <button type="submit" id="btn_submit" class="btn btn-primary">Submit</button>
        
       </div>
    </div>
    

    
    
    
 </form><!-- This ends the entire form that post up to server -->
  
		  
		  
		
		  </div><!-- ends center page -->

        
  
  </div>
         <div class="panel panel-default" id="footer">
			<p> IST 440 Group 1 Spring 2015 </p>
			<p> Professor: Taghi Ozbeki </p>
		

		</div>

	<script >
		function checkblanks()
		{
			var errMsg ="";
			if(document.getElementById('emp_id').value == "")
			{
				errMsg+="Please enter id \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_fname').value == "")
			{
				errMsg+="Please enter First name \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_lname').value == "")
			{
				errMsg+="Please enter last name \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_init').value == "")
			{
				errMsg+="Please enter  middle initial name \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_ssn').value == "")
			{
				errMsg+="Please enter  ssn name \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_dob').value == "")
			{
				errMsg+="Please enter DOB \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_gen').value == "")
			{
				errMsg+="Please enter gender\n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_manId').value == "")
			{
				errMsg+="Please enter manager Id \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_title').value == "")
			{
				errMsg+="Please enter title \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_Uname').value == "")
			{
				errMsg+="Please enter user name \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_pword').value == "")
			{
				errMsg+="Please enter password \n";
				//alert("empid");
				//return false;
			}
			if(document.getElementById('emp_doh').value == "")
			{
				errMsg+="Please enter date of hire \n";
				//alert("empid");
				//return false;
			}

			if(errMsg!="")
			{
				
				alert(errMsg);
				return false;
			}
		


		}//end checkblanks function
		
	

	
	</script>

</body>
</html>
