<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Excel Data</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script> 
</head>
<body>
    <form id="uploadForm" enctype="multipart/form-data">
        <input type="file" id="excelFile" accept=".xlsx,.xls" />
        <button type="button" onclick="uploadData()">Upload</button>
    </form>

    <script>
        function uploadData() {
            const fileInput = document.getElementById('excelFile');
            const file = fileInput.files[0];
            if (!file) {
                alert('Please select a file.');
                return;
            }

            // Read the Excel file using FileReader
            const reader = new FileReader();
            reader.onload = function(e) {
                const data = e.target.result;
                const workbook = XLSX.read(data, { type: 'binary' });

                // Assume we want to read the first sheet
                const sheet = workbook.Sheets[workbook.SheetNames[0]];
                const jsonData = XLSX.utils.sheet_to_json(sheet);

                // Now send the data to ColdFusion for processing
                sendToColdFusion(jsonData);
            };
            reader.readAsBinaryString(file);
        }

        function sendToColdFusion(data) {
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'testing.cfc', true);
            xhr.setRequestHeader('Content-Type', 'application/json');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert('Data uploaded successfully!');
                }
            };
            xhr.send(JSON.stringify(data)); // Send data to ColdFusion as JSON
        }
    </script>
</body>
</html>
