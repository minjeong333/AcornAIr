<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ACORN AIRRES</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/flight/home.css">
</head>

<body>

<header class="top-menu">
  <div class="top-links">
    <a href="${pageContext.request.contextPath}/air/login">
        로그인/가입
    </a>

    <span onclick="loadMyPage()" style="cursor:pointer;">마이페이지</span>
    <div id="mypage-container"></div>
    
</div>

  <nav class="main-nav">
    <div class="logo">
      ✈ <strong>ACORN AIR</strong>
      <span class="circle">S</span>
    </div>

    
   <ul class="nav-menu">
  <li class="nav-item">
    예약
    <div class="mega-menu">
      <div class="mega-col">
        <p><a href="/prj_2조/res">항공권 예매</a></p>
        <p>예약 조회</p>
      </div>
    </div>
  </li>

  <li class="nav-item">
    부가서비스 신청
    <div class="mega-menu">
      <div class="mega-col">
        <p>좌석 배정</p>
        <p>초과 수하물 사전 구매</p>
      </div>
    </div>
  </li>
</ul>

    <div class="search-area">
      <input type="text" placeholder="궁금한 것을 검색해보세요">
      <button>로그인</button>
    </div>
  </nav>
</header>

<div class="container">
  <div class="card">

    <div class="top-alert">
      ⚠ 두바이 공항 운항 제한
    </div>

    <div class="tabs">
  		<span class="active" id="ticketTab">항공권 예매</span>
  		<span id="myTripTab">나의 여행</span>
	</div>

<div id="ticketContent">

  <form action="<%=request.getContextPath()%>/home" method="get" id="flightSearchForm">

    <input type="hidden" name="tripType" id="tripTypeInput" value="RT">
    <input type="hidden" name="depAirport" id="depAirportInput" value="ICN">
    <input type="hidden" name="arrAirport" id="arrAirportInput">
    <input type="hidden" name="depDate" id="depDateInput">
    <input type="hidden" name="passCnt" id="passCntInput" value="1">
    <input type="hidden" name="seatClass" id="seatClassInput" value="Y">
	<input type="hidden" name="tripType" id="tripTypeInput">
	<input type="hidden" name="returnDate" id="returnDateInput">
    <div class="trip-type">
      <button type="button" class="active">왕복</button>
      <button type="button">편도</button>
    </div>


    <div class="form-row">

      <div class="input-box" id="fromBox">
        <strong>ICN</strong>
        <small>서울/모든 공항</small>
      </div>

      <div class="swap">↔</div>

      <div class="input-box" id="toBox">
        <strong>To</strong>
        <small>도착지</small>
      </div>

      <div class="input-box" id="dateBox">
        <strong>출발일</strong>
        <small id="dateText">날짜 선택</small>
      </div>

      <div class="input-box" id="passengerBox">
  		<strong>탑승객</strong>
  		<small id="passengerText">🚶 1  🚶 0  👶 0</small>
	  </div>

      <div class="input-box" id="seatBox">
  		<strong>좌석 등급</strong>
  		<small id="seatText">💺 일반석</small>
	  </div>

      <button class="search-btn">항공 검색</button>
    </div>
    </form>
	</div>
	
	<!-- 나의 여행 -->
	<div class="mytrip-content" id="myTripContent">
  <div class="mytrip-row">

    <div class="mytrip-field">
      <label>예약번호 또는 항공권번호</label>
      <input type="text" placeholder="예) A1B2C3 또는 1801234567890">
    </div>

    <div class="mytrip-field">
      <label>출발일</label>
      <div class="mytrip-date" id="myTripDateBox">
 		 <span id="myTripDateText">날짜 선택</span>
	  </div>
    </div>

    <div class="mytrip-field small">
      <label>성</label>
      <input type="text">
    </div>

    <div class="mytrip-field small">
      <label>이름</label>
      <input type="text">
    </div>

    <button class="mytrip-btn">조회</button>

  </div>
</div>


    <!-- 출발지/도착지 검색 -->
    <div class="airport-search" id="airportSearch">
      <div class="airport-header">
        <strong id="airportTitle">출발지 검색</strong>
        <button id="closeAirport">×</button>
      </div>

      <div class="airport-select-box">
        <input type="text" id="airportInput" placeholder="도시, 공항">
        <span>⌄</span>
      </div>

      <div class="all-area">
        <span>⌖</span>
        <u>모든 지역 보기</u>
      </div>
    </div>

    <!-- 캘린더 -->
    <div class="calendar" id="calendar">
      <div class="calendar-header">
        <strong>출발일</strong>
        <button id="closeCal">×</button>
      </div>

      <div class="calendar-option-row">
        <div class="calendar-trip">
          <button class="active">왕복</button>
          <button>편도</button>
        </div>

        
      </div>

      <div class="month-wrap">
        <button class="month-arrow" id="prevMonth">‹</button>

        <div class="month">
          <h3 id="monthTitle1"></h3>
          <div class="week">
            <span class="sun">일</span><span>월</span><span>화</span><span>수</span><span>목</span><span>금</span><span>토</span>
          </div>
          <div class="days" id="days1"></div>
        </div>

        <div class="month">
          <h3 id="monthTitle2"></h3>
          <div class="week">
            <span class="sun">일</span><span>월</span><span>화</span><span>수</span><span>목</span><span>금</span><span>토</span>
          </div>
          <div class="days" id="days2"></div>
        </div>

        <button class="month-arrow" id="nextMonth">›</button>
      </div>

      <div class="calendar-footer">
        * 키보드 사용 : 화살표 키로 날짜를 이동하고, Enter 키를 눌러 선택할 수 있습니다.
      </div>
    </div>
    
    <!-- 탑승객 -->
    <div class="passenger-panel" id="passengerPanel">
  <div class="passenger-header">
    <strong>승객 선택</strong>
    <button id="closePassenger">×</button>
  </div>

  <div class="passenger-counts">
    <div class="passenger-item">
      <p>성인 <span>?</span></p>
      <div class="count-control">
        <button id="adultMinus">−</button>
        <strong id="adultCount">1</strong>
        <button id="adultPlus">＋</button>
      </div>
    </div>

    <div class="passenger-item">
      <p>소아 <span>?</span></p>
      <div class="count-control">
        <button id="childMinus">−</button>
        <strong id="childCount">0</strong>
        <button id="childPlus">＋</button>
      </div>
    </div>

    <div class="passenger-item">
      <p>유아 <span>?</span></p>
      <div class="count-control">
        <button id="babyMinus">−</button>
        <strong id="babyCount">0</strong>
        <button id="babyPlus">＋</button>
      </div>
    </div>
  </div>

  <div class="age-select">나이계산기 ˅</div>

  <div class="passenger-info">
    <h3>소아/유아 및 만 14세 미만 승객 안내</h3>
    <p>• 소아는 첫번째 항공편 출발일 기준 나이입니다. 유아는 각 항공편별 탑승일 기준 나이입니다.</p>
    <p>• 유아는 생후 7일부터 탑승 가능하며, 좌석을 점유하지 않습니다. 또한 탑승일 기준 만 18세 이상의 보호자가 동반해야 합니다.</p>
    <p>• 유아 좌석 점유를 원하시는 경우, 소아로 예매를 진행하시기 바랍니다.</p>
    <p>• 만 14세 미만 승객은 예매 시 법정대리인의 동의 및 인증이 필요합니다.</p>

    <h3>구매와 동시승급 진행 시 유의사항</h3>
    <p>• 마일리지 공제를 위해 등록된 가족 기준으로 승객선택을 해주시기 바랍니다.</p>
    <p>• 가족 마일리지 합산은 로그인 회원 본인 1인 예매 시에만 가능합니다.</p>
  </div>
</div>


		<!-- 좌석등급 -->
		<div class="seat-panel" id="seatPanel">
  			<div class="seat-header">
    			<strong>좌석 등급 선택</strong>
    			<button id="closeSeat">×</button>
  			</div>

  			<div class="seat-options">
   				 <button class="seat-option active" data-seat="일반석">💺 일반석</button>
    			 <button class="seat-option" data-seat="비즈니스석">💺 비즈니스석</button>
  			</div>
		</div>
  </div>
</div>



<!-- 인기여행지 -->
<section class="popular-section">
  <h2>인기 여행지</h2>
  <p>ACORN AIR와 함께하는 특별한 여행</p>

  <div class="trip-card-wrap">

    <div class="trip-card">
      <div class="trip-img img-newyork">
        <div>
          <h3>뉴욕</h3>
          <span>미국</span>
        </div>
      </div>
      <div class="trip-info">
        <span>왕복 항공권</span>
        <div>
          <small>부터</small>
          <strong>₩950,000</strong>
        </div>
      </div>
    </div>

    <div class="trip-card">
      <div class="trip-img img-sf">
        <div>
          <h3>샌프란시스코</h3>
          <span>미국</span>
        </div>
      </div>
      <div class="trip-info">
        <span>왕복 항공권</span>
        <div>
          <small>부터</small>
          <strong>₩880,000</strong>
        </div>
      </div>
    </div>

    <div class="trip-card">
      <div class="trip-img img-london">
        <div>
          <h3>런던</h3>
          <span>영국</span>
        </div>
      </div>
      <div class="trip-info">
        <span>왕복 항공권</span>
        <div>
          <small>부터</small>
          <strong>₩1,150,000</strong>
        </div>
      </div>
    </div>

    <div class="trip-card">
      <div class="trip-img img-paris">
        <div>
          <h3>파리</h3>
          <span>프랑스</span>
        </div>
      </div>
      <div class="trip-info">
        <span>왕복 항공권</span>
        <div>
          <small>부터</small>
          <strong>₩1,080,000</strong>
        </div>
      </div>
    </div>

  </div>
</section>

<footer class="footer">
  <div class="footer-container">

    <div class="footer-col">
      <h4>회사소개</h4>
      <p>Our Transformation</p>
      <p>대한항공에 대하여</p>
      <p>기업지배구조</p>
      <p>투자정보</p>
      <p>지속가능경영</p>
      <p>뉴스룸</p>
    </div>

    <div class="footer-col">
      <h4>고객지원</h4>
      <p>공지사항</p>
      <p>고객의 말씀</p>
      <p>서비스 센터</p>
      <p>e-서식함</p>
      <p>디지털 접근성</p>
    </div>

    <div class="footer-col">
      <h4>약관 및 규정</h4>
      <p>개인정보 처리방침</p>
      <p>이용 약관</p>
      <p>운송약관 및 고지사항</p>
      <p>소비자 안전 관련 정보</p>
      <p>운임 및 서비스 요금표</p>
      <p>쿠키 설정</p>
    </div>

    <div class="footer-col">
      <h4>기타 안내</h4>
      <p>기업 출장 / 전용기</p>
      <p>고객 안내 서비스</p>
      <p>항공교통이용자 서비스 계획</p>
      <p>항공교통이용자 피해 구제</p>
      <p>관련 사이트</p>
      <p>사이트맵</p>
    </div>

    <div class="footer-col">
      <h4>인기 방문국가</h4>
      <p>미국</p>
      <p>일본</p>
      <p>중국</p>
      <p>캐나다</p>
      <p>태국</p>
    </div>

  </div>
</footer>

<script>
const fromBox = document.getElementById("fromBox");
const toBox = document.getElementById("toBox");

const airportSearch = document.getElementById("airportSearch");
const closeAirport = document.getElementById("closeAirport");
const airportInput = document.getElementById("airportInput");
const airportTitle = document.getElementById("airportTitle");

const dateBox = document.getElementById("dateBox");
const calendar = document.getElementById("calendar");
const closeCal = document.getElementById("closeCal");
const dateText = document.getElementById("dateText");

const passengerBox = document.getElementById("passengerBox");
const passengerPanel = document.getElementById("passengerPanel");
const closePassenger = document.getElementById("closePassenger");
const passengerText = document.getElementById("passengerText");

const adultCount = document.getElementById("adultCount");
const childCount = document.getElementById("childCount");
const babyCount = document.getElementById("babyCount");

const adultMinus = document.getElementById("adultMinus");
const adultPlus = document.getElementById("adultPlus");
const childMinus = document.getElementById("childMinus");
const childPlus = document.getElementById("childPlus");
const babyMinus = document.getElementById("babyMinus");
const babyPlus = document.getElementById("babyPlus");

const seatBox = document.getElementById("seatBox");
const seatPanel = document.getElementById("seatPanel");
const closeSeat = document.getElementById("closeSeat");
const seatText = document.getElementById("seatText");
const seatOptions = document.querySelectorAll(".seat-option");

const ticketTab = document.getElementById("ticketTab");
const myTripTab = document.getElementById("myTripTab");

const ticketContent = document.getElementById("ticketContent");
const myTripContent = document.getElementById("myTripContent");

const myTripDateBox = document.getElementById("myTripDateBox");
const myTripDateText = document.getElementById("myTripDateText");

const outerTripButtons = document.querySelectorAll(".trip-type button");
const calendarTripButtons = document.querySelectorAll(".calendar-trip button");
const calendarTrip = document.querySelector(".calendar-trip");

let currentTarget = null;
let currentDateTarget = "ticket";

let adult = 1;
let child = 0;
let baby = 0;

let tripType = "왕복";

let startDate = null;
let endDate = null;

function closeAllPanels() {
  airportSearch.style.display = "none";
  calendar.style.display = "none";
  passengerPanel.style.display = "none";
  seatPanel.style.display = "none";
}

function updateTripButtons(type) {
  tripType = type;

  outerTripButtons.forEach(function(btn) {
    btn.classList.toggle("active", btn.innerText.trim() === type);
  });

  calendarTripButtons.forEach(function(btn) {
    btn.classList.toggle("active", btn.innerText.trim() === type);
  });

  startDate = null;
  endDate = null;
  clearDateSelection();
}

outerTripButtons.forEach(function(btn) {
  btn.addEventListener("click", function(e) {
    e.stopPropagation();
    updateTripButtons(btn.innerText.trim());
  });
});

calendarTripButtons.forEach(function(btn) {
  btn.addEventListener("click", function(e) {
    e.stopPropagation();
    updateTripButtons(btn.innerText.trim());
  });
});

function openSearch(target, title) {
  closeAllPanels();

  airportSearch.style.display = "block";
  airportInput.value = "";
  airportInput.focus();

  currentTarget = target;
  airportTitle.innerText = title;

  const rect = target.getBoundingClientRect();
  const parentRect = target.closest(".card").getBoundingClientRect();

  airportSearch.style.left = (rect.left - parentRect.left) + "px";
}

fromBox.addEventListener("click", function(e) {
  e.stopPropagation();
  openSearch(fromBox, "출발지 검색");
});

toBox.addEventListener("click", function(e) {
  e.stopPropagation();
  openSearch(toBox, "도착지 검색");
});

closeAirport.addEventListener("click", function(e) {
  e.stopPropagation();
  airportSearch.style.display = "none";
});

airportInput.addEventListener("keydown", function(e) {
  if (e.key === "Enter") {
    const value = airportInput.value.trim();

    if (value !== "" && currentTarget !== null) {
      currentTarget.querySelector("strong").innerText = value.toUpperCase();
      currentTarget.querySelector("small").innerText = "선택됨";

      airportSearch.style.display = "none";
    }
  }
});

dateBox.addEventListener("click", function(e) {
  e.stopPropagation();

  closeAllPanels();
  calendar.style.display = "block";

  calendarTrip.style.display = "flex";
  currentDateTarget = "ticket";
});

myTripDateBox.addEventListener("click", function(e) {
  e.stopPropagation();

  closeAllPanels();
  calendar.style.display = "block";

  calendarTrip.style.display = "none";
  currentDateTarget = "mytrip";
});

closeCal.addEventListener("click", function(e) {
  e.stopPropagation();
  calendar.style.display = "none";
});

ticketTab.addEventListener("click", function() {
  ticketTab.classList.add("active");
  myTripTab.classList.remove("active");

  ticketContent.style.display = "block";
  myTripContent.style.display = "none";

  closeAllPanels();
});

myTripTab.addEventListener("click", function() {
  myTripTab.classList.add("active");
  ticketTab.classList.remove("active");

  ticketContent.style.display = "none";
  myTripContent.style.display = "block";

  closeAllPanels();
});

let today = new Date();
today.setHours(0, 0, 0, 0);

let currentYear = today.getFullYear();
let currentMonth = today.getMonth();

const maxDate = new Date(today.getFullYear() + 1, 4, 31);

function renderCalendar() {
  renderMonth(currentYear, currentMonth, "monthTitle1", "days1");
  renderMonth(currentYear, currentMonth + 1, "monthTitle2", "days2");
}

function renderMonth(year, month, titleId, daysId) {
  const date = new Date(year, month, 1);
  const realYear = date.getFullYear();
  const realMonth = date.getMonth();

  document.getElementById(titleId).innerText =
    realYear + "년 " + (realMonth + 1) + "월";

  const daysBox = document.getElementById(daysId);
  daysBox.innerHTML = "";

  const firstDay = new Date(realYear, realMonth, 1).getDay();
  const lastDate = new Date(realYear, realMonth + 1, 0).getDate();

  for (let i = 0; i < firstDay; i++) {
    daysBox.innerHTML += "<span></span>";
  }

  for (let d = 1; d <= lastDate; d++) {
    const thisDate = new Date(realYear, realMonth, d);
    thisDate.setHours(0, 0, 0, 0);

    let className = "";

    if (thisDate < today || thisDate > maxDate) {
      className += "disabled ";
    }

    if (thisDate.getDay() === 0) {
      className += "sun ";
    }

    const dateValue =
      realYear + "-" +
      String(realMonth + 1).padStart(2, "0") + "-" +
      String(d).padStart(2, "0");

    daysBox.innerHTML +=
      '<span class="' + className + '" data-date="' + dateValue + '">' + d + '</span>';
  }
}

function clearDateSelection() {
  document.querySelectorAll(".days span").forEach(function(el) {
    el.classList.remove("selected", "start", "end", "range");
  });
}

function highlightDateRange() {
  document.querySelectorAll(".days span").forEach(function(el) {
    const d = el.dataset.date;

    if (d > startDate && d < endDate) {
      el.classList.add("range");
    }
  });
}

calendar.addEventListener("click", function(e) {
  if (!e.target.dataset.date) return;

  e.stopPropagation();

  const selected = e.target.dataset.date;

  if (currentDateTarget === "mytrip") {
    clearDateSelection();
    e.target.classList.add("selected");
    myTripDateText.innerText = selected;
    calendar.style.display = "none";
    return;
  }

  if (tripType === "편도") {
    startDate = selected;
    endDate = null;

    clearDateSelection();
    e.target.classList.add("selected");

    dateText.innerText = selected;
    calendar.style.display = "none";
    return;
  }

  if (!startDate || (startDate && endDate)) {
    startDate = selected;
    endDate = null;

    clearDateSelection();
    e.target.classList.add("start");
    return;
  }

  if (startDate && !endDate) {
    if (selected < startDate) {
      startDate = selected;
      endDate = null;

      clearDateSelection();
      e.target.classList.add("start");
      return;
    }

    endDate = selected;

    e.target.classList.add("end");
    highlightDateRange();

    dateText.innerText = startDate + " ~ " + endDate;
    calendar.style.display = "none";
  }
});

document.getElementById("prevMonth").addEventListener("click", function(e) {
  e.stopPropagation();

  const prev = new Date(currentYear, currentMonth - 1, 1);
  const min = new Date(today.getFullYear(), today.getMonth(), 1);

  if (prev >= min) {
    currentMonth--;
    renderCalendar();
  }
});

document.getElementById("nextMonth").addEventListener("click", function(e) {
  e.stopPropagation();

  const next = new Date(currentYear, currentMonth + 2, 1);

  if (next <= maxDate) {
    currentMonth++;
    renderCalendar();
  }
});

function updatePassengerUI() {
  adultCount.innerText = adult;
  childCount.innerText = child;
  babyCount.innerText = baby;

  passengerText.innerText =
    "🚶 " + adult + "  🚶 " + child + "  👶 " + baby;

  adultMinus.disabled = adult <= 1;
  childMinus.disabled = child <= 0;
  babyMinus.disabled = baby <= 0;
}

passengerBox.addEventListener("click", function(e) {
  e.stopPropagation();

  closeAllPanels();

  passengerPanel.style.display = "block";

  const rect = passengerBox.getBoundingClientRect();
  const parentRect = passengerBox.closest(".card").getBoundingClientRect();

  passengerPanel.style.left = (rect.left - parentRect.left - 280) + "px";
});

closePassenger.addEventListener("click", function(e) {
  e.stopPropagation();
  passengerPanel.style.display = "none";
});

adultPlus.addEventListener("click", function(e) {
  e.stopPropagation();
  adult++;
  updatePassengerUI();
});

adultMinus.addEventListener("click", function(e) {
  e.stopPropagation();
  if (adult > 1) adult--;
  updatePassengerUI();
});

childPlus.addEventListener("click", function(e) {
  e.stopPropagation();
  child++;
  updatePassengerUI();
});

childMinus.addEventListener("click", function(e) {
  e.stopPropagation();
  if (child > 0) child--;
  updatePassengerUI();
});

babyPlus.addEventListener("click", function(e) {
  e.stopPropagation();
  baby++;
  updatePassengerUI();
});

babyMinus.addEventListener("click", function(e) {
  e.stopPropagation();
  if (baby > 0) baby--;
  updatePassengerUI();
});

seatBox.addEventListener("click", function(e) {
  e.stopPropagation();

  closeAllPanels();

  seatPanel.style.display = "block";

  const rect = seatBox.getBoundingClientRect();
  const parentRect = seatBox.closest(".card").getBoundingClientRect();

  seatPanel.style.left = (rect.left - parentRect.left - 120) + "px";
});

closeSeat.addEventListener("click", function(e) {
  e.stopPropagation();
  seatPanel.style.display = "none";
});

seatOptions.forEach(function(option) {
  option.addEventListener("click", function(e) {
    e.stopPropagation();

    const seat = option.dataset.seat;

    seatText.innerText = "💺 " + seat;

    seatOptions.forEach(function(btn) {
      btn.classList.remove("active");
    });

    option.classList.add("active");

    seatPanel.style.display = "none";
  });
});

document.addEventListener("click", function() {
  closeAllPanels();
});


const flightSearchForm = document.getElementById("flightSearchForm");

const tripTypeInput = document.getElementById("tripTypeInput");
const depAirportInput = document.getElementById("depAirportInput");
const arrAirportInput = document.getElementById("arrAirportInput");
const depDateInput = document.getElementById("depDateInput");
const passCntInput = document.getElementById("passCntInput");
const seatClassInput = document.getElementById("seatClassInput");

flightSearchForm.addEventListener("submit", function(e) {

  const depAirport = fromBox.querySelector("strong").innerText.trim();
  const arrAirport = toBox.querySelector("strong").innerText.trim();

  if (depAirport === "" || depAirport === "To") {
    alert("출발지를 입력하세요.");
    e.preventDefault();
    return;
  }

  if (arrAirport === "" || arrAirport === "To") {
    alert("도착지를 입력하세요.");
    e.preventDefault();
    return;
  }

  if (!startDate) {
    alert("출발일을 선택하세요.");
    e.preventDefault();
    return;
  }

  tripTypeInput.value = tripType === "왕복" ? "RT" : "OW";
  depAirportInput.value = depAirport;
  arrAirportInput.value = arrAirport;
  depDateInput.value = startDate;
  returnDateInput.value = endDate;
  passCntInput.value = adult + child;

  if (seatText.innerText.includes("일반석")) {
    seatClassInput.value = "Y";
  } else {
    seatClassInput.value = "C";
  }
});



updateTripButtons("왕복");
renderCalendar();
updatePassengerUI();


//mypage ajax관련 코드
/*
 /function loadMyPage() {
    // 1. Context Path
    
    const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 1));
    const url = contextPath + '/air/mypage';

    console.log("요청하는 실제 주소:", url); // 주소가 잘 만들어졌는지 개발자도구(F12) 콘솔에서 확인용

    // 2. 수정된 url로 fetch 요청
    fetch(url)
        .then(response => {
            if (!response.ok) throw new Error('페이지를 찾을 수 없습니다 (404)');
            return response.text();
        })
        .then(html => {
            const container = document.getElementById('mypage-container');
            if (container) {
                container.innerHTML = html;
                openMyPage();
            }
        })
        .catch(error => {
            console.error('마이페이지 로딩 실패:', error);
            alert("서블릿 주소가 맞지 않거나 서버 에러가 발생했습니다.");
        });
}
*/

function loadMyPage() {

    fetch('/acornAir/air/mypage')
        .then(res => res.text())
        .then(data => {

            // 로그인 안 된 경우
            if(data.trim() === "LOGIN_REQUIRED") {

                location.href = '/acornAir/air/login';
                return;
            }

            // 로그인 상태
            document.getElementById('mypage-container').innerHTML = data;

            openMyPage();
        })
        .catch(err => console.log("에러 발생:", err));
}

function openMyPage() {
    const modal = document.getElementById('mypage-modal');
    if(modal) modal.style.display = 'block';
}

function closeMyPage() {
    const modal = document.getElementById('mypage-modal');
    if(modal) {
        modal.style.display = 'none';
        // (선택사항) 닫을 때 HTML을 비워주면 메모리 관리에 좋습니다.
        document.getElementById('mypage-container').innerHTML = '';
    }
}


</script>
</body>
</html>
