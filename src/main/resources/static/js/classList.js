(function () {
  'use strict';

  const ctx = document.querySelector('meta[name="ctx"]')?.content || '';

  /* ── 강의 삭제 버튼 ── */
  const btnDelete = document.querySelector('.btn-class-delete');
  if (btnDelete) {
    btnDelete.addEventListener('click', function () {
      const docId = btnDelete.dataset.docId;
      if (!confirm('정말로 삭제하시겠습니까?')) return;

      fetch(ctx + '/class/delete.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'docId=' + encodeURIComponent(docId)
      })
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          location.href = ctx + '/class/list.do';
        } else {
          alert('삭제 처리 중 오류가 발생했습니다.');
        }
      })
      .catch(() => alert('오류가 발생했습니다.'));
    });
  }

})();
