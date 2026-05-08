<%@page import="예약.ReservationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	z-index: 1000;
	background: white; /* 필수 (안 하면 뒤 비침) */
}

/* 내용이 헤더 밑에 가려지지 않게 */
body {
	padding-top: 120px; /* 헤더 높이만큼 */
}

.container {
	padding: 80px;
	background: linear-gradient(90deg, #bfe8ff, #f5c6de);
}
/* 상단 메뉴 */
.top-menu {
	background: white;
	border-bottom: 1px solid #eee;
}

.top-links {
	height: 40px;
	display: flex;
	justify-content: flex-end;
	align-items: center;
	gap: 30px;
	padding: 0 160px;
	font-size: 14px;
	border-bottom: 1px solid #eee;
}

.top-links span:hover {
	color: #0064de;
	cursor: pointer;
}

.main-nav {
	height: 78px;
	display: flex;
	align-items: center;
	padding: 0 160px;
	gap: 45px;
}

.logo {
	display: flex;
	align-items: center;
	gap: 12px;
	font-size: 22px;
}

.circle {
	background: #e8f1ff;
	color: #0064de;
	font-size: 13px;
	padding: 5px 9px;
	border-radius: 50%;
}

.main-nav ul {
	display: flex;
	gap: 35px;
	list-style: none;
	margin: 0;
	padding: 0;
	font-size: 17px;
}

.main-nav li:hover {
	color: #0064de;
	cursor: pointer;
}

.search-area {
	margin-left: auto;
	display: flex;
	gap: 12px;
}

.search-area input {
	width: 260px;
	height: 38px;
	border: 1px solid #ccd3df;
	border-radius: 20px;
	padding: 0 18px;
}

.search-area button {
	width: 90px;
	height: 40px;
	border: 1px solid #ccd3df;
	border-radius: 20px;
	background: white;
	cursor: pointer;
}

.search-area button:hover {
	background: #0064de;
	color: white;
}

.nav-menu {
	display: flex;
	gap: 35px;
	list-style: none;
	margin: 0;
	padding: 0;
}

.nav-item {
	height: 78px;
	display: flex;
	align-items: center;
	cursor: pointer;
	color: #001b66;
	font-weight: bold;
	position: relative;
}

.nav-item:hover {
	color: #0064de;
}

.nav-item:hover::after {
	content: "";
	position: absolute;
	left: 0;
	bottom: 0;
	width: 100%;
	height: 3px;
	background: #001b66;
}

/* 드롭다운 전체 */
.mega-menu {
	display: none;
	position: absolute;
	top: 78px;
	left: 0;
	width: 260px;
	min-height: 180px;
	background: white;
	border: 1px solid #e5e8ef;
	border-radius: 0 0 14px 14px;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.12);
	z-index: 1000;
	padding: 24px;
	box-sizing: border-box;
}

.nav-item:hover .mega-menu {
	display: block;
}

.mega-col {
	width: 100%;
}

.mega-col p {
	margin: 0 0 22px;
	font-size: 16px;
	color: #001b66;
	cursor: pointer;
}

.mega-col p:hover {
	color: #0064de;
	text-decoration: underline;
}

a {
	text-decoration: none; /* 밑줄 제거 */
	color: inherit; /* 부모 요소의 글자색을 그대로 상속 (검정색 등) */
}

.reservation-wrap {
	max-width: 1100px;
	margin: 80px auto;
	padding: 20px;
}

.reservation-wrap h1 {
	margin-bottom: 30px;
}

.reservation-card {
	background: white;
	border: 1px solid #ddd;
	border-radius: 16px;
	padding: 30px;
}

.reservation-top {
	display: flex;
	justify-content: space-between;
	margin-bottom: 25px;
	font-weight: bold;
}

.status {
	color: #0064de;
}

.info-row {
	display: flex;
	gap: 20px;
	margin-bottom: 25px;
}

.flight-section {
	display: flex;
	gap: 20px;
	margin-bottom: 25px;
}

.flight-box {
	flex: 1;
	border: 1px solid #eee;
	border-radius: 12px;
	padding: 20px;
}

.detail-section {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 20px;
	margin-bottom: 30px;
}

.detail-box {
	border: 1px solid #eee;
	border-radius: 12px;
	padding: 18px 20px;
	background: #fafafa;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.label {
	color: #666;
	font-size: 14px;
}

.value {
	font-weight: bold;
	color: #001b66;
}

.total-price {
	grid-column: 1/3;
	background: #f4f8ff;
	border: 1px solid #cfe0ff;
}

.total-price .value {
	font-size: 20px;
	color: #0064de;
}

.btn-area {
	text-align: right;
}

.cancel-btn {
	background: #ff4d4f;
	color: white;
	border: none;
	padding: 12px 28px;
	border-radius: 8px;
	cursor: pointer;
}
</style>
<body>
	<header class="top-menu">
		<div class="top-links">
			<span>로그인/가입</span> <span>마이페이지</span>
		</div>

		<nav class="main-nav">
			<div class="logo">
				✈ <strong>ACORN AIR</strong> <span class="circle">S</span>
			</div>


			<ul class="nav-menu">
				<li class="nav-item">예약
					<div class="mega-menu">
						<div class="mega-col">
							<p>
								<a href="/prj_2조/res">항공권 예매</a>
							</p>
							<p>예약 조회</p>
						</div>
					</div>
				</li>

				<li class="nav-item">부가서비스 신청
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

	<%
	ArrayList<ReservationDTO> list = (ArrayList<ReservationDTO>) request.getAttribute("reservationList");
	%>
	<div class="reservation-wrap">

		<h1>예약 내역</h1>

		<%
		for (ReservationDTO r : list) {
		%>

		<div class="reservation-card">

			<div class="reservation-top">
				<strong>예약번호 : R<%=r.getBookingId()%></strong> <span
					class="status"> <%="Y".equals(r.getBookStatus()) ? "예약완료" : "예약취소"%>
				</span>
			</div>

			<div class="info-row">
				<strong>이름</strong> <span><%=r.getUserName()%></span>
			</div>

			<div class="flight-section">
				<div class="flight-box">
					<h3>가는편 정보</h3>
					<p><%=r.getGoDep()%>
						→
						<%=r.getGoArr()%></p>
				</div>

				<div class="flight-box">
					<h3>오는편 정보</h3>
					<p><%=r.getBackDep()%>
						→
						<%=r.getBackArr()%></p>
				</div>
			</div>

			<div class="detail-section">

				<div class="detail-box">
					<span class="label">탑승객 수</span> <span class="value">성인 <%=r.getPassengerCount()%>명
					</span>
				</div>

				<div class="detail-box">
					<span class="label">좌석 등급</span> <span class="value"><%=r.getSeatClass()%></span>
				</div>

				<div class="detail-box">
					<span class="label">좌석 번호</span> <span class="value"> <%=r.getSeatNo() != null ? r.getSeatNo() : "-"%>
					</span>
				</div>

				<div class="detail-box">
					<span class="label">추가 수하물</span> <span class="value"> <%=r.getBaggageKg() > 0 ? r.getBaggageKg() + "kg" : "없음"%>
					</span>
				</div>

				<div class="detail-box total-price">
					<span class="label">총 결제 금액</span> <span class="value"> <%=String.format("%,d", r.getTotalPrice())%>원
					</span>
				</div>

			</div>

			<%
			if ("Y".equals(r.getBookStatus())) {
			%>

			<div class="btn-area">
				<form action="${pageContext.request.contextPath}/reservation/cancel"
					method="post">

					<input type="hidden" name="bookingId"
						value="<%=r.getBookingId()%>">

					<button type="submit" class="cancel-btn">예약 취소</button>
				</form>
			</div>

			<%
			}
			%>

		</div>
		<%
		}
		%>
	</div>
</body>
</html>