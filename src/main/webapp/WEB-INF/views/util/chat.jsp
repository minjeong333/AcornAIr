<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/util/chat.css">
<script src="${pageContext.request.contextPath}/js/chat.js" defer></script>
</head>
<body>
<div class="chat-popup">	
  <!--  헤더 -->
	<div class="chat-header">
    <div class="header-left">
    	<button class="icon-btn" onclick="toggleMenu()">☰</button>
    </div>
	    <!-- 햄버거메뉴 슬라이드 -->
		<div id="menu-overlay" class="menu-overlay" onclick="toggleMenu()"></div>
			<div id="side-menu" class="side-menu">
		  		<div class="side-menu-header">
		    	<div class="header-brand">✈️ ACORNAIR CHATBOT</div>
		    	<button class="back-btn" onclick="toggleMenu()">
		      		<span class="arrow-icon">←</span>
		    	</button>
		  		</div>
		  	<div class="side-menu-content">
		    	<button class="new-chat-btn">
		      		<span class="edit-icon">📝</span> 새 채팅
		    	</button>
		  	</div>
			<div class="side-menu-footer">
		    	<p>* 대화 내역은 개인 정보를 보호하고, 서비스의 품질을 유지하기 위해<br>
		     	일정 기간 동안 보관 후 자동 삭제됩니다.</p>
		  	</div>
		  	</div>
	    <div class="header-right">
	      <button class="login-btn">로그인</button>
	      <button class="icon-btn">✕</button>
	    </div>
  	</div>
 <!--  메인시작 -->
  <div class="chat-content">
    <div class="ai-logo">
      <div class="symbol">S</div>
    </div>
    <h2 class="ai-title">ACORNAIR 챗봇과<br> 당신의 여정을 함께하세요.</h2>
    <div class="guide-grid">
	  <div class="grid-item">
	    <span class="icon">📝</span>
	    <span class="text">회원가입안내</span>
	  </div>
	    <div class="grid-item">
	    <span class="icon">✈️</span>
	    <span class="text">항공권 구매</span>
	  </div>
	  <div class="grid-item">
	    <span class="icon">📅</span>
	    <span class="text">예약조회</span>
	  </div>
	  <div class="grid-item">
	    <span class="icon">🛫</span>
	    <span class="text">수하물규정</span>
	  </div>
	</div>
  </div>
<!--  푸터시작 -->
  <div class="chat-footer">
    <div class="input-box">
      <textarea placeholder="궁금한 사항을 입력해 주세요."></textarea>
      <div class="input-info">
        <span class="char-count">0/200</span>
        <button class="send-btn">↑</button>
      </div>
    </div>
    <p class="disclaimer">AI는 실수를 할 수 있습니다. 중요한 정보는 다시한번 확인하세요.</p>
  </div>
</div>
</body>
</html>