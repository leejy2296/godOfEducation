(function () {
  'use strict';

  // ===== 공통 유틸 =====
  function $(sel, root) { return (root || document).querySelector(sel); }
  function $all(sel, root) { return Array.from((root || document).querySelectorAll(sel)); }

  // ===== Page1: 약관 동의 로직 =====
  (function initAgreePage() {
	  const agreeForm = document.querySelector('#joinAgreeForm');
	  if (!agreeForm) return;
	
	  const agreeAll = document.querySelector('#agreeAll');
	  const requiredChecks = Array.from(document.querySelectorAll('.agree-required'));
	  const nextBtn = document.querySelector('#agreeNextBtn');
	
	  function setNextEnabled() {
	    const ok = requiredChecks.every(ch => ch.checked);
	    nextBtn.disabled = !ok;
	  }
	
	  if (agreeAll) {
	    agreeAll.addEventListener('change', function () {
	      requiredChecks.forEach(ch => { ch.checked = agreeAll.checked; });
	      setNextEnabled();
	    });
	  }
	
	  requiredChecks.forEach(ch => {
	    ch.addEventListener('change', function () {
	      const ok = requiredChecks.every(x => x.checked);
	      if (agreeAll) agreeAll.checked = ok;
	      setNextEnabled();
	    });
	  });
	
	  // 모달 열기
	  document.querySelectorAll('.agree-view').forEach(btn => {
	    btn.addEventListener('click', function () {
	      const id = btn.getAttribute('data-modal');
	      const modal = document.getElementById(id);
	      if (modal) {
	        modal.classList.add('open');
	        modal.setAttribute('aria-hidden', 'false');
	      }
	    });
	  });
	
	  // 모달 닫기
	  document.querySelectorAll('[data-close]').forEach(btn => {
	    btn.addEventListener('click', function () {
	      const id = btn.getAttribute('data-close');
	      const modal = document.getElementById(id);
	      if (modal) {
	        modal.classList.remove('open');
	        modal.setAttribute('aria-hidden', 'true');
	      }
	    });
	  });
	
	  setNextEnabled();
	})();


  // ===== Page2: 회원가입 폼 로직 =====
  (function initJoinForm() {
    const form = $('#joinForm');
    if (!form) return;

    const streamerY  = $('#streamerY');
    const streamerN  = $('#streamerN');
    const addrRow    = $('#soopAddrRow');
    const addrInput  = $('#soopAddr');
    const userIdInput = $('#userId');
    const btnIdCheck  = $('#btnIdCheck');

    // 중복체크 통과 여부 플래그
    let idChecked = false;   // 중복체크 버튼을 눌렀는가
    let idAvailable = false; // 사용 가능한 아이디인가

    // 아이디 input이 바뀌면 체크 결과 초기화
    if (userIdInput) {
      userIdInput.addEventListener('input', function () {
        idChecked   = false;
        idAvailable = false;
        setMsg('userId', '');
      });
    }

    // ── 중복체크 버튼 클릭 ──
    if (btnIdCheck) {
      btnIdCheck.addEventListener('click', function () {
        const userId = userIdInput ? userIdInput.value.trim() : '';

        if (!userId) {
          setMsg('userId', '아이디를 입력해주세요.');
          return;
        }

        // contextPath를 JSP에서 data 속성으로 받아오거나 상대경로 사용
        const ctx = document.querySelector('meta[name="ctx"]')?.content || '';

        fetch(ctx + '/join/checkId.do?userId=' + encodeURIComponent(userId))
          .then(function (res) { return res.json(); })
          .then(function (data) {
            idChecked = true;
            if (data.duplicate) {
              idAvailable = false;
              setMsg('userId', '존재하는 아이디입니다.');
            } else {
              idAvailable = true;
              setMsg('userId', '사용가능한 아이디입니다.');
            }
          })
          .catch(function () {
            setMsg('userId', '중복 확인 중 오류가 발생했습니다.');
          });
      });
    }

    // ── 스트리머 토글 ──
    function toggleAddr() {
      const isY = streamerY && streamerY.checked;
      if (addrRow) addrRow.style.display = isY ? '' : 'none';
      if (addrInput) {
        if (isY) {
          addrInput.setAttribute('required', 'required');
        } else {
          addrInput.removeAttribute('required');
          addrInput.value = '';
          setMsg('soopAddr', '');
        }
      }
    }

    function setMsg(fieldName, msg) {
      const el = document.querySelector('[data-msg-for="' + fieldName + '"]');
      if (el) el.textContent = msg || '';
    }

    function isEmail(v) {
      return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);
    }

    function isUrl(v) {
      return /^https?:\/\/.+/i.test(v);
    }

    if (streamerY) streamerY.addEventListener('change', toggleAddr);
    if (streamerN) streamerN.addEventListener('change', toggleAddr);
    toggleAddr();

    // ── submit validation ──
    form.addEventListener('submit', function (e) {
      let ok = true;

      const userId   = userIdInput?.value.trim() || '';
      const pw       = $('#password')?.value || '';
      const email    = $('#email')?.value.trim() || '';
      const nick     = $('#userNick')?.value.trim() || '';
      const streamer = form.querySelector('input[name="streamerYn"]:checked')?.value || 'N';
      const addr     = addrInput?.value.trim() || '';

      // 메시지 초기화
      ['userId','password','email','userNick','streamerYn','soopAddr'].forEach(k => setMsg(k, ''));

      if (!userId) { setMsg('userId', '아이디를 입력해주세요.'); ok = false; }
      else if (!idChecked) {
        // 중복체크를 아예 안 한 경우
        alert('아이디 중복체크를 해주세요.');
        ok = false;
      } else if (!idAvailable) {
        // 중복체크를 했지만 이미 존재하는 아이디인 경우
        setMsg('userId', '존재하는 아이디입니다.');
        ok = false;
      }

      if (!pw) { setMsg('password', '비밀번호를 입력해주세요.'); ok = false; }
      else if (pw.length < 8) { setMsg('password', '비밀번호는 8자 이상을 권장합니다.'); }

      if (!email) { setMsg('email', '이메일을 입력해주세요.'); ok = false; }
      else if (!isEmail(email)) { setMsg('email', '이메일 형식이 올바르지 않습니다.'); ok = false; }

      if (!nick) { setMsg('userNick', '사용자 닉네임을 입력해주세요.'); ok = false; }

      if (!streamer) { setMsg('streamerYn', '스트리머 여부를 선택해주세요.'); ok = false; }

      if (streamer === 'Y') {
        if (!addr) { setMsg('soopAddr', 'SOOP 방송국 주소를 입력해주세요.'); ok = false; }
        else if (!isUrl(addr)) { setMsg('soopAddr', 'http:// 또는 https:// 로 시작하는 주소를 입력해주세요.'); ok = false; }
      }

      if (!ok) e.preventDefault();
    });
  })();

})();