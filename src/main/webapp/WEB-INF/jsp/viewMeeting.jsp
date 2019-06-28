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

        <title>MOM</title>
		<%@include file="headerCssJs.jsp" %>
	</head>
    <body>

        <div id="wrapper">

            <%@include file="header.jsp" %>

            <div id="page-wrapper">
                <div class="container-fluid" id="dashboardID">
                    <!-- /.row -->
                    <div class="row">
			            <div class="col-lg-12">
			                <h1 class="page-header">View Meeting</h1>
			            </div>
                        <!-- /.col-lg-12 -->
                    </div>
                    <div>
						<table id="example" class="table table-bordered" style="width:100%" cellspacing="0" >
							<thead class="thead-dark">
							<tr>
				                <th>Subject</th>
				                <th>Participants</th>
				                <th>Place</th>
				                <th>StartDate</th>
				                <th>EndDate</th>
				                <th>Owner</th>
				                <th>Action</th>
				            </tr>
							</thead>
							<tbody>
						
								<c:forEach items="${meetingList}" var="mlist">
									<tr>
										<td>${mlist.subject}</td>
										<td>${mlist.participants}</td>
										<td>${mlist.place}</td>
										<td>${mlist.startdate}</td>
										<td>${mlist.enddate}</td>
										<td>${mlist.owner}</td>
										<td onclick="onDisplayEditMeeting(${mlist.meetingid})"><a href="#">Edit</a></td>
									
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
			
			 		<style type="text/css">       
		        		td {
		  						word-break: break-all;  
						   }
					</style>
					
					<script type="text/javascript">
					   	$(document).ready(function() {
					    $('#example').DataTable( 
					       /*  deferRender:    true,
					        scrollY:        200,
					        scrollCollapse: true,
					        scroller:       true  */
					    );
						} );
   					</script>
                   
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /#page-wrapper -->

        </div>
        
        <%@include file="footerCssJs.jsp" %>
		
    </body>
</html>