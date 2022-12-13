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
  <h1>Create customer</h1>
  <form  method="post">
    <c:if test="${requestScope.message != null}">
<%--      <h1 style="display: none" class="alert">${requestScope.message}</h1>--%>
      <script>
        let message = '<%= request.getAttribute("message")%>'
        window.onload = function (){
          Swal.fire({
            position: 'top-center',
            icon: 'success',
            title: message,
            showConfirmButton: false,
            timer: 1500
          })
        }
      </script>
    </c:if>
    <label for="idName">Name: </label>
    <input type="text" id="idName" name="name" class="form-control">

    <label for="idAdress">Address: </label>
    <input type="text" id="idAdress" name="address" class="form-control">

    <label for="idCountry">Country: </label>
    <input type="text" id="idCountry" name="country" class="form-control">

    <button >Create</button>
  </form>

</div>
</body>
</html>
