<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet" />

<!-- 공통 헤더 -->
<header class="header" id="header">
  <div class="header-inner">
    <div class="header-logo">
      <a href="${pageContext.request.contextPath}/main/main.do">
        <span class="logo-text">VIRTUAL<em>EDUCATION</em></span>
        <span class="logo-sub">공부의신</span>
      </a>
    </div>

    <nav class="gnb">
      <ul class="gnb-list">
        <li class="gnb-item has-sub">
          <a href="${pageContext.request.contextPath}/class/list.do">강의</a>
          <ul class="sub-menu">
            <c:choose>
              <c:when test="${empty gnbSubjects}">
                <li><a href="#">등록된 과목이 없습니다.</a></li>
              </c:when>
              <c:otherwise>
                <c:forEach var="subject" items="${gnbSubjects}">
                  <li><a href="${pageContext.request.contextPath}/class/list.do?subject=${subject.docId}">${subject.name}</a></li>
                </c:forEach>
              </c:otherwise>
            </c:choose>
          </ul>
        </li>
        <li class="gnb-item"><a href="${pageContext.request.contextPath}/notice/list.do">공지사항</a></li>
        <li class="gnb-item"><a href="#">카테고리3</a></li>
        <li class="gnb-item"><a href="#">카테고리4</a></li>
        <li class="gnb-item"><a href="#">카테고리5</a></li>
      </ul>
    </nav>

    <div class="header-util">
      <c:choose>
        <c:when test="${not empty sessionScope.loginUser}">
          <%-- 로그인 상태 --%>
          <span class="header-greeting">${sessionScope.loginUser.userNick}님 안녕하세요.</span>
          <c:if test="${sessionScope.loginUser.userId eq 'admin'}">
            <a href="${pageContext.request.contextPath}/admin/adminPage.do" class="btn-admin">관리자페이지</a>
          </c:if>
          <a href="${pageContext.request.contextPath}/login/logout.do" class="btn-login">로그아웃</a>
        </c:when>
        <c:otherwise>
          <%-- 비로그인 상태 --%>
          <a href="${pageContext.request.contextPath}/login/loginPage.do" class="btn-login">로그인</a>
          <a href="${pageContext.request.contextPath}/join/joinPage1.do" class="btn-join">회원가입</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</header>
