<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="acornAir.flight.dto.FlightDTO"%>

<%
ArrayList<FlightDTO> flightList = (ArrayList<FlightDTO>) request.getAttribute("flightList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>항공편 관리</title>

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

.add-btn {
	background: #2d8f5d;
}

.delete-btn {
	background: #d9534f;
	padding: 7px 12px;
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
</style>
</head>

<body>

	<div class="header">
		<h1>항공편 관리</h1>
	</div>

	<div class="container">

		<div class="top">
			<h2>항공편 목록</h2>
			<div>
				<a class="btn add-btn"
					href="<%=request.getContextPath()%>/admin/flights/add">항공편 등록</a> <a
					class="btn" href="<%=request.getContextPath()%>/admin/dashboard">대시보드로</a>
			</div>
		</div>

		<table>
			<tr>
				<th>ID</th>
				<th>편명</th>
				<th>출발</th>
				<th>도착</th>
				<th>출발시간</th>
				<th>도착시간</th>
				<th>좌석등급</th>
				<th>가격</th>
				<th>전체좌석</th>
				<th>잔여좌석</th>
				<th>관리</th>
			</tr>

			<%
			if (flightList != null && !flightList.isEmpty()) {
				for (FlightDTO flight : flightList) {
			%>
			<tr>
				<td><%=flight.getFlightId()%></td>
				<td><%=flight.getFlightNo()%></td>
				<td><%=flight.getDepAirport()%></td>
				<td><%=flight.getArrAirport()%></td>
				<td><%=flight.getDepTime()%></td>
				<td><%=flight.getArrTime()%></td>
				<td><%=flight.getSeatClass()%></td>
				<td><%=flight.getPrice()%></td>
				<td><%=flight.getTotalSeat()%></td>
				<td><%=flight.getRemainSeat()%></td>
				<td>
					<form action="<%=request.getContextPath()%>/admin/flights/delete"
						method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
						<input type="hidden" name="flightId"
							value="<%=flight.getFlightId()%>">
						<button type="submit" class="btn delete-btn">삭제</button>
					</form>
				</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="11">항공편 정보가 없습니다.</td>
			</tr>
			<%
			}
			%>
		</table>

	</div>

</body>
</html>