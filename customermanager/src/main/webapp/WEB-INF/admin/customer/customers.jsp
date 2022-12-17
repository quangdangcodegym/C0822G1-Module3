<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>Basic Tables | Zircos - Responsive Bootstrap 4 Admin Dashboard</title>
        <jsp:include page="/WEB-INF/admin/layout/headcss.jsp"></jsp:include>
        <style>
            .row-search-form{
                justify-content: space-between;
            }
            .search-form{
                display: flex;
            }
        </style>
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
                                    <div class="row row-search-form">
                                        <div><h4 class="header-title">List Customer</h4></div>
                                        <div>
                                            <form method="get" action="/customers" class="search-form">
                                                <input type="text" name="kw" class="mr-1" value="${requestScope.kw}">
                                                <select name="idCountry" id="idCountry" class="form-control" class="mr-1" >
                                                    <option value="-1">All</option>
                                                    <c:forEach items="${applicationScope.countries}" var="country">
                                                        <option value="${country.getId()}" <c:if test="${requestScope.idCountry == country.getId()}"> selected</c:if>>${country.getName()}

                                                            </option>
                                                    </c:forEach>
                                                </select>
                                                <button>Search</button>
                                            </form>
                                        </div>
                                    </div>
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
                                                        <a href="/customers?action=delete&id=${customer.getId()}"><i class="fa fa-remove" ></i></a>
                                                        </td>
                                                </tr>
                                            </c:forEach>

                                            </tbody>
                                        </table>
                                    </div>
                                    <div>
                                        <ul class="pagination pagination-split float-right mb-0">
                                            <c:if test="${currentPage != 1}">
                                                <li class="page-item">
                                                    <a href="/customers?page=${currentPage - 1}&kw=${requestScope.kw}&idCountry=${requestScope.idCountry}" class="page-link"><i class="fa fa-angle-left"></i></a>
                                                </li>
                                            </c:if>
                                            <c:forEach begin="1" end="${noOfPages}" var="i">
                                                <c:choose>
                                                    <c:when test="${currentPage eq i}">
                                                        <li class="page-item active">
                                                            <a href="#" class="page-link">${i}</a>
                                                        </li>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <li class="page-item">
                                                            <a href="/customers?page=${i}&q=${requestScope.kw}&idCountry=${requestScope.idCountry}" class="page-link">${i}</a>
                                                        </li>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                            <c:if test="${currentPage lt noOfPages}">
                                                <li class="page-item">
                                                    <a href="/customers?page=${currentPage + 1}&kw=${requestScope.kw}&idCountry=${requestScope.idCountry}" class="page-link"><i class="fa fa-angle-right"></i></a>
                                                </li>
                                            </c:if>

                                        </ul>
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