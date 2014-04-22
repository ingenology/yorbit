<cfif (NOT CompareNoCase(#opCode#,"GetProcedures"))>
	<cfquery name="ResultSet" datasource=#ConnectionString# username=#UserName# password=#Password#>
		SELECT sysobjects.name as PROCEDURE_NAME,sysusers.name as PROCEDURE_SCHEMA
		FROM sysobjects,sysusers
		WHERE sysobjects.uid=sysusers.uid AND sysobjects.type='P' 
	</cfquery>
</cfif>
<cfif (NOT CompareNoCase(#opCode#,"GetParametersOfProcedure"))>
	<cfif IsDefined("ProcName")>
		<cfquery name="ResultSet" datasource=#ConnectionString# username=#UserName# password=#Password#>
			SELECT syscolumns.name As 'PARAMETER_NAME', systypes.name As 'DATA_TYPE', syscolumns.isoutparam As 'PARAMETER_TYPE'
			FROM syscolumns, sysobjects, systypes
			WHERE syscolumns.id = sysobjects.id
			AND systypes.xtype = syscolumns.xtype
			AND sysobjects.XTYPE = 'P'
			AND sysobjects.name  = '#ProcName#'
			AND systypes.name in (select name from master.dbo.systypes) and systypes.name <> 'sysname'
			order by syscolumns.colid
		</cfquery>
	</cfif>
</cfif>
<cfif (NOT CompareNoCase(#opCode#,"ExecuteSP"))>
	<cfif IsDefined("ExecProcName")>
		<cfscript>
			dotIndex = Find("dbo.",#ExecProcName#);
			if (dotIndex GT 0)
			{
				#ExecProcName# = Mid(#ExecProcName#,dotIndex+4,Len(#ExecProcName#)-dotIndex);			
			}
		</cfscript>
		<cfquery name="ProcParams" datasource=#ConnectionString# username=#UserName# password=#Password#>
			SELECT syscolumns.name As 'PARAMETER_NAME', systypes.name As 'DATA_TYPE', syscolumns.isoutparam As 'PARAMETER_TYPE'
			FROM syscolumns, sysobjects, systypes
			WHERE syscolumns.id = sysobjects.id
			AND systypes.xtype = syscolumns.xtype
			AND sysobjects.XTYPE = 'P'
			AND sysobjects.name  = '#ExecProcName#'
			AND systypes.name in (select name from master.dbo.systypes) and systypes.name <> 'sysname'
			order by syscolumns.colid
		</cfquery>
		<cfscript>
			CallStatement = "{call ";
			CallStatement = CallStatement & #ExecProcName#;
			if (ProcParams.RecordCount GT 0)
			{
				CallStatement = CallStatement & "(";
				MM_columns = ListToArray(ProcParams.ColumnList,",");
				For (i=1; i LTE ProcParams.RecordCount ; i=i+1) 
				{
					paramdirection = ProcParams["PARAMETER_TYPE"][i];
					paramtype	   = ProcParams["DATA_TYPE"][i];
					delimiter	   = "";
					defaultvalue   = 0;

					switch (paramtype)
					{
						case "char":
						case "nchar*":
						case "varchar":
						case "nvarchar*":
						case "date":
						case "datetime":
						case "smalldatatime":
						{
							delimiter = "'";
							defaultvalue = "";
							break;
						}
						default:
						{
							delimiter = "";
						}
					}

					if (paramdirection GT 0)
					{
						if(i GT 1)
						{
							CallStatement = CallStatement & ",";
						}

						CallStatement = CallStatement & delimiter & defaultvalue & delimiter;
					}
					else
					{
						if(i GT 1)
						{
							CallStatement = CallStatement & ",";
						}

						CallStatement = CallStatement & delimiter & ProcParams["PARAMETER_NAME"][i] & delimiter;
					}
				}

				CallStatement = CallStatement & ")";
			}

			MM_params = ListToArray(#ExecProcParameters#,",");
			For (i=1; i LTE ArrayLen(MM_params); i=i+2) 
			{
				MM_paramName = 	MM_params[i];
				MM_paramValue = MM_params[i+1];
				if (MM_paramValue EQ "empty")
				{
					MM_paramValue = "";
				}
				CallStatement = REReplaceNoCase(CallStatement,MM_paramName,MM_paramValue);
			}
			CallStatement = CallStatement & "}";
		</cfscript>
		<cfquery name="ResultSet" datasource=#ConnectionString# username=#UserName# password=#Password# MaxRows=#MaxRows#>
			#PreserveSingleQuotes(CallStatement)#
		</cfquery>
	</cfif>
</cfif>
