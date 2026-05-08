<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/flight/search.css">
<script src="${pageContext.request.contextPath}/js/flight/search.js" defer></script>
</head>
<body>
<header class="top-menu">
	<div class="top-links">
		<span>로그인/가입</span>
	    <span>마이페이지</span>
	</div>
	<nav class="main-nav">
    <div class="logo">✈ <strong>ACORN AIR</strong>
    <span class="circle">S</span>
    </div>
    <ul class="nav-menu">
    	<li class="nav-item"><p>예약</p>
        	<div class="mega-menu">
	        	<div class="mega-col">
	        	<p><a href="/prj_2조/res">항공권 예매</a></p>
	        	<p>예약 조회</p>
	        	</div>
        	</div>
    	</li>
      	<li class="nav-item"><p>부가서비스 신청</p>
	      <div class="mega-menu">
	      <div class="mega-col">
	        <p>좌석 배정</p>
	        <p>초과 수하물 사전 구매</p>
	      </div>
    		</div>
      	</li>
    </ul>
    <div class="search-area">
      <input type="text" placeholder="궁금한 것을 물어보세요">
      <button>로그인</button>
    </div>
  </nav>
</header>

<div class="container">
	<!-- 그라데이션 배경 바 추가 -->
    <div class="search-bg-bar"></div>
    <!-- ★ 1. 출발지/도착지 등이 포함된 검색 박스 -->
    <div class="search-box-container">
        <div class="input-group" id="btnFrom">
            <strong id="txtFrom">서울 (SEL)</strong>
            <small>출발지</small>
        </div>
        <div class="input-group" id="btnTo">
            <strong id="txtTo">도착지</strong>
            <small>도착지</small>
        </div>
        <div class="input-group" id="btnDate">
            <strong id="txtDate">출발일</strong>
            <small>날짜선택</small>            
        </div>
        <div class="input-group" id="btnPassenger">
            <strong id="txtPassenger">성인 0 소인 0 유아 0</strong>
            <small>탑승객</small>  
        </div>
        <div class="input-group" id="btnSeat">
            <strong id="txtSeat">💺 일반석</strong>
            <small>좌석등급</small>            
        </div>
        <button class="search-btn">항공검색</button>
    </div>

    <!-- ★ 2. 검색 시 나타나는 레이어 패널들 -->
    <!-- 도시 검색 패널 -->
    <div class="airport-search" id="panelAirport">
        <div class="panel-header"><strong id="airportTitle">도시 검색</strong><button class="close-btn" onclick="closeAll()">×</button></div>
        <div style="border:2px solid #001b66; border-radius:8px; padding:10px; display:flex;">
            <input type="text" id="airportInput" placeholder="도시 또는 공항명 입력" style="border:none; outline:none; flex:1; font-size:16px;">
        </div>
        <p style="font-size:13px; color:#666; margin-top:15px;">※ 엔터키를 눌러 입력을 완료하세요.</p>
    </div>

    <!-- 캘린더 패널 (간략화) -->
    <div class="calendar" id="panelCalendar">
        <div class="panel-header"><strong>일정 선택</strong><button class="close-btn" onclick="closeAll()">×</button></div>
        <!-- ------------------------------------------------------ -->
        <div style="text-align:center; padding:50px; background:#f9f9f9; border-radius:10px;">
        <div class="calendar-option-row">
        <div class="calendar-trip">
            <button type="button" class="trip-type-btn active" data-type="왕복">왕복</button>
            <button type="button" class="trip-type-btn" data-type="편도">편도</button>
        </div>
    </div>

    <div class="month-wrap">
    <!-- 이전 달 버튼 -->
        <button class="month-arrow" id="prevMonth">‹</button>
	<!-- 첫 번째 달 (예: 4월) -->
        <div class="month">
            <h3 id="monthTitle1"></h3>
            <div class="week">
                <span class="sun">일</span><span>월</span><span>화</span><span>수</span><span>목</span><span>금</span><span>토</span>
            </div>
            <div class="days" id="days1"></div>
        </div>
	<!-- 두 번째 달 (예: 5월) -->
        <div class="month">
            <h3 id="monthTitle2"></h3>
            <div class="week">
                <span class="sun">일</span><span>월</span><span>화</span><span>수</span><span>목</span><span>금</span><span>토</span>
            </div>
            <div class="days" id="days2"></div>
        </div>
	<!-- 다음 달 버튼 -->
        <button class="month-arrow" id="nextMonth">›</button>
    </div>

    <div class="calendar-footer">
        * 키보드 사용 : 화살표 키로 날짜를 이동하고, Enter 키를 눌러 선택할 수 있습니다.
        </div>
    </div>
    <!-- ------------------------------------------------------ -->
        
    </div>

    <!-- 승객 패널 -->
    <div class="passenger-panel" id="panelPassenger">
        <div class="panel-header"><strong>승객</strong><button class="close-btn" onclick="closeAll()">×</button></div>
        <div style="margin-bottom:20px;">
            <!-- 성인 -->
        <div style="margin-bottom:10px;">
            <span style="width:50px; display:inline-block;">성인</span>
            <button onclick="changeCount('adult', -1)">-</button> 
            <strong id="adultCount">1</strong> 
            <button onclick="changeCount('adult', 1)">+</button>
        </div>
        <!-- 소인 -->
        <div style="margin-bottom:10px;">
            <span style="width:50px; display:inline-block;">소인</span>
            <button onclick="changeCount('child', -1)">-</button> 
            <strong id="childCount">0</strong> 
            <button onclick="changeCount('child', 1)">+</button>
        </div>
        <!-- 유아 -->
        <div style="margin-bottom:10px;">
            <span style="width:50px; display:inline-block;">유아</span>
            <button onclick="changeCount('baby', -1)">-</button> 
            <strong id="babyCount">0</strong> 
            <button onclick="changeCount('baby', 1)">+</button>
        </div>
        </div>
        <hr>
        <button style="width:100%; padding:10px; margin-top:10px;" onclick="closeAll()">선택 완료</button>
    </div>
    <!-- 좌석선택 -->
        <div class="seat-panel" id="panelSeat">
        <div class="panel-header">
        <strong>좌석 등급 선택</strong><button class="close-btn" onclick="closeAll()">×</button></div>
		    <div class="seat-options" style="display: flex; flex-direction: column; gap: 10px;">
		        <button class="seat-opt-btn" onclick="selectSeat('일반석')" style="padding: 15px; border: 1px solid #ddd; border-radius: 8px; cursor: pointer; background: white; text-align: left; font-size: 16px;">💺 일반석</button>
		        <button class="seat-opt-btn" onclick="selectSeat('비즈니스석')" style="padding: 15px; border: 1px solid #ddd; border-radius: 8px; cursor: pointer; background: white; text-align: left; font-size: 16px;">✨ 비즈니스석</button>
		    </div>
        <hr>
        <button style="width:100%; padding:10px; margin-top:10px;" onclick="closeAll()">선택 완료</button>
    </div>

    <!-- 3. 비행 정보 리스트 (결과창) -->
    <div class="flight-info">
    <span>오는편</span>
    <span>SYD Sydney/KingsfordSmith</span>
    <span> → </span>
    <span>SEL Seoul/All Airports</span>
  </div>
  <!-- 날짜별 가격 슬라이더-->
<div class="date-slider-wrap">
  <button class="slider-btn prev-btn" onclick="moveSlider(-1)">❮</button>

  <div class="date-slider-viewport">
    <div class="date-slider-track">
      <div class="date-item">15(금)<br>-</div>
      <div class="date-item">16(토)<br>-</div>
      <div class="date-item">17(일)<br>1,046,900</div>
      <div class="date-item">18(월)<br>771,900</div>
      <div class="date-item">19(화)<br>896,900</div>
      <div class="date-item">20(수)<br>771,900</div>
      <div class="date-item">21(목)<br>771,900</div>
      <div class="date-item">22(금)<br>820,000</div>
    </div>
  </div>

  <button class="slider-btn next-btn" onclick="moveSlider(1)">❯</button>
</div>

    <div class="flight-card">
    <div class="time">
      <span> 07:55 SYD </span>
      <span> → 10시간 40분 → </span>
      <span> 17:35 ICN </span>
    </div>

    <div class="price-box" onclick="updateTotalPrice(this)">
      <div class="price">771,900원</div>
      <div class="type">일반석</div>
    </div>

    <div class="price-box premium" onclick="updateTotalPrice(this)">
      <div class="price">1,346,900원</div>
      <div class="type">비즈니스석</div>
    </div>
  </div>

</div>

<div class="bottom-bar">
  <!-- id="totalPriceText" 추가 -->
  <span style="font-size:18px; font-weight:bold;">총액 <span id="totalPriceText">771,900원</span></span>
  <button class="btn-next">다음</button> 
  
</div>
</body>
</html>