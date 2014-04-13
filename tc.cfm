<cfif isdefined("action") and action is "getAddress">
	<cfset addOut = #replace(address," ","+","all")#>
	<cfset cityOut = #replace(city," ","+","all")#>
		
	<cfhttp method="get" url="http://maps.googleapis.com/maps/api/geocode/xml?address=#addOut#,+#cityOut#,+#state#&sensor=true" result="getAdd"></cfhttp>
	<cfset mydoc = XmlParse(#getAdd.filecontent#)>
	<cfset latOut = mydoc.GeocodeResponse.result.geometry.location.lat.XMLText>
	<cfset longOut = mydoc.GeocodeResponse.result.geometry.location.lng.XMLText>
	<cflocation url="GIBSmap.cfm?zoomIn=7&centerIn=#latOut#,#longOut#&mapType=#mapType#&tcIn=#tcIn#&dateIn=#dateIn#">
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


<cfif isdefined("action") and action is "createNew">
	<cfif isdefined("tcIn")>	
	<cfelse>
		<cfinsert datasource="#siteDataSource#" tablename="tc" formfields="name,created,accessCode,email">
		
		<cfquery datasource="#siteDataSource#" name="getLatest">
			select refnum from tc order by refnum desc limit 1
		</cfquery>
	</cfif>
	
	
	<form action="tc.cfm?action=getAddress" method="post">
	<table width="600px" border="0" cellpadding="5" cellspacing="0">
	<tr><td colspan="2">Add a Map to your capsule:</td></tr>
	
	<cfif isdefined("tcIn")>
		<cfoutput><input type="hidden" name="tcIn" value="#tcIn#"></cfoutput>
	<cfelse>
		<cfoutput><input type="hidden" name="tcIn" value="#getLatest.refnum#"></cfoutput>
	</cfif>
	<tr><td>Address: </td><td><input type="text" name="address"></td></tr>
	<tr><td>City: </td><td><input type="text" name="city"></td></tr>
	<tr><td>State: </td><td><input type="text" name="state"></td></tr>
	<!--- <tr><td>Zip: </td><td><input type="text" name="zip"></td></tr>
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
	<cfabort>
</cfif>



<form action="tc.cfm?action=createNew" method="post">
<cfoutput>
<input type="hidden" name="created" value="#now()#">
<input type="hidden" name="accessCode" value="#randStr(5,'alphanumericupper')#">
</cfoutput>
<table width="600px" border="0" cellpadding="5" cellspacing="0">
	<tr><td colspan="2">Create New Time Capsule:</td></tr>
	<tr><td>Time Capsule Name: </td><td><input type="text" name="name" size="25"></td></tr>
	<tr><td>eMail: </td><td><input type="text" name="email" size="25"></td></tr>
	<tr><td colspan="2"><input type="submit" value="Start Time Capsule"></td></tr>
</table>
</form>

<hr>

<form action="viewCapsule.cfm" method="post">
Time Capsule Access Code: <input type="text" name="accessCode"> <input type="submit" value="Go">
</form>


</body>
</html>

<cfscript>
/**
 * Returns a randomly generated string using the specified character sets and length(s)
 * 
 * @param strLen      Either a number or a list of numbers representing the range in size of the returned string. (Required)
 * @param charset      A string describing the type of random string. Can contain: alpha, numeric, and upper. (Required)
 */
function randStr(strLen, charSet) {
	var r = Randomize(timeformat(now(),"smmHHl"), "SHA1PRNG");
    var usableChars = "";
    var charSets = arrayNew(1);
    var tmpStr = "";    
    var newStr = "";
    var i = 0;
    var thisCharPos = 0;
    var thisChar = "";
    
    charSets[1] = '48,57';    // 0-9
    charSets[2] = '65,90';    // A-Z
    charSets[3] = '97,122';    // a=z
    
    if (findnocase('alpha', charSet)) { usableChars = listappend(usableChars, 3); }
    
    if (findnocase('numeric', charSet)) { usableChars = listappend(usableChars, 1); }
    
    if (findnocase('upper', charSet)) { usableChars = listappend(usableChars, 2); }
    
    if (len(usableChars) is 0) { usableChars = '1,2,3'; }

    if(listlen(strLen) gt 1 and listfirst(strLen) lt listlast(strLen)) { strLen = randrange(listfirst(strLen), listlast(strLen), "SHA1PRNG"); }
    else if (val(strLen) is 0) { strLen = 8; }
    
    
    while (len(tmpStr) LE strLen-1)
    {
        thisSet = listFirst(usableChars);
        usableChars = listdeleteat(usableChars, 1);
        usableChars = listappend(usableChars, thisSet);
    
        tmpStr = tmpStr & chr(randrange(listfirst(charSets[thisSet]), listlast(charSets[thisSet]), "SHA1PRNG"));
    }
    
    for (i=1; i lte strLen; i=i+1)
    {
        thisCharPos = randrange(1, len(tmpStr), "SHA1PRNG");
        thisChar = mid(tmpStr, thisCharPos, 1);
        tmpStr = removeChars(tmPStr, thisCharPos, 1);
        newstr = newstr & thisChar;
    }
    
    return newStr;
}
</cfscript>
