<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="acornAir.booking.dto.BookingDTO"%>

<%
ArrayList<BookingDTO> bookingList = (ArrayList<BookingDTO>) request.getAttribute("bookingList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 관리</title>

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
	width: 1250px;
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

.btn {
	text-decoration: none;
	color: white;
	background: #1f2a44;
	padding: 9px 14px;
	border-radius: 6px;
	border: none;
	cursor: pointer;
	font-size: 14px;
}

.cancel-btn {
	background: #d9534f;
	padding: 7px 12px;
}

.disabled {
	color: #999;
}

.status-y {
	color: green;
	font-weight: bold;
}

.status-n {
	color: red;
	font-weight: bold;
}

table {
	width: 100%;
	border-collapse: collapse;
	font-size: 13px;
}

th, td {
	border-bottom: 1px solid #ddd;
	padding: 10px;
	text-align: center;
}

th {
	background: #f0f2f5;
}
</style>
</head>

<body>

	<div class="header">
		<h1>예약 관리</h1>
	</div>

	<div class="container">

		<div class="top">
			<h2>전체 예약 목록</h2>
			<a class="btn" href="<%=request.getContextPath()%>/admin/dashboard">대시보드로</a>
		</div>

		<table>
			<tr>
				<th>예약ID</th>
				<th>회원ID</th>
				<th>여정</th>
				<th>가는편</th>
				<th>오는편</th>
				<th>연락처</th>
				<th>기본금액</th>
				<th>수하물</th>
				<th>총금액</th>
				<th>결제</th>
				<th>상태</th>
				<th>예약일</th>
				<th>관리</th>
			</tr>

			<%
			if (bookingList != null && !bookingList.isEmpty()) {
				for (BookingDTO booking : bookingList) {
			%>
			<tr>
				<td><%=booking.getBookingId()%></td>
				<td><%=booking.getUserId()%></td>
				<td><%=booking.getTripType()%></td>

				<td><%=booking.getGoFlight() == null ? "-" : booking.getGoFlight().getFlightNo()%>
				</td>

				<td><%=booking.getBackFlight() == null ? "-" : booking.getBackFlight().getFlightNo()%>
				</td>

				<td><%=booking.getPhoneCountry()%> <%=booking.getContactPhone()%></td>
				<td><%=booking.getBasePrice()%></td>
				<td><%=booking.getBaggagePrice()%></td>
				<td><%=booking.getTotalPrice()%></td>
				<td><%=booking.getPayMethod()%></td>

				<td
					class="<%="Y".equals(booking.getBookStatus()) ? "status-y" : "status-n"%>">
					<%="Y".equals(booking.getBookStatus()) ? "예약완료" : "취소"%>
				</td>

				<td><%=booking.getBookDate()%></td>

				<td>
					<%
					if ("Y".equals(booking.getBookStatus())) {
					%>
					<form action="<%=request.getContextPath()%>/admin/bookings/cancel"
						method="post" onsubmit="return confirm('예약을 취소하시겠습니까?');">
						<input type="hidden" name="bookingId"
							value="<%=booking.getBookingId()%>">
						<button type="submit" class="btn cancel-btn">취소</button>
					</form> <%
 } else {
 %> <span class="disabled">처리완료</span> <%
 }
 %>
				</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="13">예약 정보가 없습니다.</td>
			</tr>
			<%
			}
			%>
		</table>

	</div>

</body>
</html>