function createContact() {
    $('#editContact').modal('show');
    document.getElementById('heading').textContent = "CREATE CONTACT";
    document.getElementById('createData').reset();
    $('.error').text("");

    $.ajax({
        type: "POST",
        url: "index.cfm?controllers=main&action=clearSession"
    });
}

function editOne(event){
    document.getElementById('heading').textContent = "EDIT CONTACT";
    $('.error').text("");
    $.ajax({
        
        type:"POST",
        url:"./index.cfm?action=main.viewOneContact",
        data:{contactId:event.target.value},
        success:function(formattedResult){
            console.log(formattedResult)
            
            let title = formattedResult.DATA[0][0];
            let firstName = formattedResult.DATA[0][1];
            let lastName = formattedResult.DATA[0][2];
            let gender = formattedResult.DATA[0][3];
            let dob = formattedResult.DATA[0][4];
            let address = formattedResult.DATA[0][5];
            let street = formattedResult.DATA[0][6];
            let pin = formattedResult.DATA[0][7];
            let district = formattedResult.DATA[0][8];
            let state = formattedResult.DATA[0][9];
            let country = formattedResult.DATA[0][10];
            let mail = formattedResult.DATA[0][11];
            let phone = formattedResult.DATA[0][12];
            let img = formattedResult.DATA[0][13];
            if(event.target.id == 'editb'){
                document.getElementById('title').value = title;
                document.getElementById('firstName').value = firstName;
                document.getElementById('lastName').value = lastName;
                document.getElementById('gender1').value = gender;
                document.getElementById('dob1').value = dob;
                document.getElementById('address1').value = address;
                document.getElementById('street1').value = street;
                document.getElementById('district1').value = district;
                document.getElementById('state1').value = state;
                document.getElementById('country1').value = country;
                document.getElementById('pin').value = pin;
                document.getElementById('mail').value = mail;
                document.getElementById('phone1').value = phone;
                document.getElementById('img2').src = "assets/product_Images/"+img;
                document.getElementById('contactId').value = event.target.value; 
                console.log(formattedResult.DATA[0][16])
                let roleIds = formattedResult.DATA[0][16].split(",");
                $('#multiSel').val(roleIds)
            }else{
                document.getElementById('name').textContent = title +firstName + " " + lastName;
                document.getElementById('gender').textContent = gender;
                document.getElementById('dob').textContent = dob;
                document.getElementById('address').textContent = address + ","+street+ "," + district + "," +state+ "," +country;
                document.getElementById('pincode').textContent = pin;
                document.getElementById('email').textContent = mail;
                document.getElementById('phone').textContent = phone;
                document.getElementById('img1').src = "assets/product_Images/"+img;
                let roleNames = formattedResult.DATA[0][15];
                $('#roles').text(roleNames);
            }
        }
    })
}

function deletePage(event){
    if(confirm("Confirm delete?")){
        $.ajax({
            type:"POST",
            url:"./index.cfm?action=main.deleteContact",
            data:{contactId:event.target.value},
            success: function (result) {
                alert("Contact deleted successfully.");
                event.target.parentNode.remove();
            }
        })
    }
    else{
        event.preventDefault()
    }
}

function logoutUser(){
    if(confirm("Confirm Logout?")){
        $.ajax({
            type:"POST",
            url:"./index.cfm?action=main.logout",
            success:function(){
                window.location.href = "./index.cfm?action=main.default"; 
            }
        })
    }
}
