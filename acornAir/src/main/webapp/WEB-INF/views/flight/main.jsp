<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
String userId = (String) session.getAttribute("loginUser");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<body>

<h2>메인페이지</h2>

<%
if(userId != null){
%>
    <h3>환영합니다 <%= userId %>님!</h3>
<%
}else{
%>
    <h3>로그인 안된 상태입니다</h3>
<%
}
%>

</body>
</html>