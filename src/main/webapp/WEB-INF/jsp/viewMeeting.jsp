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
	</head>
    <body>

        <div id="wrapper">

            <%@include file="header.jsp" %>
			<c:choose> 
				<c:when test="${meetstatus eq 'success'}">
						<script type="text/javascript">
							
								swal("Success!", "New Meeting Created Successfuly!", "success");
							
						</script>
			   </c:when>
			</c:choose>
			
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
				                <th style="width:100%;max-width: 58%;">Meeting Desc..</th>
				                <th>Place</th>
				                <th>StartDate</th>
				                <th>EndDate</th>
				                <th>Owner</th>
				            </tr>
							</thead>
							<tbody>
						
								<c:forEach items="${meetingList}" var="mlist">
								  <c:set var="startdate" value="${fn:substring(mlist.startdate,0,16)}" />
								  <c:set var="enddate" value="${fn:substring(mlist.enddate,0,16)}" />
								<tr>
										<td><a href="getMeetingDetail?meetid=${mlist.meetingid}" ><b>${mlist.subject}</b><br/><i> ${mlist.note}</i></a></td>
										<td>${mlist.place}</td>
										<td>${fn:substring(mlist.startdate,0,16)}</td>
										<td>${fn:substring(mlist.enddate,0,16)}</td>
										<td>${mlist.owner}</td>
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