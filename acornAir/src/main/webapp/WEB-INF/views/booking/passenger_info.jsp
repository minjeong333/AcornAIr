<%@page import="acornAir.booking.dto.PassengerDTO"%>
<%@page import="acornAir.flight.dto.FlightDTO"%>
<%@page import="acornAir.login.dto.UserDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
boolean passengerDone = session.getAttribute("passengers") != null;
boolean contactDone = session.getAttribute("contactPhone") != null;
boolean seatDone = session.getAttribute("goSeats") != null;
boolean baggageDone = session.getAttribute("bags") != null;

FlightDTO goFlight = (FlightDTO) session.getAttribute("goFlight");
FlightDTO backFlight = (FlightDTO) session.getAttribute("backFlight");
String goSeatClass = (String) session.getAttribute("goSeatClass");
String backSeatClass = (String) session.getAttribute("backSeatClass");
String tripType = (String) session.getAttribute("tripType");
int passCnt = session.getAttribute("passCnt") != null ? (Integer) session.getAttribute("passCnt") : 1;

String goSeatLabel = "C".equals(goSeatClass) ? "비즈니스석" : "일반석";
String backSeatLabel = "C".equals(backSeatClass) ? "비즈니스석" : "일반석";
boolean isRoundTrip = "RT".equals(tripType);

SimpleDateFormat dateFmt = new SimpleDateFormat("yyyy년 M월 dd일 (E)", new Locale("ko"));
SimpleDateFormat timeFmt = new SimpleDateFormat("HH:mm");
SimpleDateFormat birthFmt = new SimpleDateFormat("yyyy-MM-dd");
UserDTO loginUser = (UserDTO) request.getAttribute("loginUser");

// 운임 계산
int farePrice = 0;
if (goFlight != null) {
	farePrice += "C".equals(goSeatClass) ? goFlight.getBizPrice() : goFlight.getPrice();
}
if (backFlight != null) {
	farePrice += "C".equals(backSeatClass) ? backFlight.getBizPrice() : backFlight.getPrice();
}
farePrice *= passCnt;

// int fuelSurcharge = 114000;
// int tax = 63000;
int baseTotal = farePrice;
// ※ 유류할증료·세금 복원 시 위 3줄을 아래로 교체
// int fuelSurcharge = 114000;
// int tax = 63000;
// int baseTotal = farePrice + fuelSurcharge + tax;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>여정 및 승객 정보</title>
<link rel="icon" href="data:,">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/util/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/booking/passenger.css" />  <!--적용안되는중 -->
</head>
<body>

	<jsp:include page="/WEB-INF/views/util/header.jsp" />

	<!-- 	<!-- 상단 진행 표시 -->
	<div class="progress-bar">
		<div class="step done">
			<div class="circle">✓</div>
			<span>검색</span>
		</div>
		<div class="step done">
			<div class="circle">✓</div>
			<span>항공편</span>
		</div>
		<div class="step active">
			<div class="circle">3</div>
			<span>결제</span>
		</div>
	</div>
	-->

	<!-- 메인 컨테이너 -->
	<div class="container-b">

		<!-- 왼쪽 본문 -->
		<div class="main">

			<!-- 여정 정보 -->
			<div class="section-header">
				<h2 class="section-title">여정 정보</h2>
				<button class="btn-share">↗ 공유</button>
			</div>

			<!-- 가는 편 -->
			<%
			if (goFlight != null) {
			%>
			<div class="flight-card">
				<div>
					<div class="flight-label">가는 편</div>
					<div class="flight-type"><%=goSeatLabel%></div>
				</div>
				<div>
					<div class="flight-route">
						<span><%=goFlight.getDepAirport()%> <%=goFlight.getDepAirportName()%></span>
						<span class="arrow">→</span> <span><%=goFlight.getArrAirport()%>
							<%=goFlight.getArrAirportName()%></span>
					</div>
					<div class="flight-detail">
						<span><%=dateFmt.format(goFlight.getDepTime())%> <%=timeFmt.format(goFlight.getDepTime())%>~<%=timeFmt.format(goFlight.getArrTime())%></span>
						<span>✈ <%=goFlight.getFlightNo()%></span>
					</div>
				</div>
				<button class="btn-detail">상세 보기</button>
			</div>
			<%
			}
			%>

			<!-- 오는 편 (왕복일 때만) -->
			<%
			if (isRoundTrip && backFlight != null) {
			%>
			<div class="flight-card">
				<div>
					<div class="flight-label">오는 편</div>
					<div class="flight-type"><%=backSeatLabel%></div>
				</div>
				<div>
					<div class="flight-route">
						<span><%=backFlight.getDepAirport()%> <%=backFlight.getDepAirportName()%></span>
						<span class="arrow">→</span> <span><%=backFlight.getArrAirport()%>
							<%=backFlight.getArrAirportName()%></span>
					</div>
					<div class="flight-detail">
						<span><%=dateFmt.format(backFlight.getDepTime())%> <%=timeFmt.format(backFlight.getDepTime())%>~<%=timeFmt.format(backFlight.getArrTime())%></span>
						<span>✈ <%=backFlight.getFlightNo()%></span>
					</div>
				</div>
				<button class="btn-detail">상세 보기</button>
			</div>
			<%
			}
			%>

			<!-- 승객 정보 -->
			<div class="passenger-section">
				<div class="section-header">
					<h2 class="section-title">승객 정보</h2>
					<button class="btn-share">성명 입력 안내</button>
				</div>
				<p class="passenger-notice">
					<span class="req">*</span>는 필수 입력 사항입니다.
				</p>
				<div class="passenger-warning">예약 후 성명 변경은 불가하오니 여권에 기재된 성명을
					정확히 확인하시기 바랍니다.</div>

				<!-- 승객 입력 폼 (passCnt만큼 반복) -->
				<form method="post"
					action="${pageContext.request.contextPath}/air/booking/passenger">
					<input type="hidden" name="passCnt" value="<%=passCnt%>" />

					<%
					for (int i = 0; i < passCnt; i++) {
						String lastVal = (i == 0 && loginUser != null && loginUser.getEngLastName() != null)
						? loginUser.getEngLastName()
						: "";
						String firstVal = (i == 0 && loginUser != null && loginUser.getEngFirstName() != null)
						? loginUser.getEngFirstName()
						: "";
						String birthVal = (i == 0 && loginUser != null && loginUser.getBirthDate() != null)
						? birthFmt.format(loginUser.getBirthDate())
						: "";
						String genderVal = (i == 0 && loginUser != null && loginUser.getGender() != null) ? loginUser.getGender() : "F";
					%>
					<div class="accordion">
						<div class="accordion-header">
							<span>성인 <%=i + 1%></span> <span class="chevron">∧</span>
						</div>
						<div class="accordion-body">

							<!-- 성 / 이름 -->
							<div class="form-row">
								<div>
									<div class="form-label">
										승객 성 <span class="req">*</span>
									</div>
									<input class="form-input" type="text" name="engLastName_<%=i%>"
										value="<%=lastVal%>" required />
								</div>
								<div>
									<div class="form-label">
										승객 이름 <span class="req">*</span>
									</div>
									<input class="form-input" type="text"
										name="engFirstName_<%=i%>" value="<%=firstVal%>" required />
								</div>
							</div>

							<!-- 성별 / 생년월일 -->
							<div class="form-row">
								<div>
									<div class="form-label">
										성별 <span class="req">*</span>
									</div>
									<div class="select-wrap">
										<select class="form-select" name="gender_<%=i%>">
											<option value="F"
												<%="F".equals(genderVal) ? "selected" : ""%>>여성(F)</option>
											<option value="M"
												<%="M".equals(genderVal) ? "selected" : ""%>>남성(M)</option>
										</select>
									</div>
								</div>
								<div>
									<div class="form-label">
										생년월일 <span class="req">*</span>
									</div>
									<input class="form-input" type="date" name="birthDate_<%=i%>"
										value="<%=birthVal%>" />
								</div>
							</div>

						</div>
					</div>
					<%
					}
					%>

					<!-- 확인 버튼 (모든 승객 한 번에 제출) -->
					<div class="btn-confirm-wrap">
						<button type="button" class="btn-confirm"
							id="btn-passenger-confirm">확인</button>
					</div>



					<!-- 연락처 정보 아코디언 -->
					<div class="accordion" id="contact-accordion">
						<div class="accordion-header secondary" id="contact-header">
							<span>연락처 정보</span> <span class="chevron">∨</span>
						</div>
						<div class="accordion-body hidden" id="contact-body">

							<!-- 안내 문구 -->
							<div class="contact-notice">
								<span class="icon">📋</span> <span>e-티켓 확인증과 항공편 스케줄 변동
									등의 안내를 받으실 수 있도록 휴대전화 번호와 이메일을 입력해주세요.</span>
							</div>

							<!-- 국가번호 / 휴대전화 번호 -->
							<div class="form-row">
								<div>
									<div class="form-label">
										국가번호 <span class="req">*</span>
									</div>
									<div class="country-row">
										<button type="button" class="btn-country">국가번호</button>
										<input class="form-input" type="text" name="phoneCountry"
											value="${loginUser.phoneCountry}" style="max-width: 60px;" />
									</div>
								</div>
								<div>
									<div class="form-label">
										휴대전화 번호 <span class="req">*</span>
									</div>
									<input class="form-input" type="text" name="contactPhone"
										value="${loginUser.userPhone}" style="color: #0066cc;" />
								</div>
							</div>

							<!-- 이메일 / 언어 선택 -->
							<div class="form-row">
								<div>
									<div class="form-label">
										이메일 <span class="req">*</span>
									</div>
									<input class="form-input" type="email" name="contactEmail"
										value="${loginUser.userEmail}" style="color: #0066cc;" />
								</div>
								<div>
									<div class="form-label">
										언어 선택 <span class="req">*</span>
									</div>
									<div class="select-wrap">
										<select class="form-select">
											<option>한국어</option>
											<option>English</option>
											<option>日本語</option>
											<option>中文</option>
										</select>
									</div>
								</div>
							</div>

							<!-- 동의 체크박스 -->
							<div class="agree-row">
								<input type="checkbox" id="agree-update" /> <label
									for="agree-update"> [선택] 상기의 휴대전화 번호와 이메일 주소를 나의 회원 정보에
									업데이트 하는 것을 동의합니다. </label>
							</div>

							<!-- 확인 버튼 -->
							<div class="btn-confirm-wrap">
								<button class="btn-confirm" id="btn-contact-confirm"
									type="button">확인</button>
							</div>

						</div>
					</div>
				</form>
			</div>

			<!-- 부가서비스 신청 -->
			<div class="extra-section">
				<h2 class="section-title" style="margin-bottom: 14px;">부가서비스 신청</h2>
				<div class="extra-card" onclick="openSeatModal()"
					style="cursor: pointer;">
					<span class="extra-icon">&#128186;</span> <span class="extra-label">좌석
						배정</span>
				</div>
				<div class="extra-card" onclick="openBaggageModal()"
					style="cursor: pointer;">
					<span class="extra-icon">&#127890;</span> <span class="extra-label">초과
						수하물</span>
				</div>
			</div>

			<!-- 확인 및 동의 -->
			<div class="agree-section">
				<h2 class="section-title" style="margin-bottom: 14px;">확인 및 동의</h2>

				<div class="agree-box">
					<div class="agree-box-header">
						<span class="agree-badge">✓ 동의</span> <span class="agree-text">[필수]
							운송약관, 변경/환불 규정을 포함한 운임 규정, 수하물 규정을 확인하였으며 이에 동의합니다.</span>
						<button class="agree-view-btn">보기</button>
					</div>
					<div class="agree-desc">
						에이콘항공 항공권을 구매하시는 것은 본 항공사와 운송계약 체결에 동의하는 것으로 운임규정은 항공권 변경, 취소 등에
						따른 수수료와 사전좌석배정, 좌석승급 등 구매하는 항공권 운임에 적용되는 세부 조건을 기재하고 있으며, 운송 약관은
						운송 계약 체결에 따른 계약조건을 명시합니다.<br /> 에이콘항공은 '항공교통이용자 보호기준'에 따라 <a
							href="#" class="agree-link">항공교통이용자 서비스 계획</a>을 게시합니다.
					</div>
				</div>

				<div class="agree-box">
					<div class="agree-box-header">
						<span class="agree-badge">✓ 동의</span> <span class="agree-text">[필수]
							리튬 보조배터리 및 위험품 안내를 확인하였습니다.</span>
						<button class="agree-view-btn">보기</button>
					</div>
					<div class="agree-desc">고객 안전을 위해 기내 리튬 보조배터리 사용 및 충전은 금지합니다.
						폭발성, 인화성, 유독성 물질 등 반입 금지 품목을 미리 확인해 주세요.</div>
				</div>
			</div>

			<!-- 수하물 정보 -->
			<div class="baggage-accordion">
				<div class="baggage-header" id="baggageHeader">
					<span>수하물 정보</span> <span class="chevron">∧</span>
				</div>
				<div class="baggage-body" id="baggageBody">
					<p class="baggage-sub">성인</p>
					<table class="baggage-table">
						<thead>
							<tr>
								<th>여정</th>
								<th>무료 위탁 수하물</th>
								<th>기내 휴대 수하물</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>ICN &#10132; NGO</td>
								<td>1 개<br /> <span class="baggage-sub-text">23kg(50lb),
										158cm(62in)</span></td>
								<td>1 개<br /> <span class="baggage-sub-text">10kg(22lb),
										115cm(45in)</span></td>
							</tr>
							<tr>
								<td>NGO &#10132; ICN</td>
								<td>1 개<br /> <span class="baggage-sub-text">23kg(50lb),
										158cm(62in)</span></td>
								<td>1 개<br /> <span class="baggage-sub-text">10kg(22lb),
										115cm(45in)</span></td>
							</tr>
						</tbody>
					</table>
					<div class="baggage-notes">
						<p>&#9432; 항공사 우수회원 혜택, 신분(예: 군인) 등 제반 사항에 따라 추가 허용될 수 있습니다.</p>
						<p>&#9432; 무게 : kg(킬로그램), lb(파운드)</p>
						<p>&#9432; 크기(가로+세로+높이) : cm(센티미터), in(인치)</p>
					</div>
				</div>
			</div>

			<!-- 출입국 규정 -->
			<div class="immigration-row">
				<span class="immigration-title">출입국 규정 및 구비 서류 안내</span> <a
					href="https://www.0404.go.kr/bbs/contsPst/MST0000000000113/13/detail"
					class="immigration-link">출입국 규정 조회 (외교부 사이트) ›</a>
			</div>

		</div>

		<!-- 오른쪽 사이드바 -->
		<div class="sidebar">
			<div class="sidebar-card">
				<div class="card-title">항공 운송료</div>
				<div class="price-row">
					<span>운임</span> <span><%=String.format("%,d", farePrice)%> 원</span>
				</div>
				<%-- <div class="price-row">
					<span>유류할증료</span> <span>원</span>
				</div>
				<div class="price-row">
					<span>세금, 수수료 및 기타 요금</span> <span>원</span>
				</div> --%>
				<div id="extraBaggageRow" class="price-row" style="display: none;">
					<span id="extraBaggageLabel">초과 수하물</span> <span
						id="extraBaggagePrice">0 원</span>
				</div>
				<hr class="price-divider" />
				<div class="price-total">
					<span>총액</span> <span class="amount" id="sidebarTotal"><%=String.format("%,d", baseTotal)%>
						원</span>
				</div>
				<a href="#" class="link-refund">↺ 변경 및 환불 규정</a>
			</div>
		</div>

	</div>

	<div class="spacer"></div>

	<!-- 하단 결제 바 -->
	<div class="bottom-bar">
		<span class="total-label">최종 결제 금액</span> <span class="total-amount"
			id="totalAmount"><%=String.format("%,d", baseTotal)%> <span>원</span></span>
		<button class="btn-pay" onclick="openPayModal()">결제하기</button>
	</div>

	<script>
		function formatNum(n) {
			return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}

		var BASE_PRICE =
	<%=baseTotal%>
		;
		var BAG_PRICE = 40000;

		var serverBags = '${bags}' === '' ? 0 : parseInt('${bags}');
		var serverTotal = BASE_PRICE + (serverBags * BAG_PRICE);

		function applyPriceView() {
			document.getElementById('totalAmount').innerHTML = formatNum(serverTotal)
					+ ' <span>원</span>';

			document.getElementById('sidebarTotal').textContent = formatNum(serverTotal)
					+ ' 원';

			if (serverBags > 0) {
				document.getElementById('extraBaggageRow').style.display = 'flex';
				document.getElementById('extraBaggageLabel').textContent = '초과 수하물 ×'
						+ serverBags;
				document.getElementById('extraBaggagePrice').textContent = formatNum(serverBags
						* BAG_PRICE)
						+ ' 원';
			} else {
				document.getElementById('extraBaggageRow').style.display = 'none';
			}
		}

		applyPriceView();
	</script>
	<script>
		window.stepState = {
			passenger :
	<%=passengerDone%>
		,
			contact :
	<%=contactDone%>
		,
			seat :
	<%=seatDone%>
		|| sessionStorage.getItem('seatDone') === 'true',
			baggage :
	<%=baggageDone%>
		|| sessionStorage.getItem('baggageDone') === 'true'
		};

		function checkStepBeforeSeat() {
			if (!window.stepState.passenger) {
				alert("먼저 승객정보 확인 버튼을 눌러주세요.");
				return false;
			}
			if (!window.stepState.contact) {
				alert("먼저 연락처정보 확인 버튼을 눌러주세요.");
				return false;
			}
			return true;
		}

		function checkStepBeforeBaggage() {
			if (!window.stepState.seat) {
				alert("먼저 좌석배정을 완료해주세요.");
				return false;
			}
			return true;
		}

		function checkStepBeforePay() {
			if (!window.stepState.passenger) {
				alert("승객정보 확인을 먼저 진행해주세요.");
				return false;
			}
			if (!window.stepState.contact) {
				alert("연락처정보 확인을 먼저 진행해주세요.");
				return false;
			}
			if (!window.stepState.seat) {
				alert("좌석배정을 먼저 완료해주세요.");
				return false;
			}
			return true;
		}
	</script>
	<script
		src="${pageContext.request.contextPath}/js/booking/passenger.js?v=6"></script>
	<!-- ===== 결제 모달 ===== -->
	<div class="modal-overlay" id="payModal" onclick="closePayModal(event)">
		<div class="modal-wrap">

			<!-- 모달 헤더 -->
			<div class="modal-header">
				<div>
					<div class="modal-title">결제 정보 확인</div>
					<div class="modal-subtitle">결제 전 예약 내용을 확인해주세요.</div>
				</div>
				<button class="modal-close" onclick="closeModal()">&#10005;</button>
			</div>

			<!-- 모달 본문 -->
			<div class="modal-body">

				<!-- 좌측 컬럼 -->
				<div class="modal-left">

					<!-- 항공편 정보 -->
					<div class="modal-card">
						<div class="modal-card-title">항공편 정보</div>
						<div class="modal-flight-row">
							<div>
								<%
								if (goFlight != null) {
								%>
								<div class="modal-route">
									<%=goFlight.getDepAirport()%>
									<%=goFlight.getDepAirportName()%>
									→
									<%=goFlight.getArrAirport()%>
									<%=goFlight.getArrAirportName()%>
								</div>
								<div class="modal-flight-detail">
									<%=dateFmt.format(goFlight.getDepTime())%>
									&nbsp;✈
									<%=goFlight.getFlightNo()%>
									&nbsp;
									<%=timeFmt.format(goFlight.getDepTime())%>
									~
									<%=timeFmt.format(goFlight.getArrTime())%>
								</div>
								<%
								}
								%>

								<%
								if (isRoundTrip && backFlight != null) {
								%>
								<div class="modal-flight-detail">
									오는 편 &nbsp;
									<%=backFlight.getDepAirport()%>
									→
									<%=backFlight.getArrAirport()%>
									&nbsp;✈
									<%=backFlight.getFlightNo()%>
									&nbsp;
									<%=dateFmt.format(backFlight.getDepTime())%>
									<%=timeFmt.format(backFlight.getDepTime())%>
									~
									<%=timeFmt.format(backFlight.getArrTime())%>
								</div>
								<%
								}
								%>
							</div>
							<div class="modal-price-right">
								<%=String.format("%,d", baseTotal)%>
								원
							</div>
						</div>
					</div>

					<!-- 항공 운송료 -->
					<div class="modal-card">
						<div class="modal-card-title">항공 운송료</div>
						<div class="modal-fee-row">
							<span>운임</span> <span><%=String.format("%,d", farePrice)%>
								원</span>
						</div>

						<!-- !!!!! 세금 부분 일단 주석처리 -->
						<%-- <div class="modal-fee-row">
							<span>유류할증료</span> <span><%=String.format("%,d", fuelSurcharge)%>
								원</span>
						</div>
						<div class="modal-fee-row">
							<span>세금, 수수료 및 기타 요금</span> <span><%=String.format("%,d", tax)%>
								원</span>
						</div> --%>


						<div class="modal-fee-total">
							<span>소계</span> <span><%=String.format("%,d", baseTotal)%>
								원</span>
						</div>
					</div>

					<!-- 초과 수하물 (동적) -->
					<div class="modal-card" id="modalBaggageCard"
						style="display: none;">
						<div class="modal-card-title">초과 수하물</div>
						<div class="modal-flight-row">
							<div>
								<div class="modal-route" id="modalBaggageDesc">위탁 수하물</div>
								<div class="modal-flight-detail">23kg 이하, 각 편 추가</div>
							</div>
							<div class="modal-price-right" id="modalBaggagePrice">0 원</div>
						</div>
					</div>

					<!-- 결제 수단 -->
					<div class="modal-card">
						<div class="modal-card-title">결제 수단 선택</div>
						<label class="pay-option" id="opt1"> <input type="radio"
							name="payMethod" value="card" checked
							onchange="selectPay('opt1')" />
							<div class="pay-option-info">
								<div class="pay-option-name">신용 / 체크카드</div>
								<div class="pay-option-sub">Visa · MasterCard · JCB · AMEX</div>
							</div>
						</label> <label class="pay-option" id="opt2"> <input type="radio"
							name="payMethod" value="transfer" onchange="selectPay('opt2')" />
							<div class="pay-option-info">
								<div class="pay-option-name">계좌이체</div>
								<div class="pay-option-sub">실시간 계좌이체</div>
							</div>
						</label> <label class="pay-option" id="opt3"> <input type="radio"
							name="payMethod" value="simple" onchange="selectPay('opt3')" />
							<div class="pay-option-info">
								<div class="pay-option-name">간편결제</div>
								<div class="pay-option-sub">카카오페이 · 네이버페이 · 토스</div>
							</div>
						</label>
					</div>

				</div>

				<!-- 우측 컬럼 -->
				<div class="modal-right">
					<div class="modal-summary">
						<div class="modal-card-title">결제 금액</div>
						<div class="modal-fee-row">
							<span>항공권 운임</span> <span><%=String.format("%,d", farePrice)%>
								원</span>
						</div>
						<%-- <div class="modal-fee-row">
							<span>유류할증료</span> <span>원</span>
						</div>
						<div class="modal-fee-row">
							<span>세금 및 수수료</span> <span>원</span>
						</div> --%>
						<div class="modal-fee-row" id="summaryBaggageRow"
							style="display: none;">
							<span id="summaryBaggageLabel">초과 수하물</span> <span
								id="summaryBaggagePrice">0 원</span>
						</div>
						<hr class="modal-divider" />
						<div class="modal-total-row">
							<span>총 결제금액</span> <span class="modal-total-amount"
								id="modalTotalAmt"> <%=String.format("%,d", baseTotal)%>
								원
							</span>
						</div>
						<button class="modal-pay-btn" id="modalPayBtn" onclick="doPay()">
							<%=String.format("%,d", baseTotal)%>
							원 결제하기
						</button>
						<p class="modal-disclaimer">결제 시 이용약관 및 개인정보처리방침에 동의하게 됩니다.</p>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- ===== 좌석 배정 모달 ===== -->
	<div class="modal-overlay" id="seatModal"
		onclick="closeSeatModal(event)">
		<div class="modal-wrap"
			style="width: 1300px; max-width: 95vw; height: 88vh; padding: 0; display: flex; flex-direction: column; overflow: hidden;">
			<div class="modal-header" style="padding: 20px 24px; flex-shrink: 0;">
				<div>
					<div class="modal-title">좌석 배정</div>
					<div class="modal-subtitle">원하시는 좌석을 선택해 주세요.</div>
				</div>
				<button class="modal-close" onclick="closeSeatModal()">&#10005;</button>
			</div>
			<iframe id="seatFrame" src=""
				style="width: 100%; flex: 1; border: none;"></iframe>
		</div>
	</div>

	<!-- ===== 초과 수화물 모달 ===== -->
	<div class="modal-overlay" id="baggageModal"
		onclick="closeBaggageModalByOverlay(event)">
		<div class="modal-wrap"
			style="width: 900px; max-width: 95vw; height: 88vh; padding: 0; display: flex; flex-direction: column; overflow: hidden;">
			<div class="modal-header" style="padding: 20px 24px; flex-shrink: 0;">
				<div>
					<div class="modal-title">초과 수화물</div>
					<div class="modal-subtitle">추가 수화물을 선택해 주세요.</div>
				</div>
				<button class="modal-close" onclick="closeBaggageModal()">&#10005;</button>
			</div>
			<iframe id="baggageFrame" src=""
				style="width: 100%; flex: 1; border: none;"></iframe>
		</div>
	</div>

	<script>
		var selectedOpt = 'opt1';

		function openPayModal() {
			if (!checkStepBeforePay())
				return;
			var modal = document.getElementById('payModal');
			var t = serverTotal;
			var b = serverBags;

			// 초과 수하물 표시
			if (b > 0) {
				var bagAmt = b * 40000;
				document.getElementById('modalBaggageCard').style.display = 'block';
				document.getElementById('modalBaggageDesc').textContent = '위탁 수하물 × '
						+ b + '개';
				document.getElementById('modalBaggagePrice').textContent = formatNum(bagAmt)
						+ ' 원';
				document.getElementById('summaryBaggageRow').style.display = 'flex';
				document.getElementById('summaryBaggageLabel').textContent = '초과 수하물 ×'
						+ b;
				document.getElementById('summaryBaggagePrice').textContent = formatNum(bagAmt)
						+ ' 원';
			}

			document.getElementById('modalTotalAmt').textContent = formatNum(t)
					+ ' 원';
			document.getElementById('modalPayBtn').textContent = formatNum(t)
					+ ' 원 결제하기';

			modal.style.display = 'flex';
			document.body.style.overflow = 'hidden';
		}

		function closeModal() {
			document.getElementById('payModal').style.display = 'none';
			document.body.style.overflow = '';
		}

		function closePayModal(e) {
			if (e.target === document.getElementById('payModal'))
				closeModal();
		}

		function selectPay(id) {
			[ 'opt1', 'opt2', 'opt3' ].forEach(function(o) {
				document.getElementById(o).classList.remove('selected');
			});
			document.getElementById(id).classList.add('selected');
			selectedOpt = id;
		}
	<%--function doPay() {
			var confirmed = confirm('결제를 진행하시겠습니까?');
			if (confirmed) {
				alert('결제가 완료되었습니다.');
			}
		} --%>
		function doPay() {
			var payMethod = document
					.querySelector("input[name='payMethod']:checked").value;

			var msg = '결제를 진행하시겠습니까?';
			if (payMethod === 'card') {
				msg = '신용카드로 결제하시겠습니까?';
			} else if (payMethod === 'transfer') {
				msg = '계좌이체로 이용하시겠습니까?';
			} else if (payMethod === 'simple') {
				msg = '간편결제로 이용하시겠습니까?';
			}

			var confirmed = confirm(msg);
			if (!confirmed)
				return;

			var form = document.createElement("form");
			form.method = "POST";
			form.action = "${pageContext.request.contextPath}/air/booking/payment";

			function addHidden(name, value) {
				var input = document.createElement("input");
				input.type = "hidden";
				input.name = name;
				input.value = value;
				form.appendChild(input);
			}

			addHidden("payMethod", payMethod.toUpperCase());
			addHidden("bags", serverBags);
			addHidden("total", serverTotal);

			document.body.appendChild(form);
			form.submit();
		}
		// 초기 선택 표시
		document.getElementById('opt1').classList.add('selected');

		// 좌석 배정 모달
		function openSeatModal() {
			if (!checkStepBeforeSeat())
				return;
			document.getElementById('seatFrame').src = '${pageContext.request.contextPath}/air/booking/seatSelect';
			document.getElementById('seatModal').style.display = 'flex';
			document.body.style.overflow = 'hidden';
		}
		function closeSeatModal(e) {
			if (!e || e.target === document.getElementById('seatModal')) {
				document.getElementById('seatModal').style.display = 'none';
				document.getElementById('seatFrame').src = '';
				document.body.style.overflow = '';
			}
		}

		// 초과 수화물 모달
		function openBaggageModal() {
			if (!checkStepBeforeBaggage())
				return;

			document.getElementById('baggageFrame').src = '${pageContext.request.contextPath}/air/booking/baggage';

			document.getElementById('baggageModal').style.display = 'flex';
			document.body.style.overflow = 'hidden';
		}
		function closeBaggageModal() {
			document.getElementById('baggageModal').style.display = 'none';
			document.getElementById('baggageFrame').src = '';
			document.body.style.overflow = '';
		}

		function closeBaggageModalByOverlay(e) {
			if (e.target === document.getElementById('baggageModal')) {
				closeBaggageModal();
			}
		}

		function updateBaggageInfo(bags, baggageOnlyPrice) {
			serverBags = bags;
			serverTotal = BASE_PRICE + (serverBags * BAG_PRICE);
			applyPriceView();
		}

		// iframe(payment.jsp)에서 postMessage로 수하물 데이터 수신
		window.addEventListener('message', function(e) {
			if (!e.data)
				return;

			if (e.data.type === 'seatDone') {
				window.stepState.seat = true;
				sessionStorage.setItem('seatDone', 'true');

				closeSeatModal();

				// 좌석 완료 후 자동으로 수하물창 열기
				setTimeout(function() {
					openBaggageModal();
				}, 200);

				return;
			}

			if (e.data.type === 'baggageDone') {
				window.stepState.baggage = true;
				sessionStorage.setItem('baggageDone', 'true');
				updateBaggageInfo(e.data.bags, e.data.bagFee);
				closeBaggageModal();
				return;
			}
		});
	</script>

	<jsp:include page="/WEB-INF/views/util/footer.jsp" />
</body>
</html>
