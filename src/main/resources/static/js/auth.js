(function () {
  'use strict';

  function setMsg(name, msg) {
    const el = document.querySelector('[data-msg-for="' + name + '"]');
    if (el) el.textContent = msg || '';
  }

  (function initLogin() {
    const form = document.getElementById('loginForm');
    if (!form) return;

    form.addEventListener('submit', function (e) {
      setMsg('loginId', '');
      setMsg('loginPw', '');

      const id = document.getElementById('loginId')?.value.trim() || '';
      const pw = document.getElementById('loginPw')?.value || '';

      let ok = true;

      if (!id) { setMsg('loginId', '아이디를 입력해주세요.'); ok = false; }
      if (!pw) { setMsg('loginPw', '비밀번호를 입력해주세요.'); ok = false; }

      if (!ok) e.preventDefault();
    });
  })();

})();