function toggleChat() {
    var chatWindow = document.getElementById('chat-window');
    var triggerBtn = document.getElementById('chat-trigger-btn');
    if (!chatWindow) return;
    var isHidden = chatWindow.classList.contains('hidden');
    chatWindow.classList.toggle('hidden');
    if (triggerBtn) triggerBtn.style.display = isHidden ? 'none' : 'flex';
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
    appendChatMessage('user', keyword);
    fetch(contextPath + '/air/chat', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
        body: 'keyword=' + encodeURIComponent(keyword)
    })
    .then(function(res) {
        if (!res.ok) throw new Error('오류: ' + res.status);
        return res.text();
    })
    .then(function(data) { appendChatMessage('bot', data); })
    .catch(function() { appendChatMessage('bot', '서버와 연결하는 중 오류가 발생했습니다.'); });
}

function appendChatMessage(sender, text) {
    var chatContent = document.getElementById('chat-content');
    if (!chatContent) return;
    var msgDiv = document.createElement('div');
    msgDiv.innerText = text;
    msgDiv.style.cssText = 'padding:10px 14px;margin:5px 10px;border-radius:12px;max-width:75%;word-break:break-word;font-size:14px;';
    if (sender === 'user') {
        msgDiv.style.backgroundColor = '#00256c';
        msgDiv.style.color = 'white';
        msgDiv.style.marginLeft = 'auto';
        msgDiv.style.marginRight = '10px';
        msgDiv.style.alignSelf = 'flex-end';
    } else {
        msgDiv.style.backgroundColor = '#f0f0f0';
        msgDiv.style.color = '#333';
        msgDiv.style.marginLeft = '10px';
        msgDiv.style.alignSelf = 'flex-start';
    }
    chatContent.appendChild(msgDiv);
    chatContent.scrollTop = chatContent.scrollHeight;
}

function resetChat() {
    var chatContent = document.getElementById('chat-content');
    if (!chatContent) return;
    chatContent.innerHTML =
        '<div class="chat-symbol">S</div>' +
        '<h2 class="ai-title">ACORNAIR 챗봇과 여정을 함께하세요.</h2>' +
        '<div class="guide-grid">' +
            '<div class="grid-item" onclick="sendToBot(\'회원가입안내\')">📝 회원가입안내</div>' +
            '<div class="grid-item" onclick="sendToBot(\'항공권 구매\')">✈️ 항공권 구매</div>' +
            '<div class="grid-item" onclick="sendToBot(\'예약조회\')">📅 예약조회</div>' +
            '<div class="grid-item" onclick="sendToBot(\'수하물규정\')">🛫 수하물규정</div>' +
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
