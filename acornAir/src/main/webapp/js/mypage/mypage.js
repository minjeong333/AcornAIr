function openMyPage() {
    document.getElementById('mypage-modal').style.display = 'flex';
}

function closeMyPage() {
    document.getElementById('mypage-modal').style.display = 'none';
}

// 배경 클릭 시 닫기 기능 (선택 사항)
window.onclick = function(event) {
    const modal = document.getElementById('mypage-modal');
    if (event.target == modal) {
        closeMyPage();
    }
}