let currentTarget = ""; // 출발지인지 도착지인지 구분

// 모든 패널 닫기
function closeAll() {
    document.querySelectorAll('.airport-search, .calendar, .passenger-panel, .seat-panel').forEach(el => {
        el.style.display = 'none';
    });
}

// 패널 열기 로직
document.getElementById('btnFrom').addEventListener('click', function(e) {
    e.stopPropagation();
    closeAll();
    currentTarget = "from";
    document.getElementById('airportTitle').innerText = "출발지 검색";
    document.getElementById('panelAirport').style.display = 'block';
    document.getElementById('panelAirport').style.left = "20px";
});

document.getElementById('btnTo').addEventListener('click', function(e) {
    e.stopPropagation();
    closeAll();
    currentTarget = "to";
    document.getElementById('airportTitle').innerText = "도착지 검색";
    document.getElementById('panelAirport').style.display = 'block';
    document.getElementById('panelAirport').style.left = "250px"; // 도착지 버튼 위치쯤으로 이동
});

document.getElementById('btnDate').addEventListener('click', function(e) {
    e.stopPropagation();
    closeAll();
    document.getElementById('panelCalendar').style.display = 'block';
});

document.getElementById('btnPassenger').addEventListener('click', function(e) {
    e.stopPropagation();
    closeAll();
    document.getElementById('panelPassenger').style.display = 'block';
});

document.getElementById('btnSeat').addEventListener('click', function(e) {
    e.stopPropagation();
    closeAll();
    const panel = document.getElementById('panelSeat');
    panel.style.display = 'block';    

});

// 도시 입력 처리 (엔터)
document.getElementById('airportInput').addEventListener('keydown', function(e) {
    if (e.key === 'Enter') {
        const value = this.value;
        if (currentTarget === "from") {
            document.getElementById('txtFrom').innerText = value;
        } else {
            document.getElementById('txtTo').innerText = value;
        }
        this.value = "";
        closeAll();
    }
});

// 승객 카운트
// 초기 데이터 설정
let passengerData = {
    adult: 1,
    child: 0,
    baby: 0
};

let depAirport = serverData.depAirport;
let arrAirport = serverData.arrAirport;
let depDate = serverData.depDate;
let passCnt = serverData.passCnt;

if(depAirport){
  document.getElementById("txtFrom").innerText = depAirport;
}

if(arrAirport){
  document.getElementById("txtTo").innerText = arrAirport;
}

if(depDate){
  document.getElementById("txtDate").innerText = depDate;
}

if(passCnt){
  adult = passCnt;
  document.getElementById("txtPassenger").innerText = "성인 " + passCnt;
}

function changeCount(type, n) {
    // 1. 최소값 설정 (성인은 1명 미만으로 내려가지 않게, 나머지는 0명)
    const minLimit = (type === 'adult') ? 1 : 0;
    
    // 2. 해당 타입의 숫자 변경
    passengerData[type] = Math.max(minLimit, passengerData[type] + n);
    
    // 3. 패널 내부의 숫자(strong 태그) 업데이트
    document.getElementById(type + 'Count').innerText = passengerData[type];
    
    // 4. 상단 검색바의 통합 텍스트 업데이트 (id가 txtPassenger인지 확인하세요!)
    const targetDisplay = document.getElementById('txtPassenger');
    if (targetDisplay) {
        targetDisplay.innerText = `성인 ${passengerData.adult} 소인 ${passengerData.child} 유아 ${passengerData.baby}`;
    }
}

function selectSeat(seatName) {
    const seatDisplay = document.getElementById('txtSeat'); 
    seatDisplay.innerText = seatName;
    
    // 선택된 버튼 스타일 강조 (옵션)
    const buttons = document.querySelectorAll('.seat-opt-btn');
    buttons.forEach(btn => {
        if(btn.innerText.includes(seatName)) {
            btn.style.borderColor = "#001b66";
            btn.style.background = "#f0f4ff";
        } else {
            btn.style.borderColor = "#ddd";
            btn.style.background = "white";
        }
    });

    closeAll(); // 선택 후 패널 닫기
}

// 바탕 클릭 시 닫기
document.addEventListener('click', function(e) {
    if (!e.target.closest('.search-box-container') && !e.target.closest('.airport-search') && !e.target.closest('.passenger-panel')&& !e.target.closest('.seat-panel')) {
        closeAll();
    }
});

// 캘린더 제어 변수
let currentYear = new Date().getFullYear();
let currentMonth = new Date().getMonth();
let tripType = "왕복"; // 기본값
let startDate = null;
let endDate = null;

// 캘린더 초기화 함수 (페이지 로드 시 호출)
function initCalendar() {
    renderCalendar();

    // 왕복/편도 버튼 이벤트 바인딩
    const tripBtns = document.querySelectorAll('.trip-type-btn');
    tripBtns.forEach(btn => {
        btn.addEventListener('click', (e) => {
            tripBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            tripType = btn.getAttribute('data-type');
            
            // 타입 변경 시 선택 초기화
            startDate = null;
            endDate = null;
            renderCalendar();
        });
    });

    // 화살표 이벤트
    document.getElementById("prevMonth").onclick = (e) => {
        e.stopPropagation();
        currentMonth--;
        renderCalendar();
    };
    document.getElementById("nextMonth").onclick = (e) => {
        e.stopPropagation();
        currentMonth++;
        renderCalendar();
    };
}

// 렌더링 함수
function renderCalendar() {
    renderMonth(currentYear, currentMonth, "monthTitle1", "days1");
    renderMonth(currentYear, currentMonth + 1, "monthTitle2", "days2");
    updateSelectionStyles();
}

function renderMonth(year, month, titleId, daysId) {
    const date = new Date(year, month, 1);
    const realYear = date.getFullYear();
    const realMonth = date.getMonth();
    const today = new Date();
    today.setHours(0,0,0,0);

    document.getElementById(titleId).innerText = `${realYear}년 ${realMonth + 1}월`;
    const daysBox = document.getElementById(daysId);
    daysBox.innerHTML = "";

    const firstDay = new Date(realYear, realMonth, 1).getDay();
    const lastDate = new Date(realYear, realMonth + 1, 0).getDate();

    for (let i = 0; i < firstDay; i++) daysBox.innerHTML += "<span></span>";

    for (let d = 1; d <= lastDate; d++) {
        const thisDate = new Date(realYear, realMonth, d);
        const dateStr = `${realYear}-${String(realMonth + 1).padStart(2, '0')}-${String(d).padStart(2, '0')}`;
        
        let className = "";
        if (thisDate < today) className += "disabled ";
        if (thisDate.getDay() === 0) className += "sun ";

        const span = document.createElement("span");
        span.className = className;
        span.innerText = d;
        if (!className.includes("disabled")) {
            span.dataset.date = dateStr;
            span.onclick = (e) => handleDateClick(dateStr);
        }
        daysBox.appendChild(span);
    }
}

// 날짜 클릭 처리
function handleDateClick(dateStr) {
    if (tripType === "편도") {
        startDate = dateStr;
        endDate = null;
        finishSelection();
    } else {
        if (!startDate || (startDate && endDate)) {
            startDate = dateStr;
            endDate = null;
        } else if (dateStr < startDate) {
            startDate = dateStr;
        } else {
            endDate = dateStr;
            finishSelection();
        }
    }
    renderCalendar();
}

// 선택 완료 시 처리
function finishSelection() {
    const displayTarget = document.getElementById("txtDate"); // 날짜 텍스트가 표시될 곳
    if (displayTarget) {
        displayTarget.innerText = endDate ? `${startDate} ~ ${endDate}` : startDate;
    }
    // 일정 시간 후 자동으로 닫고 싶다면 closeAll() 호출
    // setTimeout(closeAll, 500); 
}

// 스타일 업데이트 (선택된 날짜 표시)
function updateSelectionStyles() {
    document.querySelectorAll(".days span[data-date]").forEach(span => {
        const d = span.dataset.date;
        span.classList.remove("selected", "start", "end", "range");
        
        if (d === startDate) span.classList.add("start");
        if (d === endDate) span.classList.add("end");
        if (d > startDate && d < endDate) span.classList.add("range");
    });
}

// 페이지 로드 시 실행
window.onload = initCalendar;

let currentIdx = 0;
const track = document.querySelector('.date-slider-track');
const items = document.querySelectorAll('.date-item');
const displayCount = 5; // 한 화면에 보여질 개수
const maxIdx = items.length - displayCount; // 이동 가능한 최대 인덱스

function moveSlider(direction) {
  currentIdx += direction;

  // 인덱스 범위 고정 (처음과 끝 제한)
  if (currentIdx < 0) currentIdx = 0;
  if (currentIdx > maxIdx) currentIdx = maxIdx;

  // 한 칸의 너비(%)만큼 이동
  const movePercentage = -(currentIdx * (100 / displayCount));
  track.style.transform = `translateX(${movePercentage}%)`;
}

// price-box 부분

function selectPrice(element, price){

    let totalPrice = price;

    // 오는편이면
    if(pageMode === "return"){

        const goPrice =
            Number(sessionStorage.getItem("goPrice"));

        totalPrice = goPrice + price;
    }

    document.getElementById("totalPriceText").innerText =
        totalPrice.toLocaleString() + "원";

    document.querySelectorAll(".price-box").forEach(box => {
        box.style.border = "1px solid #e0e0e0";
        box.style.backgroundColor = "white";
    });

    element.style.border = "2px solid #001b66";
    element.style.backgroundColor = "#f8faff";
}
 
let selectedGoFlight = null;
let selectedSeatClass = null;
let selectedGoPrice = 0;

function selectFlight(flightId, seatClass, price) {
    selectedGoFlight = flightId;
    selectedSeatClass = seatClass;
    selectedGoPrice = price;
}

function selectPrice(element, price) {

    let totalPrice = price;

    // 오는편 화면이면 가는편 금액 + 오는편 금액
    if (typeof pageMode !== "undefined" && pageMode === "return") {
        const goPrice = Number(sessionStorage.getItem("goPrice") || 0);
        totalPrice = goPrice + price;
    }

    document.getElementById("totalPriceText").innerText =
        totalPrice.toLocaleString() + "원";

    document.querySelectorAll(".price-box").forEach(box => {
        box.style.border = "1px solid #e0e0e0";
        box.style.backgroundColor = "white";
    });

    element.style.border = "2px solid #001b66";
    element.style.backgroundColor = "#f8faff";
}

function goNext() {

    if (selectedGoFlight == null) {
        alert("항공편을 선택하세요.");
        return;
    }

    // 가는편 가격 저장
    sessionStorage.setItem("goPrice", selectedGoPrice);

    location.href =
        contextPath + "/booking?goFlightId=" +
        selectedGoFlight +
        "&seatClass=" +
        selectedSeatClass;
}

// 오는편 화면 들어오자마자 가는편 가격 먼저 표시
window.addEventListener("load", function () {

    if (typeof pageMode !== "undefined" && pageMode === "return") {

        const goPrice = Number(sessionStorage.getItem("goPrice") || 0);

        if (goPrice > 0) {
            document.getElementById("totalPriceText").innerText =
                goPrice.toLocaleString() + "원";
        }
    }
});

window.addEventListener("DOMContentLoaded", function () {

  const form = document.getElementById("searchForm");

  if (!form) return;

  form.addEventListener("submit", function(e) {

    const dep = document.getElementById("txtFrom").innerText.trim();
    const arr = document.getElementById("txtTo").innerText.trim();
    const date = document.getElementById("txtDate").innerText.trim();

    if(dep === "출발지" || dep === ""){
      alert("출발지를 입력하세요");
      e.preventDefault();
      return;
    }

    if(arr === "도착지" || arr === ""){
      alert("도착지를 입력하세요");
      e.preventDefault();
      return;
    }

    if(date === "출발일" || date === ""){
      alert("날짜를 선택하세요");
      e.preventDefault();
      return;
    }

    document.getElementById("depAirportInput").value = dep;
    document.getElementById("arrAirportInput").value = arr;
    document.getElementById("depDateInput").value = date;

    document.getElementById("passCntInput").value =
      passengerData.adult + passengerData.child;

    document.getElementById("tripTypeInput").value =
      tripType === "왕복" ? "RT" : "OW";

  });

});
