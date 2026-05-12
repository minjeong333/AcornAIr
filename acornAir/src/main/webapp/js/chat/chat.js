document.addEventListener('DOMContentLoaded', function () {
    const gridItems = document.querySelectorAll('.grid-item');
    const sendBtn = document.querySelector('.send-btn');
    const textarea = document.querySelector('.input-box textarea');
    const newChatBtn = document.querySelector('.new-chat-btn');

    gridItems.forEach(function (item) {
        item.addEventListener('click', function () {
            const keyword = this.querySelector('.text').innerText.trim();
            sendToBot(keyword);
        });
    });

    if (sendBtn) {
        sendBtn.addEventListener('click', function () {
            handleSendMessage();
        });
    }

    if (textarea) {
        textarea.addEventListener('keydown', function (e) {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                handleSendMessage();
            }
        });
    }

    if (newChatBtn) {
        newChatBtn.addEventListener('click', function () {
            const chatContent = document.querySelector('.chat-content');
            if (chatContent) {
                chatContent.innerHTML = `
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
                `;

                document.querySelectorAll('.grid-item').forEach(function (item) {
                    item.addEventListener('click', function () {
                        const keyword = this.querySelector('.text').innerText.trim();
                        sendToBot(keyword);
                    });
                });
            }
        });
    }

    function handleSendMessage() {
        if (!textarea) return;

        const message = textarea.value.trim();

        if (message !== "") {
            sendToBot(message);
            textarea.value = "";
        }
    }
});

function sendToBot(keyword) {
    appendMessage('user', keyword);

    fetch(contextPath + '/air/chat', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
        },
        body: 'keyword=' + encodeURIComponent(keyword)
    })
        .then(function (res) {
            if (!res.ok) {
                throw new Error('서버 응답 오류: ' + res.status);
            }
            return res.text();
        })
        .then(function (data) {
            appendMessage('bot', data);
        })
        .catch(function (err) {
            console.error('Error:', err);
            appendMessage('bot', '서버와 연결하는 중 오류가 발생했습니다.');
        });
}

function appendMessage(sender, text) {
    const chatContent = document.querySelector('.chat-content');

    if (!chatContent) return;
	
    const msgDiv = document.createElement('div');

	// innertxt -> innerHTML contextPath추가	
	if (sender === 'bot') {
	        const fixedText = text.replace(/href="\//g, 'href="' + contextPath + '/');
	        msgDiv.innerHTML = fixedText; 
	    } else {
	        msgDiv.innerText = text;
	    }

    msgDiv.style.padding = "10px";
    msgDiv.style.margin = "5px";
    msgDiv.style.borderRadius = "10px";
    msgDiv.style.maxWidth = "70%";
    msgDiv.style.display = "block";

    if (sender === 'user') {
        msgDiv.style.backgroundColor = "#00256c";
        msgDiv.style.color = "white";
        msgDiv.style.alignSelf = "flex-end";
        msgDiv.style.marginLeft = "auto";
    } else {
        msgDiv.style.backgroundColor = "#f0f0f0";
        msgDiv.style.color = "#333";
        msgDiv.style.alignSelf = "flex-start";
        msgDiv.style.marginRight = "auto";
    }

    chatContent.appendChild(msgDiv);
    chatContent.scrollTop = chatContent.scrollHeight;
}

function toggleMenu() {
    const sideMenu = document.getElementById('side-menu');
    const menuOverlay = document.getElementById('menu-overlay');

    if (sideMenu) {
        sideMenu.classList.toggle('active');
    }

    if (menuOverlay) {
        menuOverlay.classList.toggle('active');
    }
}

function toggleChat() {
    const chatWindow = document.getElementById('chat-window');

    if (chatWindow) {
        chatWindow.classList.toggle('hidden');
    }
}