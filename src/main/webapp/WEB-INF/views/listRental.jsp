<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Rental" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Mặt Bằng</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            max-width: 800px;
            margin: 20px auto;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
        }
        form select, form input[type="number"] {
            padding: 5px;
            margin: 5px;
        }
        .btn-search {
            padding: 6px 12px;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-search:hover {
            background-color: #0056b3;
        }
        .btn-add {
            display: block;
            width: fit-content;
            margin: 0 auto 20px;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn-add:hover {
            background-color: #218838;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            margin-bottom: 30px;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #007BFF;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .btn-delete {
            color: red;
            text-decoration: none;
            font-weight: bold;
        }
        .btn-delete:hover {
            text-decoration: underline;
        }
        .no-data {
            text-align: center;
            color: #888;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>Danh Sách Mặt Bằng</h2>

<form method="get" action="${pageContext.request.contextPath}/rental">
    <label>Loại mặt bằng:
        <select name="type">
            <option value="">--Chọn--</option>
            <option>Văn phòng chia sẻ</option>
            <option>Văn phòng trọn gói</option>
        </select>
    </label>
    <label>Tầng:
        <input type="number" name="floor">
    </label>
    <label>Giá &le;
        <input type="number" name="price">
    </label>
    <input type="submit" class="btn-search" value="Tìm kiếm">
</form>

<a class="btn-add" href="${pageContext.request.contextPath}/rental?action=add">Thêm mới</a>

<%
    List<Rental> list = (List<Rental>) request.getAttribute("rentals");
    if (list == null || list.isEmpty()) {
%>
<p class="no-data">Không có mặt bằng nào được tìm thấy.</p>
<%
} else {
%>
<table>
    <tr>
        <th>Mã</th>
        <th>Trạng thái</th>
        <th>Diện tích (m²)</th>
        <th>Tầng</th>
        <th>Loại</th>
        <th>Giá (VNĐ)</th>
        <th>Bắt đầu</th>
        <th>Kết thúc</th>
        <th>Hành động</th>
    </tr>
    <%
        for (Rental r : list) {
    %>
    <tr>
        <td><%= r.getCode() %></td>
        <td><%= r.getStatus() %></td>
        <td><%= r.getArea() %></td>
        <td><%= r.getFloor() %></td>
        <td><%= r.getType() %></td>
        <td><%= r.getPrice() %></td>
        <td><%= r.getStartDate() %></td>
        <td><%= r.getEndDate() %></td>
        <td>
            <a class="btn-delete" onclick="return confirm('Bạn có chắc chắn muốn xóa mặt bằng này không?')"
               href="${pageContext.request.contextPath}/rental?action=delete&code=<%= r.getCode() %>">
                Xóa
            </a>
        </td>
    </tr>
    <% } %>
</table>
<% } %>

</body>
</html>
