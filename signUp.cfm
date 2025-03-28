<html>
    <head>
        <title>signUp page</title>
        <script src="js/validate.js"></script>
         <link href="css/bootstrap.min.css" rel="stylesheet" >
        <script src="js/bootstrap.bundle.min.js"></script>
        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"/>
    </head>
    <body>
        <cfoutput>
            <div class="container">
                <div class="header d-flex">
                    <img src="assets/icon.JPG" alt="img" class="icon">
                    <div class="headerText">ADDRESS BOOK</div>
                    <div class="signUp d-flex">
                        <a href="signUp.cfm" class="link d-flex">
                            <i class="fa-solid fa-user mb-1 mt-1" style="color:##fff"></i>
                            <div class="text-white ms-2">SignUp</div>
                        </a>
                    </div>
                    <div class="logIn d-flex">
                        <a href="login.cfm" class="link d-flex">
                            <i class="fa-solid fa-right-to-bracket mb-1 mt-1 ms-3" style="color:##fff"></i>
                            <div class="text-white ms-2">LogIn</div>
                        </a>
                    </div>
                </div>
                <div class="main d-flex">
                    <div class="leftSection mb-5">
                        <img src="assets/contactbook.JPG" alt="img" class="sectionImg">
                    </div>
                    <div class="rightSection mb-5">
                        <p class=" heading fs-3 mt-2 ">SIGN UP</p>
                        <form method="post" class="ms-5" enctype="multipart/form-data" name="form">
                            <div class="input d-flex flex-column">
                               <div class="text-secondary mt-3 ms-2"> Full Name</div>
                                <input type="text" name="fullName" class="inputs" required>
                                <div class="error text-danger" id="fullnameError"></div>
                            </div>
                            <div class="input d-flex flex-column">
                               <div class="text-secondary mt-3 ms-2"> Email Id</div>
                                <input type="text" name="mail" class="inputs">
                                <div class="error text-danger" id="mailError"></div>
                            </div>
                            <div class="input d-flex flex-column">
                               <div class="text-secondary mt-3 ms-2"> Username</div>
                                <input type="text" name="userName" class="inputs">
                                <div class="error text-danger" id="userError"></div>
                            </div>
                            <div class="input">
                               <div class="text-secondary mt-3 ms-2"> Password </div>
                                <input type="password" name="userPassword1" class="inputs">
                                <div class="error text-danger" id="pass1Error"></div>
                            </div>
                            <div class="input d-flex flex-column">
                               <div class="text-secondary mt-3 ms-2"> Confirm Password</div>
                                <input type="password" name="userPassword2" class="inputs">
                                <div class="error text-danger" id="pass2Error"></div>
                            </div>
                            <div class="input d-flex flex-column">
                               <div class="text-secondary mt-3 ms-2"> Choose Profile pic</div>
                                <input type="file" name="profile" class="inputs">
                                <div class="error text-danger" id="img1Error"></div>
                            </div>
                            <button type="submit" name="submit" class="btn mt-3" onClick="return validate()">REGISTER</button>
                            <div class="lastSec mt-3 ms-1">Already have an Account? <a href="login.cfm" class="link">LogIn Here!</a></div>
                        </form>
                    </div>
                </div>
            </div>
            <cfif structKeyExists(form,"submit")>
                <cfset loginObj=createObject("component","components.contactDetails")>
                <cfset result=loginObj.signUp(fullName = form.fullName,
                mail = form.mail,
                userName = form.userName,
                userPassword1 = form.userPassword1,
                userPassword2 = form.userPassword2,
                profile = form.profile)>
                <cfif result == "true">
                    <cflocation url="login.cfm" addToken="no">
                <cfelse>
                    <div class="text-danger">Try with another Username, Username should not contain any spaces.</div>
                </cfif>
            </cfif>
        </cfoutput>    
    </body>
</html>