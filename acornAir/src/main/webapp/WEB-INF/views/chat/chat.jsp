<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="chat-trigger-btn" class="chat-trigger-btn" onclick="toggleChat()">
    <span class="chat-icon">✨</span>
    <span class="chat-text">AI 챗봇</span>
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
            <button type="button" class="new-chat-btn" onclick="resetChat()">📝 새 채팅</button>
        </div>
    </div>

    <div class="chat-content" id="chat-content">
        <div class="ai-logo">
            <div class="symbol">S</div>
        </div>
        <h2 class="ai-title">ACORNAIR 챗봇과 여정을 함께하세요.</h2>
        <div class="guide-grid">
            <div class="grid-item" onclick="sendToBot('회원가입안내')">
                <span class="chat-icon">📝</span><span class="chat-text">회원가입안내</span>
            </div>
            <div class="grid-item" onclick="sendToBot('항공권 구매')">
                <span class="chat-icon">✈️</span><span class="chat-text">항공권 구매</span>
            </div>
            <div class="grid-item" onclick="sendToBot('예약조회')">
                <span class="chat-icon">📅</span><span class="chat-text">예약조회</span>
            </div>
            <div class="grid-item" onclick="sendToBot('수하물규정')">
                <span class="chat-icon">🛫</span><span class="chat-text">수하물규정</span>
            </div>
        </div>
    </div>

    <div class="chat-footer">
        <div class="input-box">
            <textarea id="chat-input" placeholder="궁금한 사항을 입력해 주세요."></textarea>
            <div class="input-info">
                <button type="button" class="send-btn" onclick="handleSendMessage()">↑</button>
            </div>
        </div>
    </div>

</div>
