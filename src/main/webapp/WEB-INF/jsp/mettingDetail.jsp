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
                            		<i class="fa fa-2x fa-edit" style="color:green;"></i> &nbsp;&nbsp;
                            		<i class="fa fa-2x fa-check-circle" style="color:green;"></i>
                            	</div>
                            </div>
                            </div>
                            
                           <!--  <hr style="width: 97%;margin-top: 11px;"> -->
                                 <div class="col-lg-8 col-sm-8 col-xs-12">
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
                                 	<tr><td><b>Participants&nbsp;&nbsp;&nbsp;</b></td><td></td></tr>
                                 	</table>
                                 	
                                 </div>
                                 <!-- /.col-lg-4 (nested) -->
                                 
                                 <div class="row">
                                 	 <div class="col-lg-8 col-sm-8 col-xs-12" style="padding-left: 36px;">
                                 	 	<label>Notes</label><br/>
                                 		<textarea  class="form-control" name="notes">${meeting.note}</textarea>
                                 	
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
                                 	 	<div class="tasks">
                                 	 	<button class="btn"> <span style="position:relative;top: -4px;left: -2px;">Add New </span> <i class="fa fa-2x fa-plus-circle" style="color: green;"></i></button>
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
        
        </div>
        <%@include file="footerCssJs.jsp" %>
		
    </body>
</html>