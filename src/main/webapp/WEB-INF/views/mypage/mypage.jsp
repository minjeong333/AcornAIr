<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page Modal</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mypage/mypage.css">
<script src="${pageContext.request.contextPath}/js/mypage/mypage.js" defer></script>
</head>
<body>
<!-- 메일페이지랑 붙이면 삭제 -->
<button onclick="openMyPage()">마이페이지 열기</button>

<div id="mypage-modal" class="modal-overlay">
    <div class="modal-content">
        <button class="close-modal" onclick="closeMyPage()">✕</button>

        <div class="mypage-wrapper">
            <div class="user-info-section">
                <h1>ACORN</h1>
                <div class="logo-card">
                    <div class="skypass-text">ACORNAIR ✈️</div>
                </div>
            </div>

            <div class="mypage-flex-container">
                <div class="flex-col">
                    <div class="card bg-blue">
                        <div class="row"><span>회원명</span><strong> ACORN </strong></div>
                        <div class="row"><span>회원번호</span><strong>1128 2838 1764</strong></div>
                    </div>
                    <div class="card res-card">
                        <div class="res-icon">✈️ 예약내역</div>
                        <p>예약여정</p>
                        <span>출발일-도착일</span>
                    </div>
                </div>

                <div class="flex-col">
                    <div class="card">
                        <div class="row"><span>회원등급</span><strong>일반</strong></div>
                        <div class="row"><span>마일리지</span><strong>10,000</strong></div>
                    </div>
                    <div class="card">
                        <div class="row"><span>이메일</span><strong>abc@acorn.com</strong></div>
                        <div class="row"><span>비밀번호</span><strong>****</strong></div>
                        <div class="row"><span>비밀번호변경</span><strong>&gt;</strong></div>
                    </div>
                </div>
            </div>
            
            <div class="modal-footer-links">
                <a href="#">회원정보 수정</a>
                <a href="#">로그아웃</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>