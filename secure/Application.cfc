<cfcomponent>
		<cfset This.name = "yorbit">  <!--- create applicatoin --->
		<cfset This.sessionmanagement="true"> 
		<cfset This.sessiontimeout="#createtimespan(0,2,0,0)#"> 
		 <!--- <cfset this.s3.accessKeyId = "AKIAI5SDIPOKFVOEX5UQ">  create S3 credentials 
        <cfset this.s3.awsSecretKey = "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"> --->		
		
		<cffunction name="onRequest">			
			<cfargument name="targetPage" type="String" required=true/> 
			<cfset var content="">
			
			<cfset siteDataSource = "yorbitDB"> 
			
			<cflogin>
						<cfset loginflag = false>
	
						<cfif isdefined("FORM.userIn")>
							
							<cftry>						
							<!--- query db and get password --->
							<cfquery datasource="yorbitDB" name="getPass">
								select * from users where email = '#FORM.userIn#'
							</cfquery>
							<cfcatch type="any"><cfoutput>#cfcatch.detail#  #cfcatch.message#</cfoutput><cfabort></cfcatch>
							</cftry>															
											
							<cfif FORM.passIn is getPass.password and getPass.recordcount is 1>
								<!--- If there is only one match, then log them in and set variables --->
							
								<cfset session.user = #getPass.refnum#> 
								<cfset loginflag = true>
								<cfloginuser name="#FORM.userIn#" password="#form.passIn#" roles="1">
							</cfif>
						</cfif>
						
						<cfif loginflag is false>
							<cflocation url="../index.cfm?message=Could not Log In">
							<cfabort>
						</cfif>
			</cflogin>
			
			<cfif isdefined("url.logout") and url.logout is "true">
					<cflogout>
					<cfset structClear(session)> <!--- clears all session variables --->
			</cfif>
			
			<cfif isdefined("session.user")>
				<cfsavecontent variable="content"> 
				<cfinclude template="#Arguments.targetPage#"> 
				</cfsavecontent>
			<cfelse>
				<cflogout>
				<cflocation url="../index.cfm">
				<cfabort>
			</cfif>
			
			<cfoutput>#content#</cfoutput>
			
		</cffunction>
		
		
		<cffunction name="onError" returnType="void" output="true">
		    <cfargument name="exception" required="true">
		    <cfargument name="eventname" type="string" required="true">
			
		    <cfset var errortext = "">		
		    <cfsavecontent variable="errortext">
		    <cfoutput>
			We have saved this error and will be working on it shortly.
			<hr>
		    An error occurred: http://#cgi.server_name##cgi.script_name#?#cgi.query_string#<br />
		    Time: #dateFormat(now(), "short")# #timeFormat(now(), "short")#
		    <hr>
			Error Details (please send these to <a href="mailto:jim@zeboco.com">Jim Farnham</a>):<br />
		    Message: <cfdump var="#arguments.exception.cause.message#" label="Error"><br />
			ID: #session.sessionID#<br>
			Detail Trace: <cfdump var="#arguments.exception.cause.TagContext[1].RAW_TRACE#" label="Error"><hr />
		    <cfdump var="#arguments.exception#"><!---  --->
		    </cfoutput>
		    </cfsavecontent>
		   
		   <cfset text = arguments.exception.cause.message & arguments.exception.cause.TagContext[1].RAW_TRACE>
		   <cflog file="myapperrorlog" text="#text#"> <!---  --->
		   <!---  <cfmail to="bugs@myproject.com" from="root@myproject.com" subject="Error: #arguments.exception.message#" type="html">
		        #errortext#
		    </cfmail> --->
		    
			<cfoutput>#errortext#</cfoutput>
		   <!--- <cflocation url="error.cfm"> --->
		    
		</cffunction>		
</cfcomponent>
