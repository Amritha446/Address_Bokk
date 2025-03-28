<html>
    <head>
        <title>Login page</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" >
        <script src="js/bootstrap.bundle.min.js"></script>
        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"  />
        <script src="js/validate1.js"></script>
        <script src="js/google.js"></script>
    </head>
    <body>
        <cfoutput>
            <div class="container-fluid ">
                <div class="header d-flex">
                    <img src="assets/icon.JPG" alt="img" class="icon">
                    <div class="headerText">ADDRESS BOOK</div>
                    <div class="signUp d-flex">
                        <a href="signUp.cfm" class="link d-flex">
                            <i class="fa-solid fa-user mb-1 mt-1" style="color:##fff"></i><div class="text-white ms-2">SignUp</div>
                        </a>
                    </div>
                    <div class="logIn d-flex">
                        <a href="login.cfm" class="link d-flex">
                            <i class="fa-solid fa-right-to-bracket mb-1 mt-1 ms-3" style="color:##fff"></i><div class="text-white ms-2">LogIn</div>
                        </a>
                    </div>
                </div>
                <div class="main d-flex">
                    <div class="leftSection mb-5">
                        <img src="assets/product_Images/contactbook.JPG" alt="img" class="sectionImg">
                    </div>
                    <div class="rightSection mb-5">
                        <h5 class=" heading fs-3 mt-2">LOGIN</h5>
                        <form method="post" class="ms-5" name="form">
                            <div class="input d-flex flex-column">
                               <div class="text-secondary mt-2 ms-4"> Username</div>
                                <input type="text" name="userName" class="inputs">
                                <div class="error text-danger" id="usersError"></div>
                            </div>
                            <div class="input">
                               <div class="text-secondary mt-2 ms-4"> Password </div>
                                <input type="password" name="userPassword1" class="inputs">
                                <div class="error text-danger" id="passError"></div>
                            </div>
                            <button type="submit" name="submit" class="btn mt-5" onClick="return validate1()">LogIn</button>
                            <div class="text text-secondary mt-3">Or SignIn using</div>
                            <div class="images d-flex mt-1">
                                <button type="button" class = "btnNew"><img src="assets/fb.JPG" alt="img" class="img "></button>
                                <button type="button" onClick = "googleData()" class = "btnNew"><img src="assets/google.JPG" alt="img" class="img1 pe-none"></button>
                            </div>
                            <div class="lastSec mt-3 ms-1 ">Dont't have an Account? <a href="signUp.cfm" class="link">SignUp Here!</a></div>
                        </form>
                    </div>
                </div>
            </div>
            <cfif structKeyExists(form,"submit")>
                <cfset loginObj=createObject("component","components.contactDetails")>
                <cfset result=loginObj.validateLogin(userName = form.userName ,
                                                    userPassword1 = form.userPassword1
                                                    )>
                <cfif  result == "true">
                    <cflocation  url="home.cfm">
                <cfelse>
                    <div class="text-danger">Invalid Login attempt.</div>
                </cfif>
            </cfif>
        </cfoutput>
    </body>
</html>