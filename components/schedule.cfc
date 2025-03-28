<cfcomponent>
    <cffunction name = "scheduleDate" access="remote" returnType="void">
        <cfschedule action = "update" 
        task = "TaskName" 
        operation = "HTTPRequest" 
        url = "http://addressbook.com/checkSite.cfm?userId=#session.userId#&userMail=#session.userMail#" 
        startDate = "#Now()#" 
        startTime = "12:00 AM"
        interval = "daily" 
        mode = "application"  
        >
    </cffunction>
</cfcomponent>