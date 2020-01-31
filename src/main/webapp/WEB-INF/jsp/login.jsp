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

        <title>MOM Login</title>

        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- MetisMenu CSS -->
        <link href="css/metisMenu.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/startmin.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="css/font-awesome.min.css" rel="stylesheet" type="text/css">

        
    </head>
    <body>

        <div class="container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-panel panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Mom Sign In</h3>
                        </div>
                        <div class="panel-body">
                            <form action="loginForm" method="post">
                                <fieldset>
                                	<c:if test="${type eq 'success'}"><p style="font-size: 16px;" class="alert alert-success"><c:out value="${message}"></c:out></p></c:if>
                                	<c:if test="${type eq 'alert'}"><p style="font-size: 16px;" class="alert alert-danger"><c:out value="${message}"></c:out></p></c:if>
                                    <div class="form-group">
                                        <input class="form-control" required placeholder="E-mail" name="email" type="email" autofocus>
                                    </div>
                                    <div class="form-group">
                                        <input class="form-control" required placeholder="Password" name="password" type="password" value="">
                                    </div>
                                    <div align="right">
                                    	<span>Not registered? <a href="registerAccount">Create an account</a></span>
                                    </div><br>
                                    	<input class="btn btn-lg btn-success btn-block" type="submit" name="submit" value="Login">
                                </fieldset>
								<div align="Left">
                                    	<span>Not registered? <a href="SignInWithGoogle">Sign In With Google</a></span>
                                    </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- jQuery -->
        <script src="js/jquery.min.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="js/bootstrap.min.js"></script>

        <!-- Metis Menu Plugin JavaScript -->
        <script src="js/metisMenu.min.js"></script>

        <!-- Custom Theme JavaScript -->
        <script src="js/startmin.js"></script>

    </body>
</html>