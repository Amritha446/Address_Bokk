component accessors=true {
    this.datasource = "data_base1";
    function authenticateUser(required string userName, required string userPassword1) {
        var result = { authenticated = false, userData = {} };
        var encrypted_pass = hash(arguments.userPassword1, 'SHA-512');

        var qCheck = queryExecute(
            "SELECT 
                CustomerID,
                userName,
                password,
                profile,
                fullName,
                mail 
            FROM 
                users 
            WHERE 
                userName = ? 
                AND password = ?",
                [arguments.userName, encrypted_pass],
                {datasource="data_base1"}
        );

        if (qCheck.recordCount) {
            result.authenticated = true;
            result.userData = {
                userId = qCheck.CustomerID,
                profile = qCheck.profile,
                fullName = qCheck.fullName,
                userMail = qCheck.mail
            };
        }
        return result;
    }

    function signUp(required string fullName, required string mail, required string userName, required string userPassword1, required string userPassword2, required string profile) {
        var encrypted_pass1 = hash(arguments.userPassword1, "SHA-512");
        var encrypted_pass2 = hash(arguments.userPassword2, "SHA-512");
        // Password match validation
        if (encrypted_pass1 NEQ encrypted_pass2) {
            return "Passwords do not match.";
        }

        // Username validation
        if (find(" ", arguments.userName)) {
            return "Username should not contain spaces.";
        }

        // Check if username already exists
        var qCheckUser = queryExecute(
            "SELECT userName FROM users WHERE userName = ?",
            [arguments.userName],
            {datasource=this.datasource}
        );

        if (qCheckUser.recordCount GT 0) {
            return "Username already exists.";
        }

        // Handle file upload (profile picture)
        var uploadedFile = "";
        if (structKeyExists(arguments, "profile") && len(arguments.profile)) {
            
            var uploadPath = expandPath("./assets/");
            var uploadedFile =  fileUpload(uploadPath,"profile","image/*","makeUnique");
                
        }

        // Insert new user into database
        var qInsertUser = queryExecute(
            "INSERT INTO users (fullName, mail, userName, password, profile) VALUES (?, ?, ?, ?, ?)",
            [arguments.fullName, arguments.mail, arguments.userName, encrypted_pass1, uploadedFile.serverFile],
            {datasource=this.datasource}
        );
        return true;
    }

    function createContact(
        required string title,
        required string firstName,
        required string lastName,
        required string gender,
        required string dob,
        required string img,
        required string address,
        required string street,
        required string pin,
        required string district,
        required string state,
        required string country,
        required string mail,
        required string phone,
        required string multiSel
    ) {
        var isActive = 1;
        var contactId = "";

        var checkUser = queryExecute(
            "SELECT mail FROM contact WHERE mail = ?",
            [arguments.mail],
            {datasource = "data_base1"}
        );

        if (checkUser.recordCount EQ 0) {
            if (structKeyExists(arguments, "img") && len(arguments.img)) {
                var uploadPath = expandPath("/assets");
                var fileInfo = fileUpload(uploadPath,"img","image/*","makeUnique");
                var imgPath = fileInfo.serverFile;
            }else{
                imgPath = "draft.JPG";
            }
            var dataAdd = queryExecute(
                "INSERT INTO contact (
                    title, firstName, lastName, gender, dob, img, address, 
                    street, pin, district, state, country, mail, phone, createdBy, IsActive
                ) VALUES (
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
                )",
                [
                    arguments.title, arguments.firstName, arguments.lastName, 
                    arguments.gender, arguments.dob, imgPath, arguments.address, 
                    arguments.street, arguments.pin, arguments.district, 
                    arguments.state, arguments.country, arguments.mail, 
                    arguments.phone, session.userId, isActive
                ],
                {datasource = "data_base1",result = "insertContact"}
            );

            contactId = insertContact.generatedKey;

            var roles = listToArray("101", ",");
            writeDump(roles)
            for (var i = 1; i <= arrayLen(roles); i++) { 
                queryExecute( 
                    "INSERT INTO contact_role (contact_id, role_id) VALUES (?, ?)", 
                    [contactId, val(roles[i])],
                    {datasource = "data_base1"} 
                ); 
            }

            return ""; // Success case (No error message)
        } else {
            return "Email should be unique"; // If email exists, return error message
        }
    }

    function getRoles() {
        var result =  queryExecute("
            SELECT 
                role_id, 
                role_name 
            FROM 
                role 
            ORDER BY 
                role_name",
            [],
            {datasource="data_base1"}
        );
        return result;
    }

    function viewContact(struct rc) {
        var result = queryExecute(
            "SELECT 
                userId, title, firstName, lastName, gender, dob, img, 
                address, street, pin, district, state, country, mail, phone
            FROM contact
            WHERE createdBy = ? AND IsActive = 1",
            [ session.userId ], 
            { datasource = "data_base1" } 
        );
        
        return result;
    }

}







