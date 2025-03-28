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

        <div class="leftSide mb-2 d-flex flex-column">
            <img src="assets/product_Images/#session.profile#" class="userImg mt-3 ms-3 ps-2">
            <div class="userText ms-5 mt-2 ps-0">#session.fullName#</div>
            <!-- Button to trigger the modal -->
            <button type="button" class="btn4 ms-3 mt-2" id="createb" data-bs-toggle="modal" data-bs-target="##createContact" onClick="createContact()">CREATE</button>
        </div>

        <div class="rightSide ms-5 mb-1 d-flex flex-column">
            <div class="headCreate d-flex mt-3">
                <p class="textCreate">Name</p>
                <p class="textCreate1">Email Id</p>
                <p class="textCreate2">Phone Number</p>
            </div>
            <hr class="horizontalLine">
            
            <!--- <div class="contact-list">
                <cfloop query="#rc.contactList#">
                    <div class="d-flex">
                        <img src="assets/#img#" class="dataImg mt-1 mb-1">
                        <div class="dataText ms-3">#firstName# #lastName#</div>
                        <div class="dataText ms-3 me-5">#mail#</div>
                        <div class="dataText ms-5">#phone#</div>
                        <button type="submit" class="btn5 ms-4 mt-2" id="editb" value="#userId#" onClick="editOne(event)">Edit</button>
                        <button type="submit" class="btn5 ms-4 mt-2" id="deleteb" value="#userId#" onClick="deletePage(event)">DELETE</button>
                        <button type="submit" class="btn5 ms-4 mt-2" id="viewb" value="#userId#" onClick="editOne(event)">VIEW</button>
                    </div>
                    <hr class="horizontalLine">
                </cfloop>
            </div> --->
                <!-- Modal for creating a new contact -->
            <div class="modal fade" id="createContact" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <!--- <div class="modal-header">
                            <h5 class="modal-title" id="createContactModalLabel">Create Contact</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div> --->
                        <div class="modal-body">
                            <!-- Form to create contact -->
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
                                    <select class="form-control" name="gender" id="gender" required>
                                        <option value="Male">Male</option>
                                        <option value="Female">Female</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="dob">Date of Birth</label>
                                    <input type="date" class="form-control" name="dob" id="dob" required>
                                </div>
                                <div class="form-group">
                                    <label for="img">Image</label>
                                    <input type="file" class="form-control" name="img" id="img">
                                </div>
                                <div class="form-group">
                                    <label for="address">Address</label>
                                    <input type="text" class="form-control" name="address" id="address" required>
                                </div>
                                <div class="form-group">
                                    <label for="street">Street</label>
                                    <input type="text" class="form-control" name="street" id="street" required>
                                </div>
                                <div class="form-group">
                                    <label for="pin">PIN</label>
                                    <input type="text" class="form-control" name="pin" id="pin" required>
                                </div>
                                <div class="form-group">
                                    <label for="district">District</label>
                                    <input type="text" class="form-control" name="district" id="district" required>
                                </div>
                                <div class="form-group">
                                    <label for="state">State</label>
                                    <input type="text" class="form-control" name="state" id="state" required>
                                </div>
                                <div class="form-group">
                                    <label for="country">Country</label>
                                    <input type="text" class="form-control" name="country" id="country" required>
                                </div>
                                <div class="form-group">
                                    <label for="mail">Email</label>
                                    <input type="email" class="form-control" name="mail" id="mail" required>
                                </div>
                                <div class="form-group">
                                    <label for="phone">Phone</label>
                                    <input type="text" class="form-control" name="phone" id="phone" required>
                                </div>
                                <div class="form-group">
                                    <label for="multiSel">Roles</label>
                                    <select id="multiSel" name="multiSel" multiple="true" class="ms-3">
                                    <cfif structKeyExists(rc, "roles") AND rc.roles.recordCount GT 0>
                                        <cfloop query="#rc.roles#">
                                            <option value="#rc.roles.role_id#">#rc.roles.role_name#</option>
                                        </cfloop>
                                    <cfelse>
                                        <option value="101">admin</option>
                                    </cfif>
                                </select>
                                </div>
                                <button type="submit" class="btn btn-primary">Submit</button>
                                
                            </form>
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</cfoutput>