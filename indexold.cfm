<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Yorbit</title>

</head>
<body>

<p align="center">New Yorbit Web Server <cfoutput>#now()#</cfoutput></p>

<form action="secure/maplist.cfm" method="post">
<table width="380" border="0" align="center">
<cfif isdefined("message")><tr>
          <td colspan="2"><font color="#FF0000"><cfoutput>#message#</cfoutput></font></td>
        </tr></cfif>

<tr>
<td>Email:</td>
<td><input name="userIn" type="text" size="25"></td>
</tr>

<tr>
<td>Password:</td>
<td><input name="passIn" type="password" size="25"></td>
</tr>

<tr>
<td colspan="2" align="center"><input type="submit" value="Login"></td>
</tr>
<tr>
<td colspan="2" align="right"><a href="createUser.cfm">Create User</a></td>
</tr>
</table>
</form>
</body>
</html>