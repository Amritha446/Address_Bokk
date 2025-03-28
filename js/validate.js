function validate(){
    let fullName = document.forms["form"]["fullName"].value;
    let mail = document.forms["form"]["mail"].value;
    let userName = document.forms["form"]["userName"].value;
    let userPassword1 = document.forms["form"]["userPassword1"].value;
    let userPassword2 = document.forms["form"]["userPassword2"].value;
    let profile = document.forms["form"]["profile"].value;
    let valid = true;

    if(fullName == ''){
        document.getElementById('fullnameError').textContent = 'Please enter your Full Name';
        valid = false;
    }
    else{
        document.getElementById('fullnameError').textContent = '';
    }
    if(mail == '' || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(mail)){
        document.getElementById('mailError').textContent = 'Please enter your EmailId';
        valid = false;
    }
    else{
        document.getElementById('mailError').textContent = '';
    }
    if(userName == ''){
        document.getElementById('userError').textContent = 'Please enter your User Name';
        valid = false;
    }
    else{
        document.getElementById('userError').textContent = '';
    }
    if(userPassword1 == ''){
        document.getElementById('pass1Error').textContent = 'Please enter your Password';
        valid = false;
    }
    else{
        document.getElementById('pass1Error').textContent = '';
    }
    if(userPassword2 == ''){
        document.getElementById('pass2Error').textContent = 'Re-Enter password';
        valid = false;
    }
    else{
        document.getElementById('pass2Error').textContent = '';
    }
    if(profile == ''){
        document.getElementById('img1Error').textContent = 'Please upload your image';
        valid = false;
    }
    else{
        document.getElementById('img1Error').textContent = '';
    }
    return valid;
}