<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>MOM SignUp</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- MetisMenu CSS -->
        <link href="css/metisMenu.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/startmin.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">

		<link href="<c:url value="/css/bootstrap-datetimepicker.css" />" rel="stylesheet">
		
		<!-- jQuery -->
        <script src="js/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="js/metisMenu.min.js"></script>

        <!-- Custom Theme JavaScript -->
        <script src="js/startmin.js"></script>
        
        <script src="js/moment-with-locales.js"></script>
		<script src="js/bootstrap-datetimepicker.js"></script>
        
    </head>
    <body>

        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Sign Up</h3>
                        </div>
                        <div class="panel-body">
                            <form name="userform" role="form" action="registerForm" method="post">
                                <fieldset>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Username" id="username" name="username" required="required" type="text" autofocus>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Email" name="email" id="useremail" required="required" type="email">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Password" id="password" name="password" type="password" required="required" value="">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Firstname" name="firstname" id="fname" required="required" type="text">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Lastname" name="lastname" id="lname" required="required" type="text">
                                    </div>
                                    <div class="form-group">
                                        <textarea class="form-control" placeholder="Address" rows="3" required="required" name="address"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Company" id="address" name="company" type="text">
                                    </div>
                                    <div class="form-group" style="position:relative">
                                        <input type="text" class="form-control" placeholder="BirthDate" required name="bdate" id='birthdatepicker'>
                                    </div>
                                    <input class="btn btn-lg btn-success btn-block" type="submit" name="submit" id="btnsub" value="Register">
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

	<script type="text/javascript">
		 $(document).ready(function(){
			 
          	$("#birthdatepicker").datetimepicker({
                useCurrent: false,
                maxDate: moment(),
                format: 'DD/MMM/YYYY'
            });
           
          	$("#useremail").change(function(event){           
	     	   email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
	 		   if(!email_regex.test($("#useremail").val())){ alert('this is not valid email'); $("#useremail").val("");  }
	 		   
	       		$.get("isEmailAlreadyRegistered", { useremail:$("#useremail").val() } )
				.done(function(data){
					console.log(data);
					if(data == "Email is already registered"){
						$("#useremail").val("");
						console.log("This email address is already registered. kinldy add new email");
	   		   			alert("This email address is already registered. kinldy add new email");
	   		   			
	            	}
				});    		
           });
            
          	$("#btnsub").click(function(event){
          		 alphabets_nospace_regex = /^[a-zA-Z0-9@_]+$/;
          		 password_regex = /^[a-zA-Z0-9]+$/;
          		 alphabets_withspace_regex = /^[a-zA-Z\s]+$/;
  	 		   	 if(!alphabets_nospace_regex.test($("#username").val())){ alert('No Space or Special characters(except @, _ ) allowed in username');  return false}
  	 		     if(!password_regex.test($("#password").val())){ alert('No Space allowed in password');  return false}
  	 			 if(!alphabets_withspace_regex.test($("#fname").val())){ alert('Enter only alphabets in Firstname');  return false}
  	 			 if(!alphabets_withspace_regex.test($("#lname").val())){ alert('Enter only alphabets in Lastname');  return false}
  	 		   	 
  	 		   	 if($("#username").val().length > 20){ alert('Maximum 20 characters allowed in username');  return false}
  	 		  	 if($("#password").val().length > 12){ alert('Maximum 12 characters allowed in password');  return false}
  	 			 if($("#fname").val().length > 50){ alert('Maximum 50 characters allowed in Firstname');  return false}
  	 			 if($("#lname").val().length > 50){ alert('Maximum 50 characters allowed in Lastname');  return false}  	 		   		 
  	 		   	 
          	});
           
       });
   </script>
  

    </body>
</html>