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
<script src="${pageContext.request.contextPath}/js/login/script.js"></script>

</head>

<body>
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

		<div class="content">
			<!-- STEP 1 -->
			<div class="step active">
				<h2>기본 정보</h2>
				<div class="form-row">
					<input type="text" placeholder="영문 성"> <input type="text"
						placeholder="영문 이름">
				</div>
				<div class="form-row">
					<input type="text" placeholder="한글 성"> <input type="text"
						placeholder="한글 이름">
				</div>
				<div class="form-group">
					<input type="date" id="userBirth"
						style="width: 100%; height: 40px;">
				</div>
				<!-- STEP 1 내 성별 선택 부분 수정 -->
				<div class="form-group" style="margin-bottom: 15px;">
					<div
						style="display: flex; align-items: center; gap: 20px; height: 40px;">
						<label
							style="display: flex; align-items: center; cursor: pointer; gap: 5px;">
							<input type="radio" name="g" style="width: auto; margin: 0;">
							남
						</label> <label
							style="display: flex; align-items: center; cursor: pointer; gap: 5px;">
							<input type="radio" name="g" style="width: auto; margin: 0;">
							여
						</label>
					</div>
				</div>
				<div class="button-area">
					<button type="button" class="next blue-btn">다음</button>
				</div>
			</div>

			<!-- STEP 2 -->
			<div class="step">
				<h2>계정 및 연락처</h2>
				<p class="step-guide">사용하실 아이디와 비밀번호, 연락처를 입력해 주세요.</p>
				<div class="form-group">
					<label class="input-label">아이디 *</label>
					<div class="input-row" style="display: flex; gap: 10px;">
						<input type="text" id="userId" placeholder="6~12자리 영문, 숫자 입력"
							style="flex: 1; height: 40px;">
						<button type="button" id="checkBtn" class="check-btn">중복확인</button>
					</div>
					<small id="idMsg"></small>
				</div>
				<!-- STEP 2 내 비밀번호 입력 부분 -->
				<div class="form-row">
					<!-- id="userPw" 확인 -->
					<input type="password" id="userPw" placeholder="비밀번호"
						style="flex: 1;"> <input type="password" id="pwConfirm"
						placeholder="비밀번호 확인" style="flex: 1;">
				</div>

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
				<div class="form-row" style="display: flex; gap: 10px;">
					<!-- 국가 코드 선택 드롭다운 -->
					<select id="countryCode" name="countryCode"
						style="flex: 1; padding: 12px; border: 1px solid #ccc; border-radius: 4px; background-color: #fff;">
						<option value="82" selected>Korea (the Republic of)(82)</option>
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
					</select>

					<!-- 전화번호 입력창 -->
					<input type="tel" id="userPhone" name="userPhone"
						placeholder="휴대폰 번호 입력 ('-' 제외)"
						style="flex: 2; padding: 12px; border: 1px solid #ccc; border-radius: 4px;">
				</div>
				<div class="form-row">
					<input type="email" placeholder="이메일 주소"> <input
						type="email" placeholder="이메일 주소 재입력">
				</div>
				<div class="button-area">
					<button type="button" class="prev">이전</button>
					<button type="button" class="next blue-btn">다음</button>
				</div>
			</div>

			<!-- STEP 3 -->
			<div class="step">
				<div style="margin-bottom: 25px;">
					<h2 style="margin-bottom: 5px;">주소 및 기타 정보</h2>
					<p style="color: #666; font-size: 14px;">거주 국가/지역을 선택하고 우편물 수령을
						원하신다면 상세 주소를 입력해 주세요.</p>
				</div>

				<div
					style="background: #f8f9fa; border-radius: 12px; padding: 30px; border: 1px solid #eee;">
					<div class="form-row" style="margin-bottom: 25px;">
						<!-- STEP 3 거주 국가 선택 부분 -->
						<div class="flex-1">
							<label class="input-label">거주 국가/지역 <span
								style="color: #ff4d4f;">*</span></label> <select class="styled-select"
								name="residentCountry">
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
						<div class="flex-1">
							<label class="input-label">선호 주소지 (선택)</label> <select
								class="styled-select">
								<option value="">선택</option>
								<option value="home">자택</option>
								<option value="office">직장</option>
							</select>
						</div>
					</div>

					<div class="form-group" style="margin-top: 10px;">
						<label class="input-label">선호언어 (선택)</label>
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

				<div class="button-area"
					style="display: flex; justify-content: flex-end; gap: 10px; margin-top: 30px;">
					<button type="button" class="prev"
						style="border-radius: 50px; padding: 12px 40px; background: #fff; border: 1px solid #333;">이전</button>
					<button type="button" class="next blue-btn"
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
								style="font-size: 16px; font-weight: bold; cursor: pointer;">필수
								및 선택 약관에 모두 동의합니다.</label>
						</div>
					</div>

					<!-- [필수] 이용약관 -->
					<div style="border-bottom: 1px solid #eee; padding: 10px 0;">
						<div
							style="display: flex; justify-content: space-between; align-items: center; cursor: pointer;"
							onclick="toggleNewTerms('box1', this)">
							<div style="display: flex; align-items: center; gap: 10px;">
								<input type="checkbox" class="must-agree" id="check_box1"
									onclick="event.stopPropagation()"
									style="width: 18px; height: 18px;"> <label
									for="check_box1"
									style="font-size: 14px; font-weight: bold; cursor: pointer;"
									onclick="event.stopPropagation()">[필수] 이용약관</label>
							</div>
							<span class="arrow-icon"
								style="font-size: 18px; color: #999; transition: 0.3s;">〉</span>
						</div>
						<div id="box1"
							style="max-height: 0; overflow: hidden; transition: max-height 0.3s ease-out; background: #f9f9f9; margin-top: 5px;">
							<div
								style="padding: 15px; font-size: 13px; color: #666; line-height: 1.6; border: 1px solid #ddd; white-space: pre-line;">
								제 1 조 (목적) 본 약관은 회사가 제공하는 항공 예약 및 회원 서비스(이하 "서비스")를 이용함에 있어 회사와
								이용자의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다. 제 2 조 (용어의 정의) 1. "회원"이란 회사에
								개인정보를 제공하여 회원등록을 한 자로서, 회사의 정보를 지속적으로 제공받으며 서비스를 계속적으로 이용할 수 있는
								자를 말합니다. 2. "아이디(ID)"란 회원 식별과 서비스 이용을 위하여 회원이 선정하고 회사가 승인하는 문자와
								숫자의 조합을 의미합니다. 제 3 조 (약관의 효력 및 변경) 본 약관은 서비스 화면에 게시함으로써 효력이
								발생하며, 회사는 합리적인 사유가 발생할 경우 관련 법령을 위배하지 않는 범위 안에서 약관을 개정할 수 있습니다.
							</div>
						</div>
					</div>

					<!-- [필수] 마일리지 거래 서비스 약관 -->
					<div style="border-bottom: 1px solid #eee; padding: 10px 0;">
						<div
							style="display: flex; justify-content: space-between; align-items: center; cursor: pointer;"
							onclick="toggleNewTerms('box2', this)">
							<div style="display: flex; align-items: center; gap: 10px;">
								<input type="checkbox" class="must-agree" id="check_box2"
									onclick="event.stopPropagation()"
									style="width: 18px; height: 18px;"> <label
									for="check_box2"
									style="font-size: 14px; font-weight: bold; cursor: pointer;"
									onclick="event.stopPropagation()">[필수] 마일리지 거래 서비스 약관</label>
							</div>
							<span class="arrow-icon"
								style="font-size: 18px; color: #999; transition: 0.3s;">〉</span>
						</div>
						<div id="box2"
							style="max-height: 0; overflow: hidden; transition: max-height 0.3s ease-out; background: #f9f9f9; margin-top: 5px;">
							<div
								style="padding: 15px; font-size: 13px; color: #666; line-height: 1.6; border: 1px solid #ddd; white-space: pre-line;">
								[마일리지 적립 및 사용 규정] 1. 마일리지는 회원이 유료 항공권을 구매하거나 제휴사 서비스를 이용할 경우 정해진
								기준에 따라 적립됩니다. 2. 적립된 마일리지는 항공권 보너스 발급, 좌석 승급 및 기타 제휴 서비스 이용 시
								사용할 수 있습니다. 3. 마일리지의 유효기간은 적립일로부터 10년이며, 기간 내 사용하지 않은 마일리지는 해당
								기간 종료 시점에 자동 소멸됩니다. 4. 마일리지는 타인에게 양도하거나 매매할 수 없으며, 부정한 방법으로 획득 시
								회사는 이를 환수하거나 회원 자격을 정지할 수 있습니다.</div>
						</div>
					</div>

					<!-- [필수] 개인정보 수집 및 이용 동의 -->
					<div style="border-bottom: 1px solid #eee; padding: 10px 0;">
						<div
							style="display: flex; justify-content: space-between; align-items: center; cursor: pointer;"
							onclick="toggleNewTerms('box3', this)">
							<div style="display: flex; align-items: center; gap: 10px;">
								<input type="checkbox" class="must-agree" id="check_box3"
									onclick="event.stopPropagation()"
									style="width: 18px; height: 18px;"> <label
									for="check_box3"
									style="font-size: 14px; font-weight: bold; cursor: pointer;"
									onclick="event.stopPropagation()">[필수] 개인정보 수집 및 이용 동의</label>
							</div>
							<span class="arrow-icon"
								style="font-size: 18px; color: #999; transition: 0.3s;">〉</span>
						</div>
						<div id="box3"
							style="max-height: 0; overflow: hidden; transition: max-height 0.3s ease-out; background: #f9f9f9; margin-top: 5px;">
							<div
								style="padding: 15px; font-size: 13px; color: #666; line-height: 1.6; border: 1px solid #ddd; white-space: pre-line;">
								1. 수집하는 개인정보 항목: 성명(국문/영문), 생년월일, 성별, 아이디, 비밀번호, 휴대전화번호, 이메일 주소,
								거주 국가. 2. 개인정보의 수집 및 이용 목적: 서비스 이용에 따른 본인 식별, 예약 확인 및 안내, 회원
								공지사항 전달, 부정 이용 방지. 3. 개인정보의 보유 및 이용 기간: 회원 탈퇴 시까지 보유하며, 관계 법령에
								따라 보존할 필요가 있는 경우 해당 기간 동안 보존합니다. * 귀하는 개인정보 수집에 동의하지 않을 권리가 있으나,
								동의 거부 시 회원가입 및 서비스 이용이 제한될 수 있습니다.</div>
						</div>
					</div>

					<!-- [선택] 마케팅 광고 활용 및 수신 동의 -->
					<!-- [선택] 마케팅 광고 활용 및 수신 동의 (수정본) -->
					<div style="padding: 15px 0; border-bottom: 1px solid #eee;">
						<div
							style="display: flex; align-items: center; gap: 10px; margin-bottom: 15px;">
							<input type="checkbox" id="optAgree2" class="opt-agree"
								style="width: 18px; height: 18px;"> <label
								for="optAgree2"
								style="font-size: 14px; font-weight: bold; cursor: pointer;">[선택]
								마케팅 광고 활용 및 수신 동의</label>
						</div>

						<!-- 화살표 없이 처음부터 노출되는 박스 -->
						<div
							style="background: #fcfcfc; border: 1px solid #eee; padding: 20px; border-radius: 4px;">
							<p style="font-size: 12px; color: #888; margin-bottom: 15px;">항공권
								할인 프로모션, 신규 취항 소식, 이벤트 정보 등 유용한 정보를 받아보시겠습니까?</p>

							<!-- 글자가 가로로 일렬로 배치되도록 하는 핵심 영역 -->
							<div
								style="display: flex; align-items: center; gap: 20px; white-space: nowrap;">
								<label
									style="display: flex; align-items: center; gap: 8px; font-size: 13px; cursor: pointer;">
									<input type="checkbox" class="opt-agree"> 뉴스레터
								</label> <label
									style="display: flex; align-items: center; gap: 8px; font-size: 13px; cursor: pointer;">
									<input type="checkbox" class="opt-agree"> 프로모션 정보
								</label> <span style="color: #ddd; margin: 0 5px;">|</span> <label
									style="display: flex; align-items: center; gap: 8px; font-size: 13px; cursor: pointer;">
									<input type="checkbox" class="opt-agree"> 이메일
								</label> <label
									style="display: flex; align-items: center; gap: 8px; font-size: 13px; cursor: pointer;">
									<input type="checkbox" class="opt-agree"> SMS
								</label>
							</div>


						</div>

						<!-- STEP 4 하단 부분 (수정본) -->
						<div class="button-area"
							style="margin-top: 30px; display: flex; justify-content: flex-end; gap: 10px;">
							<!-- 이전 버튼: 클래스에 prev가 있는지 확인 -->
							<button type="button" class="prev"
								style="border-radius: 50px; padding: 12px 40px; background: #fff; border: 1px solid #333;">이전</button>

							<!-- 가입완료 버튼: id="finishBtn" 확인 -->
							<button type="button" id="finishBtn" class="blue-btn"
								style="border-radius: 50px; padding: 12px 40px;">가입완료</button>
						</div>

						<!-- 닫는 태그들이 잘 닫혀 있는지 확인 (매우 중요) -->
					</div>
					<!-- content 끝 -->
				</div>
				<!-- wrapper 끝 -->

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
				</script>

				<!-- script.js는 모든 HTML 요소가 로드된 후인 </body> 직전에 위치해야 합니다. -->
				<script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>