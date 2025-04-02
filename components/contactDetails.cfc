<cfcomponent>
    <cffunction name="validateLogin" access="public" returnType="boolean">
        <cfargument  name="userName">
        <cfargument  name="userPassword1">
        <cfset local.encrypted_pass = Hash(#arguments.userPassword1#, 'SHA-512')/>
        <cfquery name="local.qCheck">
            SELECT CustomerID,
                userName,
                password,
                profile,
                fullName,
                mail
            FROM users
            WHERE userName = <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">
            AND password = <cfqueryparam value="#local.encrypted_pass#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif local.qCheck.password EQ "#local.encrypted_pass#">
            <cfif local.qCheck.recordCount >
                <cfset session.isAuthenticated = true>
                <cfset session.userId = local.qCheck.CustomerId>
                <cfset session.profile = local.qCheck.profile>
                <cfset session.fullName = local.qCheck.fullName>
                <cfset session.userMail = local.qCheck.mail>
                <cfreturn true>
            </cfif>
        <cfelse>
            <cfreturn false>
        </cfif>
        <cfreturn false>
    </cffunction>
    
    <cffunction  name="signUp" access="public" returnType="string">
        <cfargument  name="fullName">
        <cfargument  name="mail">
        <cfargument  name="userName">
        <cfargument  name="userPassword1">
        <cfargument  name="userPassword2">
        <cfargument  name="profile">
        <cfset local.path = expandPath("./assets")>
        <cffile  action="upload" destination="#local.path#" nameConflict="makeUnique">
        <cfset local.val=cffile.clientFile> 
        <cfset local.encrypted_pass1 = Hash(arguments.userPassword1, 'SHA-512')/>
        <cfset local.encrypted_pass2 = Hash(arguments.userPassword2, 'SHA-512')/>
        <cfif local.encrypted_pass1 EQ local.encrypted_pass2>
            <cfif Find(" ", arguments.userName)>
                <cfreturn "Username should not contain any spaces.">
            </cfif>
        
            <cfquery name="local.checkUser">
                SELECT userName 
                FROM users 
                WHERE userName=<cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">  
            </cfquery>

            <cfif local.checkUser.RecordCount EQ 0>
                <cfquery name="local.insertDetails">
                    INSERT INTO 
                        users(
                            fullName,
                            mail,
                            userName,
                            password,
                            profile
                        ) 
                    VALUES(
                        <cfqueryparam value="#arguments.fullName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.mail#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.userName#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#local.encrypted_pass1#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#local.val#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
                
                <cfreturn true> 
            <cfelse>
                <cfreturn false>
            </cfif>
            <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>
    </cffunction>

    <!--- <cffunction  name="setSessionId" access="remote" returnType="void">
        <cfargument  name="userId">
        <cfset session.contactId = arguments.userId>
    </cffunction> --->

    <cffunction  name="createContact" access="remote" returnType="string">
        <cfargument  name="title">
        <cfargument  name="firstName">
        <cfargument  name="lastName">
        <cfargument  name="gender">
        <cfargument  name="dob">
        <cfargument  name="img">
        <cfargument  name="address">
        <cfargument  name="street">
        <cfargument  name="pin">
        <cfargument  name="district">
        <cfargument  name="state">
        <cfargument  name="country">
        <cfargument  name="mail">
        <cfargument  name="phone">
        <cfargument  name="multiSel">
        <cfset isActive ="1">
        <cfif structKeyExists(form, "img")>
            <cfset local.path = expandPath("./assets")>
            <cffile  action="upload" destination="#local.path#" nameConflict="makeUnique">
            <cfset local.value=cffile.clientFile> 
        <cfelse>
            <cfset local.value = "draft.JPG">
        </cfif>
        <cfquery name="local.checkUser">
            SELECT 
                mail
            FROM 
                contact 
            WHERE 
                mail=<cfqueryparam value="#arguments.mail#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfif local.checkUser.recordCount EQ 0>
            <cfquery name="local.dataAdd" result = "keyValue">
                INSERT INTO 
                    contact(
                        title,
                        firstName,
                        lastName,
                        gender,
                        dob,
                        img,
                        address,
                        street,
                        pin,
                        district,
                        state,
                        country,
                        mail,
                        phone,
                        createdBy,
                        IsActive 
                    ) 
                VALUES(
                    <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.dob#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#local.value#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.address#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.pin#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.district#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.country#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.mail#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">,
                    1
                )
            </cfquery>
            <cfloop list="#arguments.multiSel#" item="item"> 
                <cfquery name = "local.selectedOptionInsertion">
                INSERT INTO 
                    contact_role(
                        contact_id,
                        role_id
                    ) 
                VALUES(
                    <cfqueryparam value="#keyValue.generatedKey#" cfsqltype="cf_sql_varchar">, 
                    <cfqueryparam value="#item#" cfsqltype="cf_sql_varchar">
                    )
                </cfquery>
            </cfloop> 
            <cfreturn "">
        <cfelse>
            <cfreturn "Email should be unique">
        </cfif>
    </cffunction>

    <cffunction  name="removeSessionId" access="remote" returnType="void">
        <cfif structKeyExists(session,"contactId")>
            <cfset structDelete(session,"contactId")>
        </cfif>
    </cffunction>

    <cffunction  name="viewContact" access="remote" returnType="query">
        <cfquery name="local.viewdata">
            SELECT 
                userId,
                title,
                firstName,
                lastName,
                gender,  
                dob,
                img,
                address,
                street,
                pin,
                district,
                state,
                country,
                mail,
                phone 
            FROM contact 
            WHERE createdBy=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
                AND IsActive = 1;
        </cfquery>
        <cfreturn local.viewdata>  
    </cffunction>

    <cffunction  name="viewExcelContact" access="remote" returnType="query">
        <cfquery name="local.viewdata">
            SELECT 
                userId,
                title,
                firstName,
                lastName,
                gender,  
                dob,
                address,
                street,
                pin,
                district,
                state,
                country,
                mail,
                phone
            FROM contact 
            WHERE createdBy=<cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
                AND IsActive = 1;
        </cfquery>
        <cfreturn local.viewdata>  
    </cffunction>
    
    <!--- <cffunction name="getRolesById" access="remote" returnType="query" returnFormat="json">
        <cfargument name = "contactId">
        <cfquery name = "local.getContactRoles">
            select 
            role_select.role_id,
            role_select.role_name,
            contact_role.contact_id
            from
            role_select 
                JOIN contact_role
            ON 
            role_select.role_id = contact_role.role_id
            WHERE contact_id = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfreturn local.getContactRoles>

    </cffunction>  --->

    <cffunction name="getOneContactById" access="remote" returnType="query" returnFormat="json">
        <cfargument name = "contactId">
        <cfquery name="local.viewdata">
           SELECT 
                c.title,
                c.firstName,
                c.lastName,
                c.gender,
                c.dob,
                c.address,
                c.street,
                c.pin,
                c.district,
                c.state,
                c.country,
                c.mail,
                c.phone,
                c.img,
                c.userId,
                STRING_AGG(rs.role_name,',') AS ROLES,
				STRING_AGG( rs.role_id,',') AS ROLESID
            FROM 
                contact c 
                LEFT JOIN contact_role cr ON c.userId = cr.contact_id
                LEFT JOIN role_select rs ON rs.role_id = cr.role_id
            WHERE userId = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">
			GROUP BY 
				c.userId,
				c.title,
                c.firstName,
                c.lastName,
                c.gender,
                c.dob,
                c.img,
                c.address,
                c.street,
                c.pin,
                c.district,
                c.state,
                c.country,
                c.mail,
                c.phone;
        </cfquery>
        <cfreturn local.viewdata>  
    </cffunction>

    <cffunction  name="editContact" access="public" returnType="string">
        <cfargument  name="title">
        <cfargument  name="firstName">
        <cfargument  name="lastName">
        <cfargument  name="gender">
        <cfargument  name="dob">
        <cfargument  name="img">
        <cfargument  name="address">
        <cfargument  name="street">
        <cfargument  name="pin">
        <cfargument  name="district">
        <cfargument  name="state">
        <cfargument  name="country">
        <cfargument  name="mail">
        <cfargument  name="phone">
        <cfargument  name="multiSel"> 
        <cfargument  name="contactId">

        <cfif structKeyExists(form, "img")>
            <cfset local.path = expandPath("./assets")>
            <cffile  action="upload" destination="#local.path#" nameConflict="makeUnique">
            <cfset local.value=cffile.clientFile> 
        <cfelse> 
            <cfset local.value = "draft.JPG">
        </cfif>
        <cfquery name="local.pageList">
            UPDATE contact 
            SET 
                title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
                firstName = <cfqueryparam value="#arguments.firstName#" cfsqltype="cf_sql_varchar">,
                lastName = <cfqueryparam value="#arguments.lastName#" cfsqltype="cf_sql_varchar">,
                gender = <cfqueryparam value="#arguments.gender#" cfsqltype="cf_sql_varchar">,
                dob = <cfqueryparam value="#arguments.dob#" cfsqltype="cf_sql_varchar">,
                img = <cfqueryparam value="#local.value#" cfsqltype="cf_sql_varchar">,
                address = <cfqueryparam value="#arguments.address#" cfsqltype="cf_sql_varchar">,
                street = <cfqueryparam value="#arguments.street#" cfsqltype="cf_sql_varchar">,
                pin = <cfqueryparam value="#arguments.pin#" cfsqltype="cf_sql_varchar">,
                district = <cfqueryparam value="#arguments.district#" cfsqltype="cf_sql_varchar">,
                state = <cfqueryparam value="#arguments.state#" cfsqltype="cf_sql_varchar">,
                country = <cfqueryparam value="#arguments.country#" cfsqltype="cf_sql_varchar">,
                mail = <cfqueryparam value="#arguments.mail#" cfsqltype="cf_sql_varchar">,
                phone = <cfqueryparam value="#arguments.phone#" cfsqltype="cf_sql_varchar">,
                updatedBy = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">
            WHERE 
                userId = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">
        </cfquery>
        <cfquery name = "local.deleteRoles">
            delete from 
                contact_role 
            where 
                contact_id = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">;
        </cfquery>
        <cfloop list="#arguments.multiSel#" item="item"> 
            <cfquery name = "local.selectedOptionInsertion">
                INSERT INTO 
                    contact_role(
                        contact_id,
                        role_id
                    ) 
                values
                (<cfqueryparam value = "#arguments.contactId#" cfsqltype="cf_sql_varchar">, 
                <cfqueryparam value = "#item#" cfsqltype="cf_sql_integer">)
            </cfquery>
        </cfloop> 
        <!--- <cflocation  url="home.cfm"> --->
        <cfreturn ""> 
    </cffunction>

    <cffunction  name="delContact" access="remote" returnType="void">
        <cfargument name = "contactId">
        <cfset dateJoined = "#Now()#">
        
        <cfquery name="local.deleteUpdation">
            UPDATE 
                contact
            SET
                IsActive = 0,
                deletedBy = <cfqueryparam value="#session.userId#" cfsqltype="cf_sql_varchar">,
                deletedOn = <cfqueryparam value="#dateJoined#" cfsqltype="cf_sql_varchar">
            WHERE
                userId = <cfqueryparam value="#arguments.contactId#" cfsqltype="cf_sql_integer">

        </cfquery>
    </cffunction>
    
    <cffunction name="logout" access="remote" returType="void" returnFormat = "JSON">
        <cfset structClear(session)>
        <cfreturn true>
    </cffunction>

    <cffunction  name="createExcel" access="remote" returnType="string" returnFormat="json">
        <cfargument name = "useState">
        <cfset local.id = createUUID()>
        <cfset local.filename = session.fullName>
        <cfset local.todaysDate = dateformat(Now())>
        <cfif arguments.useState == "allContacts">
            <cfset local.result = viewContact()>
        <cfelse> 
            <cfset local.result = viewExcelContact()>
         </cfif> 
        <cfset roleArray = arrayNew(1)>
        <cfloop query = "result">
            <cfset role_query = getOneContactById(local.result.userId)><!--- getRolesById --->
            <cfset roleString = "">
            <cfloop query="role_query">
                <cfset roleString = roleString & " " & role_query.ROLES>
            </cfloop>
            <cfset arrayAppend(roleArray, roleString)>
        </cfloop>
        <cfset queryAddColumn(local.result, "roles", roleArray)>
        <cfspreadsheet  action="write" filename="../assets/spreadsheet/#local.id#.xlsx" query="local.result">
        <cfreturn "#local.id#.xlsx">
    </cffunction>

    <cffunction  name="processExcelFile" access="public" returnType="string">
        <!--- <cfset local.id = createUUID()> --->
        <cffile action="upload" 
            filefield="exclFile" 
            destination="C:\inetpub\wwwroot\TestTask\assets" 
            nameconflict="overwrite">
        <cfset local.filePath = getDirectoryFromPath(cffile.serverFile) & cffile.serverFile>
        <cfspreadsheet action="read" 
            src="#form.exclFile#"
            sheet="1" 
            query="spreadsheetData"
            headerRow="1"
            excludeHeaderRow="true">
        
        <cfset local.missingData = []>
        <cfset local.columnMissing = []>
        <cfset local.roles = arrayNew(1)>
        <cfset local.columnNames = ["title",
                                    "firstName",
                                    "lastName",
                                    "gender",
                                    "dob", 
                                    "address",
                                    "street",
                                    "pin",
                                    "district",
                                    "state",
                                    "country",
                                    "mail",
                                    "phone"
                                    ]>
        <cfset local.roleSelect = multiSelection()>
        <cfloop query="spreadsheetData"> 

            <cfloop list="#spreadsheetData.roles#" item="item" delimiters = ",">
                <cfset local.roles = []>
                <cfset local.columnMissing = []>
                <cfset validRole = 1>
                <cfloop query = "#local.roleSelect#">
                    <cfif item EQ local.roleSelect.role_name>
                        <cfset arrayAppend(local.roles, local.roleSelect.role_id)>
                        <cfset validRole = validRole * 0>        
                    </cfif>
                </cfloop>
                <cfif validRole EQ 1>
                    <cfset arrayAppend(columnMissing, "Rolename invalid")>
                </cfif>
            </cfloop>

            <cfloop array = "#columnNames#" item = "columnName">
                <cfif len(trim(spreadsheetData[columnName].toString())) EQ 0>
                    <cfset arrayAppend(columnMissing, columnName)>
                </cfif>
            </cfloop>
            <cfif not isValid("email", spreadsheetData.mail)>
                <cfset arrayAppend(columnMissing, "Row #spreadsheetData.currentRow# has an invalid email: #spreadsheetData.mail#")>
            </cfif>
            <cfif len(trim(spreadsheetData.phone.toString())) NEQ 10>
                <cfset arrayAppend(columnMissing, "Row #spreadsheetData.currentRow# has an invalid phone: #spreadsheetData.phone#")>
            </cfif>
            <cfif spreadsheetData.roles.toString() EQ "">
                <cfset arrayAppend(columnMissing, "Enter role")>
            </cfif>
            <cfif NOT (spreadsheetData.gender EQ "Male" OR spreadsheetData.gender EQ "Female" OR spreadsheetData.gender EQ "Others")>
                <cfset arrayAppend(columnMissing, "Enter valid gender (Male, Female, or Others)")>
            </cfif>
            <cfif NOT (spreadsheetData.title EQ "Mr." OR spreadsheetData.title EQ "Miss.")>
                <cfset arrayAppend(columnMissing, "Enter name title")>
            </cfif>
            
            <cfif arrayLen(columnMissing) EQ 0>

                <cfquery name = "local.countMail">
                    SELECT
                        mail,
                        userId
                    FROM    
                        contact
                    WHERE
                        mail = <cfqueryparam value="#spreadsheetData.mail#" cfsqltype="cf_sql_varchar">;
                </cfquery>
                <cfloop list = "#spreadsheetData.ColumnList#" item = "columnName">
                    <cfif columnName EQ "">
                        <cfset arrayAppend(columnMissing,columnName)>
                    </cfif>
                </cfloop>

                <cfif local.countMail.recordCount EQ 1 >
                    <cfset local.contactId = local.countMail.userId>
                    <cfset local.multiSel = arrayToList(local.roles)>
                     <cfset editContact(
                        title = spreadsheetData.title,
                        firstName = spreadsheetData.firstName,
                        lastName = spreadsheetData.lastName,
                        gender = spreadsheetData.gender,
                        dob = spreadsheetData.dob,
                        img = "", 
                        address = spreadsheetData.address,
                        street = spreadsheetData.street,
                        pin = spreadsheetData.pin,
                        district = spreadsheetData.district,
                        state = spreadsheetData.state,
                        country = spreadsheetData.country,
                        mail = spreadsheetData.mail,
                        phone = spreadsheetData.phone,
                        IsActive = 1,
                        multiSel = local.multiSel,
                        contactId = local.contactId
                    )>
                    <cfset arrayAppend(missingData,"updated")>

                <cfelseif local.countMail.recordCount EQ 0>
                    <cfset local.multiSel = arrayToList(local.roles)>
                    <cfset local.inserted = createContact(
                        title = spreadsheetData.title,
                        firstName = spreadsheetData.firstName,
                        lastName = spreadsheetData.lastName,
                        gender = spreadsheetData.gender,
                        dob = spreadsheetData.dob,
                        img = "", 
                        address = spreadsheetData.address,
                        street = spreadsheetData.street,
                        pin = spreadsheetData.pin,
                        district = spreadsheetData.district,
                        state = spreadsheetData.state,
                        country = spreadsheetData.country,
                        mail = spreadsheetData.mail,
                        phone = spreadsheetData.phone,
                        multiSel = local.multiSel,
                        IsActive= 1
                    )> 
                    <cfset arrayAppend(missingData,"added")>
                </cfif>
            <cfelse>
                <cfset arrayAppend(missingData, arrayToList(columnMissing))>
            </cfif>
        </cfloop>
        <cfset queryAddColumn(spreadsheetData, "result",missingData)>
        <cfset local.sortedQuery = QuerySort(spreadsheetData, function(obj1, obj2){
			var check1 = FindNoCase("added", obj1.result) OR FindNoCase("updated", obj1.result);
			var check2 = FindNoCase("added", obj2.result) OR FindNoCase("updated", obj2.result);
            
			if (check1 AND NOT check2) {
				return 1;
			}
			else if (check2 AND NOT check1) {
				return -1;
			}
			return 0;
		})>
        <cfspreadsheet  action="write" filename="../assets/result.xlsx" query="local.sortedQuery" overwrite = "true">  
        <cfreturn "result.xlsx">
    </cffunction>

    <cffunction  name="plainExcel" access="remote" returnType="string" returnFormat="json">
        <cfset local.id = createUUID()>
        <!--- <cfset local.roleObj = getOneContactById()> --->
        <cfquery name = "local.viewData">
            /*SELECT name
            FROM sys.columns
            WHERE object_id = OBJECT_ID('contact'); */
            SELECT
                top 0 title,
                firstName,
                lastName,
                gender,
                dob, 
                address,
                street,
                pin,
                district,
                state,
                country,
                mail,
                phone  
            FROM 
                contact;
        </cfquery>
        <cfset local.arrayy = []>
        <cfset queryAddColumn(local.viewData, "roles",local.arrayy)>
        <cfspreadsheet  action="write" filename="../assets/spreadsheet/#local.id#.xlsx" query = "local.viewData" >
        <cfreturn "#local.id#.xlsx">
    </cffunction>
    
    <cffunction name="multiSelection" access="public" returnType="query">
        <cfquery name = "local.getMultiSelectedData">
            SELECT 
                role_id,
                role_name
            FROM
                role_select
            ORDER BY
                role_name;
        </cfquery>
        <cfreturn local.getMultiSelectedData>
    </cffunction>

</cfcomponent>