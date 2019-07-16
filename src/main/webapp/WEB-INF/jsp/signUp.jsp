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
                            <form action="registerForm" method="post">
                                <fieldset>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Username" name="username" type="text" autofocus>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Email" name="email" type="email">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Password" name="password" type="password" value="">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Firstname" name="firstname" type="text">
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Lastname" name="lastname" type="text">
                                    </div>
                                    <div class="form-group">
                                        <textarea class="form-control" placeholder="Address" rows="3" name="address"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" placeholder="Company" name="company" type="text">
                                    </div>
                                    <div class="form-group" style="position:relative">
                                        <input type="text" class="form-control" placeholder="BirthDate" required name="bdate" id='birthdatepicker'>
                                    </div>
                                    <input class="btn btn-lg btn-success btn-block" type="submit" name="submit" value="Register">
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
       });
   </script>
  

    </body>
</html>