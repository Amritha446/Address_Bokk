component extends="framework.one" {
    
    this.name = "addressbook";
    this.sessionManagement = true;
    this.sessionTimeout = createTimespan(0, 2, 0, 0);
    this.datasource = "data_base1";
    this.ormEnabled = true;

    function onApplicationStart() {
        application.addressBook = new model.services.addressBook(); 
        return true;
    }

    function onSessionStart() {
        session.isAuthenticated = false;
    }

    function setupRequest(){
        controller("main.handleRedirect");
    }
}
