<cfoauth  Type="Google"  clientid=""  
scope="email"   result="session.googleAccnt" secretKey = "">

<cfif structKeyExists(session,"googleAccnt")>
    <cfset session.isAuthenticated = true>
    <cfset session.userId = "#session.googleAccnt.id#">
    <cfset session.userName="#session.googleAccnt.other.email#">
    <cfset session.profile="#session.googleAccnt.other.picture#">
    <cfset session.fullName="#session.googleAccnt.name#">
    <cflocation  url="home.cfm">
</cfif>