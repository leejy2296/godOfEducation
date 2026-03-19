(function () {
  'use strict';

  const ctx      = document.querySelector('meta[name="ctx"]')?.content || '';
  const modal    = document.getElementById('subjectModal');
  const modalDim = document.getElementById('subjectModalDim');
  const modalTitle  = document.getElementById('subjectModalTitle');
  const nameInput   = document.getElementById('subjectName');
  const nameMsg     = document.getElementById('subjectNameMsg');
  const btnSubmit   = document.getElementById('btnModalSubmit');

  let currentMode  = 'register'; // 'register' | 'edit'
  let currentDocId = null;

  /* ── 모달 열기 ── */
  function openModal(mode, docId, name) {
    currentMode  = mode;
    currentDocId = docId || null;

    nameInput.value  = name || '';
    nameMsg.textContent = '';

    if (mode === 'edit') {
      modalTitle.textContent  = '과목 수정';
      btnSubmit.textContent   = '수정완료';
    } else {
      modalTitle.textContent  = '과목 등록';
      btnSubmit.textContent   = '등록';
    }

    modal.style.display    = 'block';
    modalDim.style.display = 'block';
    nameInput.focus();
  }

  /* ── 모달 닫기 ── */
  function closeModal() {
    modal.style.display    = 'none';
    modalDim.style.display = 'none';
    nameInput.value        = '';
    nameMsg.textContent    = '';
  }

  /* ── 등록 버튼 ── */
  document.getElementById('btnSubjectRegister')?.addEventListener('click', function () {
    openModal('register');
  });

  /* ── 수정 버튼 (이벤트 위임) ── */
  document.addEventListener('click', function (e) {
    const editBtn = e.target.closest('.btn-subject-edit');
    if (editBtn) {
      openModal('edit', editBtn.dataset.docId, editBtn.dataset.name);
    }
  });

  /* ── 삭제 버튼 (이벤트 위임) ── */
  document.addEventListener('click', function (e) {
    const delBtn = e.target.closest('.btn-subject-delete');
    if (!delBtn) return;

    if (!confirm('정말로 삭제하시겠습니까?')) return;

    fetch(ctx + '/admin/subject/delete.do', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'docId=' + encodeURIComponent(delBtn.dataset.docId)
    })
    .then(res => res.json())
    .then(data => {
      if (data.success) location.reload();
      else alert('삭제 처리 중 오류가 발생했습니다.');
    })
    .catch(() => alert('오류가 발생했습니다.'));
  });

  /* ── 모달 닫기 버튼 ── */
  document.getElementById('btnModalClose')?.addEventListener('click', closeModal);
  document.getElementById('btnModalCancel')?.addEventListener('click', closeModal);
  modalDim?.addEventListener('click', closeModal);

  /* ── 모달 제출 ── */
  btnSubmit?.addEventListener('click', function () {
    const name = nameInput.value.trim();
    if (!name) {
      nameMsg.textContent = '과목명을 입력해주세요.';
      nameInput.focus();
      return;
    }
    nameMsg.textContent = '';

    if (currentMode === 'register') {
      fetch(ctx + '/admin/subject/register.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'name=' + encodeURIComponent(name)
      })
      .then(res => res.json())
      .then(data => {
        if (data.success) { closeModal(); location.reload(); }
        else alert('등록 중 오류가 발생했습니다.');
      })
      .catch(() => alert('오류가 발생했습니다.'));

    } else {
      fetch(ctx + '/admin/subject/update.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'docId=' + encodeURIComponent(currentDocId) + '&name=' + encodeURIComponent(name)
      })
      .then(res => res.json())
      .then(data => {
        if (data.success) { closeModal(); location.reload(); }
        else alert('수정 중 오류가 발생했습니다.');
      })
      .catch(() => alert('오류가 발생했습니다.'));
    }
  });

  /* ── ESC 키로 모달 닫기 ── */
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closeModal();
  });

})();
