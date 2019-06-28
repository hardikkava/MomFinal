function showRecurring()
{
	document.getElementById('recurringPeriodID').style.display = 'block';
}

function hideRecurring()
{
	document.getElementById('recurringPeriodID').style.display ='none';
}

function onDisplayEditMeeting(meetingid)
{
	$.ajax({
		url:"displayEditMeeting?meetingid="+meetingid,
		success:function(result){
			$("#dashboardID").html(result);
		}
	});
}