<%@page import="acornAir.login.dto.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/util/common.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/util/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage/mypage.css?v=2">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/chat/chat.css">
<script>var contextPath = '${pageContext.request.contextPath}';</script>
<script src="${pageContext.request.contextPath}/js/chat/chat.js" defer></script>
<%
UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
%>
<header class="top-menu">
  <div class="top-links">
    <% if (loginUser == null) { %>
      <a href="${pageContext.request.contextPath}/air/login">로그인/가입</a>
    <% } else { %>
      <a href="#"><%= loginUser.getKorFirstName() %>님</a>
      <a href="${pageContext.request.contextPath}/air/logout">로그아웃</a>
    <% } %>
    <a href="javascript:void(0);" onclick="loadMyPage()">마이페이지</a>
  </div>

  <nav class="main-nav">
    <a href="${pageContext.request.contextPath}/home" class="logo">
      ✈ <strong>ACORN AIR</strong>
      <span class="circle">S</span>
    </a>
    <ul class="nav-menu">
      <li class="nav-item">
        예약
        <div class="mega-menu">
          <div class="mega-col">
            <p><a href="${pageContext.request.contextPath}/res">항공권 예매</a></p>
            <p><a href="${pageContext.request.contextPath}/reservation/list">예약 조회</a></p>
          </div>
        </div>
      </li>
    </ul>
  </nav>
</header>

<div id="mypage-container"></div>

<jsp:include page="/WEB-INF/views/chat/chat.jsp" />

<script>
function loadMyPage() {
    fetch('${pageContext.request.contextPath}/air/mypage')
        .then(function(res) { return res.text(); })
        .then(function(data) {
            if (data.includes("LOGIN_REQUIRED")) {
                location.href = '${pageContext.request.contextPath}/air/login';
                return;
            }
            document.getElementById('mypage-container').innerHTML = data;
            var modal = document.getElementById('mypage-modal');
            if (modal) {
                modal.classList.add('open');
                document.body.style.overflow = 'hidden';
            }
        })
        .catch(function(err) { console.log("마이페이지 오류:", err); });
}

function closeMyPage() {
    var modal = document.getElementById('mypage-modal');
    if (modal) {
        modal.classList.remove('open');
        document.body.style.overflow = '';
        document.getElementById('mypage-container').innerHTML = '';
    }
}
</script>
