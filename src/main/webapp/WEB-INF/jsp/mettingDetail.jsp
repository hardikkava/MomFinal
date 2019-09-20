<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
		
	<style>
	table tr td{
		 padding: 4px;
	}
	.edmet:hover{
		 cursor:pointer;
	}
	.tasklist table tbody tr:hover{
		background-color: #eae6e6;
	}
	
	
	</style>	
	</head>
    <body>

        <div id="wrapper">

            <%@include file="header.jsp" %>

            <div id="page-wrapper">
                <div class="container-fluid" id="dashboardID">
                    <!-- /.row -->
                    <div class="row">
		            <div class="col-lg-12">
		                <h1 class="page-header">Meeting Detail</h1>
		            </div>
                        <!-- /.col-lg-12 -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="row" style="border: double beige 1px;border-radius: 8px;padding-bottom: 33px;">
                            
                            <div class="row" style="margin-bottom: 19px;">
                            <div class="col-lg-8 col-sm-8 col-xs-12">
                         	   <h3 style="padding-left: 18px;color: #337ab7;margin-top: 11px;"><b>${meeting.subject}</b></h3>
                            </div>
                            <div class="col-lg-4 col-sm-4 col-xs-12">
                            	<div style="padding-top: 11px;">
                            		<i class="fa fa-2x fa-edit edmet" style="color:green;" data-target="#editModal" data-toggle="modal" ></i> &nbsp;&nbsp;
                            		
                            		<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
									  <div class="modal-dialog">      
										<div class="modal-content">         
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"> &times;</button>            
												<h4 class="modal-title" id="myModalLabel"> Edit Meeting </h4>   
                            				</div>
                            				<div class="modal-body">
                            					
                            				   <div class="row" style="padding-left: 14px;padding-right: 16px; ">
		                                        	<form role="form" method="post" action="saveMeeting">
		                                        		<div class="row">
			                                       			 <div class="col-lg-12">
			                                       			 	 <div class="form-group">
				                                                	<label>Subject</label>
				                                                    <input class="form-control" placeholder="Enter Meeting Subject..." required name="subject" value="${meeting.subject}" type="text" id="subject">
				                                                </div>
			                                            	 </div>
		                                            	 </div>
		                                            	 <div class="row">
			                                            	 <div class="col-lg-6">
			                                       			 	 <div class="form-group">
				                                                	<label>StartDate</label>
				                                                	<input type="text" class="form-control" placeholder="Enter Meeting Startdate..." value="${meeting.startdate}" required name="startdate" id='startdatepicker'>
				                                                </div>
			                                            	 </div>
			                                            	 <div class="col-lg-6">
			                                       			 	 <div class="form-group">
				                                                	<label>EndDate</label>
				                                                    <input type="text" class="form-control" placeholder="Enter Meeting Enddate..." required name="enddate" id='enddatepicker'>
				                                                </div>
			                                            	 </div>
		                                            	 </div>
		                                            	 <div class="row">
			                                            	 <div class="col-lg-6">
			                                       			 	 <div class="form-group">
				                                                	<label>Category</label>
				                                                	<input type="text" class="form-control" placeholder="Enter Meeting Category..." value="${meeting.category}" required name="cat">
				                                                </div>
			                                            	 </div>
			                                            </div>
			                                            <div class="row">
			                                            	 <div class="col-lg-6">
			                                       			 	 <div class="form-group">
				                                                	<label>is Recurring?</label><br/>
				                                                    
				                                                        <input type="radio" name="recurring" value="1" id="rec-yes"> Yes
				                                                   		<input type="radio" name="recurring" value="0" id="rec-no" > No
				                                                   
				                                                </div>
			                                            	 </div>
			                                            	 <div class="col-lg-6">
				                                            	 <div class="form-group" id="recurringPeriodID" style="">
				                                                	<label>Recurring Periods :</label>
				                                                    <select class="form-control" name="recurringapproch">
				                                                    	<option value="1">1 month</option>
				                                                        <option value="2">2 month</option>
				                                                        <option value="3">3 month</option>
				                                                        <option value="6">6 month</option>
				                                                        <option value="12">12 month</option>
				                                                    </select>
				                                                </div>
			                                                </div>
		                                            	 </div>
		                                            	 <div class="row">
			                                            	 <div class="col-lg-12">
			                                       			 	 <div class="form-group">
				                                                	<label>Notes</label>
				                                                	<textarea  class="form-control" name="notes">${meeting.note}</textarea>
				                                                </div>
			                                            	 </div>
		                                            	 </div>
		                                            	 <div class="row">
			                                            	 <div class="col-lg-12">
			                                       			 	 <div class="form-group">
				                                                	<label>Reference Meeting</label>
				                                                	<select class="form-control" name="ref-meet">
				                                                    	<option value="1">TEST</option>
				                                                        <option value="2">Test</option>
				                                                    </select>
				                                                </div>
			                                            	 </div>
		                                            	 </div>
		                                            
			                                    </div>
			                                    <!-- /.row (nested) -->
                                    
                                    
                            				</div>
                            				<div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>       
												<button type="submit" class="btn btn-primary" id="btnadd" name="btnadd"> Save </button>        
												 </form>
											</div> 
											
                            			</div>
                            		  </div>
                            		 </div>
                            		
                            		
                            		<i class="fa fa-2x fa-check-circle" style="color:green;"></i>
                            	</div>
                            </div>
                            </div>
                            
                           <!--  <hr style="width: 97%;margin-top: 11px;"> -->
                           <div class="row">
                                 <div style="padding-left: 40px;" class="col-lg-8 col-sm-8 col-xs-12">
                                 	<table style="width:100%;">
                                 	<tr><td><b>StartDate&nbsp;&nbsp;&nbsp;</b></td><td>${fn:substring(meeting.startdate,0,16)}</td>
                                        <td><b>EndDate&nbsp;&nbsp;&nbsp;</b></td><td>${fn:substring(meeting.enddate,0,16)}</td></tr>
                                 	<tr><td><b>Category&nbsp;&nbsp;&nbsp;</b></td><td>${meeting.category}</td>
                                 	    <td><b>is recurring&nbsp;&nbsp;&nbsp;</b></td><td>${meeting.recurring}</td></tr>
                                    <tr><td><b>Recurring Approach&nbsp;&nbsp;&nbsp;</b></td><td>${meeting.recurringapproch}</td>
                                 	    <td><b>Recurring Period&nbsp;&nbsp;&nbsp;</b></td><td>${meeting.recurringperiod}</td></tr>
                                 	</table>
                                 </div>
                                 <!-- /.col-lg-8 (nested) -->
                                 <div class="col-lg-4 col-sm-8 col-xs-12" style="border-left-width: 1px;border-left-color: #eee6e6;border-left-style: double;">
                                 	<table style="width: 100%;">
                                 	<tr><td ><b>Owner&nbsp;&nbsp;&nbsp;</b></td><td>${meeting.owner}</td></tr>
                                 	<tr><td><b>Place&nbsp;&nbsp;&nbsp;</b></td><td>${meeting.place}</td></tr>
                                 	<tr><td><b>CreatedDate&nbsp;&nbsp;&nbsp;</b></td><td>${fn:substring(meeting.createddate,0,16)}</td></tr>
                                 	<tr><td><b>Last Update&nbsp;&nbsp;&nbsp;</b></td><td>${fn:substring(meeting.updateddate,0,16)}</td></tr>
                                 	<tr><td><b>Participants&nbsp;&nbsp;&nbsp;</b></td>
                                 	<td><div style="height: 12px;">
                                 		<select name="participant[]" id="userlst" class="form-control select2-multi" multiple="multiple" required >
                                     		
                                     	<c:forEach items="${tempselectuserList}" var="selectedlist">
                                     		<c:forEach items="${participants}" var="plist">
                                   				<c:set var="comp_email" value="${plist.email}"></c:set>
                                   				<c:choose>
                                   				<c:when test="${comp_email eq selectedlist}">
                                   					<option selected="selected" value="${plist.email}">${plist.firstname} ${plist.lastname} (${plist.email})</option>
                                   				</c:when>
                                   				<c:otherwise>
                                   					<option value="${plist.email}">${plist.firstname} ${plist.lastname} (${plist.email})</option>
                                     			</c:otherwise>
                                     		</c:choose>
                                     		</c:forEach>
                                     		
                                     	</c:forEach>
                                         </select><!-- <a href='#' data-target='#newuserModal' data-toggle='modal'>[+ Add New]</a>  -->
                                 	</div></td></tr>
                                 	</table>
                                 	
                                 </div>
                                 <!-- /.col-lg-4 (nested) -->
                                 </div>
                                 
                                 <div class="row">
                                 	 <div class="col-lg-8 col-sm-8 col-xs-12" style="padding-left: 36px;">
                                 	 	<label>Notes</label><br/>
                                 		<textarea disabled="disabled"  class="form-control" name="notes">${meeting.note}</textarea>
                                 	
                                 	 </div>
                                 	  <div class="col-lg-4 col-sm-4 col-xs-12">
                                 	  </div>
                                 	  
                                 	  <div class="col-lg-8 col-sm-8 col-xs-12" style="padding-left: 36px;">
                                 	 	<label style="padding-top: 24px;">Attachments</label><br/>
                                 	 	<div class="attchments"></div>
                                 		<div style="border: dotted #CCC 4px;padding: 8px;">Drop files here or <input style="display:inline;" type="file" name="docs">  </div>
                                 	
                                 	 </div>
                                 	  <div class="col-lg-4 col-sm-4 col-xs-12">
                                 	  </div>
                                 	  
                                 	  <div class="col-lg-8 col-sm-8 col-xs-12" style="padding-left: 36px;">
                                 	 	<label style="padding-top: 24px;">Reference Meetings</label><br/>
                                 	 	<div class="ref-meetings"><i>No Ref. meetings</i></div>
                                 	 </div>
                                 	  <div class="col-lg-4 col-sm-4 col-xs-12">
                                 	  </div>
                                 	  
                                 	    <div class="col-lg-8 col-sm-8 col-xs-12" style="padding-left: 36px;">
                                 	 	<label style="padding-top: 24px;">Tasks</label><br/>
                                 	 	
                                 	 	<div class="tasklist" style="border: dotted #CCC 1px;border-radius: 3px;margin-bottom: 12px;padding-top: 11px;padding-right: 11px;padding-left: 11px;">
                                 	 		<table id="taskexample" class="table" style="width:100%" cellspacing="0" >
												<thead class="thead-dark">
												<tr>
									                <th style="width: 100%;">Task Desc..</th>
									                <th>Owner</th>
									                <th>Assignee</th>
									                <th>DueDate</th>
									                <th>Actions</th>
									            </tr>
												</thead>
												<tbody>
												<tr>
													<td>Gettnigs<br/><i>tst test yse .tsetse</i></td>
													<td>KP</td>
													<td>Kp</td>
													<td>12-21-2019 03:34</td>
													<td><i class="fa fa-edit"></i> &nbsp;&nbsp; <i class="fa fa-trash"></i></td>
												</tr>
												</tbody>
											</table>
                                 	 	</div>
                                 	 	
                                 	 	<div class="tasks">
                                 	 	<button class="btn" data-target="#taskModal" data-toggle="modal"> <span style="position:relative;top: -4px;left: -2px;">Add New </span> <i class="fa fa-2x fa-plus-circle" style="color: green;"></i></button>
                                 	 	
                                 	 	<div class="modal fade" id="taskModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
										  <div class="modal-dialog">      
											<div class="modal-content">         
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"> &times;</button>            
													<h4 class="modal-title" id="myModalLabel"> New Task </h4>
	                            				</div>
	                            				
	                            				<form role="form" method="post" action="saveMeeting">
	                            				<div class="modal-body">
	                            		
	                                        		<div class="row">
		                                       			 <div class="col-lg-12">
		                                       			 	 <div class="form-group">
			                                                	<label>Task Subject</label>
			                                                    <input type="text" class="form-control" placeholder="Enter Task Subject..." required name="tasksubject" >
			                                                </div>
		                                            	 </div>
	                                               </div>
	                                               <div class="row">
		                                       			 <div class="col-lg-12">
		                                       			 	 <div class="form-group">
			                                                	<label>Task summary</label>
			                                                   	<textarea  class="form-control" name="tasksumry" placeholder="Enter Task Summary..."></textarea>
			                                                </div>
		                                            	 </div>
	                                               </div>
	                                               <div class="row">
		                                       			 <div class="col-lg-6">
		                                       			 	 <div class="form-group">
			                                                	<label>Assignee</label>
			                                                    <select class="form-control" name="taskassignee">
				                                                    	<option value="1">TEST@gmail.com</option>
				                                                        <option value="2">kp@kp.com</option>
				                                                </select>
			                                                </div>
		                                            	 </div>
		                                            	 <div class="col-lg-6">
		                                       			 	 <div class="form-group">
			                                                	<label>DueDate</label>
			                                                    <input type="text" class="form-control" placeholder="Enter Task Duedate..." required name="duedate" id='duedatepicker'>
			                                                </div>
		                                            	 </div>
	                                               </div>
	                            				
	                            				
	                            				</div>
	                            				<div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>       
													<button type="submit" class="btn btn-primary" id="btnadd" name="btnadd"> Add </button>   
													</form>     
												</div> 
												
	                            			</div>
	                            		  </div>
	                            		</div>
                                 	 	
                                 	 	</div>
                                 	 </div>
                                 	  <div class="col-lg-4 col-sm-4 col-xs-12">
                                 	  </div>
                                 	  
                                 </div>
                                 
                            </div>
                            <!-- /.row (nested) -->
                       
                        <!-- /.col-lg-12 -->
                       </div>

                   <script>
                    $(document).ready(function() {
                    	
                    	$("#taskexample").DataTable({
                    		"paging":   false,
                            "info":     false
                    	});
                    	
                    	$("#recurringPeriodID").hide();
                    	
                    	$("input[name$='recurring']").click(function() {
                            if($(this).val() == '1')
                            	$("#recurringPeriodID").show();
                            else
                            	$("#recurringPeriodID").hide();
                            	
                      });
                    	
                    	$('#startdatepicker').datetimepicker({
                    		daysOfWeekDisabled:[0],
                    		minDate: moment()
                    	});
                    	
                        $('#enddatepicker').datetimepicker({
                            useCurrent: false,
                            daysOfWeekDisabled:[0],
                            minDate: moment()
                        });
                        
                        $('#duedatepicker').datetimepicker({
                    		daysOfWeekDisabled:[0],
                    		minDate: moment()
                    	});
                        
                        $("#startdatepicker").on("dp.change", function (e) {
                            $('#enddatepicker').data("DateTimePicker").minDate(e.date);
                        });
                        $("#enddatepicker").on("dp.change", function (e) {
                            $('#startdatepicker').data("DateTimePicker").maxDate(e.date);
                        });
							
                        $('.select2-multi').select2();	
							
							
						});
					</script>
                   
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /#page-wrapper -->

        </div>
        
        </div>
        <%@include file="footerCssJs.jsp" %>
		
    </body>
</html>