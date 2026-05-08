<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="acornAir.login.dto.UserDTO"%>

<%
List<UserDTO> userList = (List<UserDTO>) request.getAttribute("userList");
UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>

<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: #f5f6fa;
}

.header {
	background: #1f2a44;
	color: white;
	padding: 20px 40px;
}

.header h1 {
	margin: 0;
	font-size: 24px;
}

.container {
	width: 1200px;
	margin: 40px auto;
	background: white;
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.top {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.top a {
	text-decoration: none;
	color: white;
	background: #1f2a44;
	padding: 10px 16px;
	border-radius: 6px;
}

table {
	width: 100%;
	border-collapse: collapse;
	font-size: 14px;
}

th, td {
	border-bottom: 1px solid #ddd;
	padding: 12px;
	text-align: center;
}

th {
	background: #f0f2f5;
}

.admin {
	color: red;
	font-weight: bold;
}

.user {
	color: #333;
}

.delete-btn {
	border: none;
	background: #d9534f;
	color: white;
	padding: 7px 12px;
	border-radius: 5px;
	cursor: pointer;
}

.delete-btn:hover {
	background: #c9302c;
}

.disabled {
	color: #999;
	font-size: 13px;
}
</style>
</head>

<body>

	<div class="header">
		<h1>회원 관리</h1>
	</div>

	<div class="container">

		<div class="top">
			<h2>회원 목록</h2>
			<a href="<%=request.getContextPath()%>/admin/dashboard">대시보드로</a>
		</div>

		<table>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>영문명</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>성별</th>
				<th>국가</th>
				<th>권한</th>
				<th>관리</th>
				<th>예약</th>
			</tr>

			<%
			if (userList != null && !userList.isEmpty()) {
				for (UserDTO user : userList) {
			%>
			<tr>
				<td><%=user.getUserId()%></td>
				<td><%=user.getKorLastName()%><%=user.getKorFirstName()%></td>
				<td><%=user.getEngLastName()%> <%=user.getEngFirstName()%></td>
				<td><%=user.getUserEmail()%></td>
				<td><%=user.getPhoneCountry()%> <%=user.getUserPhone()%></td>
				<td><%=user.getGender()%></td>
				<td><%=user.getCountry()%></td>
				<td
					class="<%="ADMIN".equals(user.getUserRole()) ? "admin" : "user"%>">
					<%=user.getUserRole()%>
				</td>
				<td>
					<%
					if (loginUser != null && loginUser.getUserId().equals(user.getUserId())) {
					%> <span class="disabled">본인</span> <%
 } else {
 %>
					<form action="<%=request.getContextPath()%>/admin/users/delete"
						method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
						<input type="hidden" name="userId" value="<%=user.getUserId()%>">
						<button type="submit" class="delete-btn">삭제</button>
					</form> <%
 }
 %>
				</td>
				<td><%=user.getReservationStatus()%> (<%=user.getReservationCount()%>건)
				</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="9">회원 정보가 없습니다.</td>
			</tr>
			<%
			}
			%>
		</table>

	</div>

</body>
</html>