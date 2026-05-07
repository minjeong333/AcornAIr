<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<header class="top-menu">
  <div class="top-links">
    <span>로그인/가입</span>
    <span>마이페이지</span>
  </div>

  <nav class="main-nav">
    <div class="logo">
      ✈ <strong>ACORN AIR</strong>
      <span class="nav-badge">S</span>
    </div>

   <ul class="nav-menu">
  <li class="nav-item">
    예약
    <div class="mega-menu">
      <div class="mega-col">
        <p><a href="${pageContext.request.contextPath}/air/search">항공권 예매</a></p>
        <p>예약 조회</p>
      </div>
    </div>
  </li>

  <li class="nav-item">
    부가서비스 신청
    <div class="mega-menu">
      <div class="mega-col">
        <p>좌석 배정</p>
        <p>초과 수하물 사전 구매</p>
      </div>
    </div>
  </li>
</ul>

    <div class="search-area">
      <input type="text" placeholder="궁금한 것을 검색해보세요">
      <button>로그인</button>
    </div>
  </nav>
</header>
