<cftry>
	<cfif IsDefined("opCode")>
		<cfif IsDefined("Driver")>
		  <cfif (#FindNoCase(#Driver#,"SQL Server")# NEQ 0)>
				<cfinclude TEMPLATE="SQLServer7.cfm">
		  <cfelse>
				<cfscript>
					xmlOutput = "";
					xmlOutput = xmlOutput & "<ERRORS>";
					xmlOutput = xmlOutput & "<ERROR";
					xmlOutput = xmlOutput & " Description=""";
					xmlOutput = xmlOutput & "Stored Procedures For " & #Driver# & " are not supported";
					xmlOutput = xmlOutput & """";
					xmlOutput = xmlOutput & " Identification=""";
					xmlOutput = xmlOutput & "";
					xmlOutput = xmlOutput & """";
					xmlOutput = xmlOutput & "></ERROR>";
					xmlOutput = xmlOutput & "</ERRORS>";
				</cfscript>
				<cfoutput>#xmlOutput#</cfoutput>
		  </cfif>
		</cfif>
	</cfif>
	<cfif IsDefined("opCode") AND IsDefined("ResultSet")>
		<cfscript>
			xmlOutput = "";
			xmlOutput = xmlOutput & "<RESULTSET>";
			xmlOutput = xmlOutput & "<FIELDS>";
			MM_columns = ListToArray(ResultSet.ColumnList,",");
			For (i=1; i LTE ArrayLen(MM_columns); i=i+1) 
			{
				xmlOutput = xmlOutput & "<FIELD";
				xmlOutput = xmlOutput & " name=""";
				xmlOutput = xmlOutput & MM_columns[i];
				xmlOutput = xmlOutput & """";
				xmlOutput = xmlOutput & "></FIELD>";
			}
			xmlOutput = xmlOutput & "</FIELDS>";
			xmlOutput = xmlOutput & "<ROWS>";
			For (i=1; i LTE ResultSet.RecordCount ; i=i+1) 
			{
				xmlOutput = xmlOutput & "<ROW";
				For (j=1; j LTE ArrayLen(MM_columns); j=j+1) 
				{
					xmlOutput = xmlOutput & " " & MM_columns[j] & "=""";
					if (#FindNoCase(#Driver#,"SQL Server")# NEQ 0)
					{
						if (MM_columns[j] EQ "PARAMETER_TYPE")
						{
							if (ResultSet[MM_columns[j]][i] EQ "1")
							{
								xmlOutput = xmlOutput & "2";
							}
							else if (ResultSet[MM_columns[j]][i] EQ "0")
							{
								xmlOutput = xmlOutput & "1";
							}
							else
							{
								xmlOutput = xmlOutput & ResultSet[MM_columns[j]][i];
							}
						}
						else
						{
								xmlOutput = xmlOutput & ResultSet[MM_columns[j]][i];
						}
					}
					else
					{
						xmlOutput = xmlOutput & ResultSet[MM_columns[j]][i];
					}
					xmlOutput = xmlOutput & """";
				}
				xmlOutput = xmlOutput & "></ROW>";
			}
			xmlOutput = xmlOutput & "</ROWS>";
			xmlOutput = xmlOutput & "</RESULTSET>";
		</cfscript>
		<cfoutput>#xmlOutput#</cfoutput>
	</cfif>
<cfcatch type="Database">
<cfscript>
	xmlOutput = "";
	xmlOutput = xmlOutput & "<ERRORS>";
	xmlOutput = xmlOutput & "<ERROR";
	xmlOutput = xmlOutput & " Description=""";
	xmlOutput = xmlOutput & cfcatch.message;
	xmlOutput = xmlOutput & """";
	xmlOutput = xmlOutput & " Identification=""";
	xmlOutput = xmlOutput & cfcatch.NativeErrorCode;
	xmlOutput = xmlOutput & """";
	xmlOutput = xmlOutput & "></ERROR>";
	xmlOutput = xmlOutput & "</ERRORS>";
</cfscript>
	<cfoutput>#xmlOutput#</cfoutput>
</cfcatch>
</cftry>


