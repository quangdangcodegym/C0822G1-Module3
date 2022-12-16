<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Basic Tables | Zircos - Responsive Bootstrap 4 Admin Dashboard</title>
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
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">Tables</a></li>
                                            <li class="breadcrumb-item active">Basic Tables</li>
                                        </ol>
                                    </div>
                                    <h4 class="page-title">Basic Tables</h4>
                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row">
                            <div class="col-sm-12">
                                <div class="demo-box p-2">
                                    <h4 class="header-title">List Customer</h4>
                                    <div class="table-responsive">
                                        <table class="table m-0">

                                            <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Fullname</th>
                                                <th>Address</th>
                                                <th>Country</th>
                                                <th>Action</th>
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
                                    </div>
                                </div>
                                <!-- end card-box -->
                            </div>
                            <!-- end col -->
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

        <jsp:include page="/WEB-INF/admin/layout/rightbar.jsp"></jsp:include>

        <jsp:include page="/WEB-INF/admin/layout/footerjs.jsp">
            <jsp:param name="page" value="customer"/>
        </jsp:include>

    </body>

</html>