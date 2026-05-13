<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/login/style.css">

<script>
	const contextPath = "${pageContext.request.contextPath}";
</script>


</head>

<body>
<body>

<% if (request.getAttribute("errorMsg") != null) { %>
<script>
    alert("<%= request.getAttribute("errorMsg") %>");
</script>
<% } %>

	<div class="wrapper">
	<div class="wrapper">
		<div class="sidebar">
			<div class="step-item active">
				<div class="circle">1</div>
				<div>기본 정보</div>
			</div>
			<div class="step-item">
				<div class="circle">2</div>
				<div>계정 및 연락처</div>
			</div>
			<div class="step-item">
				<div class="circle">3</div>
				<div>주소 및 기타 정보</div>
			</div>
			<div class="step-item">
				<div class="circle">4</div>
				<div>약관 동의</div>
			</div>
		</div>
		<form id="joinForm"
			action="${pageContext.request.contextPath}/air/signup" method="post"
			style="flex: 1;">

			<div class="content">

				<!-- STEP 1 -->
				<div class="step active">

					<h2>기본 정보</h2>

					<div class="form-row">

						<input type="text" name="engLastName" placeholder="영문 성">

						<input type="text" name="engFirstName" placeholder="영문 이름">

					</div>

					<div class="form-row">

						<input type="text" name="korLastName" placeholder="한글 성">

						<input type="text" name="korFirstName" placeholder="한글 이름">

					</div>

					<div class="form-group">

						<input type="date" id="userBirth" name="birthDate"
							style="width: 100%; height: 40px;">

					</div>

					<!-- 성별 -->
					<div class="form-group" style="margin-bottom: 15px;">

						<div
							style="display: flex; align-items: center; gap: 20px; height: 40px;">

							<label
								style="display: flex; align-items: center; cursor: pointer; gap: 5px;">

								<input type="radio" name="gender" value="M"
								style="width: auto; margin: 0;"> 남

							</label> <label
								style="display: flex; align-items: center; cursor: pointer; gap: 5px;">

								<input type="radio" name="gender" value="F"
								style="width: auto; margin: 0;"> 여

							</label>

						</div>

					</div>

					<div class="button-area">
						<button type="button" class="blue-btn" onclick="checkStep1()">다음</button>
					</div>

				</div>

				<!-- STEP 2 -->
				<div class="step">

					<h2>계정 및 연락처</h2>

					<p class="step-guide">사용하실 아이디와 비밀번호, 연락처를 입력해 주세요.</p>

					<!-- 아이디 -->
					<div class="form-group">

						<label class="input-label">아이디 *</label>

						<div class="input-row" style="display: flex; gap: 10px;">

							<input type="text" id="userId" name="userId"
								placeholder="6~12자리 영문, 숫자 입력" style="flex: 1; height: 40px;">

							<button type="button" id="checkBtn" class="check-btn">
								중복확인</button>

						</div>

						<small id="idMsg"></small>

					</div>

					<!-- 비밀번호 -->
					<div class="form-row">

						<input type="password" id="userPw" name="userPw"
							placeholder="비밀번호" style="flex: 1;"> <input
							type="password" id="pwConfirm" placeholder="비밀번호 확인"
							style="flex: 1;">

					</div>

					<!-- 비밀번호 규칙 -->
					<div class="password-guide">

						<ul id="pwRulesList">

							<li id="rule1" class="invalid">✓ 영문, 숫자, 특수문자 조합 8자~20자 이내</li>

							<li id="rule2" class="invalid">✓ 1자 이상의 영문자 포함</li>

							<li id="rule3" class="invalid">✓ 4자리 이상 동일 또는 연속된 숫자/문자열 입력
								불가</li>

							<li id="rule4" class="invalid">✓ 아이디 사용 불가</li>

							<li id="rule5" class="invalid">✓ 생년월일, 휴대폰 번호 사용 불가</li>

						</ul>

					</div>

					<!-- 국가번호 + 전화번호 -->
					<div class="form-row" style="display: flex; gap: 10px;">

						<select id="countryCode" name="phoneCountry"
							style="flex: 1; padding: 12px; border: 1px solid #ccc; border-radius: 4px; background-color: #fff;">

							<option value="82" selected>Korea (the Republic of)(82)
							</option>

							<option value="1">United States/Canada (1)</option>

							<option value="81">Japan (81)</option>

							<option value="86">China (86)</option>

							<option value="44">England (44)</option>

							<option value="33">Franch (33)</option>

							<option value="49">German (49)</option>

							<option value="84">Vetinam (84)</option>

							<option value="63">Singapore(63)</option>

							<option value="66">Thailand (66)</option>

							<option value="61">Australia (61)</option>

						</select> <input type="tel" id="userPhone" name="userPhone"
							placeholder="휴대폰 번호 입력 ('-' 제외)"
							style="flex: 2; padding: 12px; border: 1px solid #ccc; border-radius: 4px;">

					</div>

					<!-- 이메일 -->
					<div class="form-row">

						<input type="email" name="userEmail" placeholder="이메일 주소">

						<input type="email" placeholder="이메일 주소 재입력">

					</div>

					<!-- 버튼 -->
					<div class="button-area">

						<button type="button" class="prev">이전</button>

						<button type="button" class="blue-btn" onclick="checkStep2()">다음</button>

					</div>

				</div>

				<!-- STEP 3 -->
				<div class="step">

					<div style="margin-bottom: 25px;">

						<h2 style="margin-bottom: 5px;">주소 및 기타 정보</h2>

						<p style="color: #666; font-size: 14px;">거주 국가/지역을 선택하고 우편물
							수령을 원하신다면 상세 주소를 입력해 주세요.</p>

					</div>

					<div
						style="background: #f8f9fa; border-radius: 12px; padding: 30px; border: 1px solid #eee;">

						<div class="form-row" style="margin-bottom: 25px;">

							<!-- 거주 국가 -->
							<div class="flex-1">

								<label class="input-label"> 거주 국가/지역 <span
									style="color: #ff4d4f;">*</span>
								</label> <select class="styled-select" name="country">

									<option value="KR" selected>Korea (the Republic of)</option>

									<option value="US">United States</option>

									<option value="JP">Japan</option>

									<option value="CN">China</option>

									<option value="VN">Vietnam</option>

									<option value="PH">Philippines</option>

									<option value="TH">Thailand</option>

									<option value="GB">United Kingdom</option>

									<option value="FR">France</option>

									<option value="DE">Germany</option>

									<option value="AU">Australia</option>

									<option value="CA">Canada</option>

									<option value="SG">Singapore</option>

								</select>

							</div>

							<!-- 선호 주소지 -->
							<div class="flex-1">

								<label class="input-label"> 선호 주소지 (선택) </label> <select
									class="styled-select">

									<option value="">선택</option>

									<option value="home">자택</option>

									<option value="office">직장</option>

								</select>

							</div>

						</div>

						<!-- 선호 언어 -->
						<div class="form-group" style="margin-top: 10px;">

							<label class="input-label"> 선호언어 (선택) </label>

							<p class="field-desc" style="margin-bottom: 10px;">대한항공의 다양한
								소식을 가급적 선택하신 선호 언어로 보내드려요.</p>

							<div style="width: 50%;">

								<select class="styled-select">

									<option value="ko">한국어</option>

									<option value="en">English</option>

								</select>

							</div>

						</div>

					</div>

					<!-- 버튼 -->
					<div class="button-area"
						style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 30px;">

						<button type="button" class="prev"
							style="border-radius: 50px; padding: 12px 40px; background: #fff; border: 1px solid #333;">

							이전</button>

						<button type="button" class="blue-btn"
	onclick="goStep(3)"
	style="border-radius: 50px; padding: 12px 40px;">다음</button>

					</div>

				</div>

				<!-- STEP 4 -->
				<div class="step">

					<div style="margin-bottom: 25px;">

						<h2 style="margin-bottom: 5px;">약관 동의</h2>

						<p style="color: #666; font-size: 14px;">약관 및 개인정보 수집 이용에 동의해
							주세요.</p>

					</div>

					<div class="terms-container"
						style="border: 1px solid #e0e0e0; border-radius: 8px; padding: 25px; background: #fff;">

						<!-- 전체 동의 -->
						<div
							style="border-bottom: 2px solid #333; padding-bottom: 15px; margin-bottom: 10px;">

							<div style="display: flex; align-items: center; gap: 10px;">

								<input type="checkbox" id="allAgree"
									style="width: 20px; height: 20px; cursor: pointer;"> <label
									for="allAgree"
									style="font-size: 16px; font-weight: bold; cursor: pointer;">

									필수 및 선택 약관에 모두 동의합니다. </label>

							</div>

						</div>

						<!-- 필수 약관 -->
						<div style="border-bottom: 1px solid #eee; padding: 10px 0;">

							<label style="display: flex; align-items: center; gap: 10px;">

								<input type="checkbox" class="must-agree" name="agreeService"
								value="Y" style="width: 18px; height: 18px;"> [필수] 이용약관

							</label>

						</div>

						<div style="border-bottom: 1px solid #eee; padding: 10px 0;">

							<label style="display: flex; align-items: center; gap: 10px;">

								<input type="checkbox" class="must-agree" name="agreeMileage"
								value="Y" style="width: 18px; height: 18px;"> [필수] 마일리지
								거래 서비스 약관

							</label>

						</div>

						<div style="border-bottom: 1px solid #eee; padding: 10px 0;">

							<label style="display: flex; align-items: center; gap: 10px;">

								<input type="checkbox" class="must-agree" name="agreePrivacy"
								value="Y" style="width: 18px; height: 18px;"> [필수] 개인정보
								수집 및 이용 동의

							</label>

						</div>

						<!-- 선택 약관 -->
						<div style="padding: 15px 0; border-bottom: 1px solid #eee;">

							<div
								style="display: flex; align-items: center; gap: 10px; margin-bottom: 15px;">

								<input type="checkbox" id="optAgree2" class="opt-agree"
									name="agreeMarketing" value="Y"
									style="width: 18px; height: 18px;"> <label
									for="optAgree2"
									style="font-size: 14px; font-weight: bold; cursor: pointer;">

									[선택] 마케팅 광고 활용 및 수신 동의 </label>

							</div>

							<div
								style="background: #fcfcfc; border: 1px solid #eee; padding: 20px; border-radius: 4px;">

								<p style="font-size: 12px; color: #888; margin-bottom: 15px;">

									항공권 할인 프로모션, 신규 취항 소식, 이벤트 정보 등 유용한 정보를 받아보시겠습니까?</p>

								<div
									style="display: flex; align-items: center; gap: 20px; white-space: nowrap;">

									<label
										style="display: flex; align-items: center; gap: 8px; font-size: 13px;">

										<input type="checkbox" name="agreeNewsletter" value="Y">

										뉴스레터

									</label> <label
										style="display: flex; align-items: center; gap: 8px; font-size: 13px;">

										<input type="checkbox" name="agreePromo" value="Y">

										프로모션 정보

									</label> <span style="color: #ddd; margin: 0 5px;">|</span> <label
										style="display: flex; align-items: center; gap: 8px; font-size: 13px;">

										<input type="checkbox" name="agreeEmail" value="Y">

										이메일

									</label> <label
										style="display: flex; align-items: center; gap: 8px; font-size: 13px;">

										<input type="checkbox" name="agreeSms" value="Y"> SMS

									</label>

								</div>

							</div>

						</div>

						<!-- 버튼 -->
						<div class="button-area"
							style="margin-top: 30px; display: flex; justify-content: flex-end; gap: 10px;">

							<button type="button" class="prev"
								style="border-radius: 50px; padding: 12px 40px; background: #fff; border: 1px solid #333;">

								이전</button>

							<!-- 중요 -->
							<button type="submit" id="finishBtn" class="blue-btn"
								form="joinForm" style="border-radius: 50px; padding: 12px 40px;">
								가입완료</button>

						</div>
		
	</div>
</form>
	</div>

	<script>
		// 약관 토글 함수
		function toggleNewTerms(id, el) {
			const content = document.getElementById(id);
			const arrow = el.querySelector('.arrow-icon');

			if (content.style.maxHeight === "0px"
					|| content.style.maxHeight === "") {
				content.style.maxHeight = "500px";
				if (arrow) {
					arrow.style.transform = "rotate(90deg)";
					arrow.style.color = "#0064de";
				}
			} else {
				content.style.maxHeight = "0px";
				if (arrow) {
					arrow.style.transform = "rotate(0deg)";
					arrow.style.color = "#999";
				}
			}
		}

		function goStep(index) {
		    const steps = document.querySelectorAll(".step");
		    const stepItems = document.querySelectorAll(".step-item");

		    steps.forEach(s => s.classList.remove("active"));
		    stepItems.forEach(s => s.classList.remove("active"));

		    steps[index].classList.add("active");
		    stepItems[index].classList.add("active");
		}

		function checkStep1() {
		    const engLastName = document.querySelector("[name='engLastName']").value.trim();
		    const engFirstName = document.querySelector("[name='engFirstName']").value.trim();
		    const korLastName = document.querySelector("[name='korLastName']").value.trim();
		    const korFirstName = document.querySelector("[name='korFirstName']").value.trim();
		    const birthDate = document.querySelector("[name='birthDate']").value.trim();
		    const gender = document.querySelector("[name='gender']:checked");

		    if (
		        engLastName === "" ||
		        engFirstName === "" ||
		        korLastName === "" ||
		        korFirstName === "" ||
		        birthDate === "" ||
		        gender === null
		    ) {
		        alert("기본 정보를 모두 입력해 주세요.");
		        return;
		    }

		    goStep(1);
		}

		function checkStep2() {
		    const userId = document.querySelector("[name='userId']").value.trim();
		    const userPw = document.querySelector("[name='userPw']").value.trim();
		    const pwConfirm = document.querySelector("#pwConfirm").value.trim();
		    const userPhone = document.querySelector("[name='userPhone']").value.trim();
		    const userEmail = document.querySelector("[name='userEmail']").value.trim();

		    if (
		        userId === "" ||
		        userPw === "" ||
		        pwConfirm === "" ||
		        userPhone === "" ||
		        userEmail === ""
		    ) {
		        alert("계정 및 연락처 정보를 모두 입력해 주세요.");
		        return;
		    }

		    if (userPw !== pwConfirm) {
		        alert("비밀번호가 일치하지 않습니다.");
		        return;
		    }

		    goStep(2);
		}
		
		
		
	</script>

	<!-- script.js는 모든 HTML 요소가 로드된 후인 </body> 직전에 위치해야 합니다. -->
	<script src="${pageContext.request.contextPath}/js/login/script.js?v=2"></script>
	
</body>
</html>