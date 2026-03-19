package com.virtual.geo;

import com.virtual.geo.dto.ClassDto;
import com.virtual.geo.dto.SubjectDto;
import com.virtual.geo.service.ClassService;
import com.virtual.geo.service.SubjectService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Comparator;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ClassController {

    private final ClassService   classService;
    private final SubjectService subjectService;

    /* ── 세션 유틸 ── */
    private Map<?, ?> getLoginUser(HttpSession session) {
        return (Map<?, ?>) session.getAttribute("loginUser");
    }

    private String getUserNick(HttpSession session) {
        Map<?, ?> u = getLoginUser(session);
        return u != null ? (String) u.get("userNick") : null;
    }

    private String getUserId(HttpSession session) {
        Map<?, ?> u = getLoginUser(session);
        return u != null ? (String) u.get("userId") : null;
    }

    private boolean isTeacher(HttpSession session) {
        Map<?, ?> u = getLoginUser(session);
        return u != null && "Y".equals(u.get("teacher"));
    }

    /* ── 강의 목록 ── */
    @RequestMapping(value = "/class/list.do")
    public String list(@RequestParam(value = "page",      defaultValue = "1")    int    page,
                       @RequestParam(value = "titleKw",   defaultValue = "")     String titleKw,
                       @RequestParam(value = "teacherKw", defaultValue = "")     String teacherKw,
                       @RequestParam(value = "subject",   defaultValue = "")     String subject,
                       @RequestParam(value = "sortCol",   defaultValue = "sq")   String sortCol,
                       @RequestParam(value = "sortDir",   defaultValue = "desc") String sortDir,
                       HttpSession session, Model model) throws Exception {

        Map<String, Object> paged = classService.getPagedClasses(
                page, titleKw, teacherKw, subject, sortCol, sortDir);

        // 과목 목록 (검색 selectbox용)
        List<SubjectDto> subjects = subjectService.getAllActive();
        subjects.sort(Comparator.comparing(SubjectDto::getName,
                java.text.Collator.getInstance(java.util.Locale.KOREAN)));

        model.addAttribute("paged",    paged);
        model.addAttribute("subjects", subjects);
        model.addAttribute("isTeacher", isTeacher(session));
        return "class/classList";
    }

    /* ── 강의 상세 ── */
    @RequestMapping(value = "/class/detail.do")
    public String detail(@RequestParam("docId") String docId,
                         @RequestParam(value = "page",          defaultValue = "1")    int    page,
                         @RequestParam(value = "titleKw",   defaultValue = "")     String titleKw,
                         @RequestParam(value = "teacherKw", defaultValue = "")     String teacherKw,
                         @RequestParam(value = "subject",   defaultValue = "")     String subject,
                         @RequestParam(value = "sortCol",   defaultValue = "sq")   String sortCol,
                         @RequestParam(value = "sortDir",   defaultValue = "desc") String sortDir,
                         HttpSession session, Model model,
                         RedirectAttributes ra) throws Exception {

        // 비로그인 접근 차단
        if (getLoginUser(session) == null) {
            ra.addFlashAttribute("alertMsg", "로그인 후 이용 가능합니다.");
            return "redirect:/login/loginPage.do";
        }

        ClassDto dto = classService.getClass(docId);
        if (dto == null || "Y".equals(dto.getDeleteYn())) {
            ra.addFlashAttribute("alertMsg", "존재하지 않는 강의입니다.");
            return "redirect:/class/list.do";
        }

        // 세션 기반 조회수 중복 방지
        String sessionKey = "viewed_class_" + docId;
        if (session.getAttribute(sessionKey) == null) {
            classService.increaseViewCount(docId);
            session.setAttribute(sessionKey, true);
            dto.setViewCount(dto.getViewCount() + 1);
        }

        String loginUserId = getUserId(session);
        boolean isWriter = loginUserId != null && loginUserId.equals(dto.getWriterId());

        model.addAttribute("classDto",   dto);
        model.addAttribute("embedUrl",   classService.toEmbedUrl(dto.getVideoUrl()));
        model.addAttribute("isWriter",   isWriter);
        model.addAttribute("page",       page);
        model.addAttribute("titleKw",    titleKw);
        model.addAttribute("teacherKw",  teacherKw);
        model.addAttribute("subject",    subject);
        model.addAttribute("sortCol",    sortCol);
        model.addAttribute("sortDir",    sortDir);
        return "class/classDetail";
    }

    /* ── 등록/수정 폼 ── */
    @RequestMapping(value = "/class/form.do", method = RequestMethod.GET)
    public String form(@RequestParam(value = "docId",   required = false) String docId,
                       @RequestParam(value = "page",    defaultValue = "1") int page,
                       @RequestParam(value = "sortCol", defaultValue = "sq")   String sortCol,
                       @RequestParam(value = "sortDir", defaultValue = "desc") String sortDir,
                       HttpSession session, Model model,
                       RedirectAttributes ra) throws Exception {

        if (!isTeacher(session)) {
            ra.addFlashAttribute("alertMsg", "접근 권한이 없습니다.");
            return "redirect:/class/list.do";
        }

        List<SubjectDto> subjects = subjectService.getAllActive();
        subjects.sort(Comparator.comparing(SubjectDto::getName,
                java.text.Collator.getInstance(java.util.Locale.KOREAN)));
        model.addAttribute("subjects", subjects);
        model.addAttribute("page",     page);
        model.addAttribute("sortCol",  sortCol);
        model.addAttribute("sortDir",  sortDir);

        if (docId != null) {
            ClassDto dto = classService.getClass(docId);
            if (dto == null) {
                ra.addFlashAttribute("alertMsg", "존재하지 않는 강의입니다.");
                return "redirect:/class/list.do";
            }
            // 작성자만 수정 가능
            if (!getUserId(session).equals(dto.getWriterId())) {
                ra.addFlashAttribute("alertMsg", "수정 권한이 없습니다.");
                return "redirect:/class/detail.do?docId=" + docId;
            }
            model.addAttribute("classDto", dto);
            model.addAttribute("mode",     "edit");
        } else {
            model.addAttribute("classDto", new ClassDto());
            model.addAttribute("mode",     "register");
        }
        return "class/classForm";
    }

    /* ── 등록 처리 ── */
    @RequestMapping(value = "/class/register.do", method = RequestMethod.POST)
    public String register(@ModelAttribute ClassDto dto,
                           HttpSession session, RedirectAttributes ra) throws Exception {
        if (!isTeacher(session)) {
            ra.addFlashAttribute("alertMsg", "접근 권한이 없습니다.");
            return "redirect:/class/list.do";
        }
        classService.register(dto, getUserNick(session), getUserId(session));
        return "redirect:/class/list.do";
    }

    /* ── 수정 처리 ── */
    @RequestMapping(value = "/class/update.do", method = RequestMethod.POST)
    public String update(@RequestParam("docId") String docId,
                         @RequestParam(value = "page",    defaultValue = "1")    int    page,
                         @RequestParam(value = "sortCol",   defaultValue = "sq")   String sortCol,
                         @RequestParam(value = "sortDir",   defaultValue = "desc") String sortDir,
                         @RequestParam(value = "titleKw",   defaultValue = "")     String titleKw,
                         @RequestParam(value = "teacherKw", defaultValue = "")     String teacherKw,
                         @RequestParam(value = "subject",   defaultValue = "")     String subject,
                         @ModelAttribute ClassDto dto,
                         HttpSession session, RedirectAttributes ra) throws Exception {

        ClassDto origin = classService.getClass(docId);
        if (origin == null || !getUserId(session).equals(origin.getWriterId())) {
            ra.addFlashAttribute("alertMsg", "수정 권한이 없습니다.");
            return "redirect:/class/list.do";
        }
        classService.update(docId, dto, getUserNick(session));
        return "redirect:/class/detail.do?docId=" + docId
                + "&page=" + page + "&sortCol=" + sortCol + "&sortDir=" + sortDir
                + "&titleKw=" + titleKw + "&teacherKw=" + teacherKw + "&subject=" + subject;
    }

    /* ── 삭제 API ── */
    @RequestMapping(value = "/class/delete.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> delete(@RequestParam("docId") String docId,
                                                      HttpSession session) {
        try {
            ClassDto origin = classService.getClass(docId);
            if (origin == null || !getUserId(session).equals(origin.getWriterId())) {
                return ResponseEntity.status(403).body(Map.of("success", false));
            }
            classService.delete(docId);
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }
}