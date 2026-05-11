document.addEventListener('DOMContentLoaded', function () {

  var btnConfirm    = document.getElementById('btn-passenger-confirm');
  var contactHeader = document.getElementById('contact-header');
  var contactBody   = document.getElementById('contact-body');
  var baggageHeader = document.getElementById('baggageHeader');
  var baggageBody   = document.getElementById('baggageBody');

  // 승객 아코디언 초기 토글
  document.querySelectorAll('.accordion:not(#contact-accordion)').forEach(function (acc) {
    var hdr  = acc.querySelector('.accordion-header');
    var body = acc.querySelector('.accordion-body');
    if (!hdr || !body) return;
    hdr.style.cursor = 'pointer';
    hdr.addEventListener('click', function () {
      var isOpen = body.style.display !== 'none';
      body.style.display = isOpen ? 'none' : 'block';
      var chevron = hdr.querySelector('.chevron');
      if (chevron) chevron.textContent = isOpen ? '∨' : '∧';
    });
  });

  // 연락처 헤더 초기 토글
  if (contactHeader && contactBody) {
    contactHeader.style.cursor = 'pointer';
    contactHeader.addEventListener('click', function () {
      var isOpen = !contactBody.classList.contains('hidden');
      contactBody.classList.toggle('hidden', isOpen);
      var chevron = contactHeader.querySelector('.chevron');
      if (chevron) chevron.textContent = isOpen ? '∨' : '∧';
    });
  }

  // 승객 확인 버튼 클릭
  if (btnConfirm) {
    btnConfirm.addEventListener('click', function () {
      document.querySelectorAll('.accordion:not(#contact-accordion)').forEach(function (acc, idx) {
        var hdr  = acc.querySelector('.accordion-header');
        var body = acc.querySelector('.accordion-body');
        if (!hdr || !body) return;

        var lastInput  = acc.querySelector('input[name^="engLastName_"]');
        var firstInput = acc.querySelector('input[name^="engFirstName_"]');
        var last  = lastInput  ? lastInput.value.trim()  : '';
        var first = firstInput ? firstInput.value.trim() : '';
        var nameText = (last || first) ? (last + ' ' + first) : ('성인 ' + (idx + 1));

        body.style.display = 'none';
        hdr.innerHTML =
          '<div class="confirmed-name">' +
            '<div class="check-circle">✓</div>' +
            nameText +
          '</div>' +
          '<span class="chevron">∨</span>';
        hdr.classList.add('confirmed');
      });

      if (contactBody && contactHeader) {
        contactBody.classList.remove('hidden');
        contactHeader.classList.remove('secondary');
        contactHeader.classList.add('contact-open');
        var chevron = contactHeader.querySelector('.chevron');
        if (chevron) chevron.textContent = '∧';
        contactHeader.style.color = '#fff';

        var contactAcc = document.getElementById('contact-accordion');
        if (contactAcc) contactAcc.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  }

  // 연락처 확인 버튼 클릭 → 폼 제출
  var btnContactConfirm = document.getElementById('btn-contact-confirm');
  if (btnContactConfirm && btnConfirm) {
    btnContactConfirm.addEventListener('click', function () {
      var form = btnConfirm.closest('form');
      if (form) form.submit();
    });
  }

  // 수하물 정보 아코디언 토글
  if (baggageHeader && baggageBody) {
    baggageHeader.style.cursor = 'pointer';
    baggageHeader.addEventListener('click', function () {
      var isOpen = baggageBody.style.display !== 'none';
      baggageBody.style.display = isOpen ? 'none' : 'block';
      var chevron = baggageHeader.querySelector('.chevron');
      if (chevron) chevron.textContent = isOpen ? '∨' : '∧';
    });
  }

});
