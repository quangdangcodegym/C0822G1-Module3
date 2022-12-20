<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>


<script src="/admin/assets\js\vendor.min.js"></script>

<c:if test="${param.page == 'index'}">
    <script src="/admin/assets\libs\morris-js\morris.min.js"></script>
    <script src="/admin/assets\libs\raphael\raphael.min.js"></script>

    <script src="/admin/assets\js\pages\dashboard.init.js"></script>
</c:if>

<!-- App js -->
<script src="/admin/assets\js\app.min.js"></script>
