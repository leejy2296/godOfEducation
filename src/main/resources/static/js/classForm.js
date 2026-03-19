(function () {
  'use strict';

  const form = document.getElementById('classForm');
  if (!form) return;

  form.addEventListener('submit', function (e) {
    let ok = true;

    const title      = document.getElementById('title');
    const summary    = document.getElementById('summary');
    const subjectDoc = document.getElementById('subjectDocId');
    const videoUrl   = document.getElementById('videoUrl');

    ['title', 'summary', 'subjectDocId', 'videoUrl'].forEach(k => setMsg(k, ''));

    if (!title?.value.trim())    { setMsg('title',        '강의명을 입력해주세요.');     ok = false; }
    if (!summary?.value.trim())  { setMsg('summary',      '강의 요약을 입력해주세요.');  ok = false; }
    if (!subjectDoc?.value)      { setMsg('subjectDocId', '과목을 선택해주세요.');       ok = false; }
    if (!videoUrl?.value.trim()) { setMsg('videoUrl',     '영상 주소를 입력해주세요.');  ok = false; }
    else if (!/^https?:\/\/.+/i.test(videoUrl.value.trim())) {
      setMsg('videoUrl', 'http:// 또는 https:// 로 시작하는 URL을 입력해주세요.');
      ok = false;
    }

    if (!ok) e.preventDefault();
  });

  function setMsg(name, msg) {
    const el = document.querySelector('[data-msg-for="' + name + '"]');
    if (el) el.textContent = msg || '';
  }

})();