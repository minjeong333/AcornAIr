function toggleChat() {
    var chatWindow = document.getElementById('chat-window');
    var triggerBtn = document.getElementById('chat-trigger-btn');

    if (!chatWindow) return;

    var isHidden = chatWindow.classList.contains('hidden');
    chatWindow.classList.toggle('hidden');

    if (triggerBtn) {
        triggerBtn.style.display = isHidden ? 'none' : 'flex';
    }
}

function toggleMenu() {
    var sideMenu = document.getElementById('side-menu');
    var menuOverlay = document.getElementById('menu-overlay');

    if (sideMenu) sideMenu.classList.toggle('active');
    if (menuOverlay) menuOverlay.classList.toggle('active');
}

function handleSendMessage() {
    var textarea = document.getElementById('chat-input');
    if (!textarea) return;

    var message = textarea.value.trim();
    if (message !== '') {
        sendToBot(message);
        textarea.value = '';
    }
}

function sendToBot(keyword) {
    appendMessage('user', keyword);

    fetch(contextPath + '/air/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
        body: 'keyword=' + encodeURIComponent(keyword)
    })
    .then(function(res) {
        if (!res.ok) throw new Error('서버 응답 오류: ' + res.status);
        return res.text();
    })
    .then(function(data) {
        appendMessage('bot', data);
    })
    .catch(function(err) {
        console.error('Error:', err);
        appendMessage('bot', '서버와 연결하는 중 오류가 발생했습니다.');
    });
}

function appendMessage(sender, text) {
    var chatContent = document.getElementById('chat-content');
    if (!chatContent) return;

    var msgDiv = document.createElement('div');
    msgDiv.innerText = text;
    msgDiv.style.padding = '10px 14px';
    msgDiv.style.margin = '5px 10px';
    msgDiv.style.borderRadius = '12px';
    msgDiv.style.maxWidth = '75%';
    msgDiv.style.wordBreak = 'break-word';
    msgDiv.style.fontSize = '14px';

    if (sender === 'user') {
        msgDiv.style.backgroundColor = '#00256c';
        msgDiv.style.color = 'white';
        msgDiv.style.marginLeft = 'auto';
        msgDiv.style.marginRight = '10px';
    } else {
        msgDiv.style.backgroundColor = '#f0f0f0';
        msgDiv.style.color = '#333';
        msgDiv.style.marginLeft = '10px';
        msgDiv.style.marginRight = 'auto';
    }

    chatContent.appendChild(msgDiv);
    chatContent.scrollTop = chatContent.scrollHeight;
}

function resetChat() {
    var chatContent = document.getElementById('chat-content');
    if (!chatContent) return;

    chatContent.innerHTML =
        '<div class="ai-logo"><div class="symbol">S</div></div>' +
        '<h2 class="ai-title">ACORNAIR 챗봇과 여정을 함께하세요.</h2>' +
        '<div class="guide-grid">' +
            '<div class="grid-item" onclick="sendToBot(\'회원가입안내\')">' +
                '<span class="chat-icon">📝</span><span class="chat-text">회원가입안내</span>' +
            '</div>' +
            '<div class="grid-item" onclick="sendToBot(\'항공권 구매\')">' +
                '<span class="chat-icon">✈️</span><span class="chat-text">항공권 구매</span>' +
            '</div>' +
            '<div class="grid-item" onclick="sendToBot(\'예약조회\')">' +
                '<span class="chat-icon">📅</span><span class="chat-text">예약조회</span>' +
            '</div>' +
            '<div class="grid-item" onclick="sendToBot(\'수하물규정\')">' +
                '<span class="chat-icon">🛫</span><span class="chat-text">수하물규정</span>' +
            '</div>' +
        '</div>';

    toggleMenu();
}

document.addEventListener('DOMContentLoaded', function() {
    var textarea = document.getElementById('chat-input');
    if (textarea) {
        textarea.addEventListener('keydown', function(e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                handleSendMessage();
            }
        });
    }
});
