<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="ctx" content="${pageContext.request.contextPath}">
  <title>VIRTUAL_EDUCATION - 과목관리</title>
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
        <div class="admin-hero-nav">
          <a href="${pageContext.request.contextPath}/admin/adminPage.do" class="admin-back-btn">← 관리자 홈</a>
        </div>
        <h1 class="admin-title">과목관리</h1>
        <p class="admin-desc">강의 과목을 등록 · 수정 · 삭제합니다.</p>
      </div>
    </section>

    <section class="admin-section">
      <div class="container">
        <div class="admin-card">

          <div class="admin-card-header">
            <h2>과목 목록 <span class="subject-count">총 <strong>${paged.totalCount}</strong>개</span></h2>
            <button class="btn-primary btn-sm" id="btnSubjectRegister">+ 과목 등록</button>
          </div>

          <div class="admin-table-wrap">
            <c:choose>
              <c:when test="${empty paged.list}">
                <p class="admin-empty">등록된 과목이 없습니다.</p>
              </c:when>
              <c:otherwise>
                <table class="admin-table subject-table">
                  <thead>
                    <tr>
                      <th class="col-sq">번호</th>
                      <th class="col-name">과목명</th>
                      <th class="col-date">생성일</th>
                      <th class="col-action">관리</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="subject" items="${paged.list}">
                      <tr>
                        <td class="col-sq">${subject.sq}</td>
                        <td class="col-name">${subject.name}</td>
                        <td class="col-date">${subject.createDate}</td>
                        <td class="col-action">
                          <button class="btn-approve btn-sm btn-subject-edit"
                                  data-doc-id="${subject.docId}"
                                  data-name="${subject.name}">수정</button>
                          <button class="btn-delete btn-sm btn-subject-delete"
                                  data-doc-id="${subject.docId}">삭제</button>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </c:otherwise>
            </c:choose>
          </div>

          <%-- 페이징 --%>
          <div class="admin-paging">
            <c:if test="${paged.currentPage > 1}">
              <a href="${pageContext.request.contextPath}/admin/subject/list.do?page=${paged.currentPage - 1}" class="page-btn">&#8249;</a>
            </c:if>
            <c:forEach begin="1" end="${paged.totalPages}" var="p">
              <a href="${pageContext.request.contextPath}/admin/subject/list.do?page=${p}"
                 class="page-btn ${p == paged.currentPage ? 'active' : ''}">${p}</a>
            </c:forEach>
            <c:if test="${paged.currentPage < paged.totalPages}">
              <a href="${pageContext.request.contextPath}/admin/subject/list.do?page=${paged.currentPage + 1}" class="page-btn">&#8250;</a>
            </c:if>
          </div>

        </div>
      </div>
    </section>
  </main>

  <%-- 등록/수정 모달 --%>
  <div class="subject-modal-dim" id="subjectModalDim" style="display:none;"></div>
  <div class="subject-modal" id="subjectModal" style="display:none;">
    <div class="subject-modal-header">
      <h3 id="subjectModalTitle">과목 등록</h3>
      <button class="modal-close" id="btnModalClose">✕</button>
    </div>
    <div class="subject-modal-body">
      <label class="form-label" for="subjectName">과목명 <span class="req">*</span></label>
      <input type="text" id="subjectName" class="input" placeholder="과목명을 입력하세요" maxlength="50">
      <p class="form-msg" id="subjectNameMsg"></p>
    </div>
    <div class="subject-modal-footer">
      <button class="btn-ghost" id="btnModalCancel">취소</button>
      <button class="btn-primary" id="btnModalSubmit">등록</button>
    </div>
  </div>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
  <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/subject.js"></script>
</body>
</html>
