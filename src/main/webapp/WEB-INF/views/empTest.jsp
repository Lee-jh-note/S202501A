<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>발주 조회</title>
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
  <link href="css1/sb-admin-2.min.css" rel="stylesheet">
</head>

<body id="page-top">
<div id="wrapper">
  <%@ include file="menu1.jsp" %>

  <div id="content-wrapper" class="d-flex flex-column">
    <div id="content">
      <%@ include file="header1.jsp" %>

      <div class="container-fluid">
        <h1 class="h3 mb-4 text-gray-800">발주</h1>
            <form action="searchPurchase">

            <!-- 조회 기간 -->
            <label for="startDate">매입일자</label>
            <input type="date" id="startDate" name="startDate" value="${sysdate}"/>

            <label for="endDate">~</label>
            <input type="date" id="endDate" tame="endDate" value="${sysdate}"/>

            <!-- 품목 -->
            <label for="product_name">품목</label>
            <input type="text" id="product_name" name="product_name" placeholder="품목 입력" />

            <!-- 거래처 -->
            <label for="client_name">거래처</label>
            <input type="text" id="client_name" name="client_name" placeholder="거래처 입력" />

            <!-- 담당자 -->
            <label for="emp_name">담당자</label>
            <input type="text" id="emp_name" name="emp_name" class="form-control bg-light border-0 small" placeholder="담당자 입력" aria-label="Search" aria-describedby="basic-addon2">

            <!-- 검색 버튼 -->
            <button class="btn btn-primary" type="button">
                    <i class="fas fa-search fa-sm"></i>
            </button>
        </form>
          <div>
              <select name="dataTable_length" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
                  <option value="10">대기</option>
                  <option value="25">부분입고</option>
                  <option value="50">완료</option>
              </select>
          </div>

          <div>
              <input
                      type="date"
                      data-placeholder="날짜 선택"
                      required
                      aria-required="true"
                      value={startDateValue}
                      className={styles.selectDay}
                      onChange={StartDateValueHandler}
              ></input>
          </div>
          <div>
              <div class="dropdown mb-4">
                  <button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      Dropdown
                  </button>
                  <div class="dropdown-menu animated--fade-in" aria-labelledby="dropdownMenuButton" style="">
                      <a class="dropdown-item" href="#">Action</a>
                      <a class="dropdown-item" href="#">Another action</a>
                      <a class="dropdown-item" href="#">Something else here</a>
                  </div>
              </div>
          </div>

          <div>
              <ul class="pagination">
                  <li class="paginate_button page-item previous disabled" id="dataTable_previous">
                      <a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
                  </li>
                  <li class="paginate_button page-item active">
                      <a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a>
                  </li>
                  <li class="paginate_button page-item ">
                      <a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a>
                  </li>
                  <li class="paginate_button page-item ">
                      <a href="#" aria-controls="dataTable" data-dt-idx="3" tabindex="0" class="page-link">3</a>
                  </li>
                  <li class="paginate_button page-item ">
                      <a href="#" aria-controls="dataTable" data-dt-idx="4" tabindex="0" class="page-link">4</a>
                  </li>
                  <li class="paginate_button page-item ">
                      <a href="#" aria-controls="dataTable" data-dt-idx="5" tabindex="0" class="page-link">5</a>
                  </li>
                  <li class="paginate_button page-item ">
                      <a href="#" aria-controls="dataTable" data-dt-idx="6" tabindex="0" class="page-link">6</a>
                  </li>
                  <li class="paginate_button page-item next" id="dataTable_next">
                      <a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a>
                  </li>
              </ul>


          </div>

          <div>
              <label>
                  Search:<input type="search" class="form-control form-control-sm" placeholder="" aria-controls="dataTable">
              </label>

          </div>

          <!-- Begin Page Content -->
          <div class="container-fluid">

              <!-- Page Heading -->
              <h1 class="h3 mb-2 text-gray-800">Tables</h1>
              <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                  For more information about DataTables, please visit the <a target="_blank"
                                                                             href="https://datatables.net">official DataTables documentation</a>.</p>

              <!-- DataTales Example -->
              <div class="card shadow mb-4">
                  <div class="card-header py-3">
                      <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                  </div>
                  <div class="card-body">
                      <div class="table-responsive">
                          <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                              <thead>
                              <tr>
                                  <th>Name</th>
                                  <th>Position</th>
                                  <th>Office</th>
                                  <th>Age</th>
                                  <th>Start date</th>
                                  <th>Salary</th>
                              </tr>
                              </thead>
                              <tfoot>
                              <tr>
                                  <th>Name</th>
                                  <th>Position</th>
                                  <th>Office</th>
                                  <th>Age</th>
                                  <th>Start date</th>
                                  <th>Salary</th>
                              </tr>
                              </tfoot>
                              <tbody>
                              <tr>
                                  <td>Tiger Nixon</td>
                                  <td>System Architect</td>
                                  <td>Edinburgh</td>
                                  <td>61</td>
                                  <td>2011/04/25</td>
                                  <td>$320,800</td>
                              </tr>
                              <tr>
                                  <td>Doris Wilder</td>
                                  <td>Sales Assistant</td>
                                  <td>Sidney</td>
                                  <td>23</td>
                                  <td>2010/09/20</td>
                                  <td>$85,600</td>
                              </tr>
                              <tr>
                                  <td>Angelica Ramos</td>
                                  <td>Chief Executive Officer (CEO)</td>
                                  <td>London</td>
                                  <td>47</td>
                                  <td>2009/10/09</td>
                                  <td>$1,200,000</td>
                              </tr>
                              <tr>
                                  <td>Gavin Joyce</td>
                                  <td>Developer</td>
                                  <td>Edinburgh</td>
                                  <td>42</td>
                                  <td>2010/12/22</td>
                                  <td>$92,575</td>
                              </tr>

                              </tbody>
                          </table>
                      </div>
                  </div>
              </div>

          </div>
          <!-- /.container-fluid -->

      </div>
        <!-- End of Main Content -->


        </div>
      </div>
    </div>
    <%@ include file="footer1.jsp" %>
  </div>
</div>
<!-- jQuery -->
<script src="vendor/jquery/jquery.min.js"></script>

<!-- Bootstrap Bundle -->
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin -->
<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts -->
<script src="js1/sb-admin-2.min.js"></script>
</body>

</html>
