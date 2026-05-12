document.addEventListener('DOMContentLoaded', function() {

    var btnConfirm = document.getElementById('btn-passenger-confirm');
    var contactHeader = document.getElementById('contact-header');
    var contactBody = document.getElementById('contact-body');
    var baggageHeader = document.getElementById('baggageHeader');
    var baggageBody = document.getElementById('baggageBody');

    // JSP에서 stepState가 없으면 기본 생성
    if (!window.stepState) {
        window.stepState = {
            passenger: false,
            contact: false,
            seat: false,
            baggage: false
        };
    }

    // 승객 아코디언 토글
    document.querySelectorAll('.accordion:not(#contact-accordion)').forEach(function(acc) {
        var hdr = acc.querySelector('.accordion-header');
        var body = acc.querySelector('.accordion-body');
        if (!hdr || !body) return;

        hdr.style.cursor = 'pointer';
        hdr.addEventListener('click', function() {
            var isOpen = body.style.display !== 'none';
            body.style.display = isOpen ? 'none' : 'block';

            var chevron = hdr.querySelector('.chevron');
            if (chevron) chevron.textContent = isOpen ? '∨' : '∧';
        });
    });

    // 연락처 헤더 토글
    if (contactHeader && contactBody) {
        contactHeader.style.cursor = 'pointer';
        contactHeader.addEventListener('click', function() {
            var isOpen = !contactBody.classList.contains('hidden');
            contactBody.classList.toggle('hidden', isOpen);

            var chevron = contactHeader.querySelector('.chevron');
            if (chevron) chevron.textContent = isOpen ? '∨' : '∧';
        });
    }

    // 승객 확인 버튼 클릭
    if (btnConfirm) {
        btnConfirm.addEventListener('click', function() {

            var accs = document.querySelectorAll('.accordion:not(#contact-accordion)');
            var collected = [];

            // 1단계: 전체 유효성 검사 (하나라도 실패하면 즉시 중단)
            for (var i = 0; i < accs.length; i++) {
                var acc = accs[i];
                var lastInput = acc.querySelector('input[name^="engLastName_"]');
                var firstInput = acc.querySelector('input[name^="engFirstName_"]');

                var last = lastInput ? lastInput.value.trim() : '';
                var first = firstInput ? firstInput.value.trim() : '';

                if (last === '' || first === '') {
                    alert('승객 ' + (i + 1) + '의 성과 이름을 입력해주세요.');
                    if (lastInput) lastInput.focus();
                    return;
                }

                collected.push({ acc: acc, name: last + ' ' + first });
            }

            // 2단계: 모두 통과 시 헤더만 확인 상태로 변경 (입력값 유지)
            collected.forEach(function(item) {
                var hdr = item.acc.querySelector('.accordion-header');

                hdr.innerHTML =
                    '<div class="confirmed-name">' +
                    '<div class="check-circle">✓</div>' +
                    item.name +
                    '</div>' +
                    '<span class="chevron">∧</span>';
                hdr.classList.add('confirmed');
            });

            window.stepState.passenger = true;

            if (contactBody && contactHeader) {
                contactBody.classList.remove('hidden');
                contactHeader.classList.remove('secondary');
                contactHeader.classList.add('contact-open');

                var chevron = contactHeader.querySelector('.chevron');
                if (chevron) chevron.textContent = '∧';

                contactHeader.style.color = '#fff';

                var contactAcc = document.getElementById('contact-accordion');
                if (contactAcc) {
                    contactAcc.scrollIntoView({ behavior: 'smooth', block: 'start' });
                }
            }
        });
    }

    // 연락처 확인 버튼 클릭 → AJAX로 전송 (페이지 이동 없이 화면 유지)
    var btnContactConfirm = document.getElementById('btn-contact-confirm');

    if (btnContactConfirm && btnConfirm) {
        btnContactConfirm.addEventListener('click', function() {

            if (!window.stepState.passenger) {
                alert('먼저 승객정보 확인 버튼을 눌러주세요.');
                return;
            }

            var phoneInput = document.querySelector('input[name="contactPhone"]');
            var emailInput = document.querySelector('input[name="contactEmail"]');

            if (phoneInput && phoneInput.value.trim() === '') {
                alert('휴대전화 번호를 입력해주세요.');
                phoneInput.focus();
                return;
            }

            if (emailInput && emailInput.value.trim() === '') {
                alert('이메일을 입력해주세요.');
                emailInput.focus();
                return;
            }

            var form = btnConfirm.closest('form');
            if (!form) return;

            var formData = new URLSearchParams(new FormData(form));

            fetch(form.action, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: formData
            }).then(function() {
                window.stepState.contact = true;
            }).catch(function() {
                window.stepState.contact = true;
            });
        });
    }

    // 동의 배지 토글
    document.querySelectorAll('.agree-badge').forEach(function(badge) {
        badge.style.cursor = 'pointer';
        badge.addEventListener('click', function() {
            badge.classList.toggle('active');
        });
    });

    // 수하물 정보 아코디언 토글
    if (baggageHeader && baggageBody) {
        baggageHeader.style.cursor = 'pointer';
        baggageHeader.addEventListener('click', function() {
            var isOpen = baggageBody.style.display !== 'none';
            baggageBody.style.display = isOpen ? 'none' : 'block';

            var chevron = baggageHeader.querySelector('.chevron');
            if (chevron) chevron.textContent = isOpen ? '∨' : '∧';
        });
    }

});
