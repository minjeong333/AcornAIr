<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String tripType = (String) session.getAttribute("tripType");
    String seatClass = (String) session.getAttribute("seatClass");

    if (tripType == null) tripType = "OW";
    if (seatClass == null) seatClass = "Y";

    boolean isRoundTrip = tripType.equals("RT");
    boolean isBusiness  = seatClass.equals("C");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 배정</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/booking/seatSelect.css">
</head>
<body>

    <button type="button" class="back-btn" onclick="window.parent.closeSeatModal ? window.parent.closeSeatModal() : history.back()">&#8592; 돌아가기</button>

    <div class="flight-wrap">
        <div class="trip-tabs">
            <% if (isRoundTrip) { %>
                <button type="button" class="trip-tab active" data-trip="go">✈ 가는편</button>
                <button type="button" class="trip-tab" data-trip="back">✈ 오는편</button>
            <% } else { %>
                <button type="button" class="trip-tab active" data-trip="go">✈ 좌석 선택</button>
            <% } %>
        </div>
        <div class="flight-line"></div>
    </div>

    <div class="wrap">
        <div class="seat-area <%= isBusiness ? "business-area" : "" %>">

            <% if (isBusiness) { %>
                <div class="seat-header business">
                    <span></span> <span>A</span> <span></span>
                    <span>B</span><span>C</span> <span></span>
                    <span>D</span> <span></span>
                </div>
                <% for (int i = 1; i <= 5; i++) { %>
                <div class="seat-row business">
                    <span class="row-num"><%=i%></span>
                    <button class="seat business-seat" data-seat="<%=i + "A"%>"><%=i%>A</button>
                    <div class="business-aisle"></div>
                    <button class="seat business-seat" data-seat="<%=i + "B"%>"><%=i%>B</button>
                    <button class="seat business-seat" data-seat="<%=i + "C"%>"><%=i%>C</button>
                    <div class="business-aisle"></div>
                    <button class="seat business-seat" data-seat="<%=i + "D"%>"><%=i%>D</button>
                    <span class="row-num"><%=i%></span>
                </div>
                <% } %>

            <% } else { %>
                <div class="seat-header">
                    <span></span>
                    <span>A</span><span>B</span><span>C</span>
                    <span></span>
                    <span>D</span><span>E</span><span>F</span>
                    <span></span>
                </div>
                <%
                String[] cols = {"A", "B", "C", "D", "E", "F"};
                for (int i = 1; i <= 33; i++) {
                %>
                <div class="seat-row">
                    <span class="row-num"><%=i%></span>
                    <% for (int j = 0; j < cols.length; j++) {
                        if (j == 3) { %>
                        <div class="aisle"></div>
                    <% } %>
                    <button class="seat" data-seat="<%=i + cols[j]%>"><%=cols[j]%></button>
                    <% } %>
                    <span class="row-num"><%=i%></span>
                </div>
                <% } %>
            <% } %>
        </div>

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
        <div><span class="legend-box possible"></span>선택 가능</div>
        <div><span class="legend-box selected"></span>선택한 좌석</div>
        <div><span class="legend-box disabled"></span>선택 불가</div>
    </div>
    <button type="button" class="bottom-next-btn" id="bottomNextBtn">다음</button>

<script>
    const IS_ROUND_TRIP = <%= isRoundTrip %>;

    const seats            = document.querySelectorAll(".seat");
    const selectedSeatsBox = document.getElementById("selectedSeats");
    const tripTabs         = document.querySelectorAll(".trip-tab");
    const nextBtn          = document.getElementById("nextBtn");
    const bottomNextBtn    = document.getElementById("bottomNextBtn");

    let currentTrip = "go";
    let selectedSeats = IS_ROUND_TRIP ? { go: [], back: [] } : [];

    seats.forEach(function(seat) {
        seat.addEventListener("click", function() {
            const seatName = seat.dataset.seat;
            const list = IS_ROUND_TRIP ? selectedSeats[currentTrip] : selectedSeats;

            if (seat.classList.contains("active")) {
                seat.classList.remove("active");
                if (IS_ROUND_TRIP) {
                    selectedSeats[currentTrip] = list.filter(function(s) { return s !== seatName; });
                } else {
                    selectedSeats = selectedSeats.filter(function(s) { return s !== seatName; });
                }
            } else {
                seat.classList.add("active");
                list.push(seatName);
            }
            showSelectedSeats();
        });
    });

    tripTabs.forEach(function(tab) {
        tab.addEventListener("click", function() {
            currentTrip = tab.dataset.trip;
            changeTrip(currentTrip);
        });
    });

    nextBtn.addEventListener("click", nextStep);
    bottomNextBtn.addEventListener("click", nextStep);

    function nextStep() {
        const list = IS_ROUND_TRIP ? selectedSeats[currentTrip] : selectedSeats;

        if (list.length === 0) {
            alert("좌석을 선택해주세요.");
            return;
        }

        if (IS_ROUND_TRIP && currentTrip === "go") {
            currentTrip = "back";
            changeTrip("back");
            window.scrollTo(0, 0);
        } else {
            saveSeatToSession();
        }
    }

    function changeTrip(trip) {
        tripTabs.forEach(function(tab) {
            tab.classList.toggle("active", tab.dataset.trip === trip);
        });

        seats.forEach(function(seat) {
            const inList = IS_ROUND_TRIP
                ? selectedSeats[trip].includes(seat.dataset.seat)
                : selectedSeats.includes(seat.dataset.seat);
            seat.classList.toggle("active", inList);
        });

        const label = (!IS_ROUND_TRIP || trip === "back") ? "완료" : "다음";
        nextBtn.innerText = label;
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
        const btn = document.querySelector("[data-seat='" + seatName + "']");
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
            addHidden("goSeats",   selectedSeats.go.join(","));
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
