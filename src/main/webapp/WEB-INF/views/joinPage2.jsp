<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>VIRTUAL_EDUCATION - 회원가입</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;600;700;800&family=Noto+Serif+KR:wght@400;600;700&display=swap" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/resources/css/join.css" rel="stylesheet" />
  <meta name="ctx" content="${pageContext.request.contextPath}">
</head>
<body>

  <jsp:include page="/WEB-INF/views/includes/header.jsp" />

  <main class="join-wrap">
    <section class="join-hero">
      <div class="container">
        <div class="join-hero-inner">
          <h1 class="join-title">회원가입</h1>
          <p class="join-desc">기본 정보를 입력하고 가입을 완료하세요.</p>

          <div class="join-steps">
            <div class="step done">
              <span class="step-num">1</span>
              <span class="step-label">동의</span>
            </div>
            <div class="step active">
              <span class="step-num">2</span>
              <span class="step-label">정보 입력</span>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="join-section">
      <div class="container">
        <div class="join-card">
          <div class="join-card-header">
            <h2>회원 정보 입력</h2>
            <p>필수 항목<span class="req">*</span>을 입력해주세요.</p>
          </div>

          <form id="joinForm" class="join-form" action="${pageContext.request.contextPath}/join/register.do" method="post" novalidate>
            <div class="form-grid">

              <div class="form-row">
                <label class="form-label" for="userId">아이디 <span class="req">*</span></label>
                <div class="form-field">
                  <div style="display:flex; gap:8px;">
                    <input type="text" id="userId" name="userId" class="input" placeholder="아이디 안내문구" autocomplete="username" required>
                    <button type="button" id="btnIdCheck" class="btn-ghost" style="white-space:nowrap;">중복체크</button>
                  </div>
                  <p class="form-msg" data-msg-for="userId"></p>
                </div>
              </div>

              <div class="form-row">
                <label class="form-label" for="password">비밀번호 <span class="req">*</span></label>
                <div class="form-field">
                  <input type="password" id="password" name="password" class="input" placeholder="비밀번호 안내문구" autocomplete="new-password" required>
                  <p class="form-msg" data-msg-for="password"></p>
                </div>
              </div>

              <div class="form-row">
                <label class="form-label" for="email">이메일 <span class="req">*</span></label>
                <div class="form-field">
                  <input type="email" id="email" name="email" class="input" placeholder="example@domain.com" autocomplete="email" required>
                  <p class="form-msg" data-msg-for="email"></p>
                </div>
              </div>

              <div class="form-row">
                <label class="form-label" for="userNick">사용자 닉네임 <span class="req">*</span></label>
                <div class="form-field">
                  <input type="text" id="userNick" name="userNick" class="input" placeholder="사용할 닉네임을 입력하세요" required>
                  <p class="form-msg" data-msg-for="userNick"></p>
                </div>
              </div>

              <div class="form-row">
                <label class="form-label" for="soopNick">SOOP 닉네임</label>
                <div class="form-field">
                  <input type="text" id="soopNick" name="soopNick" class="input" placeholder="SOOP 닉네임을 입력하세요 (선택)">
                  <p class="form-msg" data-msg-for="soopNick"></p>
                </div>
              </div>

              <div class="form-row">
                <label class="form-label">스트리머 여부 <span class="req">*</span></label>
                <div class="form-field">
                  <div class="radio-group" role="radiogroup" aria-label="스트리머 여부">
                    <label class="radio-pill">
                      <input type="radio" name="streamerYn" value="Y" id="streamerY">
                      <span>Y</span>
                    </label>
                    <label class="radio-pill">
                      <input type="radio" name="streamerYn" value="N" id="streamerN" checked>
                      <span>N</span>
                    </label>
                  </div>
                  <p class="form-msg" data-msg-for="streamerYn"></p>
                </div>
              </div>

              <div class="form-row">
                <label class="form-label">강사 여부 <span class="req">*</span></label>
                <div class="form-field">
                  <div class="radio-group" role="radiogroup" aria-label="강사 여부">
                    <label class="radio-pill">
                      <input type="radio" name="teacher" value="Y" id="teacherY">
                      <span>Y</span>
                    </label>
                    <label class="radio-pill">
                      <input type="radio" name="teacher" value="N" id="teacherN" checked>
                      <span>N</span>
                    </label>
                  </div>
                  <p class="form-msg" data-msg-for="teacher"></p>
                </div>
              </div>

              <!-- Y 선택 시 노출 -->
              <div class="form-row" id="soopAddrRow" style="display:none;">
                <label class="form-label" for="soopAddr">SOOP 방송국 주소 <span class="req">*</span></label>
                <div class="form-field">
                  <input type="url" id="soopAddr" name="soopAddr" class="input" placeholder="예) https://soop.example.com/your-channel">
                  <p class="form-msg" data-msg-for="soopAddr"></p>
                </div>
              </div>

            </div>

            <div class="join-actions">
              <a class="btn-ghost" href="${pageContext.request.contextPath}/join/joinPage1.do">이전</a>
              <button type="submit" class="btn-primary">가입하기</button>
            </div>

            <p class="join-hint">※ 스트리머(Y) 선택 시 방송국 주소는 필수입니다.</p>
          </form>
        </div>
      </div>
    </section>

  </main>

  <jsp:include page="/WEB-INF/views/includes/footer.jsp" />

  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/join.js"></script>

  <c:if test="${not empty alertMsg}">
    <script>alert('${alertMsg}');</script>
  </c:if>

</body>
</html>
