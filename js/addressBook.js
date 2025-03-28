function createContact() {
    document.getElementById('heading').textContent = "CREATE CONTACT";
    document.getElementById('createData').reset();
    $('.error').text("");
    $('#editContact').modal('show');

    // Clear session data using FW/1 controller action
    $.ajax({
        type: "POST",
        url: "index.cfm?controllers=main&action=clearSession"
    });
}

/* $(document).ready(function () {
    $.ajax({
        url: "index.cfm?action=main.getRoles",
        type: "GET",
        dataType: "json",
        success: function (data) {
            var select = $("#multiSel");
            select.empty();
            $.each(data, function (index, role) {
                select.append($("<option>", {
                    value: role.role_id,
                    text: role.role_name
                }));
            });
        },
        error: function () {
            console.error("Failed to load roles.");
        }
    });
}); */

