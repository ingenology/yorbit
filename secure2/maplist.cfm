<cfif isdefined("action") and action is "updateName">
	<cfquery name="updateName" datasource="#siteDataSource#">
		update tcPic set mapName = '#nameIn#' where refnum = #mapIn#
	</cfquery>
<cfabort>	
</cfif>

<cfif isdefined("action") and action is "removeMap">
	<cfquery name="remove" datasource="#siteDataSource#">
		delete from tcPic where refnum = #mapIn#
	</cfquery>
</cfif>

<cfquery datasource="#siteDataSource#" name="getData">
	select * from tcPic where user = #session.user#
</cfquery>

<html>
<head>
<title>Time Capsule - Map List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
</head>

<body>

<table border="0" width="600px" cellpadding="5" cellspacing="0">
<tr><td>Map Name</td><td>Created</td><td></td></tr>

<cfif getData.recordcount is 0>
<tr><td colspan="3">No Earth Art Created</td></tr>
</cfif>

<cfoutput query="getData">
<cfset urlLink = "http://54.186.209.124/viewMap.cfm?mapIn=#refnum#">
<tr>
<td>
<cfif mapName is not "">
	Name: <input type="text" name="#getData.currentrow#NameIn" value="#mapName#" onChange="var valin = $(this).val(); $('##hidSpan').load('maplist.cfm?action=updateName&mapIn=#refnum#',{'nameIn':valin});">
<cfelse>
	Name: <input type="text" name="#getData.currentrow#NameIn" value="#dateformat(created,'yy-m-d')# . #timeformat(created,'h:mm t')#" onChange="var valin = $(this).val(); $('##hidSpan').load('maplist.cfm?action=updateName&mapIn=#refnum#',{'nameIn':valin});">
</cfif>

</td>
<td>#dateformat(created,"m/d/yy")# @ #timeformat(created,"h:mm t")#</td>
<td><a href="maplist.cfm?action=removeMap&mapIn=#refnum#"  onClick="return confirm('Are you sure you want to DELETE Map: #mapName# ?');">Remove</a> 
<a href="http://yorb.it/viewArt.cfm?mapIn=#refnum#">View Art</a>
</td></tr>
</cfoutput>

<cfoutput><tr><td colspan="3"><a href="mapCreate.cfm">Create Earth Art</a></td></tr></cfoutput>

<tr><td colspan="3" align="right"><a href="maplist.cfm?logout=true">Log Out</a></td></tr>

</table>
<span id="hidSpan" style="visability:hidden;"></span>
</body>
</html>
