<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 12/12/2022
  Time: 8:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.6.15/dist/sweetalert2.all.min.js"></script>
</head>
<body>
<div class="container">
    <h1>Customer manager</h1>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Fullname</th>
            <th scope="col">Address</th>
            <th scope="col">Country</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${requestScope.customers}" var="customer">
            <tr>
                <th scope="row">${customer.getId()}</th>
                <td>${customer.getName()}</td>
                <td>${customer.getAddress()}</td>

                <c:forEach items="${applicationScope.countries}" var="country">
                    <c:if test="${country.getId() == customer.getIdCountry()}">
                        <td>${country.getName()}</td>
                    </c:if>
                </c:forEach>
                <td><a href="/customers?action=create"><i class="fa fa-add"></i></a>
                    <a href="/customers?action=edit&id=${customer.getId()}"><i class="fa fa-edit"></i> </a>
                    <i class="fa fa-remove" onclick="handleDeleteClick(this)" id="${customer.getId()}"></i></td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
    <script>
        function handleDeleteClick(e) {
            console.log(e);
            let id = e.id;
            let url = "http://localhost:8080/customers?action=delete&id=" + id;
            console.log(id);
            Swal.fire({
                title: 'Are you sure?',
                text: "Do you want to delete ",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
                if (result.isConfirmed) {
                    //window.location.href = url;
                    window.location.replace(url);
                }
            })
        }
    </script>
</div>
</body>
</html>
