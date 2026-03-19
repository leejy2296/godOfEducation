<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>VIRTUAL_EDUCATION - 회원가입 동의</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=Noto+Serif+KR:wght@400;600;700&display=swap" rel="stylesheet">

  <!-- 기존 메인 공통 스타일 -->
  <!-- 회원가입 전용 추가 스타일 -->
  <link href="${pageContext.request.contextPath}/resources/css/join.css" rel="stylesheet" />
</head>
<body>

  <!-- 헤더 (main.jsp와 동일한 구조) -->
  <jsp:include page="/WEB-INF/views/includes/header.jsp" />

  <main class="join-wrap">
    <section class="join-hero">
      <div class="container">
        <div class="join-hero-inner">
          <h1 class="join-title">회원가입</h1>
          <p class="join-desc">서비스 이용을 위해 약관 및 정보 제공 동의를 진행해주세요.</p>

          <div class="join-steps">
            <div class="step active">
              <span class="step-num">1</span>
              <span class="step-label">동의</span>
            </div>
            <div class="step">
              <span class="step-num">2</span>
              <span class="step-label">정보 입력</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="join-section">
      <div class="container">
        <div class="join-card">
          <div class="join-card-header">
            <h2>약관 동의</h2>
            <p>필수 항목에 동의해야 회원가입을 진행할 수 있습니다.</p>
          </div>

			          <form id="joinAgreeForm" class="join-form" action="${pageContext.request.contextPath}/join/joinPage2.do" method="get">
			
			  <div class="agree-box">
			    <label class="agree-all">
			      <input type="checkbox" id="agreeAll">
			      <span class="agree-text">
			        <strong>전체 동의</strong>
			        <em>필수 항목</em>
			      </span>
			    </label>
			  </div>
			
			  <div class="agree-list">
			    <label class="agree-item">
			      <input type="checkbox" class="agree-required" id="agreeTerms">
			      <span class="agree-text">
			        <strong>(필수)</strong> 이용약관 동의
			      </span>
			      <button type="button" class="agree-view" data-modal="modalTerms">보기</button>
			    </label>
			
			    <label class="agree-item">
			      <input type="checkbox" class="agree-required" id="agreePrivacy">
			      <span class="agree-text">
			        <strong>(필수)</strong> 개인정보 수집 및 이용 동의
			      </span>
			      <button type="button" class="agree-view" data-modal="modalPrivacy">보기</button>
			    </label>
			  </div>
			
			  <div class="join-actions">
			    <a class="btn-ghost" href="${pageContext.request.contextPath}/main/main.do">취소</a>
			    <button type="submit" class="btn-primary" id="agreeNextBtn" disabled>다음</button>
			  </div>
			
			  <p class="join-hint">※ 필수 동의 항목: 이용약관, 개인정보 수집 및 이용</p>
			</form>
        </div>
      </div>
    </section>

    <!-- 간단 모달(보기) -->
    <div class="modal" id="modalTerms" aria-hidden="true">
      <div class="modal-dim" data-close="modalTerms"></div>
      <div class="modal-panel" role="dialog" aria-modal="true" aria-label="이용약관">
        <div class="modal-header">
          <h3>이용약관</h3>
          <button type="button" class="modal-close" data-close="modalTerms">×</button>
        </div>
        <div class="modal-body">
          <p>예시 약관 내용입니다. 실제 서비스 약관으로 교체하세요.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn-primary btn-sm" data-close="modalTerms">확인</button>
        </div>
      </div>
    </div>

    <div class="modal" id="modalPrivacy" aria-hidden="true">
      <div class="modal-dim" data-close="modalPrivacy"></div>
      <div class="modal-panel" role="dialog" aria-modal="true" aria-label="개인정보 수집 및 이용">
        <div class="modal-header">
          <h3>개인정보 수집 및 이용</h3>
          <button type="button" class="modal-close" data-close="modalPrivacy">×</button>
        </div>
        <div class="modal-body">
          <p>예시 개인정보 처리 안내입니다. 실제 정책 문구로 교체하세요.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn-primary btn-sm" data-close="modalPrivacy">확인</button>
        </div>
      </div>
    </div>
  </main>

  <!-- 푸터 (간단 버전) -->
  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />

  <!-- JS -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/join.js"></script>
</body>
</html>