<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta name="ctx" content="${pageContext.request.contextPath}">
  <title>VIRTUAL_EDUCATION - 회원관리</title>
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
        <h1 class="admin-title">회원관리</h1>
        <p class="admin-desc">회원 목록을 조회하고 승인 · 탈퇴 처리를 관리합니다.</p>
      </div>
    </section>

    <section class="admin-section">
      <div class="container">
        <div class="admin-card">
          <div class="admin-card-header">
            <h2>회원 목록</h2>
            <span class="user-count">총 <strong>${userList.size()}</strong>명</span>
          </div>
          <div class="admin-table-wrap">
            <c:choose>
              <c:when test="${empty userList}">
                <p class="admin-empty">등록된 회원이 없습니다.</p>
              </c:when>
              <c:otherwise>
                <table class="admin-table">
                  <thead>
                    <tr>
                      <th>아이디</th>
                      <th>사용자 닉네임</th>
                      <th>스트리머 여부</th>
                      <th>강사 여부</th>
                      <th>SOOP 방송국 주소</th>
                      <th>상태</th>
                      <th>관리</th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="user" items="${userList}">
                      <tr class="${user.deleteYn eq 'Y' ? 'row-deleted' : ''}">
                        <td>${user.userId}</td>
                        <td>${user.userNick}</td>
                        <td>
                          <c:choose>
                            <c:when test="${user.streamerYn eq 'Y'}"><span class="streamer-badge">스트리머</span></c:when>
                            <c:otherwise><span class="streamer-badge no">일반</span></c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${user.teacher eq 'Y'}"><span class="streamer-badge">강사</span></c:when>
                            <c:otherwise><span class="streamer-badge no">-</span></c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${user.streamerYn eq 'Y' and not empty user.soopAddr}">
                              <a class="soop-addr-link" href="${user.soopAddr}" target="_blank">${user.soopAddr}</a>
                            </c:when>
                            <c:otherwise><span class="addr-none">-</span></c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${user.deleteYn eq 'Y'}"><span class="status-badge deleted">탈퇴</span></c:when>
                            <c:when test="${user.useYn eq 'Y'}"><span class="status-badge approved">승인</span></c:when>
                            <c:otherwise><span class="status-badge pending">미승인</span></c:otherwise>
                          </c:choose>
                        </td>
                        <td>
                          <c:choose>
                            <c:when test="${user.deleteYn eq 'Y'}"><button class="btn-restore" data-user-id="${user.userId}">복구</button></c:when>
                            <c:when test="${user.useYn eq 'Y'}"><button class="btn-delete" data-user-id="${user.userId}">삭제</button></c:when>
                            <c:otherwise><button class="btn-approve" data-user-id="${user.userId}">승인</button></c:otherwise>
                          </c:choose>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>
    </section>
  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />
  <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
</body>
</html>
