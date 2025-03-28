<html>
    <head>
        <title>home page</title>
        <script src="js/validation.js"></script>
        <link href="css/bootstrap.min.css" rel="stylesheet" >
        <script src="js/bootstrap.bundle.min.js"></script>
        <link href="css/style.css" rel="stylesheet">
        <script src="js/jquery.min.js"></script>
        <script src="js/ajax.js"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.1/css/all.min.css"/>  
    </head>
    <body>
        <cfoutput>
            <div class="container" id="container">
                <div class="header d-flex">
                    <img src="assets/icon.JPG" alt="img" class="icon">
                    <div class="headerText">ADDRESS BOOK</div>
                    <button type="button" class="btn1" onClick="logoutUser()">
                        <div class="signUp d-flex">
                            <i class="fa-solid fa-right-from-bracket mb-1 mt-1" style="color:##fff"></i><div class="text-white ms-2">SignOut</div>
                        </div>
                    </button>
                </div>
                <!--- <div class="topSection mt-4 d-flex mb-4">
                    <form method="post">
                        <button type="submit" class="btn2 mb-1" name = "createPDF"><img src="assets/pdf.JPG" class="hImg" alt="img"></button>
                    </form>
                    <button type="button" class="btn3" onClick="excelCreate('allContacts')" id = "excelCreate"><img src="assets/xml.JPG" class="hImg" alt="img"></button>
                    <button type="button" class="btn3" onClick="window.print();return false;">
                        <img src="assets/draft.JPG" class="hImg" alt="img">
                    </button>
                </div> --->
                <div class="d-flex secondSection">
                    <div class="leftSide mb-2 d-flex flex-column">
                        <cfif structKeyExists(session,"googleAccnt")>
                            <img src="#session.profile#" class="userImg mt-3 ms-4 ps-2">
                        <cfelse>
                            <img src="assets/#session.profile#" class="userImg mt-3 ms-3 ps-2">
                        </cfif>
                        <div class="userText ms-5 mt-2 ps-0">#session.fullName#</div>
                        <button type="button" class="btn4 ms-3 mt-2" id="createb" onClick="createContact()">CREATE</button>
                        <!--- <button type = "submit" id = "schlr" class="btn4 ms-3 mt-2" onClick = "scheduler()">Scheduler</button>
                        <button type="button" class="btn4 ms-3 mt-2" id="upldExcelFile" data-bs-toggle="modal" data-bs-target="##upldExcel">UPLOAD</button> --->
                    </div>

                    <div class="rightSide ms-5 mb-1 d-flex flex-column">
                        <div class="headCreate d-flex mt-3">
                            <p class="textCreate">Name</p>
                            <p class="textCreate1">Email Id</p>
                            <p class="textCreate2">Phone Number</p>
                        </div>
                        <hr class="horizontalLine">
                        <!---<cfset local.objCreate=createObject("component", "components.contactDetails")>
                        <cfset local.result1=local.objCreate.viewContact()>--->
                        <cfset ormReload()>
                        <cfset result1 = entityLoad("orm",{createdBy="#session.userId#",IsActive = 1})>
                        <cfloop array = "#result1#" item = "ormRow">
                            <div class="d-flex">
                                <img src="assets/#ormRow.getimg()#" class="dataImg mt-1 mb-1">
                                <div class="dataText ms-3">#ormRow.getfirstName()# #ormRow.getlastName()#</div>
                                <div class="dataText ms-3 me-5">#ormRow.getmail()#</div>
                                <div class="dataText ms-5">#ormRow.getphone()#</div>
                                <button type="submit" class="btn5 ms-4 mt-2" data-bs-toggle="modal" data-bs-target="##editContact" 
                                id="editb" value="#ormRow.getuserId()#" onClick="editOne(event)">Edit</button>
                                <button type="submit" class="btn5 ms-4 mt-2" id="deleteb" value="#ormRow.getuserId()#" 
                                onClick="deletePage(event)">DELETE</button>
                                <button type="submit" class="btn5 ms-4 mt-2" data-bs-toggle="modal" data-bs-target="##viewContact" 
                                id="viewb" value="#ormRow.getuserId()#" onClick="editOne(event)">VIEW</button>
                                <hr class="horizontalLine">
                            </div>
                            
                        </cfloop>
                        
                        <div class="modal fade" id="editContact" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-body d-flex">
                                        <div class="mainSection ms-3">
                                            <form method="post" name="form" enctype="multipart/form-data" id="createData">
                                                <input type="hidden" value="" name = "contactId" id = "contactId">
                                                <div class="headEdit mt-1 ">
                                                    <div class="headEditText" id="heading"></div>
                                                </div>
                                                <div class="textHead1">
                                                    PERSONAL CONTACT
                                                </div><hr class="horizontalLine1 mt-1">                                                
                                                <div class="d-flex ">
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead">Title</div>
                                                        <select name="title" class="editBtn ms-3 mt-1" id="title">
                                                            <option></option>
                                                            <option>Mr.</option>
                                                            <option>Miss.</option>
                                                        </select>
                                                        <div class="error text-danger" id="titleError"></div>
                                                    </div>
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead">FIRST NAME</div>
                                                        <input type="text" name="firstName" class="editBtn2 ms-3" id="firstName">
                                                        <div class="error text-danger" id="firstnError"></div>
                                                    </div>
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead">LAST NAME</div>
                                                        <input type="text" name="lastName" class="editBtn2 ms-3" id="lastName">
                                                        <div class="error text-danger" id="lastnError"></div>
                                                    </div>
                                                </div>
                                                <div class="d-flex">
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead">GENDER</div>
                                                        <select class="editBtn2 me-5 ms-3" name="gender" id="gender1">
                                                            <option></option>
                                                            <option>Male</option>
                                                            <option>Female</option>
                                                            <option>Others</option>
                                                        </select>
                                                        <div class="error text-danger" id="genderError"></div>
                                                    </div>
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead">DOB</div>
                                                        <input type="date" name="dob" class="editBtn2 ms-3" id="dob1" 
                                                        max="#dateformat(now(),"yyyy-mm-dd")#" max-length="8">   
                                                        <div class="error text-danger" id="dobError"></div>
                                                    </div>
                                                </div>
                                                <div class="d-flex ">
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead">UPLOAD PHOTO</div>
                                                        <input type="file" class="editBtn1 ms-3 " name="img" id="img1">
                                                        <div class="error text-danger" id="imgError"></div>
                                                    </div>
                                                </div>
                                                
                                                <div class="textHead1">
                                                    CONTACT DEAILS
                                                </div>
                                                <hr class="horizontalLine1 mt-1">
                                                <div class="d-flex ">
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead ">ADDRESS</div>
                                                        <input type="textarea" name="address" class="editBtn2 ms-3" id="address1">
                                                        <div class="error text-danger" id="addressError"></div>
                                                    </div>
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead ms-5">STREET</div>
                                                        <input type="text" name="street" class="editBtn2 ms-5" id="street1">
                                                        <div class="error text-danger" id="streetError"></div>
                                                    </div>
                                                </div>
                                                <div class="d-flex ">
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead ">PINCODE</div>
                                                        <input type="text" name="pin" class="editBtn2 ms-3" id="pin">
                                                        <div class="error text-danger" id="pinError"></div>
                                                    </div>
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead ms-5">DISTRICT</div>
                                                        <input type="text" name="district" class="editBtn2 ms-5" id="district1">
                                                        <div class="error text-danger" id="districtError"></div>
                                                    </div>
                                                </div>
                                                <div class="d-flex ">
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead ">STATE</div>
                                                        <input type="text" name="state" class="editBtn2 ms-3" id="state1">
                                                        <div class="error text-danger" id="stateError"></div>
                                                    </div>
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead ms-5">COUNTRY</div>
                                                        <input type="text" name="country" class="editBtn2 ms-5" id="country1">
                                                        <div class="error text-danger" id="countryError"></div>
                                                    </div>
                                                </div>
                                                <div class="d-flex ">
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead ">EMAIL</div>
                                                        <input type="mail" name="mail" class="editBtn2 ms-3" id="mail">
                                                        <div class="error text-danger" id="mailError"></div>
                                                    </div>
                                                    <div class="d-flex flex-column">
                                                        <div class="textHead ms-5">PHONE NUMBER</div>
                                                        <input type="text" name="phone" class="editBtn2 ms-5" id="phone1">
                                                        <div class="error text-danger" id="phoneError"></div>
                                                    </div>
                                                </div>

                                                <div class="d-flex flex-column" id = "multiSelect">
                                                    <cfset result = createObject("component","components.contactDetails")>
                                                    <cfset multiSelect = result.multiSelection()>
                                                    <div class="textHead ">ROLE</div>
                                                    <select id="multiSel" name="multiSel" data-live-search = "true" multiple = "true" class="ms-3" multiple aria-label = "Default select example">
                                                        <cfloop query = #multiSelect#>
                                                            <option value = "#multiSelect.role_id#" id = "multiSelected">#multiSelect.role_name#</option>
                                                        </cfloop>
                                                    </select>
                                                    <div class="error text-danger" id="multiError"></div>
                                                </div>

                                                <div id="errorcontact"></div>
                                                <button type="submit" value="submit" class="btn mt-3 mb-5 ms-5" name="submit" onClick="return validation()">SUBMIT</button>
                                                <button type="button" class="btn btn-secondary ms-5" data-bs-dismiss="modal">Close</button>
                                            </form>
                                        </div>  
                                        <div class="newUser"><img src="assets/newUser.JPG" alt="img" class="newUser" id="img2"></div>
                                    </div>                                        
                                </div>
                            </div>
                        </div>
                        
                        <cfif structKeyExists(form,"submit") AND form.contactId == "">
                            <cfset editObj=createObject("component","components.contactDetails")>
                            <cfset resultContact=editObj.createContact(title = form.title,
                                                                    firstName = form.firstName,
                                                                    lastName = form.lastName,
                                                                    gender = form.gender,
                                                                    dob = form.dob,
                                                                    img = form.img,
                                                                    address = form.address,
                                                                    street = form.street,
                                                                    pin = form.pin,
                                                                    district = form.district,
                                                                    state = form.state,
                                                                    country = form.country,
                                                                    mail = form.mail,
                                                                    phone = form.phone,
                                                                    multiSel = form.multiSel
                                                                    )>
                            <cflocation  url="home.cfm">
                        </cfif>
                        <cfif structKeyExists(form,"submit") AND form.contactId != "">
                            <cfset editObj=createObject("component","components.contactDetails")>
                            <cfset resultEdit=editObj.editContact(title = form.title,
                                                                firstName = form.firstName,
                                                                lastName = form.lastName,
                                                                gender = form.gender,
                                                                dob = form.dob,
                                                                img = form.img,
                                                                address = form.address,
                                                                street = form.street,
                                                                pin = form.pin,
                                                                district = form.district,
                                                                state = form.state,
                                                                country = form.country,
                                                                mail = form.mail,
                                                                phone = form.phone,
                                                                userId = form.contactId,
                                                                contactId = form.contactId,
                                                                multiSel = form.multiSel
                                                                )>
                            <cflocation  url="home.cfm">
                        </cfif>
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
                                            <cfif structKeyExists(form, "submit")>
                                                <cfset viewObj = createObject("component","components.contactDetails")>
                                                <cfset result2 = viewObj.getOneContactById()><!--- getOneContact --->
                                            </cfif>
                                        </div>
                                        <div class="newUser"><img src="assets/newUser.JPG" alt="img" class="newUser" id="img1"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="upldExcel" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modalContent ms-3 d-flex flex-column">
                                        <form method = "post" name = "form" enctype='multipart/form-data'>
                                            <div class = "d-flex excelBtn ">
                                                <button type="button" class="exclBtn1 text-light" name="withData" onClick="excelCreate('')">Template With Data</button>
                                                <button type="button" class="exclBtn2 ms-2 text-light" name="plainData" id = "plainData" onClick = "plainExcel()">Plain Template</button>
                                            </div>
                                            <h5 class="btnexcl">Upload Excel File</h5>
                                            <hr class="horizontalLineExcl">
                                            <div class="textHead">Upload Excel*</div>
                                            <input type = "file" name = "exclFile" id = "exclFile" class = "ms-4 exclFile" required>
                                            <div class="d-flex exclSubmit">
                                                <button type="submit" class="submitBtnExcl fw-bold">SUBMIT</button>
                                                <button type="submit" name="closeBtnExcl" class="closeBtnExcl" data-bs-dismiss="modal">CLOSE</button>
                                            </div>
                                        </form>

                                        <cfif structKeyExists(form, "exclFile")>
                                            <cfset excelRead = createObject("component","components.contactDetails")>
                                            <cfset objExcel = excelRead.processExcelFile()>
                                            <cflocation  url="home.cfm">
                                        </cfif>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <cfif structKeyExists(form, "createPDF")>
                <cfset objPdf = createObject("component", "components.contactDetails")>
                <cfset result = objPdf.viewContact()>
                <cfset roleArray = arrayNew(1)>
                <cfloop query = "result">
                    <cfset role_query = objPdf.getOneContactById(result.userId)><!--- getRolesById --->
                    <cfset roleString = "">
                    <cfloop query="role_query">
                        <cfset roleString = roleString & " " & role_query.ROLES>
                    </cfloop>
                    <cfset arrayAppend(roleArray, roleString)>
                </cfloop>
                <cfset queryAddColumn(result, "roles", roleArray)>
                <cfdocument  format="PDF" overwrite="yes" filename = "./assets/createdPdf.pdf" >
                    <table border = "1">
                        <thead>
                            <tr>
                                <th>TITLE</th>
                                <th>FIRST NAME</th>
                                <th>SECOND NAME</th>
                                <th>GENDER</th>
                                <th>DOB</th>
                                <th>IMAGE NAME</th>
                                <th>ADDRESS</th>
                                <th>STREET</th>
                                <th>PIN</th>
                                <th>DISTRICT</th>
                                <th>STATE</th>
                                <th>COUNTRY</th>
                                <th>EMAIL</th>
                                <th>PHONE</th>
                                <th>ROLE</th>
                            </tr>
                        </thead>
                        <tbody>
                            <cfloop query = "#result#">
                                <tr>
                                    <td>#result.title#</td>
                                    <td>#result.firstName#</td>
                                    <td>#result.lastName#</td>
                                    <td>#result.gender#</td>
                                    <td>#result.dob#</td>
                                    <td><img src="assets/#result.img#" alt="img"></td>
                                    <td>#result.address#</td>
                                    <td>#result.street#</td>
                                    <td>#result.pin#</td>
                                    <td>#result.district#</td>
                                    <td>#result.state#</td>
                                    <td>#result.country#</td>
                                    <td>#result.mail#</td>
                                    <td>#result.phone#</td> 
                                    <td>#result.roles#</td>
                                </tr>
                            </cfloop>
                        </tbody>
                    <table>  
                </cfdocument>
            </cfif>
        </cfoutput>   
    </body>
</html>