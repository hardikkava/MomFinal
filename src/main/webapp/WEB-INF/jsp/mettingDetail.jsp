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
	.edtask:hover{
		cursor:pointer;
	}
	.tasklist table tbody tr:hover{
		background-color: #eae6e6;
	}
	.optionicons{
	  font-family: 'Font Awesome\ 5 Brands' , 'arial'
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
		                                        	<form role="form" method="post" action="updateMeeting">
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
				                                                	<input type="text" disabled="disabled" class="form-control" placeholder="Enter Meeting Startdate..." value="${meeting.startdate}" required name="stdate" id='startdatepicker'>
				                                                    <input type="hidden" value="${meeting.startdate}" name="startdate">	
				                                                    <input type="hidden" value="${meeting.place}" name="place">
				                                                </div>
			                                            	 </div>
			                                            	 <div class="col-lg-6">
			                                       			 	 <div class="form-group">
				                                                	<label>EndDate</label>
				                                                    <input type="text" class="form-control" placeholder="Enter Meeting Enddate..."  name="enddate" id='enddatepicker' value="${meeting.enddate}">
				                                                </div>
			                                            	 </div>
		                                            	 </div>
		                                            	 <div class="row">
			                                            	 <div class="col-lg-12">
			                                       			 	 <div class="form-group">
				                                                	<label>Category</label>
				                                                	<input type="text" class="form-control" placeholder="Enter Meeting Category..." value="${meeting.category}" required name="category">
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
				                                                	<textarea  class="form-control" name="note">${meeting.note}</textarea>
				                                                </div>
			                                            	 </div>
		                                            	 </div>
		                                            	 <div class="row">
			                                            	 <div class="col-lg-12">
			                                       			 	 <div class="form-group">
				                                                	<label>Participants</label>
				                                                	<select name="updatedparticipant[]" id="updateduserlst" class="select2-multi-updatedpart" multiple="multiple" required >
                                     									<c:forEach items="${participants}" var="plist">
                                     										<c:set var="found" value="0"></c:set>
                                     										<c:forEach items="${tempselectuserList}" var="selectedlist">
								                                     			<c:set var="comp_email" value="${plist.email}"></c:set>
								                                   				<c:choose>
								                                   				<c:when test="${comp_email eq selectedlist}">
								                                   					<c:set var="found" value="1"></c:set>
								                                   					<option selected="selected" value="${plist.email}">${plist.firstname} ${plist.lastname} (${plist.email})</option>
								                                   				</c:when>
								                                     		</c:choose>
								                                     		</c:forEach>
								                                     			<c:if test="${found eq 0}">
								                                     				<option value="${plist.email}">${plist.firstname} ${plist.lastname} (${plist.email})</option>
								                                     			</c:if>
								                                     	</c:forEach>
							                                         </select>
				                                                </div>
			                                            	 </div>
		                                            	 </div>
		                                            	 <div class="row">
			                                            	 <div class="col-lg-12">
			                                       			 	 <div class="form-group">
				                                                	<label>Reference Meeting</label>
				                                               		 <select name="updatedrefermeeting[]" id="" class="select2-multi-updatedmeet" multiple="multiple" >	
				                                                		<c:forEach items="${refermeetings}" var="reflist">
				                                                			<c:set var="found" value="0"></c:set>
				                                                			<c:forEach items="${finalRefmeetList}" var="finalrefmeetlist">
			                                   									<c:set var="comp_meetid" value="${reflist.meetingid}"></c:set>
								                                   				<c:choose>
									                                   				<c:when test="${comp_meetid eq finalrefmeetlist}">
									                                   					<c:set var="found" value="1"></c:set>
									                                   					<option selected="selected" value="${reflist.meetingid}"> MEET${reflist.meetingid} [${reflist.subject}]</option>
									                                   				</c:when>
								                                     			</c:choose>
							                                     			</c:forEach>
							                                     			<c:if test="${found eq 0}">
							                                     				<option value="${reflist.meetingid}"> MEET${reflist.meetingid} [${reflist.subject}]</option>
							                                     			</c:if>
							                                     		</c:forEach>
									                                   </select>             	
				                                                </div>
			                                            	 </div>
		                                            	 </div>
		                                            
			                                    </div>
			                                    <!-- /.row (nested) -->
                                    
                                    			
                            				</div>
                            				<div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>       
												 <input type="hidden" name="meetingid" value="${meeting.meetingid}">
												<button type="submit" class="btn btn-primary" id="btnsavemeet" name="btnupdatemeet"> Save </button>        
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
                                 	<tr><td></td><td></td></tr>
                                 	<tr><td><b>Participants&nbsp;&nbsp;&nbsp;</b></td>
                                 	<td>
	                                 	<c:forEach items="${tempselectuserList}" var="selectedlist">
											<span>${selectedlist}</span><br>
										</c:forEach>
                                 	</td></tr>	
                                 	
                                 	
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
                                 	 	<div class="ref-meetings">
                                 	 		<c:choose>
                                   				<c:when test="${fn:length(finalRefmeetList) lt 1}">
		                                 	 		<i>No Reference meetings</i>
                                      			</c:when>
	                                      		<c:otherwise>
	                                 	 			<c:forEach items="${finalRefmeetList}" var="finalrefmeetlist">
		                                     		<c:forEach items="${refermeetings}" var="refmeetlist">
		                                   				<c:set var="comp_meetid" value="${refmeetlist.meetingid}"></c:set>
		                                   				<c:choose>
		                                   				<c:when test="${comp_meetid eq finalrefmeetlist}">
		                                   					<i><a style="text-decoration: none;" href="getMeetingDetail?meetid=${refmeetlist.meetingid}"><span>MEET${refmeetlist.meetingid} &nbsp;&nbsp;&nbsp;${refmeetlist.subject} </span></a><br></i>
		                                   				</c:when>
		                                     			</c:choose>
		                                     		</c:forEach>	
		                                     		</c:forEach>
                                 	 			</c:otherwise>
                                 	 		</c:choose>
                                 	 	</div>
                                 	 </div>
                                 	  <div class="col-lg-4 col-sm-4 col-xs-12">
                                 	  </div>
                                 	  
                                 	    <div class="col-lg-8 col-sm-8 col-xs-12" style="padding-left: 36px;">
                                 	 	<label style="padding-top: 24px;">Tasks</label><br/>
                                 	 	
                                 	 	<div class="tasklist" style="border: dotted #CCC 1px;border-radius: 3px;margin-bottom: 12px;padding-top: 11px;padding-right: 11px;padding-left: 11px;">
                                 	 		<table id="taskexample" class="table" style="width:100%;table-layout:fixed;" cellspacing="0" >
												<thead class="thead-dark">
												<tr>
													<th style="width: 1px;"></th>
									                <th>Task Desc..</th>
									                <th>Assignees</th>
									                <th>Owner</th>
									                <th>DueDate</th>
									                <th style="width: 1px;">Actions</th>
									            </tr>
												</thead>
												<tbody>
												<c:forEach items="${meetVsTaskList}" var="mvtlist">
 													<tr> 
														<c:if test="${mvtlist.tasktype eq 'Task'}"> 
															<td style="width: 1px;"> 📝  </td>
															</c:if> 
															<c:if test="${mvtlist.tasktype eq 'Information'}"> 
														<td style="width: 1px;"> ℹ  </td> 
													</c:if> 
													<c:if test="${mvtlist.tasktype eq 'Discussion'}"> 
														<td style="width: 1px;"> &#128101; </td>
													</c:if>
													<c:if test="${mvtlist.tasktype eq 'Decision'}"> 
														<td style="width: 1px;">  🎯   </td>
													</c:if> 
													<td> ${mvtlist.subject}</td>
													<td style="word-wrap:break-word;"> ${mvtlist.responsible}</td> 
													<td style="word-wrap:break-word;"> ${mvtlist.assignee}</td> 
													<td style="word-wrap:break-word;"> ${mvtlist.duedate}</td> 
													<td style="width: 1px;"> <i class="edtask fa fa-edit" data-target="#getupdatetask_taskid${mvtlist.taskid}" data-toggle="modal"></i></td>
													
													<!--  edit task modal -->
													<div class="modal fade" id="getupdatetask_taskid${mvtlist.taskid}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
													  <div class="modal-dialog">      
														<div class="modal-content">         
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal"> &times;</button>            
																<h4 class="modal-title" id="myModalLabel"> Update Task </h4>
				                            				</div>
				                            				
				                            				<form role="form" method="post" action="updateTask">
				                            				<div class="modal-body">
				                            		
				                            					<div class="row">
					                                       			 <div class="col-lg-12">
					                                       			 	 <div class="form-group">
					                                       			 	 
					                                       			 	 <input type="hidden" name="taskid" value="${mvtlist.taskid}">
						                                                	<label>Task Type</label>
						                                                   <select class="form-control" name="tasktype" id="taskselupdate">
						                                                    	<option ${mvtlist.tasktype == 'Task' ? 'selected="selected"' : ''} value="Task"> 📝 Task</option>
						                                                        <option ${mvtlist.tasktype == 'Information' ? 'selected="selected"' : ''} value="Information">&nbsp;   ℹ    &nbsp; Information</option>
						                                                        <option ${mvtlist.tasktype == 'Discussion' ? 'selected="selected"' : ''} value="Discussion">&#128101;  Discussion</option>
						                                                        <option ${mvtlist.tasktype == 'Decision' ? 'selected="selected"' : ''} value="Decision"> 🎯  Decision</option>
							                                                </select>
						                                                </div>
					                                            	 </div>
				                                               </div>
				                                        		<div class="row">
					                                       			 <div class="col-lg-12">
					                                       			 	 <div class="form-group">
						                                                	<label>Subject</label>
						                                                    <input type="text" class="form-control" placeholder="Enter Subject..." required name="tasksubject" value="${mvtlist.subject}">
						                                                </div>
					                                            	 </div>
				                                               </div>
				                                               <div class="row">
					                                       			 <div class="col-lg-12">
					                                       			 	 <div class="form-group">
						                                                	<label>Summary</label>
						                                                   	<textarea  class="form-control" name="tasksumry" placeholder="Enter Summary...">${mvtlist.description}</textarea>
						                                                </div>
					                                            	 </div>
				                                               </div>
				                                               <div class="row taskdivupdate" >
					                                       			 <div class="col-lg-12">
					                                       			 	 <div class="form-group">
						                                                	<label>Task Assignee</label><br>
										                                     <select name="assignperson[]" disabled="disabled" class="select2-multi-addtaskassignee" multiple="multiple" required id="taskassignedpersonupdate" style="min-width: 100% !important;">
						                                                    
						                                                    <c:forEach items="${participants}" var="plist">
                                     										<c:set var="found" value="0"></c:set>
                                     										<c:forEach items="${mvtlist.responsible}" var="selectedlist">
								                                     			<c:set var="comp_email" value="${plist.email}"></c:set>
								                                   				<c:choose>
								                                   				<c:when test="${comp_email eq selectedlist}">
								                                   					<c:set var="found" value="1"></c:set>
								                                   					<option selected="selected" value="${plist.email}">${plist.firstname} ${plist.lastname} (${plist.email})</option>
								                                   				</c:when>
								                                     		</c:choose>
								                                     		</c:forEach>
								                                     			<c:if test="${found eq 0}">
								                                     				<option value="${plist.email}">${plist.firstname} ${plist.lastname} (${plist.email})</option>
								                                     			</c:if>
								                                     	</c:forEach>
								                                     	
								                                     	</select>
			                                                    
						                                                </div>
					                                            	 </div>
					                                            	 
				                                               </div>
				                                               <div class="row" >
					                                               <div class="col-lg-12">
						                                       			 	 <div class="form-group">
							                                                	<label>DueDate</label>
							                                                    <input type="text" class="form-control" placeholder="Enter Task Duedate..." required name="duedate" id='duedatepicker_update' value="${mvtlist.duedate}" >
							                                                </div>
						                                           </div>
				                            					</div>
				                            				
				                            				</div>
				                            				<input type="hidden" name="meetingid" value="${meeting.meetingid}"> 
				                            				<div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>       
																<button type="submit" class="btn btn-primary" id="btnupdatetask" name="btnupdate"> Save </button>   
																</form>     
															</div> 
															
				                            			</div>
				                            		  </div>
	                            					<!--  edit task modal ends -->	  
													
													</tr>  
												</c:forEach>
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
	                            				
	                            				<form role="form" method="post" action="addNewTask">
	                            				<div class="modal-body">
	                            		
	                            					<div class="row">
		                                       			 <div class="col-lg-12">
		                                       			 	 <div class="form-group">
			                                                	<label>Task Type</label>
			                                                   <select class="form-control" name="tasktype" id="tasksel">
			                                                    	<option value="Task"> 📝 Task</option>
			                                                        <option value="Information">&nbsp;   ℹ    &nbsp; Information</option>
			                                                        <option value="Discussion">&#128101;  Discussion</option>
			                                                        <option value="Decision"> 🎯  Decision</option>
				                                                </select>
			                                                </div>
		                                            	 </div>
	                                               </div>
	                                        		<div class="row">
		                                       			 <div class="col-lg-12">
		                                       			 	 <div class="form-group">
			                                                	<label>Subject</label>
			                                                    <input type="text" class="form-control" placeholder="Enter Subject..." required name="tasksubject" >
			                                                </div>
		                                            	 </div>
	                                               </div>
	                                               <div class="row">
		                                       			 <div class="col-lg-12">
		                                       			 	 <div class="form-group">
			                                                	<label>Summary</label>
			                                                   	<textarea  class="form-control" name="tasksumry" placeholder="Enter Summary..."></textarea>
			                                                </div>
		                                            	 </div>
	                                               </div>
	                                               <div class="row taskdiv" >
		                                       			 <div class="col-lg-12">
		                                       			 	 <div class="form-group">
			                                                	<label>Task Assignee</label><br>
							                                     <select name="assignperson[]"  class="select2-multi-addtaskassignee" multiple="multiple" required id="taskassignedperson" style="min-width: 100% !important;">
			                                                		
			                                                		<c:forEach items="${participants}" var="plist">
							                                   			<option value="${plist.email}">${plist.firstname} ${plist.lastname} (${plist.email})</option>
							                                     	</c:forEach>
			                                                    </select>
                                                    
			                                                </div>
		                                            	 </div>
		                                            	 
	                                               </div>
	                                               <div class="row" >
		                                               <div class="col-lg-12">
			                                       			 	 <div class="form-group">
				                                                	<label>DueDate</label>
				                                                    <input type="text" class="form-control" placeholder="Enter Task Duedate..." required name="duedate" id='duedatepicker'>
				                                                </div>
			                                           </div>
	                            					</div>
	                            				
	                            				</div>
	                            				<input type="hidden" name="meetingid" value="${meeting.meetingid}"> 
	                            				<div class="modal-footer"> <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>       
													<button type="submit" class="btn btn-primary" id="btnaddtask" name="btnaddtask"> Add </button>   
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
                    	
                    	var dateString, dateTimeParts, timeParts, dateParts, date;
                    	
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

                    	dateString = $("#startdatepicker").val(); 
                    	dateTimeParts = dateString.split(' ');
                    	timeParts = dateTimeParts[1].split(':');
                    	dateParts = dateTimeParts[0].split('-');
                    	date = new Date(dateParts[0], parseInt(dateParts[1], 10) - 1, dateParts[2], timeParts[0], timeParts[1]);
						
                    	$('#startdatepicker').datetimepicker({
                    		daysOfWeekDisabled:[0],
                    		format: 'DD/MMM/YYYY hh:mm A',
                    		date: new Date(date.getTime())
                    	});
                    	
                    	dateString = $("#enddatepicker").val();
                        dateTimeParts = dateString.split(' ');
                        timeParts = dateTimeParts[1].split(':');
                        dateParts = dateTimeParts[0].split('-');
                    	date = new Date(dateParts[0], parseInt(dateParts[1], 10) - 1, dateParts[2], timeParts[0], timeParts[1]);
                    	
                        $('#enddatepicker').datetimepicker({
                            useCurrent: false,
                            daysOfWeekDisabled:[0],
                            format: 'DD/MMM/YYYY hh:mm A',
                            minDate: moment(),
                            date: new Date(date.getTime())
                        });
                        
                        $('#duedatepicker').datetimepicker({
                    		daysOfWeekDisabled:[0],
                    		format: 'DD/MMM/YYYY hh:mm A',
                    		minDate: moment()
                    	});
                        
                        
                        dateString = $("#duedatepicker_update").val();
                        dateTimeParts = dateString.split(' ');
                        timeParts = dateTimeParts[1].split(':');
                        dateParts = dateTimeParts[0].split('-');
                    	date = new Date(dateParts[0], parseInt(dateParts[1], 10) - 1, dateParts[2], timeParts[0], timeParts[1]);
                    	
                        $('#duedatepicker_update').datetimepicker({
                            useCurrent: false,
                            daysOfWeekDisabled:[0],
                            format: 'DD/MMM/YYYY hh:mm A',
                            minDate: moment(),
                            date: new Date(date.getTime())
                        });
                        
//                         $("#startdatepicker").on("dp.change", function (e) {
//                             $('#enddatepicker').data("DateTimePicker").minDate(e.date);
//                         });
//                         $("#enddatepicker").on("dp.change", function (e) {
//                             $('#startdatepicker').data("DateTimePicker").maxDate(e.date);
//                         });
							
                        $('.select2-multi-updatedpart').select2();
                        $('.select2-multi-updatedmeet').select2();
                        $('.select2-multi-addtaskassignee').select2();
                        
                       var taskassigneeselect = document.getElementById("taskassignedperson");
                        
                   	    $('#tasksel').on('change', function() {
                   	    	if(this.value == 'Task'){
                   	    		taskassigneeselect.setAttribute('required','required');
	                        	$(".taskdiv").show();
                   	    	}else
                   	    	{
                   	    		taskassigneeselect.removeAttribute('required');
	                        	$(".taskdiv").hide();
                   	    	}
                   	   });
 						
                   	 var taskassigneeselect_update = document.getElementById("taskassignedpersonupdate");
                   	  $('#taskselupdate').on('change', function() {
                	    	if(this.value == 'Task'){
                	    		taskassigneeselect_update.setAttribute('required','required');
                	    		taskassigneeselect_update.removeAttribute('disabled');
	                        	$(".taskdivupdate").show();
                	    	}else
                	    	{
                	    		taskassigneeselect_update.removeAttribute('required');
	                        	$(".taskdivupdate").hide();
                	    	}
                	   });
                   	
                   	    
                   	    
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