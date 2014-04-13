<cfif isdefined("action") and action is "checkUserName">
	<cfquery name="checkUser" datasource="#siteDataSource#">
		select refnum from users where email = '#userIn#'
	</cfquery>
	<cfif checkUser.recordcount is 0><font color="green">Available</font><cfelse><font color="red">Not Available</font></cfif>
<cfabort>
</cfif>

<cfif isdefined("action") and action is "addUser">
	<cfset form.email = uidin>
	<cfset form.password = passIn>
	<cfinsert datasource="#siteDataSource#" tablename="users" formfields="email,password">
	<cflocation url="index.cfm">

</cfif>

<!doctype html>
<html>
<head>
<title>Create User</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<link rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/themes/smoothness/jquery-ui.css" />
<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
</head>

<body>
<form action="createUser.cfm?action=addUser" method="post">
<input type="hidden" name="snapLogout" value="true">
<table width="380" border="0" align="center">
<tr>
<td>Email:</td>
<td><input name="uidin" id="uidin" type="text" size="25" required onChange="var val = $(this).val(); $('#userChk').load('createUser.cfm?action=checkUserName',{'userIn':val});"><span id="userChk"></span></td>
</tr>

<tr>
<td>Password:</td>
<td><input name="passIn" type="password" size="25" required></td>
</tr>

<tr>
<td colspan="2" align="center"><input type="submit" value="Create User"></td>
</tr>
<tr>
<td colspan="2" align="right"><a href="createUser.cfm">Create User</a></td>
</tr>
</table>
</form>
</body>
</html>
