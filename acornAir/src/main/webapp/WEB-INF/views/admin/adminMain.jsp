<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="acornAir.login.dto.UserDTO"%>

<%
UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");

if (loginUser == null || !"ADMIN".equals(loginUser.getUserRole())) {
	response.sendRedirect(request.getContextPath() + "/home");
	return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 대시보드</title>

<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background-color: #f5f6fa;
}

.header {
	background-color: #1f2a44;
	color: white;
	padding: 20px 40px;
}

.header h1 {
	margin: 0;
	font-size: 24px;
}

.header p {
	margin: 8px 0 0;
	font-size: 14px;
}

.container {
	width: 900px;
	margin: 40px auto;
}

.menu-box {
	display: flex;
	gap: 20px;
}

.card {
	flex: 1;
	background-color: white;
	border-radius: 12px;
	padding: 30px;
	text-align: center;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.card h2 {
	margin-top: 0;
	font-size: 20px;
	color: #222;
}

.card p {
	color: #666;
	font-size: 14px;
}

.card a {
	display: inline-block;
	margin-top: 15px;
	padding: 10px 20px;
	background-color: #1f2a44;
	color: white;
	text-decoration: none;
	border-radius: 6px;
}

.card a:hover {
	background-color: #35466d;
}

.logout {
	margin-top: 30px;
	text-align: right;
}

.logout a {
	color: #1f2a44;
	text-decoration: none;
	font-weight: bold;
}
</style>
</head>

<body>

	<div class="header">
		<h1>관리자 대시보드</h1>
		<p><%=loginUser.getKorLastName()%><%=loginUser.getKorFirstName()%>
			관리자님 환영합니다.
		</p>
	</div>

	<div class="container">

		<div class="menu-box">

			<div class="card">
				<h2>회원 관리</h2>
				<p>회원 목록을 조회하고 관리합니다.</p>
				<a href="<%=request.getContextPath()%>/admin/users">이동</a>
			</div>

			<div class="card">
				<h2>항공편 관리</h2>
				<p>항공편 등록, 수정, 삭제를 관리합니다.</p>
				<a href="<%=request.getContextPath()%>/admin/flights">이동</a>
			</div>

			<div class="card">
				<h2>예약 관리</h2>
				<p>전체 예약 내역을 확인합니다.</p>
				<a href="<%=request.getContextPath()%>/admin/bookings">이동</a>
			</div>

		</div>

		<div class="logout">
			<a href="<%=request.getContextPath()%>/air/logout">로그아웃</a>
		</div>

	</div>

</body>
</html>