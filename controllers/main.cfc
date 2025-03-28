component accessors=true {
    property addressBookService; // Injecting the model layer
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

    function createContact( struct rc ) { 
        
    }

    function home(struct rc) {
        rc.roles = variables.addressBookService.getRoles(); 
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

        // If form is submitted with contact information
        if ( structKeyExists(rc, "title") && structKeyExists(rc, "firstName") ) {
            // Call the model layer to add the contact
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

            if (result == "") {
                
            } else {
                rc.error = result;
                
            }
        }/*  else {
            setView("main.home");
        } */
        /* if (rc.roles.recordCount EQ 0) {
            rc.roles = queryNew("role_id, role_name", "integer,varchar");
        } */
    }

    function viewContact( struct rc ) {
        rc.contactList = variables.addressBookService.viewContact(rc);
        if (!structKeyExists(rc, "contactList")) {
            rc.contactList = [];
        }
        setView("main.viewContact");
    }
}







