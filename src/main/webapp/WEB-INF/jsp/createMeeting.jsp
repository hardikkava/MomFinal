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
		                <h1 class="page-header">Create Meeting</h1>
		            </div>
                        <!-- /.col-lg-12 -->
                    </div>
                    <!-- /.row -->
                    <div class="row">
                        <div class="col-lg-12">
                          
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <form role="form" method="post" action="saveMeeting">
                                                <div class="form-group">
                                                <label>Subject</label>
                                                    <input class="form-control" placeholder="Enter Meeting Subject..." required name="subject" type="text" id="subject">
                                                </div>
                                                <div class="form-group">
                                                    <label>Participants</label>
                                                    <input class="form-control" placeholder="Enter Participants..." required name="participants" type="text" id="participants">
                                                </div>
                                                <div class="form-group">
                                                	<label>Owner</label>
                                                    <input class="form-control" placeholder="Enter Meeting Owner name" required name="owner" type="text">
                                                </div>
                                                <div class="form-group">
                                                	<label>Place</label>
                                                    <input class="form-control" placeholder="Enter Place..." required name="place" type="text">
                                                </div>
                                                <div class="form-group">
                                                <label>Notes</label>
                                                    <textarea class="form-control" placeholder="Enter Note..." required rows="3" name="note"></textarea>
                                                </div>
                                                <div class="form-group">
                                                <label>File(s)</label>
                                                    <input type="file" name="uploadfile">
                                                </div>
                                                <div class="form-group">
                                                <label>Category</label>
                                                    <input class="form-control" placeholder="Enter Catagory..." required name="category" type="text">
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
                                                    	<option value="1">1 month</option>
                                                        <option value="2">2 month</option>
                                                        <option value="3">3 month</option>
                                                        <option value="6">6 month</option>
                                                        <option value="12">12 month</option>
                                                    </select>
                                                </div>
                                                <div class="form-group">
                                                <label>Reference Meeting </label>
                                                    <input class="form-control" placeholder="Refer Meeting..." name="referancemeeting" type="text">
                                                </div>
                                                
                                                <div class="form-group" style="position:relative">
                                                	<label>Start date</label>
                                                    <input type="text" class="form-control" required name="fromdate" id='startdatepicker'>
                                                </div>
                                    
										  		<div class="form-group" style="position:relative">
                                                	<label>End date</label>
                                                    <input type="text" class="form-control" required name="todate" id="enddatepicker">
                                                </div>
                                          
									          
                                                <div class="pull-right">
                                                	<button type="submit" class="btn btn-primary">Submit</button>
                                                	<button type="button" class="btn btn-default">Cancel</button>
                                                </div>
                                            </form>
                                        </div>
                                        
                                        <!-- /.col-lg-6 (nested) -->
                                    </div>
                                    <!-- /.row (nested) -->
                       
                        <!-- /.col-lg-12 -->
                    </div>
                    
                   
                
                   <script>
                    $(document).ready(function() {
							
                    	$('#startdatepicker').datetimepicker({
                    		daysOfWeekDisabled:[0],
                    		minDate: moment()
                    	});
                    	
                        $('#enddatepicker').datetimepicker({
                            useCurrent: false,
                            daysOfWeekDisabled:[0],
                            minDate: moment()
                        });
                        $("#startdatepicker").on("dp.change", function (e) {
                            $('#enddatepicker').data("DateTimePicker").minDate(e.date);
                        });
                        $("#enddatepicker").on("dp.change", function (e) {
                            $('#startdatepicker').data("DateTimePicker").maxDate(e.date);
                        });
							
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
                   
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- /#page-wrapper -->

        </div>
        
        <%@include file="footerCssJs.jsp" %>
		
    </body>
</html>