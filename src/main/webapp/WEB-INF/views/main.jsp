<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>VIRTUAL_EDUCATION</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=Noto+Serif+KR:wght@400;600;700&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" />
</head>
<body>
<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

  <main>

    <!-- 메인 배너 슬라이더 -->
    <section class="hero-banner">
      <div class="banner-slider" id="bannerSlider">
        <div class="banner-slide active">
          <div class="banner-image-placeholder">
            <img src="https://images.unsplash.com/photo-1503676260728-1c00da094a0b" alt="메인 배너1" style="position:absolute;width:100%;height:100%;object-fit:cover;">
            <div class="banner-overlay"></div>
            <div class="banner-content">
              <p class="banner-tag">이미지1_작은제목</p>
              <h2 class="banner-title">이미지1_내용<br>줄바꿈_내용</h2>
              <p class="banner-desc">이미지1_작은내용</p>
              <div class="banner-actions">
              </div>
            </div>
          </div>
        </div>
        <div class="banner-slide">
          <div class="banner-image-placeholder color2">
            <img src="https://images.unsplash.com/photo-1496307042754-b4aa456c4a2d" alt="메인 배너2" style="position:absolute;width:100%;height:100%;object-fit:cover;">
            <div class="banner-overlay"></div>
            <div class="banner-content">
              <p class="banner-tag">이미지2_작은제목</p>
              <h2 class="banner-title">이미지2_내용<br>줄바꿈_내용</h2>
              <p class="banner-desc">이미지2_작은내용</p>
              <div class="banner-actions">
              </div>
            </div>
          </div>
        </div>
        <div class="banner-slide">
          <div class="banner-image-placeholder color3">
            <img src="https://images.unsplash.com/photo-1513258496099-48168024aec0" alt="메인 배너3" style="position:absolute;width:100%;height:100%;object-fit:cover;">
            <div class="banner-overlay"></div>
            <div class="banner-content">
              <p class="banner-tag">이미지3_작은제목</p>
              <h2 class="banner-title">이미지3_내용<br>줄바꿈_내용</h2>
              <p class="banner-desc">이미지3_작은내용</p>
              <div class="banner-actions">
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
                <svg viewBox="0 0 40 40" fill="none"><circle cx="20" cy="20" r="18" stroke="currentColor" stroke-width="2"/><text x="20" y="25" text-anchor="middle" font-size="13" fill="currentColor" font-weight="700">1</text></svg>
              </div>
              <span>카테고리</span>
              <em>바로가기</em>
            </a>
          </li>
          <li>
            <a href="#">
              <div class="quick-icon middle">
                <svg viewBox="0 0 40 40" fill="none"><circle cx="20" cy="20" r="18" stroke="currentColor" stroke-width="2"/><text x="20" y="25" text-anchor="middle" font-size="13" fill="currentColor" font-weight="700">2</text></svg>
              </div>
              <span>카테고리</span>
              <em>바로가기</em>
            </a>
          </li>
          <li>
            <a href="#">
              <div class="quick-icon mypage">
                <svg viewBox="0 0 40 40" fill="none"><circle cx="20" cy="20" r="18" stroke="currentColor" stroke-width="2"/><path d="M20 18a5 5 0 100-10 5 5 0 000 10zm-9 14c0-5 4-9 9-9s9 4 9 9" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>
              </div>
              <span>카테고리</span>
              <em>바로가기</em>
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
            <span class="section-badge">HOT</span>
            <h2 class="section-title">인기 강의</h2>
          </div>
          <a href="${pageContext.request.contextPath}/class/list.do" class="btn-more">전체보기 <span>→</span></a>
        </div>

        <div class="lecture-grid">
          <c:choose>
            <c:when test="${empty topClasses}">
              <div style="grid-column:1/-1; padding:40px; text-align:center; color:var(--text-muted);">
                등록된 강의가 없습니다.
              </div>
            </c:when>
            <c:otherwise>
              <c:forEach var="cls" items="${topClasses}">
                <div class="lecture-card" onclick="location.href='${pageContext.request.contextPath}/class/detail.do?docId=${cls.docId}'" style="cursor:pointer;">
                  <div class="lecture-thumb">
                    <c:choose>
                      <c:when test="${not empty cls.thumbnailUrl}">
                        <img src="${cls.thumbnailUrl}" alt="${cls.title}" style="width:100%;height:100%;object-fit:cover;">
                      </c:when>
                      <c:otherwise>
                        <div class="thumb-placeholder"><span>No Image</span></div>
                      </c:otherwise>
                    </c:choose>
                  </div>
                  <div class="lecture-info">
                    <c:if test="${not empty cls.subjectName}">
                      <span class="lecture-subject korean">${cls.subjectName}</span>
                    </c:if>
                    <h3 class="lecture-title">${cls.title}</h3>
                    <p class="lecture-teacher">${cls.writer}</p>
                    <div class="lecture-meta">
                      <span class="lecture-count">
                        <c:choose>
                          <c:when test="${not empty cls.summary and fn:length(cls.summary) > 10}">
                            ${fn:substring(cls.summary, 0, 10)}...
                          </c:when>
                          <c:otherwise>${cls.summary}</c:otherwise>
                        </c:choose>
                      </span>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </section>

    <!-- 이벤트 & 공지사항 배너 -->
    <section class="event-banner-section">
      <div class="container">
        <div class="event-banner-grid">
          <div class="event-banner-item">
            <div class="event-banner-img placeholder-event1">
              <span class="image-label">이미지4 (기타 배너)</span>
            </div>
          </div>
          <div class="event-banner-item">
            <div class="event-banner-img placeholder-event2">
              <span class="image-label">이미지5 (기타 배너)</span>
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
              <a href="${pageContext.request.contextPath}/notice/list.do" class="btn-more-sm">더보기 +</a>
            </div>
            <ul class="board-list">
              <c:choose>
                <c:when test="${empty recentNotices}">
                  <li class="board-item">
                    <span class="board-link" style="color:var(--text-muted);">등록된 공지사항이 없습니다.</span>
                  </li>
                </c:when>
                <c:otherwise>
                  <c:forEach var="notice" items="${recentNotices}">
                    <li class="board-item">
                      <a href="${pageContext.request.contextPath}/notice/detail.do?docId=${notice.docId}" class="board-link">${notice.title}</a>
                      <span class="board-date">${notice.regDate}</span>
                    </li>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
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
                <a href="#" class="board-link">질문1</a>
              </li>
              <li class="board-item">
                <span class="faq-q">Q</span>
                <a href="#" class="board-link">질문2</a>
              </li>
              <li class="board-item">
                <span class="faq-q">Q</span>
                <a href="#" class="board-link">질문3</a>
              </li>
              <li class="board-item">
                <span class="faq-q">Q</span>
                <a href="#" class="board-link">질문4</a>
              </li>
              <li class="board-item">
                <span class="faq-q">Q</span>
                <a href="#" class="board-link">질문5</a>
              </li>
            </ul>
          </div>

          <!-- 고객센터 안내 -->
          <div class="board-box cs-box">
            <div class="board-header">
              <h2>기타부분</h2>
            </div>
            <div class="cs-content">
              <div class="cs-tel">
                <span class="cs-tel-label">대표</span>
                <strong>독고혜지</strong>
              </div>
              <div class="cs-hours">
                <p>기타내용1</p>
                <p>기타내용2</p>
                <p class="holiday">중요 기타내용</p>
              </div>
              <ul class="cs-links">
                <li><a href="#">기타링크1</a></li>
                <li><a href="#">기타링크2</a></li>
                <li><a href="#">기타링크3</a></li>
                <li><a href="#">기타링크4</a></li>
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
          <h2 class="section-title sm">플로우파트</h2>
        </div>
        <div class="partners-track-wrap">
          <div class="partners-track" id="partnersTrack">
            <span>플로우1</span>
            <span>플로우2</span>
            <span>플로우3</span>
            <span>플로우4</span>
            <span>플로우5</span>
            <span>플로우6</span>
            <span>플로우7</span>
            <span>플로우8</span>
            <span>플로우9</span>
            <span>플로우10</span>
            <span>플로우11</span>
            <span>플로우12</span>
            <span>플로우13</span>
            <span>플로우14</span>
            <span>플로우15</span>
            <span>플로우16</span>
            <span>플로우17</span>
          </div>
        </div>
      </div>
    </section>

  </main>

  <!-- 푸터 -->
  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />

  <!-- 플로팅 버튼 -->
  <div class="floating-btns">
    <button class="floating-btn top" id="scrollTop" title="맨 위로">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M18 15l-6-6-6 6"/></svg>
    </button>
  </div>

  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>