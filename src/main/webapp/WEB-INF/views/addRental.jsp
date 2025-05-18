<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thêm Mặt Bằng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            padding: 20px;
        }
        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            display: block;
            margin-top: 12px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"],
        select {
            width: 100%;
            padding: 8px;
            margin-top: 4px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }
        .btn-submit {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            background-color: #007BFF;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-submit:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            margin-top: 10px;
            font-weight: bold;
            text-align: center;
        }
        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
        }
    </style>
    <script>
        function validateForm() {
            const codeRegex = /^MB\d{3}$/;
            const code = document.forms["rentalForm"]["code"].value.trim();
            const area = parseFloat(document.forms["rentalForm"]["area"].value);
            const floor = parseInt(document.forms["rentalForm"]["floor"].value);
            const price = parseInt(document.forms["rentalForm"]["price"].value);

            if (!codeRegex.test(code)) {
                alert("Mã mặt bằng sai định dạng,(ví dụ: MB001)");
                return false;
            }
            if (isNaN(area) || area <= 20) {
                alert("Diện tích phải lớn hơn 20m²");
                return false;
            }
            if (isNaN(floor) || floor < 1 || floor > 15) {
                alert("Tầng phải từ 1 đến 15");
                return false;
            }
            if (isNaN(price) || price <= 1000000) {
                alert("Giá tiền phải lớn hơn 1.000.000 VNĐ");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div class="container">
    <h2>Thêm Mặt Bằng</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="error-message"><%= request.getAttribute("error") %></div>
    <% } %>

    <form name="rentalForm" action="/rental" method="post" onsubmit="return validateForm()">
        <label for="code">Mã mặt bằng:</label>
        <input type="text" name="code" id="code" placeholder="Ví dụ: MB001" required>

        <label for="status">Trạng thái:</label>
        <select name="status" id="status">
            <option>Trống</option>
            <option>Hạ tầng</option>
            <option>Đầy đủ</option>
        </select>

        <label for="area">Diện tích (m²):</label>
        <input type="number" name="area" id="area" placeholder="Ví dụ: 45" required>

        <label for="floor">Tầng:</label>
        <input type="number" name="floor" id="floor" placeholder="Từ 1 đến 15" required>

        <label for="type">Loại mặt bằng:</label>
        <select name="type" id="type">
            <option>Văn phòng chia sẻ</option>
            <option>Văn phòng trọn gói</option>
        </select>

        <label for="price">Giá tiền (VNĐ):</label>
        <input type="number" name="price" id="price" placeholder="Ví dụ: 5000000" required>

        <label for="startDate">Ngày bắt đầu (dd/mm/yyyy):</label>
        <input type="text" name="startDate" id="startDate" placeholder="VD: 01/06/2025" required>

        <label for="endDate">Ngày kết thúc (dd/mm/yyyy):</label>
        <input type="text" name="endDate" id="endDate" placeholder="VD: 01/12/2025" required>

        <input type="submit" class="btn-submit" value="Thêm mới">
    </form>

    <a class="back-link" href="/rental">← Quay lại danh sách</a>
</div>
</body>
</html>
