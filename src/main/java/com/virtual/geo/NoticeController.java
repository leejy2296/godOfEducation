package com.virtual.geo;

import com.virtual.geo.dto.NoticeDto;
import com.virtual.geo.service.NoticeService;
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

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class NoticeController {

    private final NoticeService noticeService;

    /* ── 권한 체크 유틸 ── */
    private boolean isAdmin(HttpSession session) {
        Map<?, ?> loginUser = (Map<?, ?>) session.getAttribute("loginUser");
        return loginUser != null && "admin".equals(loginUser.get("userId"));
    }

    private String getSoopNick(HttpSession session) {
        Map<?, ?> loginUser = (Map<?, ?>) session.getAttribute("loginUser");
        return loginUser != null ? (String) loginUser.get("userNick") : null;
    }

    /* ── 목록 ── */
    @RequestMapping(value = "/notice/list.do")
    public String list(@RequestParam(value = "page", defaultValue = "1") int page,
                       HttpSession session,
                       Model model) throws Exception {
        boolean admin = isAdmin(session);
        Map<String, Object> paged = noticeService.getPagedNotices(page, admin);
        model.addAttribute("paged",   paged);
        model.addAttribute("isAdmin", admin);
        return "notice/noticeList";
    }

    /* ── 상세 ── */
    @RequestMapping(value = "/notice/detail.do")
    public String detail(@RequestParam("docId") String docId,
                         @RequestParam(value = "page", defaultValue = "1") int page,
                         HttpSession session,
                         Model model,
                         RedirectAttributes ra) throws Exception {
        boolean admin = isAdmin(session);
        NoticeDto dto = noticeService.getNotice(docId);

        // 존재하지 않는 게시물
        if (dto == null) {
            ra.addFlashAttribute("alertMsg", "존재하지 않는 게시물입니다.");
            return "redirect:/notice/list.do";
        }

        // 일반 유저가 삭제된 게시물 접근 시 차단
        if (!admin && "Y".equals(dto.getDeleteYn())) {
            ra.addFlashAttribute("alertMsg", "존재하지 않는 게시물입니다.");
            return "redirect:/notice/list.do";
        }

        model.addAttribute("notice",  dto);
        model.addAttribute("isAdmin", admin);
        model.addAttribute("page",    page);
        return "notice/noticeDetail";
    }

    /* ── 등록 폼 ── */
    @RequestMapping(value = "/notice/form.do", method = RequestMethod.GET)
    public String form(@RequestParam(value = "docId", required = false) String docId,
                       @RequestParam(value = "page", defaultValue = "1") int page,
                       HttpSession session,
                       Model model,
                       RedirectAttributes ra) throws Exception {
        // admin만 접근 가능
        if (!isAdmin(session)) {
            ra.addFlashAttribute("alertMsg", "접근 권한이 없습니다.");
            return "redirect:/notice/list.do";
        }

        if (docId != null) {
            // 수정 모드
            NoticeDto dto = noticeService.getNotice(docId);
            if (dto == null) {
                ra.addFlashAttribute("alertMsg", "존재하지 않는 게시물입니다.");
                return "redirect:/notice/list.do";
            }
            model.addAttribute("notice", dto);
            model.addAttribute("mode",   "edit");
        } else {
            // 등록 모드
            model.addAttribute("notice", new NoticeDto());
            model.addAttribute("mode",   "register");
        }
        model.addAttribute("page", page);
        return "notice/noticeForm";
    }

    /* ── 등록 처리 ── */
    @RequestMapping(value = "/notice/register.do", method = RequestMethod.POST)
    public String register(@ModelAttribute NoticeDto dto,
                           HttpSession session,
                           RedirectAttributes ra) throws Exception {
        if (!isAdmin(session)) {
            ra.addFlashAttribute("alertMsg", "접근 권한이 없습니다.");
            return "redirect:/notice/list.do";
        }
        noticeService.register(dto, getSoopNick(session));
        return "redirect:/notice/list.do";
    }

    /* ── 수정 처리 ── */
    @RequestMapping(value = "/notice/update.do", method = RequestMethod.POST)
    public String update(@RequestParam("docId") String docId,
                         @RequestParam(value = "page", defaultValue = "1") int page,
                         @ModelAttribute NoticeDto dto,
                         HttpSession session,
                         RedirectAttributes ra) throws Exception {
        if (!isAdmin(session)) {
            ra.addFlashAttribute("alertMsg", "접근 권한이 없습니다.");
            return "redirect:/notice/list.do";
        }
        noticeService.update(docId, dto, getSoopNick(session));
        return "redirect:/notice/detail.do?docId=" + docId + "&page=" + page;
    }

    /* ── 삭제 API ── */
    @RequestMapping(value = "/notice/delete.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> delete(@RequestParam("docId") String docId,
                                                      HttpSession session) {
        if (!isAdmin(session)) {
            return ResponseEntity.status(403).body(Map.of("success", false));
        }
        try {
            noticeService.delete(docId);
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }

    /* ── 복구 API ── */
    @RequestMapping(value = "/notice/restore.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> restore(@RequestParam("docId") String docId,
                                                       HttpSession session) {
        if (!isAdmin(session)) {
            return ResponseEntity.status(403).body(Map.of("success", false));
        }
        try {
            noticeService.restore(docId);
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }
}