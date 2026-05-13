document.addEventListener("DOMContentLoaded", function() {
    console.log("스크립트 통합 실행됨");

    // --- [1] 단계 전환 로직 ---
    const steps = document.querySelectorAll(".step");
    const stepItems = document.querySelectorAll(".step-item");
    let current = 0;

    function showStep(index) {
        steps.forEach(s => s.classList.remove("active"));
        stepItems.forEach(s => s.classList.remove("active"));
        steps[index].classList.add("active");
        stepItems[index].classList.add("active");
    }

   document.querySelectorAll(".next").forEach(btn => {
       btn.onclick = () => {

           // STEP 1 검사
           if (current === 0) {
               const engLastName = document.querySelector("[name='engLastName']");
               const engFirstName = document.querySelector("[name='engFirstName']");
               const korLastName = document.querySelector("[name='korLastName']");
               const korFirstName = document.querySelector("[name='korFirstName']");
               const birthDate = document.querySelector("[name='birthDate']");
               const gender = document.querySelector("[name='gender']:checked");

               if (
                   engLastName.value.trim() === "" ||
                   engFirstName.value.trim() === "" ||
                   korLastName.value.trim() === "" ||
                   korFirstName.value.trim() === "" ||
                   birthDate.value.trim() === "" ||
                   gender === null
               ) {
                   alert("기본 정보를 모두 입력해 주세요.");
                   return;
               }
           }

           // STEP 2 검사
           if (current === 1) {
               const userId = document.querySelector("[name='userId']");
               const userPw = document.querySelector("[name='userPw']");
               const pwConfirm = document.querySelector("#pwConfirm");
               const userPhone = document.querySelector("[name='userPhone']");
               const userEmail = document.querySelector("[name='userEmail']");

               if (
                   userId.value.trim() === "" ||
                   userPw.value.trim() === "" ||
                   pwConfirm.value.trim() === "" ||
                   userPhone.value.trim() === "" ||
                   userEmail.value.trim() === ""
               ) {
                   alert("계정 및 연락처 정보를 모두 입력해 주세요.");
                   return;
               }

               if (userPw.value !== pwConfirm.value) {
                   alert("비밀번호가 일치하지 않습니다.");
                   return;
               }
			   
           }

           if (current < steps.length - 1) {
               current++;
               showStep(current);
           }
       };
   });


    // --- [1.5] 비밀번호 실시간 유효성 검사 ---
    const userPw = document.getElementById("userPw");
    const userIdInput = document.getElementById("userId"); // 아이디 비교용
    const userBirth = document.getElementById("userBirth"); // 생년월일 비교용
    const userPhone = document.getElementById("userPhone"); // 휴대폰 비교용

    if (userPw) {
        userPw.addEventListener("input", function() {
            const pw = this.value;
            const userId = userIdInput ? userIdInput.value : "";
            const birth = userBirth ? userBirth.value.replace(/-/g, "") : "";
            const phone = userPhone ? userPhone.value.replace(/-/g, "") : "";

            // 규칙 1: 영문, 숫자, 특수문자 조합 8~20자
            const reg1 = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+|~={}\[\]:";'<>?,.\/]).{8,20}$/;
            updateRule("rule1", reg1.test(pw));

            // 규칙 2: 1자 이상의 영문자 포함
            const reg2 = /[a-zA-Z]/;
            updateRule("rule2", reg2.test(pw));

            // 규칙 3: 4자리 이상 동일 또는 연속된 문자열 불가
            const hasContinuous = /(\w)\1\1\1/.test(pw) || isContinuous(pw);
            updateRule("rule3", pw.length > 0 && !hasContinuous);

            // 규칙 4: 아이디 포함 여부
            const includesId = userId.length > 3 && pw.includes(userId);
            updateRule("rule4", pw.length > 0 && !includesId);

            // 규칙 5: 생년월일, 휴대폰 번호 포함 여부
            const includesPrivate = (birth.length > 0 && pw.includes(birth)) || (phone.length > 7 && pw.includes(phone.slice(-4)));
            updateRule("rule5", pw.length > 0 && !includesPrivate);
        });
    }

    // 규칙 업데이트 함수
    function updateRule(id, isValid) {
        const el = document.getElementById(id);
        if (el) {
            if (isValid) {
                el.classList.add("is-valid");
                el.classList.remove("invalid"); // 스타일에서 기본 빨간색 처리용
            } else {
                el.classList.remove("is-valid");
                el.classList.add("invalid");
            }
        }
    }

    // 연속된 문자(1234, abcd) 체크 함수
    function isContinuous(pw) {
        for (let i = 0;i < pw.length - 3;i++) {
            const char1 = pw.charCodeAt(i);
            const char2 = pw.charCodeAt(i + 1);
            const char3 = pw.charCodeAt(i + 2);
            const char4 = pw.charCodeAt(i + 3);

            // 오름차순 (1234) 또는 내림차순 (4321) 검사
            if ((char2 === char1 + 1 && char3 === char2 + 1 && char4 === char3 + 1) ||
                (char2 === char1 - 1 && char3 === char2 - 1 && char4 === char3 - 1)) {
                return true;
            }
        }
        return false;
    }

    // --- [2] 아이디 중복확인 ---
   const checkBtn = document.getElementById("checkBtn");

   if (checkBtn) {
       checkBtn.onclick = function() {
           const userId = document.getElementById("userId").value.trim();
           const msg = document.getElementById("idMsg");

           if (userId === "") {
               msg.innerText = "아이디를 입력해주세요.";
               msg.style.color = "red";
               return;
           }

           fetch(contextPath + "/air/checkId?userId=" + encodeURIComponent(userId))
               .then(res => res.text())
               .then(data => {
                   data = data.trim();

                   if (data === "duplicate") {
                       msg.innerText = "이미 사용 중인 아이디입니다.";
                       msg.style.color = "red";
                   } else if (data === "available") {
                       msg.innerText = "사용 가능한 아이디입니다.";
                       msg.style.color = "green";
                   } else {
                       msg.innerText = "중복확인 오류";
                       msg.style.color = "red";
                       console.log("응답값:", data);
                   }
               });
       };
   }
    // --- [3] 약관 동의 로직 (Step 4) ---
    const allAgree = document.getElementById('allAgree');
    // 필수(must-agree)와 선택(opt-agree)을 모두 포함
    const subAgrees = document.querySelectorAll('.must-agree, .opt-agree');

    if (allAgree) {
        // 전체 동의 체크박스 로직
        allAgree.addEventListener('change', function() {
            subAgrees.forEach(cb => {
                cb.checked = allAgree.checked;
            });
        });

        // 개별 체크박스 로직
        subAgrees.forEach(cb => {
            cb.addEventListener('change', function() {
                const allChecked = Array.from(subAgrees).every(item => item.checked);
                allAgree.checked = allChecked;
            });
        });
    }

    // --- [4] 가입완료 버튼 클릭 로직 ---
    const finishBtn = document.getElementById('finishBtn');
    if (finishBtn) {
        finishBtn.onclick = function(e) {
            const mustChecks = document.querySelectorAll('.must-agree');
            let allMustChecked = true;

            mustChecks.forEach(cb => {
                if (!cb.checked) {
                    allMustChecked = false;
                }
            });

            if (!allMustChecked) {
                alert("필수 약관에 모두 동의해 주세요.");
                e.preventDefault(); // 폼 제출 방지
            } else {
                alert("가입이 성공적으로 완료되었습니다!");
                // 폼을 실제 서버로 전송하려면 아래 주석 해제
                // document.getElementById('joinForm').submit(); 
            }
        };
    }
});

// 약관 펼치기 함수 (인라인 onclick 대응을 위해 scope 밖에 배치)
function toggleTerms(boxId, headerEl) {
    const box = document.getElementById(boxId);
    const arrow = headerEl.querySelector('.arrow-btn');

    if (!box) return;

    const isHidden = window.getComputedStyle(box).display === "none";

    if (isHidden) {
        box.style.display = "block";
        if (arrow) arrow.classList.add('active');
    } else {
        box.style.display = "none";
        if (arrow) arrow.classList.remove('active');
    }
}

// webapp/js/script.js 내부
