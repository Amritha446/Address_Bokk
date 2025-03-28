function validate1(){
    let userName = document.forms["form"]["userName"].value;
    let userPassword1 = document.forms["form"]["userPassword1"].value;
    let valid = true;

    if(userName == ''){
        document.getElementById('usersError').textContent = 'Please enter your User Name';
        valid = false;
    }
    else{
        document.getElementById('usersError').textContent = '';
    }
    if(userPassword1 == ''){
        document.getElementById('passError').textContent = 'Please enter your Password';
        valid = false;
    }
    else{
        document.getElementById('passError').textContent = '';
    }
    return valid;
}