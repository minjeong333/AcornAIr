<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>항공편 등록</title>

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

.container {
	width: 700px;
	margin: 40px auto;
	background: white;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

h1 {
	margin: 0;
}

form {
	display: flex;
	flex-direction: column;
	gap: 15px;
}

label {
	font-weight: bold;
}

input, select {
	padding: 10px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 6px;
}

.btn-area {
	margin-top: 20px;
	display: flex;
	gap: 10px;
}

.btn {
	padding: 10px 16px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	color: white;
	font-size: 14px;
}

.submit-btn {
	background: #2d8f5d;
}

.back-btn {
	background: #1f2a44;
	text-decoration: none;
	display: inline-block;
	text-align: center;
	line-height: 38px;
}
</style>
</head>

<body>

	<div class="header">
		<h1>항공편 등록</h1>
	</div>

	<div class="container">

		<form method="post"
			action="<%=request.getContextPath()%>/admin/flights/add">

			<label>편명</label> <input type="text" name="flightNo" required>

			<label>출발 공항</label> <input type="text" name="depAirport"
				placeholder="ICN" required> <label>도착 공항</label> <input
				type="text" name="arrAirport" placeholder="NRT" required> <label>출발
				시간</label> <input type="datetime-local" name="depTime" required> <label>도착
				시간</label> <input type="datetime-local" name="arrTime" required> <label>가격</label>
			<input type="number" name="price" required> <label>유류할증료</label>
			<input type="number" name="fuelSurcharge" required> <label>세금</label>
			<input type="number" name="taxPrice" required> <label>일반석
				좌석 수</label> <input type="number" name="economySeat" required> <label>비즈니스석
				좌석 수</label> <input type="number" name="businessSeat" required>

			<div class="btn-area">
				<button type="submit" class="btn submit-btn">등록하기</button>

				<a class="btn back-btn"
					href="<%=request.getContextPath()%>/admin/flights"> 목록으로 </a>
			</div>

		</form>

	</div>

</body>
</html>