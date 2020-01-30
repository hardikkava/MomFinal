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
		
		<script type="text/javascript">

	
					
		</script>
		
	</head>
    <body>

        <div id="wrapper" class="container">

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
                    
                    
                    <div class="modal fade" id="newuserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">  
					  <div class="modal-dialog">      
						<div class="modal-content">         
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"> &times;</button>            
								<h4 class="modal-title" id="myModalLabel"> Add Participant </h4>   
	                    </div>
               				 	<form role="form" method="post">
               					<div class="modal-body">
               						 <div class="form-group">
                                      	<label>FirstName</label>&nbsp;<span style="color:red;">*</span>
                                       <input class="form-control" placeholder="Enter FirstName" id="fname" type="text">
                                     </div>
               						 <div class="form-group">
                                      	<label>LastName</label>&nbsp;<span style="color:red;">*</span>
                                       <input class="form-control" placeholder="Enter LastName" id="lname" type="text">
                                     </div>
                                     <div class="form-group">
                                      	<label>Email</label>&nbsp;<span style="color:red;">*</span>
                                       <input class="form-control" placeholder="Enter Participant Email Address" id="useremail" type="email">
                                     </div>
                				</div>
                				<div class="modal-footer">
                					<div class="pull-right">
                                          <input class="btn btn-primary" id="btnaddguest" type="button" value="Add">
                                          <input class="btn btn-default" type="button" data-dismiss="modal" value="Cancel">
                                    </div>
                				</div>	
                				</form>
                		   	</div>
	                       </div>
	                    </div>
	                       		 
                    </div>
                            				
                    
                    
                    
                    <div class="row">
                        <div class="col-lg-12">
                          
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <form role="form" method="post" action="saveMeeting" enctype="multipart/form-data">
                                                <div class="form-group">
                                                <label>Subject</label>&nbsp;<span style="color:red;">*</span>
                                                    <input class="form-control" placeholder="Enter Meeting Subject..." required name="subject" type="text" id="subject">
                                                </div>
                                                <div class="form-group">
                                                    <label>Participants</label>&nbsp;<span style="color:red;">*</span>
                                                   <!--  <input class="form-control" placeholder="Enter Participants..." required name="participants" type="text" id="participants">  -->
                                                	<select name="participant[]" id="userlst" class="form-control select2-multi" multiple="multiple" required >
                                                		<c:forEach items="${participants}" var="plist">
                                                			<option value="${plist.email}">${plist.firstname} ${plist.lastname} (${plist.email})</option>
                                                		</c:forEach>
                                                    </select><a href='#' data-target='#newuserModal' data-toggle='modal'>[+ Add New]</a>
                                                </div>
                                               <!--  <div class="form-group">
                                                	<label>Owner</label><span style="color:red;">*</span>
                                                    <input class="form-control" placeholder="Enter Meeting Owner name" required name="owner" type="text">
                                                </div>  -->
                                                <div class="form-group">
                                                	<label>Place</label>&nbsp;<span style="color:red;">*</span>
                                                    <input class="form-control" placeholder="Enter Place..." required name="place" id="place" type="text">
                                                </div>
                                                <div class="form-group">
                                                <label>Notes</label>
                                                    <textarea class="form-control" placeholder="Enter Note..." rows="3" name="note"></textarea>
                                                </div>
                                                <div class="form-group">
                                                <label>File(s)</label>
                                                    <input type="file" class="attchedfiles" name="uploadfile" placeholder="select file(s)..." multiple="multiple">
                                                </div>
                                                <div class="form-group">
                                                <label>Category</label>
                                                    <input class="form-control" placeholder="Enter Catagory..." name="category" id="category" type="text">
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
                                                   <!-- <input class="form-control" placeholder="Refer Meeting..." name="referancemeeting" type="text">  -->
													<select name="refermeeting[]" id="" class="form-control select2-multi-meet" multiple="multiple" >
                                                		<c:forEach items="${refermeetings}" var="reflist">
                                                			<option value="${reflist.meetingid}"> MEET${reflist.meetingid} [${reflist.subject}]</option>
                                                		</c:forEach>
                                                    </select>
                                                </div>
                                                
                                                <div class="form-group" style="position:relative">
                                                	<label>Start date</label>&nbsp;<span style="color:red;">*</span>
                                                    <input type="text" class="form-control" required name="fromdate" id='startdatepicker'>
                                                </div>
                                    
										  		<div class="form-group" style="position:relative">
                                                	<label>End date</label>&nbsp;<span style="color:red;">*</span>
                                                    <input type="text" class="form-control" required name="todate" id="enddatepicker">
                                                </div>
                                          
									          
                                                <div class="pull-right">
                                                	<button type="submit" id="btnsub" class="btn btn-primary">Submit</button>
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
                    	var isStartDateInvalid = false;
                    	var isEndDateInvalid = false;
                    	
                    	$('#startdatepicker').datetimepicker({
                    		daysOfWeekDisabled:[0],
                    		format: 'DD/MMM/YYYY hh:mm A',
                    		minDate: moment()
						});           			
                    		
                        $('#enddatepicker').datetimepicker({
                            useCurrent: false,
                            daysOfWeekDisabled:[0],
                            format: 'DD/MMM/YYYY hh:mm A',
                            minDate: moment()
                        });
                        
                        $("#startdatepicker").on("dp.change", function (e) {
                        	
                        	isStartDateInvalid = false;
                            $('#enddatepicker').data("DateTimePicker").minDate(e.date);
                            var weekday = e.date.format('d');
                            if(weekday === '0'){
                                $('#startdatepicker').val("");
                                isStartDateInvalid = true;
                            	alert("Kindly select different date, as selected date falls in weekend.");
                            }
                            
                        });
                        $("#enddatepicker").on("dp.change", function (e) {
                        	isEndDateInvalid = false;
                            $('#startdatepicker').data("DateTimePicker").maxDate(e.date);
                            var weekday = e.date.format('d');
                            if(weekday === '0'){
                                $('#enddatepicker').val("");
                                isEndDateInvalid = true;
                            	alert("Kindly select different date, as selected date falls in weekend.");
                            }
                        });
						
                		
                    	$('.select2-multi').select2();
                    	$('.select2-multi-meet').select2();
                    	
                    	$(".attchedfiles").change(function(event){
            				var c=0;
            				if($(".attchedfiles")[0].files.length > 5) {
            					alert("Maximum 5 files allowed.");
            				}
            			
            				$.each($(".attchedfiles").prop("files"),function(k,v){
            					var siz = v['size'];
            					if(siz > 5242880)
            						c=c+1;
            				});
            				if(c>0)
            					alert("Size cannot be more than 5 MB");
            				
            				$.each($(".attchedfiles").prop("files"),function(k,v){
            					var ext = v['name'].split('.').pop().toLowerCase();
            					if($.inArray(ext,['jpg','jpeg','gif','png', 'txt','doc','docx','pdf','xls','xlsx','ppt','pptx','zip','7z']) == -1)
            						c=c+1;
            				});
            				if(c>0)
            					alert("Choose only files with (.jpg, .jpeg, .gif, .png, .txt, .doc, .docx, .pdf, .xls, .xlsx, .ppt, .pptx, .zip, .7z) extension.");

            			});
            						
                    	$("#btnsub").click(function(event){
                   		
                    		if($("#subject").val().length > 120){ alert('Maximum 110-120 characters allowed in Subject');  return false}
                 	 		if($("#place").val().length > 30){ alert('Maximum 30 characters allowed in Place');  return false}
                 	 		if($("#category").val().length > 30){ alert('Maximum 30 characters allowed in Category');  return false}
              	 		 
            				var c=0;
            				if($(".attchedfiles")[0].files.length > 5) {
            					alert("Maximum 5 files allowed.");
            					return false;
            				}
            			
            				$.each($(".attchedfiles").prop("files"),function(k,v){
            					var siz = v['size'];
            					if(siz > 5242880)
            						c=c+1;
            				});
            				if(c>0){
            					alert("Size cannot be more than 5 MB");
            					return false;
            				}
            				
            				$.each($(".attchedfiles").prop("files"),function(k,v){
            					var ext = v['name'].split('.').pop().toLowerCase();
            					if($.inArray(ext,['jpg','jpeg','gif','png', 'txt','doc','docx','pdf','xls','xlsx','ppt','pptx']) == -1)
            						c=c+1;
            				});
            				if(c>0){
            					alert("Choose only images with (.jpg, .jpeg, .gif, .png, .txt, .doc, .docx, .pdf, .xls, .xlsx, .ppt, .pptx) extension.");
            					return false;
            				}
            				
            				if(isStartDateInvalid || isEndDateInvalid){
            					alert("Kindly select different date, as selected date falls in weekend.");
            					return false;
            				}
            				
            			});


                    	$("#btnaddguest").click(function(event){

                    		if($("#fname").val() == ''){
								alert("Enter firstname");
								return false;
                        	}
                    		if($("#lname").val() == ''){
								alert("Enter lastname");
								return false;
                        	}
                    		if($("#useremail").val() == ''){
								alert("Enter email");
								return false;
                        	}
                    		email_regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
                    		   if(!email_regex.test($("#useremail").val())){ alert('this is not valid email'); return false;  }
                    		   
                    		$.get("isEmailAlreadyRegistered", { useremail:$("#useremail").val() } )
								.done(function(data){
									if(data == "Email is already registered"){
                       		   			alert("This email address is already registered. kinldy add new email");
										return false;
                                	}else{
                                		$.post("addGuestUser", 
          	                       			  { fname: $("#fname").val(),
          	                       			    lname: $("#lname").val(),
          	                       			    email: $("#useremail").val()
          	                       			   }, 
          	                       			  function(result){
               	                       			  if(result == "true"){
               	                       				alert("User Added Successfully.");
               	                       			 	var newOption = $('<option value="'+$("#useremail").val()+'">'+$("#fname").val()+" "+$("#lname").val()+" ("+$("#useremail").val()+")"+'</option>');
		               	                       		$('#userlst').append(newOption);
			               	                       	$("#fname").val('');
	           	                       				$("#lname").val('');
	           	                       				$("#useremail").val('');
	           	                       			 	$('#newuserModal').modal('toggle');
               	                       		 
                           	                      }else{
                           	                    	alert("Error during adding new user. try after sometime");
                           	                    	$("#fname").val('');
               	                       				$("#lname").val('');
               	                       				$("#useremail").val('');
                           	                    	$('#newuserModal').modal('toggle');
                               	                  }
          	                       		   		
                                  		});
                                    }

                                	
                			});
                    		
                    	/*	$.post("isEmailAlreadyRegistered", 
                       			  {  useremail: $("#useremail").val()
                       			   }, 
                       			  function(result){
                            		alert(result);
                            		if(result == 'Email is already registered'){
                       		   			alert("Email is already registered. kinldy add new email");
										return false;
                                	}else{

                                		alert("called");
                                		$.post("addGuestUser", 
            	                       			  { fname: $("#fname").val(),
            	                       			    lname: $("#lname").val(),
            	                       			    email: $("#useremail").val()
            	                       			   }, 
            	                       			  function(result){
            	                       		   		alert("User Added Successfully.");
                                    		});
            											

                                        }
                      		});  */
						});
                    	
                    	
						 /*$('#participants').autocomplete({
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
							    
							}); */
							
							
							
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