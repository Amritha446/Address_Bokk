component {
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
        if (encrypted_pass1 NEQ encrypted_pass2) {
            return "Passwords do not match.";
        }

        if (find(" ", arguments.userName)) {
            return "Username should not contain spaces.";
        }

        var qCheckUser = queryExecute(
            "SELECT 
                userName 
            FROM 
                users 
            WHERE 
                userName = ?",
            [arguments.userName],
            {datasource=this.datasource}
        );

        if (qCheckUser.recordCount GT 0) {
            return "Username already exists.";
        }

        var uploadedFile = "";
        if (structKeyExists(arguments, "profile") && len(arguments.profile)) {
            
            var uploadPath = expandPath("./assets/");
            var uploadedFile =  fileUpload(uploadPath,"profile","image/*","makeUnique");
                
        }

        var qInsertUser = queryExecute(
            "INSERT INTO users (fullName, mail, userName, password, profile) VALUES (?, ?, ?, ?, ?)",
            [arguments.fullName, arguments.mail, arguments.userName, encrypted_pass1, uploadedFile.serverFile],
            {datasource=this.datasource}
        );
        return true;
    }

    /* function getActiveContacts() {
        var contacts = entityLoad("Contact", { IsActive = 1 });
        return contacts;
    } */

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
            "SELECT 
                mail 
            FROM 
                contact 
            WHERE 
                mail = ?",
            [arguments.mail],
            {datasource = "data_base1"}
        );

        if (checkUser.recordCount EQ 0) {
            if (structKeyExists(arguments, "img") && len(arguments.img)) {
                var uploadPath = expandPath("/assets/product_Images");
                var fileInfo = fileUpload(uploadPath,"img","image/*","makeUnique");
                var imgPath = fileInfo.serverFile;
            }else{
                imgPath = "draft.JPG";
            }
            var dataAdd = queryExecute(
                "INSERT INTO 
                    contact (
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
                ) VALUES (
                    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
                )",
                [
                    arguments.title,
                    arguments.firstName, 
                    arguments.lastName, 
                    arguments.gender, 
                    arguments.dob, 
                    imgPath, 
                    arguments.address, 
                    arguments.street, 
                    arguments.pin, 
                    arguments.district, 
                    arguments.state, 
                    arguments.country, 
                    arguments.mail, 
                    arguments.phone, 
                    session.userId, 
                    isActive
                ],
                {datasource = "data_base1",result = "insertContact"}//result = generated key
            );

            contactId = insertContact.generatedKey;

            var roles = listToArray(arguments.multiSel, ",");
            
            for (var i = 1; i <= arrayLen(roles); i++) { 
                queryExecute( 
                    "INSERT INTO 
                        contact_role (
                            contact_id, 
                            role_id) 
                    VALUES 
                        (?, ?)", 
                    [contactId,roles[i]],
                    {datasource = "data_base1"} 
                ); 
            }
            return {
                contactId = contactId,
                roles = roles
            }; 
        } else {
            return "Email should be unique"; 
        }
    }

    function getRoles() {
        var result =  queryExecute("
            SELECT 
                role_id, 
                role_name 
            FROM 
                role_select
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
            FROM 
                contact
            WHERE 
                createdBy = ? 
                AND IsActive = 1",
            [ session.userId ], 
            { datasource = "data_base1" } 
        );
        
        return result;
    }


    public function editContact(
        required numeric contactId,
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
        ) 
        {
            var imgPath = "";
            var checkUser = queryExecute(
                "SELECT 
                    userId 
                FROM 
                    contact 
                WHERE 
                    mail = ? 
                    AND userId != ?",
                [arguments.mail, arguments.contactId],
                {datasource = "data_base1"}
            );

            if (checkUser.recordCount EQ 0) {
                if (structKeyExists(arguments, "img") && arguments.img != "") {
                    var uploadPath = expandPath("/assets/product_Images/");
                    var fileInfo = fileUpload(uploadPath,"img","image/*","makeUnique");
                    var imgPath = fileInfo.serverFile;
                }else{
                    var currentImg = queryExecute(
                        "SELECT 
                            img 
                        FROM 
                            contact 
                        WHERE 
                            userId = ?",
                        [arguments.contactId],
                        {datasource = "data_base1"}
                    );
                    imgPath = (currentImg.recordCount ? currentImg.img : "draft.JPG");
                }

                queryExecute(
                    "UPDATE contact SET 
                        title = ?, 
                        firstName = ?, 
                        lastName = ?, 
                        gender = ?, 
                        dob = ?, 
                        img = ?, 
                        address = ?, 
                        street = ?, 
                        pin = ?, 
                        district = ?, 
                        state = ?, 
                        country = ?, 
                        mail = ?, 
                        phone = ?, 
                        updatedBy = ?
                    WHERE userId = ?",
                    [
                        arguments.title,
                        arguments.firstName,
                        arguments.lastName,
                        arguments.gender,
                        arguments.dob,
                        imgPath,
                        arguments.address,
                        arguments.street,
                        arguments.pin,
                        arguments.district,
                        arguments.state,
                        arguments.country,
                        arguments.mail,
                        arguments.phone,
                        session.userId,
                        arguments.contactId
                    ],
                    {datasource = "data_base1"}
                );

                queryExecute(
                    "DELETE FROM 
                        contact_role 
                    WHERE 
                        contact_id = ?",
                    [arguments.contactId],
                    {datasource = "data_base1"}
                );

                var roles = listToArray(arguments.multiSel, ",");
                for (var i = 1; i <= arrayLen(roles); i++) {
                    queryExecute(
                        "INSERT INTO 
                            contact_role (
                                contact_id, 
                                role_id) 
                        VALUES 
                            (?, ?)",
                        [arguments.contactId, val(roles[i])],
                        {datasource = "data_base1"}
                    );
                }
                return "";
            } else {
                return "Email should be unique";
            }
        }


    public query function getOneContactById(required string contactId) {
        var result = queryExecute(
            "SELECT 
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
                STRING_AGG(rs.role_id,',') AS ROLESID
            FROM contact c 
                LEFT JOIN contact_role cr ON c.userId = cr.contact_id
                LEFT JOIN role_select rs ON rs.role_id = cr.role_id
            WHERE
                c.userId = ? 
                AND c.IsActive = 1
            GROUP BY 
                c.userId, c.title, c.firstName, c.lastName, c.gender, 
                c.dob, c.img, c.address, c.street, c.pin, c.district, 
                c.state, c.country, c.mail, c.phone", 
            [contactId],
            {datasource = "data_base1"}
        );

        return result; 
    }

    public void function deleteContact( required numeric contactId ) {
        var dateJoined = now();

        var deleteUpdation = queryExecute(
            "UPDATE 
                contact
            SET 
                IsActive = 0,
                deletedBy = ?,
                deletedOn = ?
            WHERE 
                userId = ?",
            [session.userId, dateJoined, contactId],
            { datasource = "data_base1" }
        );
    }

    function logout() {
        structClear(session);
        
    }
}










