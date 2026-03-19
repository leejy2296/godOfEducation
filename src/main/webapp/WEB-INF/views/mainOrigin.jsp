<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>에듀온 인터넷 강의</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=Noto+Serif+KR:wght@400;600;700&display=swap" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" />
</head>
<body>

  <!-- 헤더 -->
  <header class="header" id="header">
    <div class="header-inner">
      <div class="header-logo">
        <a href="#">
          <span class="logo-text">EDU<em>ON</em></span>
          <span class="logo-sub">인터넷 강의</span>
        </a>
      </div>

      <nav class="gnb">
        <ul class="gnb-list">
          <li class="gnb-item has-sub">
            <a href="#">고등부</a>
            <ul class="sub-menu">
              <li><a href="#">국어</a></li>
              <li><a href="#">수학</a></li>
              <li><a href="#">영어</a></li>
              <li><a href="#">탐구</a></li>
              <li><a href="#">한국사</a></li>
            </ul>
          </li>
          <li class="gnb-item has-sub">
            <a href="#">중등부</a>
            <ul class="sub-menu">
              <li><a href="#">국어</a></li>
              <li><a href="#">수학</a></li>
              <li><a href="#">영어</a></li>
              <li><a href="#">과학</a></li>
              <li><a href="#">사회</a></li>
            </ul>
          </li>
          <li class="gnb-item has-sub">
            <a href="#">AI 추천</a>
            <ul class="sub-menu">
              <li><a href="#">맞춤 강의 추천</a></li>
              <li><a href="#">학습 진단</a></li>
              <li><a href="#">성취도 분석</a></li>
            </ul>
          </li>
          <li class="gnb-item has-sub">
            <a href="#">커뮤니티</a>
            <ul class="sub-menu">
              <li><a href="#">공지사항</a></li>
              <li><a href="#">이벤트</a></li>
              <li><a href="#">자주 묻는 질문</a></li>
              <li><a href="#">1:1 문의</a></li>
            </ul>
          </li>
          <li class="gnb-item">
            <a href="#">고객센터</a>
          </li>
        </ul>
      </nav>

      <div class="header-util">
        <a href="#" class="btn-login">로그인</a>
        <a href="#" class="btn-join">회원가입</a>
        <button class="btn-menu-toggle" id="menuToggle" aria-label="메뉴">
          <span></span><span></span><span></span>
        </button>
      </div>
    </div>

    <!-- 모바일 메뉴 -->
    <nav class="mobile-nav" id="mobileNav">
      <ul>
        <li><a href="#">고등부</a></li>
        <li><a href="#">중등부</a></li>
        <li><a href="#">AI 추천</a></li>
        <li><a href="#">커뮤니티</a></li>
        <li><a href="#">고객센터</a></li>
        <li><a href="#" class="mobile-login">로그인</a></li>
        <li><a href="#" class="mobile-join">회원가입</a></li>
      </ul>
    </nav>
  </header>

  <main>

    <!-- 메인 배너 슬라이더 -->
    <section class="hero-banner">
      <div class="banner-slider" id="bannerSlider">
        <div class="banner-slide active">
          <div class="banner-image-placeholder">
            <span class="image-label">이미지1</span>
            <div class="banner-overlay"></div>
            <div class="banner-content">
              <p class="banner-tag">2025 수능 대비</p>
              <h2 class="banner-title">나만의 맞춤 강의로<br>수능을 정복하세요</h2>
              <p class="banner-desc">AI 분석으로 최적의 강의를 추천해 드립니다</p>
              <div class="banner-actions">
                <a href="#" class="btn-banner-primary">강의 보러가기</a>
                <a href="#" class="btn-banner-secondary">무료 강의 체험</a>
              </div>
            </div>
          </div>
        </div>
        <div class="banner-slide">
          <div class="banner-image-placeholder color2">
            <span class="image-label">이미지2</span>
            <div class="banner-overlay"></div>
            <div class="banner-content">
              <p class="banner-tag">중등부 특별 기획</p>
              <h2 class="banner-title">중학교 내신부터<br>꼼꼼하게 준비하세요</h2>
              <p class="banner-desc">전문 강사진의 체계적인 커리큘럼</p>
              <div class="banner-actions">
                <a href="#" class="btn-banner-primary">강의 보러가기</a>
                <a href="#" class="btn-banner-secondary">커리큘럼 확인</a>
              </div>
            </div>
          </div>
        </div>
        <div class="banner-slide">
          <div class="banner-image-placeholder color3">
            <span class="image-label">이미지3</span>
            <div class="banner-overlay"></div>
            <div class="banner-content">
              <p class="banner-tag">이벤트</p>
              <h2 class="banner-title">신규 회원 특별 혜택<br>지금 바로 받으세요</h2>
              <p class="banner-desc">가입 즉시 무료 강의 30일 제공</p>
              <div class="banner-actions">
                <a href="#" class="btn-banner-primary">지금 가입하기</a>
                <a href="#" class="btn-banner-secondary">이벤트 자세히 보기</a>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- 슬라이더 컨트롤 -->
      <div class="banner-controls">
        <button class="banner-prev" id="bannerPrev" aria-label="이전">&#8249;</button>
        <div class="banner-dots" id="bannerDots">
          <button class="dot active" data-index="0"></button>
          <button class="dot" data-index="1"></button>
          <button class="dot" data-index="2"></button>
        </div>
        <button class="banner-next" id="bannerNext" aria-label="다음">&#8250;</button>
        <button class="banner-pause" id="bannerPause" aria-label="일시정지">
          <svg width="12" height="14" viewBox="0 0 12 14"><rect x="0" y="0" width="4" height="14"/><rect x="8" y="0" width="4" height="14"/></svg>
        </button>
      </div>
    </section>

    <!-- 빠른 이동 -->
    <section class="quick-nav">
      <div class="container">
        <ul class="quick-nav-list">
          <li>
            <a href="#">
              <div class="quick-icon high">
                <svg viewBox="0 0 40 40" fill="none"><circle cx="20" cy="20" r="18" stroke="currentColor" stroke-width="2"/><text x="20" y="25" text-anchor="middle" font-size="13" fill="currentColor" font-weight="700">고</text></svg>
              </div>
              <span>고등부</span>
              <em>바로가기</em>
            </a>
          </li>
          <li>
            <a href="#">
              <div class="quick-icon middle">
                <svg viewBox="0 0 40 40" fill="none"><circle cx="20" cy="20" r="18" stroke="currentColor" stroke-width="2"/><text x="20" y="25" text-anchor="middle" font-size="13" fill="currentColor" font-weight="700">중</text></svg>
              </div>
              <span>중등부</span>
              <em>바로가기</em>
            </a>
          </li>
          <li>
            <a href="#">
              <div class="quick-icon ai">
                <svg viewBox="0 0 40 40" fill="none"><circle cx="20" cy="20" r="18" stroke="currentColor" stroke-width="2"/><text x="20" y="25" text-anchor="middle" font-size="11" fill="currentColor" font-weight="700">AI</text></svg>
              </div>
              <span>AI 추천</span>
              <em>맞춤 강의</em>
            </a>
          </li>
          <li>
            <a href="#">
              <div class="quick-icon mypage">
                <svg viewBox="0 0 40 40" fill="none"><circle cx="20" cy="20" r="18" stroke="currentColor" stroke-width="2"/><path d="M20 18a5 5 0 100-10 5 5 0 000 10zm-9 14c0-5 4-9 9-9s9 4 9 9" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
              </div>
              <span>마이페이지</span>
              <em>나의 강의실</em>
            </a>
          </li>
        </ul>
      </div>
    </section>

    <!-- 강의 섹션: 고등부 인기 강의 -->
    <section class="lecture-section">
      <div class="container">
        <div class="section-header">
          <div class="section-title-wrap">
            <span class="section-badge">고등부</span>
            <h2 class="section-title">인기 강의</h2>
          </div>
          <a href="#" class="btn-more">전체보기 <span>→</span></a>
        </div>

        <div class="tab-menu" id="highTab">
          <button class="tab-btn active" data-tab="all">전체</button>
          <button class="tab-btn" data-tab="korean">국어</button>
          <button class="tab-btn" data-tab="math">수학</button>
          <button class="tab-btn" data-tab="english">영어</button>
          <button class="tab-btn" data-tab="science">탐구</button>
        </div>

        <div class="lecture-grid">
          <div class="lecture-card">
            <div class="lecture-thumb">
              <div class="thumb-placeholder"><span>강의 썸네일1</span></div>
              <span class="lecture-badge new">NEW</span>
            </div>
            <div class="lecture-info">
              <span class="lecture-subject korean">국어</span>
              <h3 class="lecture-title">2025 수능 국어 완성 - 비문학 독해 전략</h3>
              <p class="lecture-teacher">김민준 선생님</p>
              <div class="lecture-meta">
                <span class="lecture-count">총 48강</span>
                <span class="lecture-rating">★ 4.9</span>
              </div>
            </div>
          </div>
          <div class="lecture-card">
            <div class="lecture-thumb">
              <div class="thumb-placeholder"><span>강의 썸네일2</span></div>
              <span class="lecture-badge hot">HOT</span>
            </div>
            <div class="lecture-info">
              <span class="lecture-subject math">수학</span>
              <h3 class="lecture-title">수학 1·2 개념부터 실전까지 완벽 정리</h3>
              <p class="lecture-teacher">이서연 선생님</p>
              <div class="lecture-meta">
                <span class="lecture-count">총 60강</span>
                <span class="lecture-rating">★ 4.8</span>
              </div>
            </div>
          </div>
          <div class="lecture-card">
            <div class="lecture-thumb">
              <div class="thumb-placeholder"><span>강의 썸네일3</span></div>
            </div>
            <div class="lecture-info">
              <span class="lecture-subject english">영어</span>
              <h3 class="lecture-title">수능 영어 1등급 달성 - 독해·어법 집중</h3>
              <p class="lecture-teacher">박지훈 선생님</p>
              <div class="lecture-meta">
                <span class="lecture-count">총 52강</span>
                <span class="lecture-rating">★ 4.7</span>
              </div>
            </div>
          </div>
          <div class="lecture-card">
            <div class="lecture-thumb">
              <div class="thumb-placeholder"><span>강의 썸네일4</span></div>
              <span class="lecture-badge new">NEW</span>
            </div>
            <div class="lecture-info">
              <span class="lecture-subject science">탐구</span>
              <h3 class="lecture-title">생명과학 Ⅱ 완전정복 - 핵심 개념 총정리</h3>
              <p class="lecture-teacher">최수진 선생님</p>
              <div class="lecture-meta">
                <span class="lecture-count">총 36강</span>
                <span class="lecture-rating">★ 4.9</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 이벤트 & 공지사항 배너 -->
    <section class="event-banner-section">
      <div class="container">
        <div class="event-banner-grid">
          <div class="event-banner-item">
            <div class="event-banner-img placeholder-event1">
              <span class="image-label">이미지4 (이벤트 배너)</span>
            </div>
          </div>
          <div class="event-banner-item">
            <div class="event-banner-img placeholder-event2">
              <span class="image-label">이미지5 (이벤트 배너)</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 중등부 인기 강의 -->
    <section class="lecture-section bg-light">
      <div class="container">
        <div class="section-header">
          <div class="section-title-wrap">
            <span class="section-badge middle">중등부</span>
            <h2 class="section-title">인기 강의</h2>
          </div>
          <a href="#" class="btn-more">전체보기 <span>→</span></a>
        </div>

        <div class="lecture-grid">
          <div class="lecture-card">
            <div class="lecture-thumb">
              <div class="thumb-placeholder"><span>강의 썸네일5</span></div>
              <span class="lecture-badge hot">HOT</span>
            </div>
            <div class="lecture-info">
              <span class="lecture-subject math">수학</span>
              <h3 class="lecture-title">중학 수학 3학년 1학기 내신 완성</h3>
              <p class="lecture-teacher">정우석 선생님</p>
              <div class="lecture-meta">
                <span class="lecture-count">총 40강</span>
                <span class="lecture-rating">★ 4.8</span>
              </div>
            </div>
          </div>
          <div class="lecture-card">
            <div class="lecture-thumb">
              <div class="thumb-placeholder"><span>강의 썸네일6</span></div>
            </div>
            <div class="lecture-info">
              <span class="lecture-subject korean">국어</span>
              <h3 class="lecture-title">중학 국어 문학 + 문법 단기 완성</h3>
              <p class="lecture-teacher">한소희 선생님</p>
              <div class="lecture-meta">
                <span class="lecture-count">총 32강</span>
                <span class="lecture-rating">★ 4.7</span>
              </div>
            </div>
          </div>
          <div class="lecture-card">
            <div class="lecture-thumb">
              <div class="thumb-placeholder"><span>강의 썸네일7</span></div>
              <span class="lecture-badge new">NEW</span>
            </div>
            <div class="lecture-info">
              <span class="lecture-subject english">영어</span>
              <h3 class="lecture-title">중학 영어 회화 + 문법 올인원 과정</h3>
              <p class="lecture-teacher">오민아 선생님</p>
              <div class="lecture-meta">
                <span class="lecture-count">총 44강</span>
                <span class="lecture-rating">★ 4.6</span>
              </div>
            </div>
          </div>
          <div class="lecture-card">
            <div class="lecture-thumb">
              <div class="thumb-placeholder"><span>강의 썸네일8</span></div>
            </div>
            <div class="lecture-info">
              <span class="lecture-subject science">과학</span>
              <h3 class="lecture-title">중학 과학 전 학년 핵심 개념 정리</h3>
              <p class="lecture-teacher">강태양 선생님</p>
              <div class="lecture-meta">
                <span class="lecture-count">총 38강</span>
                <span class="lecture-rating">★ 4.8</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 공지사항 + FAQ -->
    <section class="board-section">
      <div class="container">
        <div class="board-grid">
          <!-- 공지사항 -->
          <div class="board-box">
            <div class="board-header">
              <h2>공지사항</h2>
              <a href="#" class="btn-more-sm">더보기 +</a>
            </div>
            <ul class="board-list">
              <li class="board-item">
                <span class="board-badge new-badge">NEW</span>
                <a href="#" class="board-link">2025학년도 수능 대비 특강 일정 안내</a>
                <span class="board-date">2025.03.01</span>
              </li>
              <li class="board-item">
                <a href="#" class="board-link">봄학기 신규 강의 오픈 안내</a>
                <span class="board-date">2025.02.28</span>
              </li>
              <li class="board-item">
                <a href="#" class="board-link">이벤트 당첨자 발표 (겨울방학 인증샷)</a>
                <span class="board-date">2025.02.20</span>
              </li>
              <li class="board-item">
                <a href="#" class="board-link">시스템 점검 안내 (3월 5일 새벽 2~4시)</a>
                <span class="board-date">2025.02.18</span>
              </li>
              <li class="board-item">
                <a href="#" class="board-link">강의 다운로드 정책 변경 안내</a>
                <span class="board-date">2025.02.10</span>
              </li>
            </ul>
          </div>

          <!-- FAQ -->
          <div class="board-box">
            <div class="board-header">
              <h2>자주 묻는 질문</h2>
              <a href="#" class="btn-more-sm">더보기 +</a>
            </div>
            <ul class="board-list faq-list">
              <li class="board-item">
                <span class="faq-q">Q</span>
                <a href="#" class="board-link">회원가입 후 정회원 전환은 어떻게 하나요?</a>
              </li>
              <li class="board-item">
                <span class="faq-q">Q</span>
                <a href="#" class="board-link">수강신청 및 이용 방법을 알고 싶어요.</a>
              </li>
              <li class="board-item">
                <span class="faq-q">Q</span>
                <a href="#" class="board-link">강의 재생이 안 될 때는 어떻게 하나요?</a>
              </li>
              <li class="board-item">
                <span class="faq-q">Q</span>
                <a href="#" class="board-link">모바일에서도 수강할 수 있나요?</a>
              </li>
              <li class="board-item">
                <span class="faq-q">Q</span>
                <a href="#" class="board-link">강의 수강 기간은 얼마나 되나요?</a>
              </li>
            </ul>
          </div>

          <!-- 고객센터 안내 -->
          <div class="board-box cs-box">
            <div class="board-header">
              <h2>고객센터</h2>
            </div>
            <div class="cs-content">
              <div class="cs-tel">
                <span class="cs-tel-label">대표번호</span>
                <strong>1577-0000</strong>
              </div>
              <div class="cs-hours">
                <p>평일 09:00 ~ 18:00</p>
                <p>점심 12:00 ~ 13:00</p>
                <p class="holiday">토·일·공휴일 휴무</p>
              </div>
              <ul class="cs-links">
                <li><a href="#">고객의 소리</a></li>
                <li><a href="#">원격 지원</a></li>
                <li><a href="#">이용 가이드</a></li>
                <li><a href="#">다운로드</a></li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 파트너 기관 -->
    <section class="partners-section">
      <div class="container">
        <div class="section-header">
          <h2 class="section-title sm">함께하는 기관</h2>
        </div>
        <div class="partners-track-wrap">
          <div class="partners-track" id="partnersTrack">
            <span>서울 강북구청</span>
            <span>서울 광진구청</span>
            <span>서울 구로구청</span>
            <span>서울 용산구청</span>
            <span>서울 도봉구청</span>
            <span>경기 군포시청</span>
            <span>경기 남양주시청</span>
            <span>경기 의정부시청</span>
            <span>인천 중구청</span>
            <span>강원 삼척시청</span>
            <span>대전 중구청</span>
            <span>충남 보령시청</span>
            <span>대구 남구청</span>
            <span>부산 해운대구청</span>
            <span>울산 동구청</span>
            <span>경남 밀양시청</span>
            <span>전남 무안군청</span>
            <span>전북 전주시청</span>
          </div>
        </div>
      </div>
    </section>

  </main>

  <!-- 푸터 -->
  <footer class="footer">
    <div class="container">
      <div class="footer-top">
        <div class="footer-logo">
          <span class="logo-text">EDU<em>ON</em></span>
        </div>
        <div class="footer-sns">
          <a href="#" class="sns-link" aria-label="네이버 블로그">
            <svg viewBox="0 0 24 24" fill="currentColor"><path d="M16.273 12.845L7.376 0H0v24h7.727V11.155L16.624 24H24V0h-7.727z"/></svg>
          </a>
          <a href="#" class="sns-link" aria-label="유튜브">
            <svg viewBox="0 0 24 24" fill="currentColor"><path d="M23.498 6.186a3.016 3.016 0 00-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 00.502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 002.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 002.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z"/></svg>
          </a>
          <a href="#" class="sns-link" aria-label="인스타그램">
            <svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zM12 0C8.741 0 8.333.014 7.053.072 2.695.272.273 2.69.073 7.052.014 8.333 0 8.741 0 12c0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98C8.333 23.986 8.741 24 12 24c3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98C15.668.014 15.259 0 12 0zm0 5.838a6.162 6.162 0 100 12.324 6.162 6.162 0 000-12.324zM12 16a4 4 0 110-8 4 4 0 010 8zm6.406-11.845a1.44 1.44 0 100 2.881 1.44 1.44 0 000-2.881z"/></svg>
          </a>
        </div>
      </div>

      <div class="footer-links">
        <a href="#">소개</a>
        <a href="#">찾아오시는 길</a>
        <a href="#">이용약관</a>
        <a href="#" class="privacy">개인정보처리방침</a>
        <a href="#">고객센터</a>
      </div>

      <div class="footer-info">
        <p>
          <span>대표자: 에듀온 대표</span>
          <span>사업자등록번호: 000-00-00000</span>
          <span>통신판매업 신고: 제0000-서울00-00000호</span>
        </p>
        <p>
          <span>주소: 서울특별시 ○○구 ○○로 000</span>
          <span>고객센터: 1577-0000</span>
        </p>
        <p class="footer-copy">COPYRIGHT © 2025 EDUON. ALL RIGHTS RESERVED.</p>
      </div>
    </div>
  </footer>

  <!-- 플로팅 버튼 -->
  <div class="floating-btns">
    <button class="floating-btn chatbot" title="챗봇 상담">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/></svg>
    </button>
    <button class="floating-btn top" id="scrollTop" title="맨 위로">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M18 15l-6-6-6 6"/></svg>
    </button>
  </div>

  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>