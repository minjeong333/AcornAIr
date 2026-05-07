const btnConfirm    = document.getElementById('btn-passenger-confirm');
const passengerAcc  = btnConfirm.closest('.accordion');
const passengerHdr  = passengerAcc.querySelector('.accordion-header');
const passengerBody = passengerAcc.querySelector('.accordion-body');
const contactHeader = document.getElementById('contact-header');
const contactBody   = document.getElementById('contact-body');

// 성인 1 확인 버튼 클릭
btnConfirm.addEventListener('click', function () {
  // 성인 1 접힘 + 완료 표시
  passengerBody.style.display = 'none';
  passengerHdr.innerHTML = `
    <div class="confirmed-name">
      <div class="check-circle">✓</div>
      KIM MINJEONG
    </div>
    <span class="chevron">∨</span>
  `;
  passengerHdr.classList.add('confirmed');

  // 성인 1 헤더 클릭 시 펼치기 토글
  passengerHdr.onclick = function () {
    const isOpen = passengerBody.style.display !== 'none';
    passengerBody.style.display = isOpen ? 'none' : 'block';
    passengerHdr.querySelector('.chevron').textContent = isOpen ? '∨' : '∧';
  };

  // 연락처 정보 자동 열기
  contactBody.classList.remove('hidden');
  contactHeader.classList.remove('secondary');
  contactHeader.classList.add('contact-open');
  contactHeader.querySelector('.chevron').textContent = '∧';
  contactHeader.style.color = '#fff';

  // 연락처 헤더 토글
  contactHeader.onclick = function () {
    const isOpen = !contactBody.classList.contains('hidden');
    contactBody.classList.toggle('hidden', isOpen);
    contactHeader.querySelector('.chevron').textContent = isOpen ? '∨' : '∧';
  };

  // 연락처 정보로 스크롤
  document.getElementById('contact-accordion').scrollIntoView({ behavior: 'smooth', block: 'start' });
});

// 수하물 정보 아코디언 토글
const baggageHeader = document.getElementById('baggageHeader');
const baggageBody   = document.getElementById('baggageBody');
baggageHeader.addEventListener('click', function () {
  const isOpen = baggageBody.style.display !== 'none';
  baggageBody.style.display = isOpen ? 'none' : 'block';
  baggageHeader.querySelector('.chevron').textContent = isOpen ? '∨' : '∧';
});
