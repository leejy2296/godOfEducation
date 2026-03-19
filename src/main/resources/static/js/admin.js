(function () {
  'use strict';

  const ctx = document.querySelector('meta[name="ctx"]')?.content || '';

  // ── 승인 버튼 ──
  document.querySelectorAll('.btn-approve').forEach(function (btn) {
    btn.addEventListener('click', function () {
      const userId = btn.dataset.userId;
      if (!confirm('정말로 승인하시겠습니까?')) return;

      fetch(ctx + '/admin/approve.do', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'userId=' + encodeURIComponent(userId)
      })
      .then(function (res) { return res.json(); })
      .then(function (data) {
        if (data.success) {
          // 버튼을 삭제 버튼으로 교체
          const td = btn.closest('td');
          const row = btn.closest('tr');
          td.innerHTML = '<button class="btn-delete" data-user-id="' + userId + '">삭제</button>';
          // 상태 badge 업데이트
          const statusBadge = row.querySelector('.status-badge');
          if (statusBadge) {
            statusBadge.className = 'status-badge approved';
            statusBadge.textContent = '승인';
          }
          // 새로 생긴 삭제 버튼에 이벤트 등록
          td.querySelector('.btn-delete').addEventListener('click', handleDelete);
        }
      })
      .catch(function () { alert('처리 중 오류가 발생했습니다.'); });
    });
  });

  // ── 삭제 버튼 ──
  document.querySelectorAll('.btn-delete').forEach(function (btn) {
    btn.addEventListener('click', handleDelete);
  });

  function handleDelete() {
    const btn = this;
    const userId = btn.dataset.userId;
    if (!confirm('정말로 탈퇴 처리 하시겠습니까?')) return;

    fetch(ctx + '/admin/delete.do', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'userId=' + encodeURIComponent(userId)
    })
    .then(function (res) { return res.json(); })
    .then(function (data) {
      if (data.success) {
        const td = btn.closest('td');
        const row = btn.closest('tr');
        td.innerHTML = '<button class="btn-restore" data-user-id="' + userId + '">복구</button>';
        // 상태 badge 업데이트
        const statusBadge = row.querySelector('.status-badge');
        if (statusBadge) {
          statusBadge.className = 'status-badge deleted';
          statusBadge.textContent = '탈퇴';
        }
        // row 흐림 처리
        row.classList.add('row-deleted');
        // 새로 생긴 복구 버튼에 이벤트 등록
        td.querySelector('.btn-restore').addEventListener('click', handleRestore);
      }
    })
    .catch(function () { alert('처리 중 오류가 발생했습니다.'); });
  }

  // ── 복구 버튼 ──
  document.querySelectorAll('.btn-restore').forEach(function (btn) {
    btn.addEventListener('click', handleRestore);
  });

  function handleRestore() {
    const btn = this;
    const userId = btn.dataset.userId;
    if (!confirm('정말로 탈퇴 처리를 취소하시겠습니까?')) return;

    fetch(ctx + '/admin/restore.do', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'userId=' + encodeURIComponent(userId)
    })
    .then(function (res) { return res.json(); })
    .then(function (data) {
      if (data.success) {
        const td = btn.closest('td');
        const row = btn.closest('tr');
        // useYn 상태에 따라 승인/삭제 버튼으로 복구
        // 복구 후 useYn은 서버 응답에서 확인
        const useYn = data.useYn;
        row.classList.remove('row-deleted');

        if (useYn === 'Y') {
          td.innerHTML = '<button class="btn-delete" data-user-id="' + userId + '">삭제</button>';
          const statusBadge = row.querySelector('.status-badge');
          if (statusBadge) {
            statusBadge.className = 'status-badge approved';
            statusBadge.textContent = '승인';
          }
          td.querySelector('.btn-delete').addEventListener('click', handleDelete);
        } else {
          td.innerHTML = '<button class="btn-approve" data-user-id="' + userId + '">승인</button>';
          const statusBadge = row.querySelector('.status-badge');
          if (statusBadge) {
            statusBadge.className = 'status-badge pending';
            statusBadge.textContent = '미승인';
          }
          td.querySelector('.btn-approve').addEventListener('click', function () {
            handleApprove.call(td.querySelector('.btn-approve'));
          });
        }
      }
    })
    .catch(function () { alert('처리 중 오류가 발생했습니다.'); });
  }

  function handleApprove() {
    const btn = this;
    const userId = btn.dataset.userId;
    if (!confirm('정말로 승인하시겠습니까?')) return;

    fetch(ctx + '/admin/approve.do', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'userId=' + encodeURIComponent(userId)
    })
    .then(function (res) { return res.json(); })
    .then(function (data) {
      if (data.success) {
        const td = btn.closest('td');
        const row = btn.closest('tr');
        td.innerHTML = '<button class="btn-delete" data-user-id="' + userId + '">삭제</button>';
        const statusBadge = row.querySelector('.status-badge');
        if (statusBadge) {
          statusBadge.className = 'status-badge approved';
          statusBadge.textContent = '승인';
        }
        td.querySelector('.btn-delete').addEventListener('click', handleDelete);
      }
    })
    .catch(function () { alert('처리 중 오류가 발생했습니다.'); });
  }

})();
