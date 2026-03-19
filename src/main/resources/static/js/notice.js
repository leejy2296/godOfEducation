(function () {
  'use strict';

  const ctx = document.querySelector('meta[name="ctx"]')?.content || '';

  /* ── 삭제 버튼 ── */
  const btnDelete = document.querySelector('.btn-delete-notice');
  if (btnDelete) {
    btnDelete.addEventListener('click', function () {
      const docId = btnDelete.dataset.docId;
      if (!confirm('정말로 삭제하시겠습니까?')) return;

      fetch(ctx + '/notice/delete.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'docId=' + encodeURIComponent(docId)
      })
      .then(function (res) { return res.json(); })
      .then(function (data) {
        if (data.success) {
          location.href = ctx + '/notice/list.do';
        } else {
          alert('삭제 처리 중 오류가 발생했습니다.');
        }
      })
      .catch(function () { alert('오류가 발생했습니다.'); });
    });
  }

  /* ── 복구 버튼 ── */
  const btnRestore = document.querySelector('.btn-restore-notice');
  if (btnRestore) {
    btnRestore.addEventListener('click', function () {
      const docId = btnRestore.dataset.docId;
      if (!confirm('정말로 복구하시겠습니까?')) return;

      fetch(ctx + '/notice/restore.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'docId=' + encodeURIComponent(docId)
      })
      .then(function (res) { return res.json(); })
      .then(function (data) {
        if (data.success) {
          location.reload();
        } else {
          alert('복구 처리 중 오류가 발생했습니다.');
        }
      })
      .catch(function () { alert('오류가 발생했습니다.'); });
    });
  }

  /* ── 등록/수정 폼 유효성 검사 ── */
  const form = document.getElementById('noticeForm');
  if (form) {
    form.addEventListener('submit', function (e) {
      let ok = true;

      const title   = document.getElementById('title');
      const content = document.getElementById('content');

      setMsg('title',   '');
      setMsg('content', '');

      if (!title || !title.value.trim()) {
        setMsg('title', '제목을 입력해주세요.');
        ok = false;
      }
      if (!content || !content.value.trim()) {
        setMsg('content', '내용을 입력해주세요.');
        ok = false;
      }

      if (!ok) e.preventDefault();
    });
  }

  function setMsg(name, msg) {
    const el = document.querySelector('[data-msg-for="' + name + '"]');
    if (el) el.textContent = msg || '';
  }

})();
