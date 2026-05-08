<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--<!DOCTYPE html>
<html>
<head>
<title>My Page Modal</title>-->

<meta charset="UTF-8">

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage/mypage.css">
<script src="${pageContext.request.contextPath}/js/mypage/mypage.js" defer></script>

<!--</head>
<body>-->
<!-- 확인용<button onclick="openMyPage()">마이페이지 열기</button>-->

<div id="mypage-modal" class="modal-overlay">
    <div class="modal-content">
        <button class="close-modal" onclick="closeMyPage()">✕</button>
        <div class="mypage-wrapper">
            <div class="user-info-section">
                <h1><div class="row"><strong>${user.korLastName}${user.korFirstName}</strong></div></h1>
                <div class="logo-card">
                    <div class="skypass-text">ACORNAIR ✈️</div>
                </div>
            </div>

            <div class="mypage-flex-container">
                <div class="flex-col">
                    <div class="card bg-blue">
                        <div class="row"><span>회원ID</span><strong>${user.userId}</strong></div>
                        <!-- 국문 성 + 이름 결합 -->
                        <div class="row"><span>회원명</span><strong>${user.korLastName}${user.korFirstName}</strong></div>
                    </div>
                    <div class="card res-card">
                        <div class="res-icon">✈️ 예약내역</div>
                        <p><a href="${pageContext.request.contextPath}/reservation/list">예약조회 및 취소</a></p>
                        <!-- <a href="#">예약조회 및 취소</a></p> -->    
                    </div>
                </div>

                <div class="flex-col">
                    <div class="card">
                       	<div class="mem-info">회원정보</div>
                       	<!-- 영문 성 + 이름 결합-->                       	
                        <div class="row"><span>영문명</span><strong>${user.engLastName} ${user.engFirstName}</strong></div>
                        <div class="row"><span>이메일</span><strong>${user.userEmail}</strong></div>
                    </div>
                    <div class="card">
	                    <!-- 연락처: 국가코드와 번호 결합 -->
                        <div class="row"><span>전화번호</span><strong>(+${user.phoneCountry}) ${user.userPhone}</strong></div>
                        <!-- 생년월일이나 국가 정보 등 추가 활용 가능 -->
                        <div class="row"><span>생년월일</span><strong>${user.birthDate}</strong></div>                        
                    </div>
                </div>
            </div>
            
            <div class="modal-footer-links">
                <a href="${pageContext.request.contextPath}/air/logout" onclick="return confirm('로그아웃 하시겠습니까?');">로그아웃</a>
            </div>
        </div>
    </div>
</div>

<!-- </body>
</html>  -->
