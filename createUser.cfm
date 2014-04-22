<cfif isdefined("action") and action is "checkUserName">
	<cfquery name="checkUser" datasource="yorbitDB">
		select refnum from users where email = '#userIn#'
	</cfquery>
	<cfif checkUser.recordcount is 0><font color="green">Email Available</font><cfelse><font color="red">Email Not Available</font></cfif>
<cfabort>
</cfif>

<cfif isdefined("action") and action is "addUser">
	<cfset form.email = userIn>
	<cfset form.password = passIn>
	<cfinsert datasource="yorbitDB" tablename="users" formfields="email,password">
	<cflocation url="secure/maplist.cfm?userIn=#userIn#&passIn=#passIn#">
</cfif>

<!doctype html>
<html class="no-js">
    <head>
        <meta charset="utf-8">
        <title>Create User - Yorbit</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="shortcut icon" href="images/favicon.ico">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png" />
		<link rel="apple-touch-icon" sizes="57x57" href="images/apple-touch-icon-57x57.png" />
		<link rel="apple-touch-icon" sizes="72x72" href="images/apple-touch-icon-72x72.png" />
		<link rel="apple-touch-icon" sizes="76x76" href="images/apple-touch-icon-76x76.png" />
		<link rel="apple-touch-icon" sizes="114x114" href="images/apple-touch-icon-114x114.png" />
		<link rel="apple-touch-icon" sizes="120x120" href="images/apple-touch-icon-120x120.png" />
		<link rel="apple-touch-icon" sizes="144x144" href="images/apple-touch-icon-144x144.png" />
		<link rel="apple-touch-icon" sizes="152x152" href="images/apple-touch-icon-152x152.png" />
        <link rel="stylesheet" href="styles/styles.css">

        <script src="scripts/vendor/modernizr.js"></script>
    </head>
    <body>
        <!--[if lt IE 10]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <header>
            
			
<div class="container"> 
  <div class="logo"> <a href="/"> <img src="marketing/images/logo.png" alt="Yorb.it" title="Yorb.it Logo" /> 
	</a> </div>
</div>
        </header>
        
		
<div class="container"> 
  <div class="modal" id="modal1"> 
	<p id="userChk">Create a new user.</p>
	<form action="createUser.cfm?action=addUser" method="post" id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_self">
	  <input type="email" name="userIn" class="location" id="location" placeholder="Email Address" required onChange="var val = $(this).val(); $('#userChk').load('createUser.cfm?action=checkUserName',{'userIn':val});"/>
	  <input type="password" name="passIn" class="password" id="password" placeholder="Password" />
	  <input type="submit" name="subscribe" class="btn btn-primary btn-large pull-right" value="Create Account" />
	</form>
  </div>
</div>

	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	
	</body>
</html>
