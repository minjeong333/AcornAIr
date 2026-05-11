<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>ACORNAIR 챗봇</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/chat/chat.css">

<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>

<script src="${pageContext.request.contextPath}/js/chat/chat.js" defer></script>

<style>
    .chat-content {
        display: flex;
        flex-direction: column;
        overflow-y: auto;
        height: 400px;
        padding: 20px;
    }

    .hidden {
        display: none !important;
    }
</style>
</head>

<body>

<div id="chat-trigger-btn" class="chat-trigger-btn" onclick="toggleChat()">
    <span class="icon">✨</span>
    <span class="text">AI 챗봇</span>
</div>

<div id="chat-window" class="chat-popup hidden">

    <div class="chat-header">
        <div class="header-left">
            <button type="button" class="icon-btn" onclick="toggleMenu()">☰</button>
        </div>

        <div class="header-right">
            <button type="button" class="icon-btn" onclick="toggleChat()">✕</button>
        </div>
    </div>

    <div id="menu-overlay" class="menu-overlay" onclick="toggleMenu()"></div>

    <div id="side-menu" class="side-menu">
        <div class="side-menu-header">
            <div class="header-brand">✈️ ACORNAIR CHATBOT</div>
            <button type="button" class="back-btn" onclick="toggleMenu()">←</button>
        </div>

        <div class="side-menu-content">
            <button type="button" class="new-chat-btn">📝 새 채팅</button>
        </div>
    </div>

    <div class="chat-content">
        <div class="ai-logo">
            <div class="symbol">S</div>
        </div>

        <h2 class="ai-title">ACORNAIR 챗봇과 여정을 함께하세요.</h2>

        <div class="guide-grid">
            <div class="grid-item">
                <span class="icon">📝</span>
                <span class="text">회원가입안내</span>
            </div>

            <div class="grid-item">
                <span class="icon">✈️</span>
                <span class="text">항공권 구매</span>
            </div>

            <div class="grid-item">
                <span class="icon">📅</span>
                <span class="text">예약조회</span>
            </div>

            <div class="grid-item">
                <span class="icon">🛫</span>
                <span class="text">수하물규정</span>
            </div>
        </div>
    </div>

    <div class="chat-footer">
        <div class="input-box">
            <textarea placeholder="궁금한 사항을 입력해 주세요."></textarea>

            <div class="input-info">
                <button type="button" class="send-btn">↑</button>
            </div>
        </div>
    </div>

</div>

</body>
</html>