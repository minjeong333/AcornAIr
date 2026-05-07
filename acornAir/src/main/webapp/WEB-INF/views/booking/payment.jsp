<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>초과 수하물</title>
<link rel="icon" href="data:,">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/booking/payment.css" />
</head>
<body>
<%
String errorMsg = (String) request.getAttribute("errorMsg");
if (errorMsg != null) {
%>
    <div style="color:red; font-weight:bold; padding:20px;">
        <%= errorMsg %>
    </div>
<%
}
%>

	<!-- 상단 바 -->
	<div class="top-bar">
		<button type="button" class="back-btn" onclick="history.back()">&#8592;
			돌아가기</button>
		<h1 class="top-title">초과 수하물</h1>
	</div>

	<div class="page-wrap">

		<!-- 여정 1/2 -->
		<div class="journey-card">
			<div class="journey-header" id="jh1"
				onclick="toggleJourney('jb1','jh1')">
				<div class="journey-badge">
					<span class="pin">&#9711;</span> <span class="journey-num">여정
						1 / 2</span>
				</div>
				<span class="journey-route">ICN &#10132; NGO</span> <span
					class="j-chevron">&#8743;</span>
			</div>

			<div class="journey-body" id="jb1">
				<!-- 항공편 정보 -->
				<div class="flight-info-box">
					<div class="flight-code">
						<span>&#9992; KE741</span> <span class="divider">|</span>
					</div>
					<div class="flight-class">일반석</div>
					<div class="flight-visual">
						<span class="city">서울/인천</span>
						<div class="route-line">
							<span class="plane-icon">&#9992;</span> <span class="dots">&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;</span>
							<span class="mid-dot">&#9679;</span> <span class="dots">&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;</span>
							<span class="plane-icon arrive">&#9992;</span>
						</div>
						<span class="city">나고야</span>
					</div>
					<div class="flight-date">2026년 07월 09일 (목) 10:35</div>
				</div>

				<!-- 승객 수하물 -->
				<div class="pax-baggage-row">
					<div class="pax-info">
						<input type="checkbox" class="pax-check" />
						<div>
							<div class="pax-name">KIM MINJEONG</div>
							<div class="pax-skypass">스카이패스 클럽 (KE)</div>
							<div class="pax-num">121920252139</div>
						</div>
					</div>

					<div class="baggage-box">
						<div class="baggage-box-title">무료 제공 수하물</div>
						<div class="baggage-box-content">
							<div class="weight-row">
								<span class="weight-badge">23kg</span> <span class="times">&#215;
									1</span>
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
									<button class="cnt-btn" onclick="changeCount(this,-1)">&#8722;</button>
									<span class="cnt-num">0</span>
									<button class="cnt-btn" onclick="changeCount(this,1)">&#43;</button>
								</div>
							</div>
							<div class="baggage-note">추가 구매</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 여정 2/2 -->
		<div class="journey-card">
			<div class="journey-header" id="jh2"
				onclick="toggleJourney('jb2','jh2')">
				<div class="journey-badge">
					<span class="pin">&#9711;</span> <span class="journey-num">여정
						2 / 2</span>
				</div>
				<span class="journey-route">NGO &#10132; ICN</span> <span
					class="j-chevron">&#8743;</span>
			</div>

			<div class="journey-body" id="jb2">
				<!-- 항공편 정보 -->
				<div class="flight-info-box">
					<div class="flight-code">
						<span>&#9992; KE742</span> <span class="divider">|</span>
					</div>
					<div class="flight-class">일반석</div>
					<div class="flight-visual">
						<span class="city">나고야</span>
						<div class="route-line">
							<span class="plane-icon">&#9992;</span> <span class="dots">&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;</span>
							<span class="mid-dot">&#9679;</span> <span class="dots">&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;&#183;</span>
							<span class="plane-icon arrive">&#9992;</span>
						</div>
						<span class="city">서울/인천</span>
					</div>
					<div class="flight-date">2026년 07월 10일 (금) 13:40</div>
				</div>

				<!-- 승객 수하물 -->
				<div class="pax-baggage-row">
					<div class="pax-info">
						<input type="checkbox" class="pax-check" />
						<div>
							<div class="pax-name">KIM MINJEONG</div>
							<div class="pax-skypass">스카이패스 클럽 (KE)</div>
							<div class="pax-num">121920252139</div>
						</div>
					</div>

					<div class="baggage-box">
						<div class="baggage-box-title">무료 제공 수하물</div>
						<div class="baggage-box-content">
							<div class="weight-row">
								<span class="weight-badge">23kg</span> <span class="times">&#215;
									1</span>
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
									<button class="cnt-btn" onclick="changeCount(this,-1)">&#8722;</button>
									<span class="cnt-num">0</span>
									<button class="cnt-btn" onclick="changeCount(this,1)">&#43;</button>
								</div>
							</div>
							<div class="baggage-note">추가 구매</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<div class="spacer"></div>

	<!-- 하단 결제 바 -->
	<div class="bottom-bar">
		<span class="total-label">최종 결제 금액</span> <span class="total-amount"
			id="totalAmount"> ${totalPrice} <span>원</span></span>
		<button class="btn-pay" onclick="goToPayment()">다음</button>
	</div>

	<script>
		var BASE_PRICE = ('${totalPrice}' !== '' ? parseInt('${totalPrice}')
				: 0);
		var BAG_PRICE = ('${bagPrice}' !== '' ? parseInt('${bagPrice}') : 40000);

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
			if (val < 0)
				val = 0;
			numEl.textContent = val;
			updateTotal();
		}

		function updateTotal() {
			var extraBags = 0;
			document.querySelectorAll('.cnt-num').forEach(function(el) {
				extraBags += parseInt(el.textContent.trim()) || 0;
			});
			var total = BASE_PRICE + extraBags * BAG_PRICE;
			document.getElementById('totalAmount').innerHTML = formatNum(total)
					+ ' <span>원</span>';
		}

		function goToPayment() {
			var extraBags = 0;

			document.querySelectorAll('.cnt-num').forEach(function(el) {
				extraBags += parseInt(el.textContent.trim()) || 0;
			});

			var total = BASE_PRICE + extraBags * BAG_PRICE;

			// iframe 안에서 열린 경우: 부모 passenger_info.jsp에 값 전달 후 모달 닫기
			if (window.parent && window.parent !== window && window.parent.updateBaggageInfo) {
				window.parent.updateBaggageInfo(extraBags, total);

				if (window.parent.closeBaggageModal) {
					window.parent.closeBaggageModal();
				}
				return;
			}

			// 단독 페이지로 열린 경우: passenger로 복귀
			location.href = "${pageContext.request.contextPath}/air/booking/passenger";
		}
	</script>
</body>
</html>
