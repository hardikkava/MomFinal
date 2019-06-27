<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                <th>Edit</th>
                <th>Teste</th>
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
							<td><a href="#">Edit</a></td>
							<td><a href="#">Edit</a></td>
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