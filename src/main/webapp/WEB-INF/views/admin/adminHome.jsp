<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>VIRTUAL_EDUCATION - 관리자페이지</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=Noto+Serif+KR:wght@400;600;700&display=swap" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet" />
</head>
<body>

  <jsp:include page="/WEB-INF/views/includes/header.jsp" />

  <main class="admin-wrap">
    <section class="admin-hero">
      <div class="container">
        <h1 class="admin-title">관리자 페이지</h1>
        <p class="admin-desc">관리할 항목을 선택해주세요.</p>
      </div>
    </section>

    <section class="admin-section">
      <div class="container">
        <div class="admin-home-grid">

          <a href="${pageContext.request.contextPath}/admin/userManage.do" class="admin-home-card">
            <div class="admin-home-icon">👥</div>
            <h2 class="admin-home-card-title">회원관리</h2>
            <p class="admin-home-card-desc">회원 승인 · 탈퇴 · 복구를 관리합니다.</p>
          </a>

          <a href="${pageContext.request.contextPath}/admin/subject/list.do" class="admin-home-card">
            <div class="admin-home-icon">📚</div>
            <h2 class="admin-home-card-title">과목관리</h2>
            <p class="admin-home-card-desc">강의 과목을 등록 · 수정 · 삭제합니다.</p>
          </a>

        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
  <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>
