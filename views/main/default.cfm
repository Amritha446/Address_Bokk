<cfoutput>
    <div class="container-fluid">
        <div class="header d-flex">
            <img src="assets/product_Images/icon.JPG" alt="img" class="icon">
            <div class="headerText">ADDRESS BOOK</div>
            <div class="signUp d-flex">
                <a href="#buildURL('main.signup')#" class="link d-flex">
                    <i class="fa-solid fa-user mb-1 mt-1" style="color:##fff"></i>
                    <div class="text-white ms-2">SignUp</div>
                </a>
            </div>
        </div>

        <div class="main d-flex">
            <div class="leftSection mb-5">
                <img src="assets/product_Images/contactbook.JPG" alt="img" class="sectionImg">
            </div>

            <div class="rightSection mb-5">
                <h5 class="heading fs-3 mt-2">LOGIN</h5>
                <form action="#buildURL('main.default')#" method="post">
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
                        <button type="button" class="btnNew">
                            <img src="assets/product_Images/fb.JPG" alt="img" class="img ">
                        </button>
                        <button type="button" onClick="googleData()" class="btnNew">
                            <img src="assets/product_Images/google.JPG" alt="img" class="img1 pe-none">
                        </button>
                    </div>

                    <div class="lastSec mt-3 ms-1">Don't have an Account? 
                        <a href="#buildURL('main.signup')#" class="link">SignUp Here!</a>
                    </div>

                    <cfif structKeyExists(rc, "error") AND structKeyExists(rc, "submit")>
                        <div class="alert alert-danger">#rc.error#</div>
                    </cfif>

                </form>
            </div>
        </div>
    </div>
</cfoutput>
