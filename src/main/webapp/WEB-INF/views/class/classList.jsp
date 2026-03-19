<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="ctx" content="${pageContext.request.contextPath}">
  <title>VIRTUAL_EDUCATION - 강의</title>
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
        <p class="class-hero-desc">다양한 강의를 만나보세요.</p>
      </div>
    </section>

    <section class="class-section">
      <div class="container">

        <%-- 검색 영역 --%>
        <form class="class-search-form" method="get" action="${pageContext.request.contextPath}/class/list.do" id="searchForm">
          <input type="hidden" name="sortCol" value="${paged.sortCol}">
          <input type="hidden" name="sortDir" value="${paged.sortDir}">
          <div class="class-search-bar">

            <div class="class-search-group">
              <label class="class-search-label">강의명</label>
              <input type="text" class="class-search-input" name="titleKw"
                     value="${paged.titleKw}" placeholder="강의명 검색">
            </div>

            <div class="class-search-divider"></div>

            <div class="class-search-group">
              <label class="class-search-label">강사명</label>
              <input type="text" class="class-search-input" name="teacherKw"
                     value="${paged.teacherKw}" placeholder="강사명 검색">
            </div>

            <div class="class-search-divider"></div>

            <div class="class-search-group">
              <label class="class-search-label">과목</label>
              <select class="class-search-select" name="subject">
                <option value="">전체</option>
                <c:forEach var="subject" items="${subjects}">
                  <option value="${subject.docId}"
                    ${paged.subject eq subject.docId ? 'selected' : ''}>${subject.name}</option>
                </c:forEach>
              </select>
            </div>

            <div class="class-search-actions">
              <button type="submit" class="btn-primary btn-sm">검색</button>
              <a href="${pageContext.request.contextPath}/class/list.do?sortCol=${paged.sortCol}&sortDir=${paged.sortDir}"
                 class="btn-ghost btn-sm">초기화</a>
            </div>

          </div>
        </form>

        <div class="class-card">
          <div class="class-card-header">
            <span class="class-total">전체 <strong>${paged.totalCount}</strong>개</span>
            <c:if test="${isTeacher}">
              <a href="${pageContext.request.contextPath}/class/form.do" class="btn-primary btn-sm">+ 강의 등록</a>
            </c:if>
          </div>

          <%-- 목록 테이블 --%>
          <div class="class-table-wrap">
            <c:choose>
              <c:when test="${empty paged.list}">
                <p class="class-empty">등록된 강의가 없습니다.</p>
              </c:when>
              <c:otherwise>
                <table class="class-table">
                  <thead>
                    <tr>
                      <th class="col-sq">
                        <a href="?titleKw=${paged.titleKw}&teacherKw=${paged.teacherKw}&subject=${paged.subject}&sortCol=sq&sortDir=${paged.sortCol eq 'sq' and paged.sortDir eq 'desc' ? 'asc' : 'desc'}" class="sort-link">
                          번호<span class="sort-icon">${paged.sortCol eq 'sq' ? (paged.sortDir eq 'asc' ? '↑' : '↓') : ''}</span>
                        </a>
                      </th>
                      <th class="col-thumb">썸네일</th>
                      <th class="col-summary">강의 요약</th>
                      <th class="col-writer">
                        <a href="?titleKw=${paged.titleKw}&teacherKw=${paged.teacherKw}&subject=${paged.subject}&sortCol=writer&sortDir=${paged.sortCol eq 'writer' and paged.sortDir eq 'desc' ? 'asc' : 'desc'}" class="sort-link">
                          작성자<span class="sort-icon">${paged.sortCol eq 'writer' ? (paged.sortDir eq 'asc' ? '↑' : '↓') : ''}</span>
                        </a>
                      </th>
                      <th class="col-date">
                        <a href="?titleKw=${paged.titleKw}&teacherKw=${paged.teacherKw}&subject=${paged.subject}&sortCol=regDate&sortDir=${paged.sortCol eq 'regDate' and paged.sortDir eq 'desc' ? 'asc' : 'desc'}" class="sort-link">
                          작성일<span class="sort-icon">${paged.sortCol eq 'regDate' ? (paged.sortDir eq 'asc' ? '↑' : '↓') : ''}</span>
                        </a>
                      </th>
                      <th class="col-view">
                        <a href="?titleKw=${paged.titleKw}&teacherKw=${paged.teacherKw}&subject=${paged.subject}&sortCol=viewCount&sortDir=${paged.sortCol eq 'viewCount' and paged.sortDir eq 'desc' ? 'asc' : 'desc'}" class="sort-link">
                          조회수<span class="sort-icon">${paged.sortCol eq 'viewCount' ? (paged.sortDir eq 'asc' ? '↑' : '↓') : ''}</span>
                        </a>
                      </th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="cls" items="${paged.list}">
                      <tr class="class-row" onclick="location.href='${pageContext.request.contextPath}/class/detail.do?docId=${cls.docId}&page=${paged.currentPage}&sortCol=${paged.sortCol}&sortDir=${paged.sortDir}&titleKw=${paged.titleKw}&teacherKw=${paged.teacherKw}&subject=${paged.subject}'">
                        <td class="col-sq">${cls.sq}</td>
                        <td class="col-thumb">
                          <c:choose>
                            <c:when test="${not empty cls.thumbnailUrl}">
                              <img src="${cls.thumbnailUrl}" alt="썸네일" class="class-thumb-img">
                            </c:when>
                            <c:otherwise>
                              <div class="class-thumb-placeholder">No Image</div>
                            </c:otherwise>
                          </c:choose>
                        </td>
                        <td class="col-summary">
                          <p class="class-title-text">${cls.title}</p>
                          <p class="class-summary-text">${cls.summary}</p>
                          <c:if test="${not empty cls.subjectName}">
                            <span class="class-subject-badge">${cls.subjectName}</span>
                          </c:if>
                        </td>
                        <td class="col-writer">${cls.writer}</td>
                        <td class="col-date">${cls.regDate}</td>
                        <td class="col-view">${cls.viewCount}</td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </c:otherwise>
            </c:choose>
          </div>

          <%-- 페이징 --%>
          <div class="class-paging">
            <c:if test="${paged.currentPage > 1}">
              <a href="?page=${paged.currentPage - 1}&titleKw=${paged.titleKw}&teacherKw=${paged.teacherKw}&subject=${paged.subject}&sortCol=${paged.sortCol}&sortDir=${paged.sortDir}" class="page-btn">&#8249;</a>
            </c:if>
            <c:forEach begin="1" end="${paged.totalPages}" var="p">
              <a href="?page=${p}&titleKw=${paged.titleKw}&teacherKw=${paged.teacherKw}&subject=${paged.subject}&sortCol=${paged.sortCol}&sortDir=${paged.sortDir}"
                 class="page-btn ${p == paged.currentPage ? 'active' : ''}">${p}</a>
            </c:forEach>
            <c:if test="${paged.currentPage < paged.totalPages}">
              <a href="?page=${paged.currentPage + 1}&titleKw=${paged.titleKw}&teacherKw=${paged.teacherKw}&subject=${paged.subject}&sortCol=${paged.sortCol}&sortDir=${paged.sortDir}" class="page-btn">&#8250;</a>
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
