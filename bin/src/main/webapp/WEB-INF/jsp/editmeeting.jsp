<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="row">
		            <div class="col-lg-12">
		                <h1 class="page-header">Meeting</h1>
		            </div>
                        <!-- /.col-lg-12 -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Edit Meeting
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <form role="form" method="post" action="updateMeeting">
                                                <c:forEach items="${editMeetingList}" var="editList">
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Subject" name="subject" type="text" id="subject" value="${editList.subject}">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Participants" name="participants" type="text" id="participants" value="${editList.participants}">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Owner" name="owner" type="text" value="${editList.owner}">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Place" name="place" type="text" value="${editList.place}">
                                                </div>
                                                <div class="form-group">
                                                    <textarea class="form-control" placeholder="Note" rows="3" name="note">${editList.note}</textarea>
                                                </div>
                                                <div class="form-group">
                                                    <input type="file" name="uploadfile">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Catagory" name="category" type="text" value="${editList.category}">
                                                </div>
                                                <div class="form-group">
                                                    <label>Recurring : </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="recurring" value="1" onclick="showRecurring();">Yes
                                                    </label>
                                                    <label class="radio-inline">
                                                        <input type="radio" name="recurring" value="0" onclick="hideRecurring();" checked>No
                                                    </label>
                                                </div>
                                                <div class="form-group" id="recurringPeriodID" style="display: none;">
                                                	<label>Recurring Periods :</label>
                                                    <select class="form-control" name="recurringapproch">
                                                    	<option value="1" <c:if test="${editList.recurringapproch eq '1'}">selected</c:if>>1 month</option>
                                                        <option value="2" <c:if test="${editList.recurringapproch eq '2'}">selected</c:if>>2 month</option>
                                                        <option value="3" <c:if test="${editList.recurringapproch eq '3'}">selected</c:if>>3 month</option>
                                                        <option value="6" <c:if test="${editList.recurringapproch eq '6'}">selected</c:if>>6 month</option>
                                                        <option value="12" <c:if test="${editList.recurringapproch eq '12'}">selected</c:if>>12 month</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Referancemeeting" name="referancemeeting" type="text" value="${editList.referancemeeting}">
                                                </div>
                                                <div class="form-group">
                                                	<label>Start date</label>
                                                    <input class="form-control"  name="fromdate" type="datetime-local" value="${editList.startdate}">
                                                </div>
                                                <div class="form-group">
                                                	<label>End date</label>
                                                    <input class="form-control"  name="todate" type="datetime-local" value="${editList.enddate}">
                                                </div>
                                                </c:forEach>
                                                
                                                <div align="center">
                                                	<button type="submit" class="btn btn-primary">Submit</button>
                                                </div>
                                            </form>
                                        </div>
                                        
                                        <!-- /.col-lg-6 (nested) -->
                                    </div>
                                    <!-- /.row (nested) -->
                                </div>
                                <!-- /.panel-body -->
                            </div>
                            <!-- /.panel -->
                        </div>
                        <!-- /.col-lg-12 -->
                    </div>
                    
                    <script>
						$(document).ready(function() {
							$('#participants').autocomplete({
								serviceUrl: 'searchParticipants',
								paramName: "paramName",
								delimiter: ",",
							    transformResult: function(response) {
							    	
							        return {
							        	
							            suggestions: $.map($.parseJSON(response), function(item) {
							            	
							                return { value: item.email, data: item.username };
							            })
							            
							        };
							        
							    }
							    
							});
							
							
							
						});
					</script>