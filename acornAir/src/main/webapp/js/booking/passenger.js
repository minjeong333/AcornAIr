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

            window.stepState.passenger = true;

            document.querySelectorAll('.accordion:not(#contact-accordion)').forEach(function(acc, idx) {
                var hdr = acc.querySelector('.accordion-header');
                var body = acc.querySelector('.accordion-body');
                if (!hdr || !body) return;

                var lastInput = acc.querySelector('input[name^="engLastName_"]');
                var firstInput = acc.querySelector('input[name^="engFirstName_"]');

                var last = lastInput ? lastInput.value.trim() : '';
                var first = firstInput ? firstInput.value.trim() : '';

                if (last === '' || first === '') {
                    alert('승객 성과 이름을 입력해주세요.');
                    if (lastInput) lastInput.focus();
                    window.stepState.passenger = false;
                    return;
                }

                var nameText = last + ' ' + first;

                body.style.display = 'none';
                hdr.innerHTML =
                    '<div class="confirmed-name">' +
                    '<div class="check-circle">✓</div>' +
                    nameText +
                    '</div>' +
                    '<span class="chevron">∨</span>';

                hdr.classList.add('confirmed');
            });

            if (!window.stepState.passenger) return;

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

    // 연락처 확인 버튼 클릭 → 폼 제출
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

            // 연락처 input이 form 밖에 있으므로 hidden으로 복사해서 전송
            var hiddenPhone = document.createElement('input');
            hiddenPhone.type = 'hidden';
            hiddenPhone.name = 'contactPhone';
            hiddenPhone.value = phoneInput ? phoneInput.value.trim() : '';

            var hiddenEmail = document.createElement('input');
            hiddenEmail.type = 'hidden';
            hiddenEmail.name = 'contactEmail';
            hiddenEmail.value = emailInput ? emailInput.value.trim() : '';

            form.appendChild(hiddenPhone);
            form.appendChild(hiddenEmail);

            window.stepState.contact = true;
            form.submit();
        });
    }

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
