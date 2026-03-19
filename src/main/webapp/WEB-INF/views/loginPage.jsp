<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>VIRTUAL_EDUCATION - 로그인</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=Noto+Serif+KR:wght@400;600;700&display=swap" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/resources/css/auth.css" rel="stylesheet" />
</head>
<body>

  <!-- 헤더 -->
  <jsp:include page="/WEB-INF/views/includes/header.jsp" />

  <main class="auth-wrap">
    <section class="auth-hero">
      <div class="container">
        <h1 class="auth-title">로그인</h1>
        <p class="auth-desc">아이디와 비밀번호를 입력해 주세요.</p>
      </div>
    </section>

    <section class="auth-section">
      <div class="container">
        <div class="auth-card">
          <div class="auth-card-header">
            <h2>계정 로그인</h2>
            <p>입력하신 정보로 로그인을 진행합니다.</p>
          </div>

          <form id="loginForm" class="auth-form" action="${pageContext.request.contextPath}/login/loginProc.do" method="post" novalidate>
            <div class="auth-field">
              <label class="auth-label" for="loginId">아이디</label>
              <input class="auth-input" type="text" id="loginId" name="loginId" autocomplete="username" placeholder="아이디를 입력하세요" required>
              <p class="auth-msg" data-msg-for="loginId"></p>
            </div>

            <div class="auth-field">
              <label class="auth-label" for="loginPw">비밀번호</label>
              <input class="auth-input" type="password" id="loginPw" name="loginPw" autocomplete="current-password" placeholder="비밀번호를 입력하세요" required>
              <p class="auth-msg" data-msg-for="loginPw"></p>
            </div>

            <div class="auth-row">
              <a class="auth-link" href="${pageContext.request.contextPath}/login/findPassword.do">비밀번호 찾기</a>
            </div>

            <div class="auth-actions">
              <button type="submit" class="btn-primary w-full">로그인</button>
              <a class="btn-ghost w-full" href="${pageContext.request.contextPath}/join/joinPage1.do">회원가입</a>
            </div>
          </form>

        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />

  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/auth.js"></script>

  <%-- 로그인 실패 시 서버에서 넘어온 alert 메시지 출력 --%>
  <c:if test="${not empty alertMsg}">
    <script>alert('${alertMsg}');</script>
  </c:if>

</body>
</html>
