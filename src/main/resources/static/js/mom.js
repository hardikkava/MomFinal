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