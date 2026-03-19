<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="ctx" content="${pageContext.request.contextPath}">
  <title>VIRTUAL_EDUCATION - 공지사항</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=Noto+Serif+KR:wght@400;600;700&display=swap" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/notice.css" rel="stylesheet" />
</head>
<body>

  <jsp:include page="/WEB-INF/views/includes/header.jsp" />

  <main class="notice-wrap">
    <section class="notice-hero">
      <div class="container">
        <h1 class="notice-title">공지사항</h1>
        <p class="notice-desc">새로운 소식과 공지를 확인하세요.</p>
      </div>
    </section>

    <section class="notice-section">
      <div class="container">
        <div class="notice-card">

          <%-- 삭제된 게시물 표시 (admin만) --%>
          <c:if test="${isAdmin and notice.deleteYn eq 'Y'}">
            <div class="deleted-notice-bar">삭제 처리된 게시물입니다.</div>
          </c:if>

          <div class="notice-detail-header">
            <h2 class="notice-detail-title">${notice.title}</h2>
            <div class="notice-detail-meta">
              <span>작성자 : <strong>${notice.writer}</strong></span>
              <span>등록일 : ${notice.regDate}</span>
              <c:if test="${not empty notice.modDate}">
                <span>수정일 : ${notice.modDate} (${notice.modifier})</span>
              </c:if>
            </div>
          </div>

          <div class="notice-detail-content">
            <pre>${notice.content}</pre>
          </div>

          <div class="notice-detail-actions">
            <a href="${pageContext.request.contextPath}/notice/list.do?page=${page}" class="btn-ghost">목록</a>
            <c:if test="${isAdmin}">
              <c:choose>
                <c:when test="${notice.deleteYn eq 'Y'}">
                  <%-- 복구 버튼 --%>
                  <button class="btn-warning btn-restore-notice" data-doc-id="${notice.docId}">복구</button>
                </c:when>
                <c:otherwise>
                  <%-- 수정 / 삭제 버튼 --%>
                  <a href="${pageContext.request.contextPath}/notice/form.do?docId=${notice.docId}&page=${page}" class="btn-primary">수정</a>
                  <button class="btn-danger btn-delete-notice" data-doc-id="${notice.docId}">삭제</button>
                </c:otherwise>
              </c:choose>
            </c:if>
          </div>

        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />

  <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>

  <c:if test="${not empty alertMsg}">
    <script>alert('${alertMsg}');</script>
  </c:if>

</body>
</html>
