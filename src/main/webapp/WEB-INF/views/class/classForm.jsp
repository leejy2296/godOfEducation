<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>VIRTUAL_EDUCATION - 강의 ${mode eq 'edit' ? '수정' : '등록'}</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=Noto+Serif+KR:wght@400;600;700&display=swap" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/css/class.css" rel="stylesheet" />
</head>
<body>

  <jsp:include page="/WEB-INF/views/includes/header.jsp" />

  <main class="class-wrap">
    <section class="class-hero">
      <div class="container">
        <h1 class="class-hero-title">강의 ${mode eq 'edit' ? '수정' : '등록'}</h1>
      </div>
    </section>

    <section class="class-section">
      <div class="container">
        <div class="class-card">
          <c:choose>
            <c:when test="${mode eq 'edit'}">
              <form id="classForm" class="class-form"
                    action="${pageContext.request.contextPath}/class/update.do" method="post" novalidate>
                <input type="hidden" name="docId"   value="${classDto.docId}">
                <input type="hidden" name="page"    value="${page}">
                <input type="hidden" name="sortCol" value="${sortCol}">
                <input type="hidden" name="sortDir" value="${sortDir}">
            </c:when>
            <c:otherwise>
              <form id="classForm" class="class-form"
                    action="${pageContext.request.contextPath}/class/register.do" method="post" novalidate>
            </c:otherwise>
          </c:choose>

            <div class="class-form-row">
              <label class="class-form-label" for="title">강의명 <span class="req">*</span></label>
              <input type="text" id="title" name="title" class="input"
                     value="${classDto.title}" placeholder="강의명을 입력하세요" required>
              <p class="form-msg" data-msg-for="title"></p>
            </div>

            <div class="class-form-row">
              <label class="class-form-label" for="summary">강의 요약 <span class="req">*</span></label>
              <textarea id="summary" name="summary" class="class-textarea"
                        placeholder="강의를 간략하게 설명해주세요" required>${classDto.summary}</textarea>
              <p class="form-msg" data-msg-for="summary"></p>
            </div>

            <div class="class-form-row">
              <label class="class-form-label" for="subjectDocId">과목 <span class="req">*</span></label>
              <select id="subjectDocId" name="subjectDocId" class="class-select" required>
                <option value="">과목을 선택하세요</option>
                <c:forEach var="subject" items="${subjects}">
                  <option value="${subject.docId}"
                    ${classDto.subjectDocId eq subject.docId ? 'selected' : ''}>${subject.name}</option>
                </c:forEach>
              </select>
              <p class="form-msg" data-msg-for="subjectDocId"></p>
            </div>

            <div class="class-form-row">
              <label class="class-form-label" for="videoUrl">영상 주소 <span class="req">*</span></label>
              <input type="url" id="videoUrl" name="videoUrl" class="input"
                     value="${classDto.videoUrl}" placeholder="유튜브 영상 URL을 입력하세요" required>
              <p class="form-msg" data-msg-for="videoUrl"></p>
            </div>

            <div class="class-form-actions">
              <c:choose>
                <c:when test="${mode eq 'edit'}">
                  <a href="${pageContext.request.contextPath}/class/detail.do?docId=${classDto.docId}&page=${page}&sortCol=${sortCol}&sortDir=${sortDir}"
                     class="btn-ghost">취소</a>
                  <button type="submit" class="btn-primary">수정완료</button>
                </c:when>
                <c:otherwise>
                  <a href="${pageContext.request.contextPath}/class/list.do" class="btn-ghost">취소</a>
                  <button type="submit" class="btn-primary">등록완료</button>
                </c:otherwise>
              </c:choose>
            </div>

          </form>
        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
  <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/classForm.js"></script>
</body>
</html>
