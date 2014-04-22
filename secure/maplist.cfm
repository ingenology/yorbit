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
	select * from tcPic where user = #session.user# order by refnum desc
</cfquery>

<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>View your maps | Yorbit</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width">
        <link rel="shortcut icon" href="/images/favicon.ico">
        <link rel="apple-touch-icon" href="/images/apple-touch-icon.png" />
		<link rel="apple-touch-icon" sizes="57x57" href="/images/apple-touch-icon-57x57.png" />
		<link rel="apple-touch-icon" sizes="72x72" href="/images/apple-touch-icon-72x72.png" />
		<link rel="apple-touch-icon" sizes="76x76" href="/images/apple-touch-icon-76x76.png" />
		<link rel="apple-touch-icon" sizes="114x114" href="/images/apple-touch-icon-114x114.png" />
		<link rel="apple-touch-icon" sizes="120x120" href="/images/apple-touch-icon-120x120.png" />
		<link rel="apple-touch-icon" sizes="144x144" href="/images/apple-touch-icon-144x144.png" />
		<link rel="apple-touch-icon" sizes="152x152" href="/images/apple-touch-icon-152x152.png" />
        <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->

        <link rel="stylesheet" href="../styles/styles.css"/>
        <script src="../scripts/vendor/modernizr.js"></script>

    </head>
    <body>
<!--[if lt IE 10]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
	<header> 
		<div class="container"> 
			<div class="logo">
				<a href="/">
					<img src="/images/logo.png" alt="Yorb.it" title="Yorb.it Logo" /> 
				</a>
			</div>
			<div class="navigation-button" id="trigger-overlay">
				<img src="/images/menu_button.png" /> 
			</div>
		</div>
	</header> 
	<div class="overlay overlay-door">
	    <div class="close_button">
	        <a href="#" class="close_navigation overlay-close" onclick="return false;">X</a>
	    </div>
	    <nav class="navigation">
	        <ul>					
	            <li><a href="screen1.cfm">Add your own earth art</a></li>
	            <li><a href="maplist.cfm?logout=true">Log out</a></li>
				<li><a href="/">How Does it Work</a></li>
	        </ul>
	    </nav>
	</div>
	<div class="container">
        <div class="modal map-list">
            <p>This is your earth gallery. View your creation, give it a name, or remove it from your collection.</p>
            <div class="map-entry" id="mapListContent">
	            <cfif getData.recordcount is 0>
					<p class="no-results">You have not created any maps yet. Click the button below to get started.</p>
					<a href="screen1.cfm" class="btn btn-primary btn-skinny">Create map</a>
				</cfif>
				<div class="detail">
					<cfoutput query="getData">
						<cfset urlLink = "http://yorb.it/viewMap.cfm?mapIn=#refnum#">
						<cfif mapName is not "">
							<input type="text" class="textfield" name="#getData.currentrow#NameIn" value="#mapName#" onChange="var valin = $(this).val(); $('##hidSpan').load('maplist.cfm?action=updateName&mapIn=#refnum#',{'nameIn':valin});" />
						<cfelse>
							<input type="text" class="textfield" name="#getData.currentrow#NameIn" value="#dateformat(created,'yy-m-d')#" onChange="var valin = $(this).val(); $('##hidSpan').load('maplist.cfm?action=updateName&mapIn=#refnum#',{'nameIn':valin});" />
							<div class="buttons">
	                            <a href="screen3.cfm?mapIn=#refnum#" class="button">
	                                Save &amp; View
	                            </a>
	                            <a href="maplist.cfm?action=removeMap&mapIn=#refnum#" class="button" target="_self" title="Remove Art" onClick="return confirm('Are you sure you want to REMOVE this art: #mapName# ?');">
	                                Remove
	                            </a>
	                        </div>
						</cfif>
					</cfoutput>
				</div>
            </div>
        </div>
	</div>
	
	<script src="../scripts/vendor.js"></script>
    <script src="../scripts/scripts.js"></script>
    
    </body>
</html>
<!--		
	<div id="mapListContent">
		<cfif getData.recordcount is 0>
			<p>You have not created any maps yet</p>
		</cfif>
		
	
	
<table border="0" width="900px" cellpadding="20" cellspacing="40" align="center">

<cfif getData.recordcount is 0>
<tr><td colspan="4">No Earth Art Created Yet. Click the Menu.</td></tr>
<cfelse>
<tr><td>Earth Art Name</td><td>Created</td><td></td><td></td></tr>
</cfif>




<cfoutput query="getData">
<cfset urlLink = "http://yorb.it/viewMap.cfm?mapIn=#refnum#">
<tr>
<td>
<cfif mapName is not "">
	<input type="text" name="#getData.currentrow#NameIn" value="#mapName#" onChange="var valin = $(this).val(); $('##hidSpan').load('maplist.cfm?action=updateName&mapIn=#refnum#',{'nameIn':valin});">
<cfelse>
	<input type="text" name="#getData.currentrow#NameIn" value="#dateformat(created,'yy-m-d')#" onChange="var valin = $(this).val(); $('##hidSpan').load('maplist.cfm?action=updateName&mapIn=#refnum#',{'nameIn':valin});">
</cfif>

</td>
<td>#dateformat(created,"m/d/yy")#</td>

<td><a href="screen3.cfm?mapIn=#refnum#" class="blueButton">Share Publish</a></td>

<td align="right"><a href="maplist.cfm?action=removeMap&mapIn=#refnum#" target="_self" title="Remove Art" onClick="return confirm('Are you sure you want to REMOVE this art: #mapName# ?');"><img src="../images/delete-icon.png" align="absmiddle"></a></td>
</tr>
</cfoutput>

 <cfoutput><tr><td colspan="3"><a href="screen1.cfm" target="_self">Create Earth Art</a></td></tr></cfoutput>

<tr><td colspan="3" align="right"><a href="maplist.cfm?logout=true">Log Out</a></td></tr> 

</table>
<span id="hidSpan" style="visability:hidden;"></span>
		
		</div>


        <script src="../scripts/vendor.js"></script>



        <script src="../scripts/scripts.js"></script>
</body>
</html>
-->