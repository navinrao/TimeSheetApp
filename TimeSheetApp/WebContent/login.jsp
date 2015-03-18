

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>

			<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}//CSS/login.css" >
			


</head>
<body>

	<img src="${pageContext.request.contextPath}/Images/logo.jpg" alt="logo" style="width:175px;height:125px">


<div class="container">

	<div class="panel panel-info">
 	 <div class="panel-heading"><h4>Please Sign In</h4></div>
  	</div>

<div class="jumbotron">

	
		
      <form class="form-signin" id="login" method="post" action="index.jsp">
       
        <label for="username" class="sr-only">User Name</label>
        <input type="text" name="username" id="user" class="form-control"  required >
        <label for="password" class="sr-only">Password</label>
        <input type="password" name="password"  id="pass" class="form-control" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
      </form>
      
      
    
     
      
	</div><!-- end jumbotron -->

    	<div class="panel panel-primary">
		<p> IST 440 Group 1 Spring 2015 </p>
		</div>

    </div> <!--  end container -->



</body>
</html>