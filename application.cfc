component extends="framework.one" {
    
    this.name = "addressbook";
    this.sessionManagement = true;
    this.sessionTimeout = createTimespan(0, 2, 0, 0);
    this.datasource = "data_base1";
    this.ormEnabled = true;

    function onApplicationStart() {
        application.addressBook = new model.services.addressBook(); 
        return true;
    }

    function onSessionStart() {
        session.isAuthenticated = false;
    }

    /* function onRequestStart() {
        var excludePages = ["main.default"];
        var section = structKeyExists(url, "section") ? url.section : "main";
        var item = structKeyExists(url, "item") ? url.item : "default";
        var requestedPage = section & "." & item;

        // Redirect to login if user is not authenticated
        if (!session.isAuthenticated && !arrayContains(excludePages, requestedPage)) {
            if (requestedPage != "main.default") {
                location(url="index.cfm?section=main&item=default", addtoken=false);
            }
        }

        return true;
    }  */
}
