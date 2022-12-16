<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Form Elements | Zircos - Responsive Bootstrap 4 Admin Dashboard</title>
        <jsp:include page="/WEB-INF/admin/layout/headcss.jsp"></jsp:include>

    </head>

    <body data-layout="horizontal">

        <!-- Begin page -->
        <div id="wrapper">

            <!-- Navigation Bar-->
            <jsp:include page="/WEB-INF/admin/layout/topnav.jsp"></jsp:include>
                <!-- End Navigation Bar-->

            <!-- ============================================================== -->
            <!-- Start Page Content here -->
            <!-- ============================================================== -->

            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box">
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Zircos</a></li>
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Forms</a></li>
                                            <li class="breadcrumb-item active">Form elements</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">Form elements</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            <div class="col-sm-12">
                                <form class="form-horizontal" method="post">
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
                                    <c:if test="${requestScope.errors!=null}">
                                        <div class="alert alert-danger" role="alert">
                                            <ul>
                                                <c:forEach items="${requestScope.errors}" var="error">
                                                    <li>${error}</li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </c:if>
                                    <div class="form-group row">
                                        <label class="col-md-2 control-label">Fullname</label>
                                        <div class="col-md-10">
                                            <input type="text" class="form-control" name = "name" value="${requestScope.customer.getName()}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-2 control-label" for="example-email">Address</label>
                                        <div class="col-md-10">
                                            <input type="email" id="example-email" name="address" class="form-control" value="${requestScope.customer.getAddress()}">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-2 control-label">Country</label>
                                        <div class="col-md-10">
                                            <select name="idCountry" id="idCountry" class="form-control" >
                                                <c:forEach items="${applicationScope.countries}" var="country">
                                                    <option value="${country.getId()}">${country.getName()}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <div class="col-md-10 offset-2">
                                            <button >Create</button>
                                        </div>
                                    </div>

                                </form>
                            </div>
                        </div>
                        <!-- end row -->

                    </div>
                    <!-- end container-fluid -->

                </div>
                <!-- end content -->

                

                <!-- Footer Start -->
                <jsp:include page="/WEB-INF/admin/layout/footer.jsp"></jsp:include>
                <!-- end Footer -->

            </div>

            <!-- ============================================================== -->
            <!-- End Page content -->
            <!-- ============================================================== -->

        </div>
        <!-- END wrapper -->

        <!-- Right Sidebar -->
        <jsp:include page="/WEB-INF/admin/layout/rightbar.jsp"></jsp:include>

        <jsp:include page="/WEB-INF/admin/layout/footerjs.jsp">
            <jsp:param name="page" value="create"/>
        </jsp:include>

    </body>

</html>