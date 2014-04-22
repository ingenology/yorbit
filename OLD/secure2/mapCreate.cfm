<cfif isdefined("action") and action is "getAddress">
	<cfset addOut = #replace(location," ","+","all")#>
	<!--- <cfset cityOut = #replace(city," ","+","all")#> --->
		
	<cfhttp method="get" url="http://maps.googleapis.com/maps/api/geocode/xml?address=#location#&sensor=true" result="getAdd"></cfhttp>
	<cfset mydoc = XmlParse(#getAdd.filecontent#)>
	<cfset latOut = mydoc.GeocodeResponse.result.geometry.location.lat.XMLText>
	<cfset longOut = mydoc.GeocodeResponse.result.geometry.location.lng.XMLText>
	<cflocation url="GIBSmap.cfm?zoomIn=7&centerIn=#latOut#,#longOut#&mapType=#mapType#&dateIn=#dateIn#">
	<cfabort>
	<cfoutput>
	Lat: #latOut#<br>
	Long: #longOut#<br>
	<a href="GIBSmap.cfm?zoomIn=7&centerIn=#latOut#,#longOut#">Map It</a>
	</cfoutput>
	<cfabort> 
</cfif>


<!doctype html>
<html>
<head>
<title>Create Time Capsule</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
<script src="http://maps.google.com/maps/api/js?sensor=false"></script>

<script>
$(function() {
	$( "#dateIn" ).datepicker({ dateFormat: "yy-mm-dd" });
});
</script>
</head>

<body>

<form action="mapCreate.cfm?action=getAddress" method="post">
	<table width="600px" border="0" cellpadding="5" cellspacing="0">
	<tr><td colspan="2">Add a Map to your capsule:</td></tr>
	
	<tr><td>Location: </td><td><input type="text" name="location"></td></tr>
	<!---<tr><td>City: </td><td><input type="text" name="city"></td></tr>
	<tr><td>State: </td><td><input type="text" name="state"></td></tr>
	 <tr><td>Zip: </td><td><input type="text" name="zip"></td></tr>
	<tr><td>Country: </td><td><input type="text" name="country"></td></tr> --->
	<tr><td>Date:</td><td><input name="dateIn" id="dateIn"></td></tr>
	<tr><td colspan="2">
	<select name="mapType">
		<option value="1">CorrectedReflectance_TrueColor</option>
		<option value="2">City Lights</option>
		<option value="3">MODIS_Aqua_SurfaceReflectance_Bands121</option>
	</select>
	</td></tr>
	<tr><td colspan="2"><input type="submit" value="Add Map"></td></tr>
	</table>
</form>

</body>
</html>
