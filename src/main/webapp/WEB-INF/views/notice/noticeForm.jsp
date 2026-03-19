<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>VIRTUAL_EDUCATION - 공지사항 ${mode eq 'edit' ? '수정' : '등록'}</title>
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
        <h1 class="notice-title">공지사항 ${mode eq 'edit' ? '수정' : '등록'}</h1>
      </div>
    </section>

    <section class="notice-section">
      <div class="container">
        <div class="notice-card">

          <c:choose>
            <%-- 수정 --%>
            <c:when test="${mode eq 'edit'}">
              <form id="noticeForm" class="notice-form"
                    action="${pageContext.request.contextPath}/notice/update.do"
                    method="post" novalidate>
                <input type="hidden" name="docId" value="${notice.docId}">
                <input type="hidden" name="page"  value="${page}">

                <div class="form-row">
                  <label class="form-label" for="title">제목 <span class="req">*</span></label>
                  <input type="text" id="title" name="title" class="input" value="${notice.title}" required>
                  <p class="form-msg" data-msg-for="title"></p>
                </div>

                <div class="form-row">
                  <label class="form-label" for="content">내용 <span class="req">*</span></label>
                  <textarea id="content" name="content" class="notice-textarea" required>${notice.content}</textarea>
                  <p class="form-msg" data-msg-for="content"></p>
                </div>

                <div class="notice-form-actions">
                  <a href="${pageContext.request.contextPath}/notice/detail.do?docId=${notice.docId}&page=${page}" class="btn-ghost">취소</a>
                  <button type="submit" class="btn-primary">수정완료</button>
                </div>
              </form>
            </c:when>

            <%-- 등록 --%>
            <c:otherwise>
              <form id="noticeForm" class="notice-form"
                    action="${pageContext.request.contextPath}/notice/register.do"
                    method="post" novalidate>

                <div class="form-row">
                  <label class="form-label" for="title">제목 <span class="req">*</span></label>
                  <input type="text" id="title" name="title" class="input" required>
                  <p class="form-msg" data-msg-for="title"></p>
                </div>

                <div class="form-row">
                  <label class="form-label" for="content">내용 <span class="req">*</span></label>
                  <textarea id="content" name="content" class="notice-textarea" required></textarea>
                  <p class="form-msg" data-msg-for="content"></p>
                </div>

                <div class="notice-form-actions">
                  <a href="${pageContext.request.contextPath}/notice/list.do" class="btn-ghost">취소</a>
                  <button type="submit" class="btn-primary">등록완료</button>
                </div>
              </form>
            </c:otherwise>
          </c:choose>

        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />

  <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>

</body>
</html>
