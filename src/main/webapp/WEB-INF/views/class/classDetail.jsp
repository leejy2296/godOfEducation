<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="ctx" content="${pageContext.request.contextPath}">
  <title>VIRTUAL_EDUCATION - ${classDto.title}</title>
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
        <h1 class="class-hero-title">강의</h1>
      </div>
    </section>

    <section class="class-section">
      <div class="container">
        <div class="class-card">

          <%-- 강의 헤더 --%>
          <div class="class-detail-header">
            <c:if test="${not empty classDto.subjectName}">
              <span class="class-subject-badge">${classDto.subjectName}</span>
            </c:if>
            <h2 class="class-detail-title">${classDto.title}</h2>
            <div class="class-detail-meta">
              <span>작성자 : <strong>${classDto.writer}</strong></span>
              <span>등록일 : ${classDto.regDate}</span>
              <span>조회수 : ${classDto.viewCount}</span>
              <c:if test="${not empty classDto.modDate}">
                <span>수정일 : ${classDto.modDate} (${classDto.modifier})</span>
              </c:if>
            </div>
            <p class="class-detail-summary">${classDto.summary}</p>
          </div>

          <%-- 영상 플레이어 --%>
          <div class="class-video-wrap">
            <c:choose>
              <c:when test="${not empty embedUrl}">
                <iframe class="class-video-iframe"
                        src="${embedUrl}"
                        frameborder="0"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                        allowfullscreen></iframe>
              </c:when>
              <c:otherwise>
                <div class="class-video-placeholder">영상을 불러올 수 없습니다.</div>
              </c:otherwise>
            </c:choose>
          </div>

          <%-- 하단 버튼 --%>
          <div class="class-detail-actions">
            <a href="${pageContext.request.contextPath}/class/list.do?page=${page}&sortCol=${sortCol}&sortDir=${sortDir}&titleKw=${titleKw}&teacherKw=${teacherKw}&subject=${subject}"
               class="btn-ghost">목록</a>
            <c:if test="${isWriter}">
              <a href="${pageContext.request.contextPath}/class/form.do?docId=${classDto.docId}&page=${page}&sortCol=${sortCol}&sortDir=${sortDir}"
                 class="btn-primary">수정</a>
              <button class="btn-danger btn-class-delete" data-doc-id="${classDto.docId}">삭제</button>
            </c:if>
          </div>

        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
  <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/classList.js"></script>

  <c:if test="${not empty alertMsg}">
    <script>alert('${alertMsg}');</script>
  </c:if>
</body>
</html>
