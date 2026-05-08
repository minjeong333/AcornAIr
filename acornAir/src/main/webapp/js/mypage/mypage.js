function openMyPage() {
    document.getElementById('mypage-modal').style.display = 'flex';
}

function closeMyPage() {
    document.getElementById('mypage-modal').style.display = 'none';
}

// 배경 클릭 시 닫기 기능 (선택 사항)
 

function confirmLogout() {
	
    if (confirm("로그아웃 하시겠습니까?")) {
        return true; // 서블릿으로 이동
    }
    return false; // 이동 취소
}

 
window.onclick = function(event) {
    const modal = document.getElementById('mypage-modal');
    if (event.target == modal) {
        closeMyPage();
    }
 
}
//로그아웃 에러창
 
 
 
