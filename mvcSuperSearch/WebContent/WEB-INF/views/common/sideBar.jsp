<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
    
    
    <!-- Sidebar -->
    <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

      <!-- Sidebar - Brand -->
      <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<c:url value="/main.wn" />">
        <div class="sidebar-brand-icon rotate-n-15">
          <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">Classficator<sup>1.0</sup></div >
      </a>

      <!-- Divider -->
      <hr class="sidebar-divider my-0">

      <!-- Nav Item - Dashboard -->
      <li class="nav-item <%=request.getRequestURI().contains("/dashboard") ? "active" : "" %>" >
        <a class="nav-link" href="<c:url value="/main.wn" />">
          <i class="fas fa-fw fa-tachometer-alt"></i>
          <span>현황판</span></a>
      </li>

      <li class="nav-item <%=request.getRequestURI().contains("/server/server") ? "active" : "" %>" >
        <a class="nav-link" href="<c:url value="/server/serverMove.wn"/>">
          <i class="fas fa-fw fa-wrench"></i>
          <span>서버관리</span>
        </a>
      </li>
      
      <li class="nav-item <%=request.getRequestURI().contains("/act/study") ? "active" : "" %>" >
        <a class="nav-link" href="<c:url value="/study/studyMove.wn"/>">
          <i class="fas fa-fw fa-cog"></i>
          <span>학습관리</span>
        </a>
      </li>
      
      <li class="nav-item <%=request.getRequestURI().contains("/run/run") ? "active" : "" %>" >
        <a class="nav-link" href="<c:url value="/run/runMove.wn"/>">
          <i class="fas fa-fw fa-spinner"></i>
          <span>실행관리</span>
        </a>
      </li>
      
      
      <li class="nav-item <%=request.getRequestURI().contains("/act/act") ? "active" : "" %>" >
        <a class="nav-link" href="<c:url value="/act/actMove.wn"/>">
          <i class="fas fa-fw fa-desktop"></i>
          <span>시뮬레이터</span>
        </a>
      </li>
      
      
<!--       Divider
      <hr class="sidebar-divider">

      Heading
      <div class="sidebar-heading" >
         관리도구
      </div>
 -->
      <!-- Nav Item - Pages Collapse Menu -->
     <%--  <li class="nav-item <%=request.getRequestURI().contains("/server/server") ? "active" : "" %>">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="true" aria-controls="collapseTwo">
          <i class="fas fa-fw fa-cog"></i>
          <span>서버관리</span>
        </a>
        <div id="collapseTwo" class="collapse <%=request.getRequestURI().contains("/server/server") ? "show" : "" %>" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">server manager</h6>
            <a class="collapse-item  <%=request.getRequestURI().contains("/server/server") ? "active" : "" %>" href="<c:url value="/server/serverMove.wn" />">서버 등록/수정</a>
            <!-- <a class="collapse-item active" href="cards.html">Cards</a> -->
          </div>
        </div>
      </li> --%>

      <!-- Nav Item - Utilities Collapse Menu -->
     <%--  <li class="nav-item <%=request.getRequestURI().contains("/act/act") || request.getRequestURI().contains("/act/study") ? "active" : "" %>" >
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities" aria-expanded="true" aria-controls="collapseUtilities">
          <i class="fas fa-fw fa-wrench"></i>
          <span>분류관리</span>
        </a>
        <div id="collapseUtilities" class="collapse <%=request.getRequestURI().contains("/act/act") || request.getRequestURI().contains("/act/study") ? "show" : "" %>" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Classificator manager:</h6>
            <a class="collapse-item <%=request.getRequestURI().contains("/act/act") ? "active" : "" %>" href="<c:url value="/act/actMove.wn" />">시뮬레이터</a>
            <a class="collapse-item <%=request.getRequestURI().contains("/act/study") ? "active" : "" %>" href="<c:url value="/study/studyMove.wn" />">학습데이터</a>
            <a class="collapse-item <%=request.getRequestURI().contains("/act/search") ? "active" : "" %>" href="<c:url value="/result/results.wn" />">분석데이터</a>
            <!-- <a class="collapse-item" href="utilities-border.html">Borders</a>
            <a class="collapse-item" href="utilities-animation.html">Animations</a>
            <a class="collapse-item" href="utilities-other.html">Other</a> -->
          </div>
        </div>
      </li> --%>

      <!-- Nav Item - Utilities Collapse Menu -->
      <%-- <li class="nav-item <%=request.getRequestURI().contains("/run/run") ? "active" : "" %>" >
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseRun" aria-expanded="true" aria-controls="collapseRun">
          <i class="fas fa-fw fa-wrench"></i>
          <span>실행관리</span>
        </a>
        <div id="collapseRun" class="collapse <%=request.getRequestURI().contains("/run/run") ? "show" : "" %>" aria-labelledby="headingRun" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Training manager:</h6>
            <a class="collapse-item <%=request.getRequestURI().contains("/run/run") ? "active" : "" %>" href="<c:url value="/run/runMove.wn" />">분석/학습 실행</a>
            <!-- <a class="collapse-item" href="utilities-border.html">Borders</a>
            <a class="collapse-item" href="utilities-animation.html">Animations</a>
            <a class="collapse-item" href="utilities-other.html">Other</a> -->
          </div>
        </div>
      </li> --%>

      <!-- Divider -->
     <!--  <hr class="sidebar-divider"> -->

      <!-- Heading -->
    <!--   <div class="sidebar-heading">
        Addons
      </div> -->
<!-- 
      Nav Item - Pages Collapse Menu
      <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages" aria-expanded="true" aria-controls="collapsePages">
          <i class="fas fa-fw fa-folder"></i>
          <span>Pages</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
          <div class="bg-white py-2 collapse-inner rounded">
            <h6 class="collapse-header">Login Screens:</h6>
            <a class="collapse-item" href="login.html">Login</a>
            <a class="collapse-item" href="register.html">Register</a>
            <a class="collapse-item" href="forgot-password.html">Forgot Password</a>
            <div class="collapse-divider"></div>
            <h6 class="collapse-header">Other Pages:</h6>
            <a class="collapse-item" href="404.html">404 Page</a>
            <a class="collapse-item" href="blank.html">Blank Page</a>
          </div>
        </div>
      </li>

      Nav Item - Charts
      <li class="nav-item">
        <a class="nav-link" href="charts.html">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>Charts</span></a>
      </li>

      Nav Item - Tables
      <li class="nav-item">
        <a class="nav-link" href="tables.html">
          <i class="fas fa-fw fa-table"></i>
          <span>Tables</span></a>
      </li>
 -->
      <!-- Divider -->
      <hr class="sidebar-divider d-none d-md-block">

      <!-- Sidebar Toggler (Sidebar) -->
      <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
      </div>

    </ul>
    <!-- End of Sidebar -->
