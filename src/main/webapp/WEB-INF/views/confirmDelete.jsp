<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xác nhận xóa</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 50px;
            text-align: center;
        }
        .confirm-box {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            display: inline-block;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        h3 {
            color: #dc3545;
            margin-bottom: 30px;
        }
        .btn {
            padding: 10px 20px;
            border-radius: 5px;
            margin: 0 10px;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-confirm {
            background-color: #dc3545;
            color: white;
            border: none;
        }
        .btn-confirm:hover {
            background-color: #c82333;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            display: inline-block;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

<div class="confirm-box">
    <h3>Bạn có chắc chắn muốn xóa mặt bằng với mã số <strong><%= request.getAttribute("code") %></strong> không?</h3>

    <form action="${pageContext.request.contextPath}/rental" method="post" style="display:inline;">
        <input type="hidden" name="action" value="confirmDelete">
        <input type="hidden" name="code" value="<%= request.getAttribute("code") %>">
        <input type="submit" class="btn btn-confirm" value="Có, xóa">
    </form>

    <a href="${pageContext.request.contextPath}/rental" class="btn btn-cancel">Không</a>
</div>

</body>
</html>
