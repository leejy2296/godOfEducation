/* =============================================
   VIRTUAL_EDUCATION - main.js (clean)
============================================= */
(function () {
  'use strict';

  // =============================================
  // 헤더 스크롤 효과
  // =============================================
  const header = document.getElementById('header');

  function handleHeaderScroll() {
    if (!header) return;
    if (window.scrollY > 30) header.classList.add('scrolled');
    else header.classList.remove('scrolled');
  }
  window.addEventListener('scroll', handleHeaderScroll, { passive: true });


  // =============================================
  // 배너 슬라이더
  // =============================================
  const slides = document.querySelectorAll('.banner-slide');
  const dots = document.querySelectorAll('.dot');
  const prevBtn = document.getElementById('bannerPrev');
  const nextBtn = document.getElementById('bannerNext');
  const pauseBtn = document.getElementById('bannerPause');

  let currentIndex = 0;
  let isPlaying = true;
  let autoSlideTimer = null;

  const pauseIcon = `<svg width="12" height="14" viewBox="0 0 12 14"><rect x="0" y="0" width="4" height="14" fill="white"/><rect x="8" y="0" width="4" height="14" fill="white"/></svg>`;
  const playIcon = `<svg width="12" height="14" viewBox="0 0 12 14"><polygon points="0,0 12,7 0,14" fill="white"/></svg>`;

  function goToSlide(index) {
    if (!slides.length) return;

    slides[currentIndex].classList.remove('active');
    if (dots[currentIndex]) dots[currentIndex].classList.remove('active');

    currentIndex = (index + slides.length) % slides.length;

    slides[currentIndex].classList.add('active');
    if (dots[currentIndex]) dots[currentIndex].classList.add('active');
  }

  function startAutoSlide() {
    stopAutoSlide();
    if (!slides.length) return;
    autoSlideTimer = setInterval(function () {
      goToSlide(currentIndex + 1);
    }, 4500);
  }

  function stopAutoSlide() {
    if (autoSlideTimer) {
      clearInterval(autoSlideTimer);
      autoSlideTimer = null;
    }
  }

  if (prevBtn) {
    prevBtn.addEventListener('click', function () {
      goToSlide(currentIndex - 1);
      if (isPlaying) startAutoSlide();
    });
  }

  if (nextBtn) {
    nextBtn.addEventListener('click', function () {
      goToSlide(currentIndex + 1);
      if (isPlaying) startAutoSlide();
    });
  }

  dots.forEach(function (dot) {
    dot.addEventListener('click', function () {
      const idx = parseInt(dot.dataset.index, 10);
      if (Number.isNaN(idx)) return;
      goToSlide(idx);
      if (isPlaying) startAutoSlide();
    });
  });

  if (pauseBtn) {
    pauseBtn.innerHTML = pauseIcon; // 초기 아이콘 고정
    pauseBtn.addEventListener('click', function () {
      if (isPlaying) {
        stopAutoSlide();
        isPlaying = false;
        pauseBtn.innerHTML = playIcon;
        pauseBtn.setAttribute('aria-label', '재생');
      } else {
        startAutoSlide();
        isPlaying = true;
        pauseBtn.innerHTML = pauseIcon;
        pauseBtn.setAttribute('aria-label', '일시정지');
      }
    });
  }

  // 슬라이더 키보드 접근성
  document.addEventListener('keydown', function (e) {
    if (!slides.length) return;
    if (e.key === 'ArrowLeft') goToSlide(currentIndex - 1);
    if (e.key === 'ArrowRight') goToSlide(currentIndex + 1);
  });

  // 터치 스와이프 지원
  (function () {
    const slider = document.getElementById('bannerSlider');
    if (!slider || !slides.length) return;

    let startX = 0;
    slider.addEventListener('touchstart', function (e) {
      startX = e.touches[0].clientX;
    }, { passive: true });

    slider.addEventListener('touchend', function (e) {
      const diff = startX - e.changedTouches[0].clientX;
      if (Math.abs(diff) > 50) {
        goToSlide(diff > 0 ? currentIndex + 1 : currentIndex - 1);
        if (isPlaying) startAutoSlide();
      }
    }, { passive: true });
  })();

  // 자동 슬라이드 시작
  startAutoSlide();


  // =============================================
  // 파트너 트랙 무한 복제 (심리스 스크롤)
  // =============================================
  const partnersTrack = document.getElementById('partnersTrack');
  if (partnersTrack) {
    const original = partnersTrack.innerHTML;
    partnersTrack.innerHTML = original + original;

    partnersTrack.addEventListener('mouseenter', function () {
      partnersTrack.style.animationPlayState = 'paused';
    });
    partnersTrack.addEventListener('mouseleave', function () {
      partnersTrack.style.animationPlayState = 'running';
    });
  }


  // =============================================
  // 스크롤 탑 버튼
  // =============================================
  const scrollTopBtn = document.getElementById('scrollTop');

  if (scrollTopBtn) {
    window.addEventListener('scroll', function () {
      if (window.scrollY > 400) scrollTopBtn.classList.add('show');
      else scrollTopBtn.classList.remove('show');
    }, { passive: true });

    scrollTopBtn.addEventListener('click', function () {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }


  // =============================================
  // 진입 애니메이션 (Intersection Observer)
  // main.jsp에 존재하는 요소만 대상으로 유지
  // =============================================
  const animateTargets = document.querySelectorAll('.lecture-card, .board-box, .event-banner-item');

  if (animateTargets.length) {
    const observer = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry, i) {
        if (entry.isIntersecting) {
          setTimeout(function () {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
          }, i * 80);
          observer.unobserve(entry.target);
        }
      });
    }, { threshold: 0.1 });

    animateTargets.forEach(function (el) {
      el.style.opacity = '0';
      el.style.transform = 'translateY(20px)';
      el.style.transition = 'opacity 0.5s ease, transform 0.5s ease, box-shadow 0.25s cubic-bezier(0.4,0,0.2,1)';
      observer.observe(el);
    });
  }

})();