function onDashboardClick()
{
	$.ajax({
		url: "dashboard", 
		success: function(result)
		{
			$("#dashboardID").html(result);
		}
		});
}

function onCreateMeeting()
{
	$.ajax({
		url: "createMeeting", 
		success: function(result)
		{
			$("#dashboardID").html(result);
		}
		});
}

function onViewMeeting() {
	$.ajax({
		url:"viewMeeting",
		success:function(result){
			$("#dashboardID").html(result);
		}
	});
}

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