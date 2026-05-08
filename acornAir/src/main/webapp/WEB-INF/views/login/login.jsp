<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인 - 대한항공</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/login/login.css">
<script src="${pageContext.request.contextPath}/js/login/script.js"></script>

</head>
<body>
	<div class="login-wrapper">
		<div class="login-container">
			<!-- 왼쪽: 회원가입 안내 섹션 -->
			<div class="info-section">
				<h1>
					아직,<br>Acorn항공 회원이<br>아니세요?
				</h1>
				<p>
					회원으로 가입하시고<br>마일리지 혜택을 누려 보세요.
				</p>
				<!-- 파일명을 register.jsp로 변경합니다 -->
				<!-- webapp/login.jsp 내부 -->
				<button type="button" class="btn-join"
					onclick="location.href='${pageContext.request.contextPath}/air/signup'">
					회원가입</button>
				<div class="info-footer">
					<a href="#">로그인에 어려움이 있나요?</a>
				</div>
			</div>

			<!-- 오른쪽: 로그인 폼 섹션 -->
			<div class="form-section">
				<div class="tab-menu">
					<button class="tab-item active">아이디</button>

				</div>

				<form id="loginForm"
					action="${pageContext.request.contextPath}/air/login" method="post">

					<div class="input-group">

						<label for="userId"> 아이디 * </label> <input type="text" id="userId"
							name="userId" placeholder="아이디" required>

					</div>

					<div class="input-group">

						<label for="userPw"> 비밀번호 * </label> <input type="password"
							id="userPw" name="userPw" placeholder="비밀번호" required>

					</div>

					<div class="form-options">

						<label> <input type="checkbox"> 아이디 저장
						</label>

					</div>

					<button type="submit" class="btn-login">로그인</button>

				</form>


			</div>
		</div>
	</div>
	</div>
</body>
</html>