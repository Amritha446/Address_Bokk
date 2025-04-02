component accessors=true {
    property addressBookService; // Injecting the model layer
    function init(fw) {
        variables.fw=arguments.fw;
        return this;
    }
    function default( struct rc ) {
        param name="rc.userName" default="";
        param name="rc.userPassword1" default="";

        // If login form is submitted, authenticate user
        if ( structKeyExists(rc, "userName") && structKeyExists(rc, "userPassword1") ) {
            var authResult = variables.addressBookService.authenticateUser(rc.userName, rc.userPassword1);

            if (authResult.authenticated) { 
                session.isAuthenticated = true;
                session.userId = authResult.userData.userId;
                session.profile = authResult.userData.profile;
                session.fullName = authResult.userData.fullName;
                session.userMail = authResult.userData.userMail;

                location("?action=main.home");
            } else {
                rc.error = "Invalid login attempt. Please try again.";
            }
        }

        // If user is not authenticated, show login page
        /* if (!session.isAuthenticated) {
            location("?action=main.default"); // Ensure it correctly maps to views/main/default.cfm
        } */
    }

    function signUp(rc) {
        if (structKeyExists(rc, "submit")) {

            var signUpResult = variables.addressBookService.signUp(
                fullName = rc.fullName,
                mail = rc.mail,
                userName = rc.userName,
                userPassword1 = rc.userPassword1,
                userPassword2 = rc.userPassword2,
                profile = rc.profile
            );

            if (signUpResult == true) {
                location("?action=main.default");
            } else {
            rc.errorMessage  = "Invalid attempt. Please try again.";
                
            }
        }
    }

    function clearSession() {
        structDelete(session, "contactData", true);
        writeOutput("success");
    }

    function home(struct rc) {
        
        param name="rc.contactId" default="";
        param name="rc.title" default="";
        param name="rc.firstName" default="";
        param name="rc.lastName" default="";
        param name="rc.gender" default="";
        param name="rc.dob" default="";
        param name="rc.img" default="";
        param name="rc.address" default="";
        param name="rc.street" default="";
        param name="rc.pin" default="";
        param name="rc.district" default="";
        param name="rc.state" default="";
        param name="rc.country" default="";
        param name="rc.mail" default="";
        param name="rc.phone" default="";
        param name="rc.multiSel" default="";

        if ( structKeyExists(rc, "title") && structKeyExists(rc, "firstName") && rc.contactId == "") {
            var result = variables.addressBookService.createContact(
                rc.title,
                rc.firstName,
                rc.lastName,
                rc.gender,
                rc.dob,
                rc.img,
                rc.address,
                rc.street,
                rc.pin,
                rc.district,
                rc.state,
                rc.country,
                rc.mail,
                rc.phone,
                rc.multiSel
            );

            /* if (result == "") {
                
            } else { */
                /* location("?action=main.home"); */
                rc.error = result;
                
            /* } */
        } else{
            var result = variables.addressBookService.editContact(
            contactId = rc.contactId,
            title = rc.title,
            firstName = rc.firstName,
            lastName = rc.lastName,
            gender = rc.gender,
            dob = rc.dob,
            img = rc.img ?: "", 
            address = rc.address,
            street = rc.street,
            pin = rc.pin,
            district = rc.district,
            state = rc.state,
            country = rc.country,
            mail = rc.mail,
            phone = rc.phone,
            multiSel = rc.multiSel
            );
            
            rc.error = result;
            /* location("?action=main.home"); */
        }
        rc.contactList = variables.addressBookService.viewContact();
        rc.roles = variables.addressBookService.getRoles(); 
        
        return rc.roles;
    }

    /* function viewContact( struct rc ) {
        rc.contactList = variables.addressBookService.viewContact(rc);
        if (!structKeyExists(rc, "contactList")) {
            rc.contactList = [];
        }
        setView("main.viewContact");
    } */

    /* function viewContact(struct rc) {
        rc.contactList = variables.addressBookService.getActiveContacts();
        if (!structKeyExists(rc, "contactList")) {
            rc.contactList = [];
        }
    } */

    function viewOneContact(struct rc) {
        rc.contactDetails = variables.addressBookService.getOneContactById(rc.contactId);
            variables.fw.renderData( "json", rc.contactDetails );
    }

    function deleteContact( struct rc ) {
        if (structKeyExists(rc, "contactId")) {
            rc.contactDetails = variables.addressBookService.deleteContact(rc.contactId);
            variables.fw.renderData( "json" );
        }
    }

    function logout( struct rc ) {
        rc.logOut = variables.addressBookService.logout();
        variables.fw.renderData( "json", { "status": "loggedOut" } );
    }

    function handleRedirect(){
        var excludePages = ["main.default","main.signup"];
        var requestedPage = structKeyExists(url, "action") ? url.action : "main.default";
       /*  var item = structKeyExists(url, "item") ? url.item : "default";
        var requestedPage = section & "." & item; */

        // Redirect to login if user is not authenticated
        if (!structKeyExists(session, "isAuthenticated") && !arrayContains(excludePages, requestedPage)) {
            if (requestedPage != "main.default") {
                location(url="index.cfm?action=main.default", addtoken=false);
            }
        }
        /* else if (requestedPage != "main.default"){
            location(url="index.cfm?action=main.default", addtoken=false);
        } */
        return true;
    }

}







