function validation(){
    // alert(document.getElementById('multiSel').value);
    let title = document.forms["form"]["title"].value;
    let firstname = document.forms["form"]["firstName"].value;
    let lastname = document.forms["form"]["lastName"].value;
    let gender = document.forms["form"]["gender"].value;
    let dob = document.forms["form"]["dob"].value;
    let img = document.forms["form"]["img"].value;
    let address = document.forms["form"]["address"].value;
    let street = document.forms["form"]["street"].value;
    let pin = document.forms["form"]["pin"].value;
    let district = document.forms["form"]["district"].value;
    let state = document.forms["form"]["state"].value;
    let country = document.forms["form"]["country"].value;
    let mail = document.forms["form"]["mail"].value;
    let phone = document.forms["form"]["phone"].value;
    let multi = document.forms["form"]["multiSel"].value;
    let valid = true;

    if(title == ''){
        document.getElementById('titleError').textContent = 'Please select one option';
        valid = false;
    }
    else{
        document.getElementById('titleError').textContent = '';
    }
    if(firstname == '' || !/^[a-zA-Z ]+$/.test(firstname)){
        document.getElementById('firstnError').textContent = 'Please enter your First name';
        valid = false;
    }
    else{
        document.getElementById('firstnError').textContent = '';
    }
    if(lastname == '' || !/^[a-zA-Z ]+$/.test(lastname)){
        document.getElementById('lastnError').textContent = 'Please enter your Last name';
        valid = false;
    }
    else{
        document.getElementById('lastnError').textContent = '';
    }
    if(gender == ''){
        document.getElementById('genderError').textContent = 'Please select one option';
        valid = false;
    }
    else{
        document.getElementById('genderError').textContent = '';
    }
    if(dob == ''){
        document.getElementById('dobError').textContent = 'Please select your DOB';
        valid = false;
    }
    else{
        document.getElementById('dobError').textContent = '';
    }
    if(img == ''){
        document.getElementById('imgError').textContent = 'Please select image file for profile pic';
        valid = false;
    }
    else{
        document.getElementById('imgError').textContent = '';
    }
    if(address == ''){
        document.getElementById('addressError').textContent = 'Please enter your address';
        valid = false;
    }
    else{
        document.getElementById('addressError').textContent = '';
    }
    if(street == ''){
        document.getElementById('streetError').textContent = 'Please enter your street';
        valid = false;
    }
    else{
        document.getElementById('streetError').textContent = '';
    }
    if(pin == ''){
        document.getElementById('pinError').textContent = 'Please enter your pin';
        valid = false;
    }
    else{
        document.getElementById('pinError').textContent = '';
    }
    if(district == ''){
        document.getElementById('districtError').textContent = 'Please enter your district';
        valid = false;
    }
    else{
        document.getElementById('districtError').textContent = '';
    }
    if(state == ''){
        document.getElementById('stateError').textContent = 'Please enter your state';
        valid = false;
    }
    else{
        document.getElementById('stateError').textContent = '';
    }
    if(country == ''){
        document.getElementById('countryError').textContent = 'Please enter your country';
        valid = false;
    }
    else{
        document.getElementById('countryError').textContent = '';
    }
    if(mail == '' || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(mail)){
        document.getElementById('mailError').textContent = 'Please enter your mail';
        valid = false;
    }
    else{
        document.getElementById('mailError').textContent = '';
    }
    if(phone == '' || !/^\d{10}$/.test(phone)){
        document.getElementById('phoneError').textContent = 'Please enter your contact number';
        valid = false;
    }
    else{
        document.getElementById('phoneError').textContent = '';
    }
    if(multi == ''){
        document.getElementById('multiError').textContent = 'Please select';
        valid = false;
    }
    else{
        document.getElementById('multiError').textContent = '';
    }
    return valid;
}