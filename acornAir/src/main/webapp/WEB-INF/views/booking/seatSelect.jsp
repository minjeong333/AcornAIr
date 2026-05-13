<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%
String tripType = (String) session.getAttribute("tripType");
String goSeatClass = (String) session.getAttribute("goSeatClass");
String backSeatClass = (String) session.getAttribute("backSeatClass");

if (tripType == null)
	tripType = "OW";
if (goSeatClass == null)
	goSeatClass = "Y";
if (backSeatClass == null)
	backSeatClass = "Y";

boolean isRoundTrip = "RT".equals(tripType);
boolean isGoBusiness = "C".equals(goSeatClass);
boolean isBackBusiness = "C".equals(backSeatClass);

String[] cols = {"A", "B", "C", "D", "E", "F"};

@SuppressWarnings("unchecked")
List<String> goBookedSeats = (List<String>) request.getAttribute("goBookedSeats");
@SuppressWarnings("unchecked")
List<String> backBookedSeats = (List<String>) request.getAttribute("backBookedSeats");
if (goBookedSeats == null)
	goBookedSeats = new java.util.ArrayList<>();
if (backBookedSeats == null)
	backBookedSeats = new java.util.ArrayList<>();

// JS에 전달할 JSON 배열 문자열 생성
StringBuilder goBookedJson = new StringBuilder("[");
for (int k = 0; k < goBookedSeats.size(); k++) {
	if (k > 0)
		goBookedJson.append(",");
	goBookedJson.append("\"").append(goBookedSeats.get(k)).append("\"");
}
goBookedJson.append("]");

StringBuilder backBookedJson = new StringBuilder("[");
for (int k = 0; k < backBookedSeats.size(); k++) {
	if (k > 0)
		backBookedJson.append(",");
	backBookedJson.append("\"").append(backBookedSeats.get(k)).append("\"");
}
backBookedJson.append("]");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 배정</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/booking/seatSelect.css">
</head>
<body>

	<button type="button" class="back-btn"
		onclick="window.parent.closeSeatModal ? window.parent.closeSeatModal() : history.back()">&#8592;
		돌아가기</button>

	<div class="flight-wrap">
		<div class="trip-tabs">
			<%
			if (isRoundTrip) {
			%>
			<button type="button" class="trip-tab active" data-trip="go">✈
				가는편</button>
			<button type="button" class="trip-tab" data-trip="back">✈
				오는편</button>
			<%
			} else {
			%>
			<button type="button" class="trip-tab active" data-trip="go">✈
				좌석 선택</button>
			<%
			}
			%>
		</div>
		<div class="flight-line"></div>
	</div>

	<div class="wrap">

		<!-- 가는편 좌석 -->
		<div id="seat-area-go"
			class="seat-area <%=isGoBusiness ? "business-area" : ""%>">
			<%
			if (isGoBusiness) {
			%>
			<div class="seat-header business">
				<span></span><span>A</span><span></span> <span>B</span><span>C</span><span></span>
				<span>D</span><span></span>
			</div>
			<%
			for (int i = 1; i <= 5; i++) {
				String[] bizCols = {"A", "B", "C", "D"};
			%>
			<div class="seat-row business">
				<span class="row-num"><%=i%></span>
				<%
				for (int j = 0; j < bizCols.length; j++) {
					String seatId = i + bizCols[j];
					boolean booked = goBookedSeats.contains(seatId);
					if (j == 1) {
				%><div class="business-aisle"></div>
				<%
				}
				if (j == 3) {
				%><div class="business-aisle"></div>
				<%
				}
				%>
				<button class="seat business-seat<%=booked ? " disabled" : ""%>"
					data-seat="<%=seatId%>" <%=booked ? "disabled" : ""%>>
					<%=booked ? "✕" : (i + bizCols[j])%>
				</button>
				<%
				}
				%>
				<span class="row-num"><%=i%></span>
			</div>
			<%
			}
			%>
			<%
			} else {
			%>
			<div class="seat-header">
				<span></span> <span>A</span><span>B</span><span>C</span> <span></span>
				<span>D</span><span>E</span><span>F</span> <span></span>
			</div>
			<%
			for (int i = 1; i <= 33; i++) {
			%>
			<div class="seat-row">
				<span class="row-num"><%=i%></span>
				<%
				for (int j = 0; j < cols.length; j++) {
					if (j == 3) {
				%><div class="aisle"></div>
				<%
				}
				String seatId = i + cols[j];
				boolean booked = goBookedSeats.contains(seatId);
				%>
				<button class="seat<%=booked ? " disabled" : ""%>"
					data-seat="<%=seatId%>" <%=booked ? "disabled" : ""%>>
					<%=booked ? "✕" : cols[j]%>
				</button>
				<%
				}
				%>
				<span class="row-num"><%=i%></span>
			</div>
			<%
			}
			%>
			<%
			}
			%>
		</div>

		<!-- 오는편 좌석 (왕복일 때만) -->
		<%
		if (isRoundTrip) {
		%>
		<div id="seat-area-back"
			class="seat-area <%=isBackBusiness ? "business-area" : ""%>"
			style="display: none;">
			<%
			if (isBackBusiness) {
			%>
			<div class="seat-header business">
				<span></span><span>A</span><span></span> <span>B</span><span>C</span><span></span>
				<span>D</span><span></span>
			</div>
			<%
			for (int i = 1; i <= 5; i++) {
				String[] bizCols = {"A", "B", "C", "D"};
			%>
			<div class="seat-row business">
				<span class="row-num"><%=i%></span>
				<%
				for (int j = 0; j < bizCols.length; j++) {
					String seatId = i + bizCols[j];
					boolean booked = backBookedSeats.contains(seatId);
					if (j == 1) {
				%><div class="business-aisle"></div>
				<%
				}
				if (j == 3) {
				%><div class="business-aisle"></div>
				<%
				}
				%>
				<button class="seat business-seat<%=booked ? " disabled" : ""%>"
					data-seat="<%=seatId%>" <%=booked ? "disabled" : ""%>>
					<%=booked ? "✕" : (i + bizCols[j])%>
				</button>
				<%
				}
				%>
				<span class="row-num"><%=i%></span>
			</div>
			<%
			}
			%>
			<%
			} else {
			%>
			<div class="seat-header">
				<span></span> <span>A</span><span>B</span><span>C</span> <span></span>
				<span>D</span><span>E</span><span>F</span> <span></span>
			</div>
			<%
			for (int i = 1; i <= 33; i++) {
			%>
			<div class="seat-row">
				<span class="row-num"><%=i%></span>
				<%
				for (int j = 0; j < cols.length; j++) {
					if (j == 3) {
				%><div class="aisle"></div>
				<%
				}
				String seatId = i + cols[j];
				boolean booked = backBookedSeats.contains(seatId);
				%>
				<button class="seat<%=booked ? " disabled" : ""%>"
					data-seat="<%=seatId%>" <%=booked ? "disabled" : ""%>>
					<%=booked ? "✕" : cols[j]%>
				</button>
				<%
				}
				%>
				<span class="row-num"><%=i%></span>
			</div>
			<%
			}
			%>
			<%
			}
			%>
		</div>
		<%
		}
		%>

		<div class="info-box">
			<h3>좌석정보</h3>
			<img src="<%=request.getContextPath()%>/images/seat.png" alt="좌석 이미지">
			<ul>
				<li>개인 모니터에서 제공되는 엔터테인먼트 시스템</li>
				<li>개인용 모니터 크기 27cm (10.6인치)</li>
				<li>USB 포트 (A 타입)</li>
				<li>좌석 간격 79~84cm (31~33인치)</li>
				<li>좌석 너비 46cm (18.1인치)</li>
				<li>좌석 기울기 각도 118˚</li>
			</ul>
			<div class="selected-box">
				<h3>선택한 좌석</h3>
				<div id="selectedSeats"></div>
			</div>
			<button type="button" class="next-btn" id="nextBtn">다음</button>
		</div>
	</div>

	<div class="legend-fixed">
		<div>
			<span class="legend-box possible"></span>선택 가능
		</div>
		<div>
			<span class="legend-box selected"></span>선택한 좌석
		</div>
		<div>
			<span class="legend-box disabled"></span>선택 불가
		</div>
	</div>
	<button type="button" class="bottom-next-btn" id="bottomNextBtn">다음</button>

	<script>
    const IS_ROUND_TRIP   = <%=isRoundTrip%>;
    const GO_BOOKED       = <%=goBookedJson%>;
    const BACK_BOOKED     = <%=backBookedJson%>;

    const selectedSeatsBox = document.getElementById("selectedSeats");
    const nextBtn          = document.getElementById("nextBtn");
    const bottomNextBtn    = document.getElementById("bottomNextBtn");
    
    const PASS_CNT = <%= session.getAttribute("passCnt") != null 
    ? (Integer)session.getAttribute("passCnt") 
    : 1 %>;
    

    let currentTrip   = "go";
    let selectedSeats = IS_ROUND_TRIP ? { go: [], back: [] } : [];

    // 좌석 클릭 핸들러 (모든 좌석에 등록)
    document.querySelectorAll(".seat").forEach(function(seat) {
        seat.addEventListener("click", function() {
            if (seat.classList.contains("disabled")) return;
            const seatName = seat.dataset.seat;
            const area     = seat.closest("[id^='seat-area-']");
            const trip     = area ? area.id.replace("seat-area-", "") : "go";
	
            if (IS_ROUND_TRIP) {
                const list = selectedSeats[trip];
                if (seat.classList.contains("active")) {
                    seat.classList.remove("active");
                    selectedSeats[trip] = list.filter(function(s) { return s !== seatName; });
                } else {

                    // 승객 수 초과 선택 방지
                    if (list.length >= PASS_CNT) {
                        alert("승객 수만큼만 좌석을 선택할 수 있습니다. (" + PASS_CNT + "개)");
                        return;
                    }

                    seat.classList.add("active");
                    list.push(seatName);
                }
            } else {
                if (seat.classList.contains("active")) {
                    seat.classList.remove("active");
                    selectedSeats = selectedSeats.filter(function(s) { return s !== seatName; });
                } else {

                    // 승객 수 초과 선택 방지
                    if (selectedSeats.length >= PASS_CNT) {
                        alert("승객 수만큼만 좌석을 선택할 수 있습니다. (" + PASS_CNT + "개)");
                        return;
                    }

                    seat.classList.add("active");
                    selectedSeats.push(seatName);
                }
            }
            showSelectedSeats();
        });
    });

    // 탭 클릭
    document.querySelectorAll(".trip-tab").forEach(function(tab) {
        tab.addEventListener("click", function() {
            changeTrip(tab.dataset.trip);
        });
    });

    nextBtn.addEventListener("click", nextStep);
    bottomNextBtn.addEventListener("click", nextStep);

    function nextStep() {
        const list = IS_ROUND_TRIP ? selectedSeats[currentTrip] : selectedSeats;
        if (list.length < PASS_CNT) {
            alert("좌석을 " + PASS_CNT + "개 선택해야 합니다.");
            return;
        }
        if (IS_ROUND_TRIP && currentTrip === "go") {
            changeTrip("back");
            window.scrollTo(0, 0);
        } else {
            saveSeatToSession();
        }
    }

    function changeTrip(trip) {
        currentTrip = trip;

        // 좌석 영역 표시 전환
        var goArea   = document.getElementById("seat-area-go");
        var backArea = document.getElementById("seat-area-back");
        if (goArea)   goArea.style.display   = (trip === "go")   ? "" : "none";
        if (backArea) backArea.style.display  = (trip === "back") ? "" : "none";

        // 탭 활성화
        document.querySelectorAll(".trip-tab").forEach(function(tab) {
            tab.classList.toggle("active", tab.dataset.trip === trip);
        });

        // 버튼 레이블
        var label = (!IS_ROUND_TRIP || trip === "back") ? "완료" : "다음";
        nextBtn.innerText      = label;
        bottomNextBtn.innerText = label;

        showSelectedSeats();
    }

    function showSelectedSeats() {
        selectedSeatsBox.innerHTML = "";
        const list = IS_ROUND_TRIP ? selectedSeats[currentTrip] : selectedSeats;
        list.forEach(function(seatName) {
            const span = document.createElement("span");
            span.className = "selected-item";
            span.innerHTML = seatName +
                ' <button type="button" onclick="removeSeat(\'' + seatName + '\')">×</button>';
            selectedSeatsBox.appendChild(span);
        });
    }

    function removeSeat(seatName) {
        if (IS_ROUND_TRIP) {
            selectedSeats[currentTrip] = selectedSeats[currentTrip].filter(function(s) { return s !== seatName; });
        } else {
            selectedSeats = selectedSeats.filter(function(s) { return s !== seatName; });
        }
        const area = document.getElementById("seat-area-" + currentTrip);
        const btn  = area ? area.querySelector("[data-seat='" + seatName + "']") : null;
        if (btn) btn.classList.remove("active");
        showSelectedSeats();
    }

    function saveSeatToSession() {
        const form = document.createElement("form");
        form.method = "POST";
        form.action = "<%=request.getContextPath()%>/air/booking/seatSelect";

			function addHidden(name, value) {
				const input = document.createElement("input");
				input.type = "hidden";
				input.name = name;
				input.value = value;
				form.appendChild(input);
			}

			if (IS_ROUND_TRIP) {
				addHidden("goSeats", selectedSeats.go.join(","));
				addHidden("backSeats", selectedSeats.back.join(","));
			} else {
				addHidden("goSeats", selectedSeats.join(","));
			}

			document.body.appendChild(form);
			form.submit();
		}

		changeTrip(currentTrip);
	</script>
</body>
</html>
