<cfoutput>
    <div class="container" id="container">
        <div class="header d-flex">
            <img src="assets/product_Images/icon.JPG" alt="img" class="icon">
            <div class="headerText">ADDRESS BOOK</div>
            <button type="button" class="btn1" onClick="logoutUser()">
                <div class="signUp d-flex">
                    <i class="fa-solid fa-right-from-bracket mb-1 mt-1" style="color:##fff"></i><div class="text-white ms-2">SignOut</div>
                </div>
            </button>
        </div>

        <cfif structKeyExists(variables, "errorMessage")>
            <div class="alert alert-danger">
                #variables.errorMessage#
            </div> 
        </cfif>
        <div class="d-flex">
            <div class="leftSide mb-2 d-flex flex-column mt-5">
                <img src="assets/product_Images/#session.profile#" class="userImg mt-3 ms-3 ps-2">
                <div class="userText ms-5 mt-2 ps-0">#session.fullName#</div>
                <button type="button" class="btn4 ms-3 mt-2" id="createb" onClick="createContact()">CREATE</button>
            </div>

            <div class="rightSide ms-5 mb-1 d-flex flex-column mt-5">
                <div class="headCreate d-flex mt-3">
                    <p class="textCreate">Name</p>
                    <p class="textCreate1">Email Id</p>
                    <p class="textCreate2">Phone Number</p>
                </div>
                <hr class="horizontalLine">

                <div class="contact-list ">
                    <cfloop query="#rc.contactList#">
                        <div class="d-flex">
                            <img src="assets/product_Images/#rc.contactList.img#" class="dataImg mt-1 mb-1">
                            <div class="dataText ms-3">#rc.contactList.firstName# #rc.contactList.lastName#</div>
                            <div class="dataText ms-3 me-5">#rc.contactList.mail#</div>
                            <div class="dataText ms-5">#rc.contactList.phone#</div>
                            <button type="submit" class="btn5 ms-4 mt-2" id="editb" value="#rc.contactList.userId#" onClick="editOne(event)" data-bs-toggle="modal" data-bs-target="##editContact">Edit</button>
                            <button type="submit" class="btn5 ms-4 mt-2" id="deleteb" value="#rc.contactList.userId#" onClick="deletePage(event)">DELETE</button>
                            <button type="submit" class="btn5 ms-4 mt-2" id="viewb" value="#rc.contactList.userId#" onClick="editOne(event)" data-bs-toggle="modal" data-bs-target="##viewContact">VIEW</button>
                        </div>
                        <hr class="horizontalLine">
                    </cfloop>
                </div> 

                <div class="modal fade" id="editContact" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">  
                            <div class="modal-body">
                                <form method="post" enctype="multipart/form-data" action="#buildURL('main.home')#">

                                    <input type="hidden" value="" name = "contactId" id = "contactId">
                                    <div class="headEdit mt-1 ">
                                        <div class="headEditText" id="heading"></div>
                                    </div>
                                    <div class="form-group">
                                        <label for="title">Title</label>
                                        <input type="text" class="form-control" name="title" id="title" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="firstName">First Name</label>
                                        <input type="text" class="form-control" name="firstName" id="firstName" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="lastName">Last Name</label>
                                        <input type="text" class="form-control" name="lastName" id="lastName" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="gender">Gender</label>
                                        <select class="form-control" name="gender" id="gender1" required>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="dob">Date of Birth</label>
                                        <input type="date" class="form-control" name="dob" id="dob1" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="img">Image</label>
                                        <input type="file" class="form-control" name="img" id="img2">
                                    </div>
                                    <div class="form-group">
                                        <label for="address">Address</label>
                                        <input type="text" class="form-control" name="address" id="address1" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="street">Street</label>
                                        <input type="text" class="form-control" name="street" id="street1" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="pin">PIN</label>
                                        <input type="text" class="form-control" name="pin" id="pin" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="district">District</label>
                                        <input type="text" class="form-control" name="district" id="district1" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="state">State</label>
                                        <input type="text" class="form-control" name="state" id="state1" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="country">Country</label>
                                        <input type="text" class="form-control" name="country" id="country1" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="mail">Email</label>
                                        <input type="email" class="form-control" name="mail" id="mail" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Phone</label>
                                        <input type="text" class="form-control" name="phone" id="phone1" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="multiSel">Roles</label>
                                        <select id="multiSel" name="multiSel" multiple="true" class="ms-3">
                                            <cfif structKeyExists(rc, "roles") AND rc.roles.recordCount GT 0>
                                                <cfloop query="#rc.roles#">
                                                    <option value="#rc.roles.role_id#">#rc.roles.role_name#</option>
                                                </cfloop>
                                            <cfelse>
                                                <option value="301">User</option>
                                            </cfif>
                                        </select>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Submit</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="modal fade" id="viewContact" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-body d-flex">
                                <div class="mainSection ms-3">
                                    <form method="post" name="form">
                                        <div class="headEdit mt-1 ">
                                            <div class="headEditText" >CONTACT DETAILS</div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="textHead">NAME  :   </div>                                            
                                            <div class = "data" id="name"></div>                                                       
                                        </div>
                                        <div class="d-flex">
                                            <div class="textHead">GENDER  :</div>
                                            <div class = "data" id="gender"></div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="textHead">DOB  :</div>
                                            <div class = "data" id="dob"></div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="textHead">ADDRESS  :</div>
                                            <div class = "data" id="address"></div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="textHead">PINCODE  :</div>
                                            <div class = "data" id="pincode"></div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="textHead">EMAIL  :</div>
                                            <div class = "data" id="email"></div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="textHead">PHONE  :</div>
                                            <div class = "data" id="phone"></div>
                                        </div>
                                        <div class="d-flex">
                                            <div class="textHead">ROLES  :</div>
                                            <div class = "data" id="roles"></div>
                                        </div>
                                        <button type="submit" name="closeBtn" class="closeBtn" >CLOSE</button>
                                    </form>
                                    <!--- <cfif structKeyExists(form, "submit")>
                                        <cfset viewObj = createObject("component","components.contactDetails")>
                                        <cfset result2 = viewObj.getOneContactById()><!--- getOneContact --->
                                    </cfif> --->
                                </div>
                                <div class="newUser"><img src="assets/newUser.JPG" alt="img" class="newUser" id="img1"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</cfoutput>