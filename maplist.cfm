<cfif isdefined("action") and action is "updateName">
	<cfquery name="updateName" datasource="#siteDataSource#">
		update tcPic set mapName = '#nameIn#' where refnum = #mapIn#
	</cfquery>
<font color="green" style="font-size:10px;">Saved</font><cfabort>	
</cfif>

<cfif isdefined("action") and action is "removeMap">
	<cfquery name="remove" datasource="#siteDataSource#">
		delete from tcPic where refnum = #mapIn#
	</cfquery>
</cfif>

<cfquery datasource="#siteDataSource#" name="getData">
	select * from tcPic where tc = #tcIn#
</cfquery>

<cfquery datasource="#siteDataSource#" name="getTC">
	select * from tc where refnum=#tcIn#
</cfquery>

<cfset urlLink = "http://54.186.209.124/viewCapsule.cfm?accessCode=#urlencodedformat(getTC.accessCode)#">

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
<tr>
<td><strong>Maps in Capsule</strong></td><td>Time Capsule Name: <cfoutput>#getTC.name#</cfoutput></td>
</tr>

<cfif isdefined("message")><tr><td colspan="3"><cfoutput>#message#</cfoutput></td></tr></cfif>

<tr><td></tr></td><td colspan="2"></td></tr>

<cfoutput query="getData">
<tr><td>
Name: <input type="text" name="NameIn" value="#mapName#" onChange="var valin = $(this).val(); $('##nameSpan').load('maplist.cfm?action=updateName&mapIn=#refnum#',{'nameIn':valin});">
<span id="nameSpan"></span>
</td><td>#dateformat(created,"m/d/yy")# @ #timeformat(created,"h:mm t")#</td><td><a href="maplist.cfm?action=removeMap&mapIn=#refnum#&tcIn=#tcIn#"  onClick="return confirm('Are you sure you want to DELETE Map: #mapName# ?');">Remove</a></td></tr>
</cfoutput>

<cfoutput><tr><td colspan="3"><a href="tc.cfm?action=createNew&tcIn=#tcIn#">Add another Map</a></td></tr></cfoutput>
<tr><td colspan="3"><cfoutput><a href="mailto:?Subject=Yourb.it%20NASA%20Time%20Capsule&body=#urlencodedformat(urlLink)#">Email Link Time Capsule</a></cfoutput></td></tr>
<tr><td colspan="3">
View your Time Capsule:<br>
Visit <a href="<cfoutput>#urlLink#</cfoutput>" target="_blank"><cfoutput>#urlLink#</cfoutput></a>
</td></tr>

<tr><td colspan="3">URL for Twitter, Facebook, etc.<br><cfoutput>#urlLink#</cfoutput></td></tr>

<tr><td colspan="3">Remember your Time Capsule Code: <cfoutput><strong>#getTC.accessCode#</strong></cfoutput></td></tr>
</table>
</body>
</html>
