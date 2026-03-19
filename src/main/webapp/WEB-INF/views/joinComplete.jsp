<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>VIRTUAL_EDUCATION - 회원가입 완료</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=Noto+Serif+KR:wght@400;600;700&display=swap" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/resources/css/main.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath}/resources/css/auth.css" rel="stylesheet" />
</head>
<body>

  <!-- 헤더 -->
  <jsp:include page="/WEB-INF/views/includes/header.jsp" />

  <main class="auth-wrap">
    <section class="auth-hero">
      <div class="container">
        <h1 class="auth-title">회원가입 완료</h1>
        <p class="auth-desc">가입이 완료되었습니다. 로그인 후 서비스를 이용해 주세요.</p>
      </div>
    </section>

    <section class="auth-section">
      <div class="container">
        <div class="auth-card">
          <div class="auth-card-body">
            <div class="auth-icon" aria-hidden="true">✓</div>
            <h2 class="auth-card-title">가입이 정상적으로 처리되었습니다.</h2>
            <p class="auth-card-text">
              로그인 후 VIRTUAL EDUCATION의 다양한 서비스를 이용할 수 있습니다.
            </p>

            <div class="auth-actions">
              <a class="btn-ghost" href="${pageContext.request.contextPath}/main/main.do">메인으로</a>
              <a class="btn-primary" href="${pageContext.request.contextPath}/login/loginPage.do">로그인</a>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />

  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/auth.js"></script>
</body>
</html>