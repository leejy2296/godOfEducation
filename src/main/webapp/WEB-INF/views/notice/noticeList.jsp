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

          <div class="notice-card-header">
            <span class="notice-total">전체 <strong>${paged.totalCount}</strong>건</span>
            <c:if test="${isAdmin}">
              <a href="${pageContext.request.contextPath}/notice/form.do" class="btn-primary notice-write-btn">등록</a>
            </c:if>
          </div>

          <table class="notice-table">
            <thead>
              <tr>
                <th class="col-sq">번호</th>
                <th class="col-title">제목</th>
                <th class="col-writer">작성자</th>
                <th class="col-date">등록일</th>
              </tr>
            </thead>
            <tbody>
              <c:choose>
                <c:when test="${empty paged.list}">
                  <tr><td colspan="4" class="notice-empty">등록된 공지사항이 없습니다.</td></tr>
                </c:when>
                <c:otherwise>
                  <c:forEach var="notice" items="${paged.list}">
                    <tr class="${isAdmin and notice.deleteYn eq 'Y' ? 'row-deleted' : ''}">
                      <td class="col-sq">${notice.sq}</td>
                      <td class="col-title">
                        <a href="${pageContext.request.contextPath}/notice/detail.do?docId=${notice.docId}&page=${paged.currentPage}" class="notice-link">
                          ${notice.title}
                          <c:if test="${isAdmin and notice.deleteYn eq 'Y'}">
                            <span class="deleted-badge">삭제됨</span>
                          </c:if>
                        </a>
                      </td>
                      <td class="col-writer">${notice.writer}</td>
                      <td class="col-date">${notice.regDate}</td>
                    </tr>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
            </tbody>
          </table>

          <%-- 페이징 --%>
          <div class="notice-paging">
            <c:if test="${paged.currentPage > 1}">
              <a href="${pageContext.request.contextPath}/notice/list.do?page=${paged.currentPage - 1}" class="page-btn">&#8249;</a>
            </c:if>
            <c:forEach begin="1" end="${paged.totalPages}" var="p">
              <a href="${pageContext.request.contextPath}/notice/list.do?page=${p}"
                 class="page-btn ${p == paged.currentPage ? 'active' : ''}">${p}</a>
            </c:forEach>
            <c:if test="${paged.currentPage < paged.totalPages}">
              <a href="${pageContext.request.contextPath}/notice/list.do?page=${paged.currentPage + 1}" class="page-btn">&#8250;</a>
            </c:if>
          </div>

        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />

  <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

  <c:if test="${not empty alertMsg}">
    <script>alert('${alertMsg}');</script>
  </c:if>

</body>
</html>
