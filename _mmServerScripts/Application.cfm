<!--- 
**
* Name:Macromedia
*
* Copyright (c) 2002 Macromedia.  All Rights Reserved.
* DO NOT REDISTRIBUTE THIS SOFTWARE IN ANY WAY WITHOUT THE EXPRESSED
* WRITTEN PERMISSION OF MACROMEDIA.
--->

<cftry>
	<cfsetting showdebugoutput="no">
	<cfset factory = createObject("java", "coldfusion.server.ServiceFactory")>
	<cfset request.security = factory.securityService>
	<cfset checkSecurity=request.security.RDSSecurityEnabled>
<cfcatch type="any">
	<cfset checkSecurity="false">
</cfcatch>
</cftry>

<cfif checkSecurity>
	<cfif IsDefined('form.rdspassword')>
		<cfset rdspassword="#form.rdspassword#">
	<cfelseif IsDefined('URL.rdspassword')>
		<cfset rdspassword="#URL.rdspassword#">
	<cfelse>
		<cfabort>
	</cfif>

	<cfif NOT request.security.checkRDSPassword(rdspassword)>
		<cfif NOT request.security.checkAdminPassword(rdspassword)>
			<cfabort>
		</cfif>
	</cfif>
</cfif>
