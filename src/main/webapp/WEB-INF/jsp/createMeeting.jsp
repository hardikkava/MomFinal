<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                                    Create Meeting
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-lg-6">
                                            <form role="form">
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Subject" name="subject" type="text" id="subject">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Participants" name="participants" type="text" id="participants">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Owner" name="owner" type="text">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Place" name="place" type="text">
                                                </div>
                                                <div class="form-group">
                                                    <textarea class="form-control" placeholder="Note" rows="3" name="note"></textarea>
                                                </div>
                                                <div class="form-group">
                                                    <input type="file" name="file">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Catagory" name="catagory" type="text">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Recurring" name="recurring" type="text">
                                                </div>
                                                <div class="form-group">
                                                    <input class="form-control" placeholder="Referancemeeting" name="referancemeeting" type="text">
                                                </div>
                                                <div class="form-group">
                                                	<label>Due date</label>
                                                    <input class="form-control"  name="duedate" type="datetime-local">
                                                </div>
                                                
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