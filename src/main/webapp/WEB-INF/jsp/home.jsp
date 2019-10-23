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
                            <h1 class="page-header">Dashboard</h1>
                        </div>
                        <!-- /.col-lg-12 -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-users fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"><c:out value="${meetingsDueCount}"></c:out></div>
                                            <div>Meetings</div>
                                        </div>
                                    </div>
                                </div>
                                <a href="viewMeeting">
                                    <div class="panel-footer">
                                        <span class="pull-left">View Details</span>
                                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>

                                        <div class="clearfix"></div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="panel panel-yellow">
                                <div class="panel-heading">
                                    <div class="row">
                                        <div class="col-xs-3">
                                            <i class="fa fa-tasks fa-5x"></i>
                                        </div>
                                        <div class="col-xs-9 text-right">
                                            <div class="huge"><c:out value="${tasksDueCount}"></c:out></div>
                                            <div>Task</div>
                                        </div>
                                    </div>
                                </div>
                                <a href="viewMeeting">
                                    <div class="panel-footer">
                                        <span class="pull-left">View Details</span>
                                        <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>

                                        <div class="clearfix"></div>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6"> 
<!--                             <div class="panel panel-green"> -->
<!--                                 <div class="panel-heading"> -->
<!--                                     <div class="row"> -->
<!--                                         <div class="col-xs-3"> -->
<!--                                             <i class="fa fa-tasks fa-5x"></i> -->
<!--                                         </div> -->
<!--                                         <div class="col-xs-9 text-right"> -->
<%--                                             <div class="huge"><c:out value="${tasksDueCount}"></c:out></div> --%>
<!--                                             <div>Tasks</div> -->
<!--                                         </div> -->
<!--                                     </div> -->
<!--                                 </div> -->
<!--                                 <a href="#"> -->
<!--                                     <div class="panel-footer"> -->
<!--                                         <span class="pull-left">View Details</span> -->
<!--                                         <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span> -->

<!--                                         <div class="clearfix"></div> -->
<!--                                     </div> -->
<!--                                 </a> -->
<!--                             </div> -->
                        </div> 
                        <div class="col-lg-3 col-md-6">
                        </div>                       
						                 
                    </div>
                   
                    <!-- /.row -->
                    <div class="row">
                    	<!--  meeting panel -->
                        <div class="col-lg-6 col-md-6">
                        	<div class="panel panel-primary">
							  	<div class="panel-heading">Meetings</div>
							 	   <div class="panel-body">
		                        	<table id="example" class="table" style="width:100%;table-layout:fixed;" cellspacing="0" >
										<thead class="thead-dark">
										<tr>
											<th>Meeting</th>
							                <th>Subject</th>
							                <th>Owner</th>
							                <th>EndDate</th>
							            </tr>
										</thead>
										<tbody>
											<c:forEach items="${meetingResult}" var="meetlist">
											<tr>
												<td><i><a href="getMeetingDetail?meetid=${meetlist.meetingid}">MEET${meetlist.meetingid}</a></i></td>
												<td><a href="getMeetingDetail?meetid=${meetlist.meetingid}">${meetlist.subject}</a></td>
												<td style="word-wrap:break-word;" >${meetlist.owner}</td>
												<td style="word-wrap:break-word;" >${meetlist.enddate}</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
                        		</div>
                         </div>
                     </div>
                        
                        <!--  task panel -->
                        <div class="col-lg-6 col-md-6">
                        	<div class="panel panel-yellow">
							  	<div class="panel-heading">Tasks</div>
							 	   <div class="panel-body">
			                         <table id="taskexample" class="table" style="width:100%;table-layout:fixed;" cellspacing="0" >
										<thead class="thead-dark">
										<tr>
											<th style="width:40px;"></th>
							                <th>Task</th>
							                <th>Assignee</th>
							                <th>Responsible</th>
							                <th>Meeting</th>
							                <th>EndDate</th>
							            </tr>
										</thead>
										<tbody>
											<c:forEach items="${taskResult}" var="tasklist">
											<tr>
												<c:if test="${tasklist.tasktype eq 'Task'}"> 
													<td style=""> 📝  </td>
													</c:if> 
												<c:if test="${tasklist.tasktype eq 'Information'}"> 
													<td style="""> ℹ  </td> 
												</c:if> 
												<c:if test="${tasklist.tasktype eq 'Discussion'}"> 
													<td style=""> &#128101; </td>
												</c:if>
												<c:if test="${tasklist.tasktype eq 'Decision'}"> 
													<td style="">  🎯   </td>
												</c:if> 
													
												<td>${tasklist.subject}</td>
												<td style="word-wrap:break-word;" >${tasklist.assignee}</td>
												<td style="word-wrap:break-word;" >${tasklist.responsible}</td>
												<td><i><a href="getMeetingDetail?meetid=${tasklist.meetingid}">MEET${tasklist.meetingid}</a></i></td>
												<td style="word-wrap:break-word;" >${tasklist.duedate}</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
                        </div>
                    </div>
                    <!-- /.row ends -->
                   
                   
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /#page-wrapper -->

        </div>
        <script type="text/javascript">
		   	$(document).ready(function() {
		   	
		   		$("#example").DataTable({
            		"paging":   false,
                    "info":     false
            	});
		   		$("#taskexample").DataTable({
            		"paging":   false,
                    "info":     false
            	});
		   		
			});
		</script>
   						
        <%@include file="footerCssJs.jsp" %>
		
    </body>
</html>