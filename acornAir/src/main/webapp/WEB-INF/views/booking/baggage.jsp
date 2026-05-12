<%@page import="acornAir.booking.dto.PassengerDTO"%>
<%@page import="acornAir.flight.dto.FlightDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
FlightDTO goFlight = (FlightDTO) session.getAttribute("goFlight");
FlightDTO backFlight = (FlightDTO) session.getAttribute("backFlight");

String goSeatClass = (String) session.getAttribute("goSeatClass");
String backSeatClass = (String) session.getAttribute("backSeatClass");
String tripType = (String) session.getAttribute("tripType");

boolean isRoundTrip = "RT".equals(tripType);

String goSeatLabel = "C".equals(goSeatClass) ? "비즈니스석" : "일반석";
String backSeatLabel = "C".equals(backSeatClass) ? "비즈니스석" : "일반석";

SimpleDateFormat dateFmt = new SimpleDateFormat("yyyy년 MM월 dd일 (E) HH:mm", new Locale("ko"));

@SuppressWarnings("unchecked")
List<PassengerDTO> passengers = (List<PassengerDTO>) session.getAttribute("passengers");

int passCnt = passengers != null ? passengers.size() : 1;
int bagPrice = 40000;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>초과 수하물</title>
<link rel="icon" href="data:,">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/booking/payment.css" />
</head>
<body>

	<div class="top-bar">
		<button type="button" class="back-btn"
			onclick="window.parent.closeBaggageModal()">&#8592; 돌아가기</button>
		<h1 class="top-title">초과 수하물</h1>
	</div>

	<div class="page-wrap">

		<% if (goFlight != null) { %>
		<div class="journey-card">
			<div class="journey-header" id="jh1"
				onclick="toggleJourney('jb1','jh1')">
				<div class="journey-badge">
					<span class="pin">&#9711;</span>
					<span class="journey-num">여정 1 <%=isRoundTrip ? "/ 2" : "/ 1"%></span>
				</div>
				<span class="journey-route">
					<%=goFlight.getDepAirport()%> &#10132; <%=goFlight.getArrAirport()%>
				</span>
				<span class="j-chevron">&#8743;</span>
			</div>

			<div class="journey-body" id="jb1">
				<div class="flight-info-box">
					<div class="flight-code">
						<span>&#9992; <%=goFlight.getFlightNo()%></span>
						<span class="divider">|</span>
					</div>
					<div class="flight-class"><%=goSeatLabel%></div>

					<div class="flight-visual">
						<span class="city"><%=goFlight.getDepAirportName()%></span>
						<div class="route-line">
							<span class="plane-icon">&#9992;</span>
							<span class="dots">&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;</span>
							<span class="mid-dot">&#9679;</span>
							<span class="dots">&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;</span>
							<span class="plane-icon arrive">&#9992;</span>
						</div>
						<span class="city"><%=goFlight.getArrAirportName()%></span>
					</div>

					<div class="flight-date"><%=dateFmt.format(goFlight.getDepTime())%></div>
				</div>

				<% for (int i = 0; i < passCnt; i++) {
					PassengerDTO p = passengers != null ? passengers.get(i) : null;
					String paxName = p != null
						? (p.getEngLastName() + " " + p.getEngFirstName())
						: "PASSENGER " + (i + 1);
				%>
				<div class="pax-baggage-row">
					<div class="pax-info">
						<input type="checkbox" class="pax-check" checked />
						<div>
							<div class="pax-name"><%=paxName%></div>
							<div class="pax-skypass">에이콘항공</div>
							<div class="pax-num">성인 <%=i + 1%></div>
						</div>
					</div>

					<div class="baggage-box">
						<div class="baggage-box-title">무료 제공 수하물</div>
						<div class="baggage-box-content">
							<div class="weight-row">
								<span class="weight-badge">23kg</span>
								<span class="times">&#215; 1</span>
							</div>
							<div class="baggage-note">기본</div>
						</div>
					</div>

					<div class="baggage-box">
						<div class="baggage-box-title">초과 수하물</div>
						<div class="baggage-box-content">
							<div class="weight-row">
								<span class="weight-badge">23kg</span>
								<div class="count-ctrl">
									<button type="button" class="cnt-btn"
										onclick="changeCount(this,-1)">&#8722;</button>
									<span class="cnt-num">0</span>
									<button type="button" class="cnt-btn"
										onclick="changeCount(this,1)">&#43;</button>
								</div>
							</div>
							<div class="baggage-note">추가 구매</div>
						</div>
					</div>
				</div>
				<% } %>
			</div>
		</div>
		<% } %>

		<% if (isRoundTrip && backFlight != null) { %>
		<div class="journey-card">
			<div class="journey-header" id="jh2"
				onclick="toggleJourney('jb2','jh2')">
				<div class="journey-badge">
					<span class="pin">&#9711;</span>
					<span class="journey-num">여정 2 / 2</span>
				</div>
				<span class="journey-route">
					<%=backFlight.getDepAirport()%> &#10132; <%=backFlight.getArrAirport()%>
				</span>
				<span class="j-chevron">&#8743;</span>
			</div>

			<div class="journey-body" id="jb2">
				<div class="flight-info-box">
					<div class="flight-code">
						<span>&#9992; <%=backFlight.getFlightNo()%></span>
						<span class="divider">|</span>
					</div>
					<div class="flight-class"><%=backSeatLabel%></div>

					<div class="flight-visual">
						<span class="city"><%=backFlight.getDepAirportName()%></span>
						<div class="route-line">
							<span class="plane-icon">&#9992;</span>
							<span class="dots">&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;</span>
							<span class="mid-dot">&#9679;</span>
							<span class="dots">&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;</span>
							<span class="plane-icon arrive">&#9992;</span>
						</div>
						<span class="city"><%=backFlight.getArrAirportName()%></span>
					</div>

					<div class="flight-date"><%=dateFmt.format(backFlight.getDepTime())%></div>
				</div>

				<% for (int i = 0; i < passCnt; i++) {
					PassengerDTO p = passengers != null ? passengers.get(i) : null;
					String paxName = p != null
						? (p.getEngLastName() + " " + p.getEngFirstName())
						: "PASSENGER " + (i + 1);
				%>
				<div class="pax-baggage-row">
					<div class="pax-info">
						<input type="checkbox" class="pax-check" checked />
						<div>
							<div class="pax-name"><%=paxName%></div>
							<div class="pax-skypass">에이콘항공</div>
							<div class="pax-num">성인 <%=i + 1%></div>
						</div>
					</div>

					<div class="baggage-box">
						<div class="baggage-box-title">무료 제공 수하물</div>
						<div class="baggage-box-content">
							<div class="weight-row">
								<span class="weight-badge">23kg</span>
								<span class="times">&#215; 1</span>
							</div>
							<div class="baggage-note">기본</div>
						</div>
					</div>

					<div class="baggage-box">
						<div class="baggage-box-title">초과 수하물</div>
						<div class="baggage-box-content">
							<div class="weight-row">
								<span class="weight-badge">23kg</span>
								<div class="count-ctrl">
									<button type="button" class="cnt-btn"
										onclick="changeCount(this,-1)">&#8722;</button>
									<span class="cnt-num">0</span>
									<button type="button" class="cnt-btn"
										onclick="changeCount(this,1)">&#43;</button>
								</div>
							</div>
							<div class="baggage-note">추가 구매</div>
						</div>
					</div>
				</div>
				<% } %>
			</div>
		</div>
		<% } %>

	</div>

	<div class="spacer"></div>

	<div class="bottom-bar">
		<span class="total-label">초과 수하물 금액</span>
		<span class="total-amount" id="totalAmount">0 <span>원</span></span>
		<button class="btn-pay" onclick="submitBaggage()">다음</button>
	</div>

	<script>
		var BAG_PRICE = <%=bagPrice%>;

		function formatNum(n) {
			return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		function toggleJourney(bodyId, headerId) {
			var body = document.getElementById(bodyId);
			var header = document.getElementById(headerId);
			var chevron = header.querySelector('.j-chevron');

			var isOpen = body.style.display !== 'none';
			body.style.display = isOpen ? 'none' : 'block';
			chevron.innerHTML = isOpen ? '&#8744;' : '&#8743;';
		}

		function changeCount(btn, delta) {
			var ctrl = btn.parentElement;
			var numEl = ctrl.querySelector('.cnt-num');

			var val = (parseInt(numEl.textContent.trim()) || 0) + delta;
			if (val < 0) val = 0;

			numEl.textContent = val;
			updateTotal();
		}

		function getExtraBags() {
			var extraBags = 0;

			document.querySelectorAll('.cnt-num').forEach(function(el) {
				extraBags += parseInt(el.textContent.trim()) || 0;
			});

			return extraBags;
		}

		function updateTotal() {
			var extraBags = getExtraBags();
			var total = extraBags * BAG_PRICE;

			document.getElementById('totalAmount').innerHTML =
				formatNum(total) + ' <span>원</span>';
		}

		function submitBaggage() {
			var extraBags = getExtraBags();

			fetch('${pageContext.request.contextPath}/air/booking/baggage', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
				},
				body: 'bags=' + extraBags
			})
			.then(function() {
				window.parent.postMessage({
					type: 'baggageDone',
					bags: extraBags,
					bagFee: extraBags * BAG_PRICE
				}, '*');
			});
		}

		updateTotal();
	</script>

</body>
</html>