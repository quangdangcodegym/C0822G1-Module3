<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>


<script src="assets\js\vendor.min.js"></script>

<c:if test="${param.page == 'index'}">
    <script src="assets\libs\morris-js\morris.min.js"></script>
    <script src="assets\libs\raphael\raphael.min.js"></script>

    <script src="assets\js\pages\dashboard.init.js"></script>
</c:if>

<!-- App js -->
<script src="assets\js\app.min.js"></script>
