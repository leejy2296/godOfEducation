package com.virtual.geo;

import com.virtual.geo.dto.SubjectDto;
import com.virtual.geo.dto.UserDto;
import com.virtual.geo.service.SubjectService;
import com.virtual.geo.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class AdminController {

    private final UserService    userService;
    private final SubjectService subjectService;

    /* ── 권한 체크 ── */
    private boolean isAdmin(HttpSession session) {
        Map<?, ?> loginUser = (Map<?, ?>) session.getAttribute("loginUser");
        return loginUser != null && "admin".equals(loginUser.get("userId"));
    }

    private String getSoopNick(HttpSession session) {
        Map<?, ?> loginUser = (Map<?, ?>) session.getAttribute("loginUser");
        return loginUser != null ? (String) loginUser.get("userNick") : null;
    }

    /* ════════════════════════════════════════
       관리자 홈 (중간 선택 페이지)
    ════════════════════════════════════════ */
    @RequestMapping(value = "/admin/adminPage.do")
    public String adminHome(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/main/main.do";
        return "admin/adminHome";
    }

    /* ════════════════════════════════════════
       회원관리
    ════════════════════════════════════════ */
    @RequestMapping(value = "/admin/userManage.do")
    public String userManage(HttpSession session, Model model) throws Exception {
        if (!isAdmin(session)) return "redirect:/main/main.do";
        List<UserDto> userList = userService.getAllUsers();
        model.addAttribute("userList", userList);
        return "admin/userManage";
    }

    @RequestMapping(value = "/admin/approve.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> approve(@RequestParam("userId") String userId,
                                                       HttpSession session) {
        if (!isAdmin(session)) return ResponseEntity.status(403).body(Map.of("success", false));
        try {
            userService.approveUser(userId);
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }

    @RequestMapping(value = "/admin/delete.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> delete(@RequestParam("userId") String userId,
                                                      HttpSession session) {
        if (!isAdmin(session)) return ResponseEntity.status(403).body(Map.of("success", false));
        try {
            userService.deleteUser(userId);
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }

    @RequestMapping(value = "/admin/restore.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> restore(@RequestParam("userId") String userId,
                                                       HttpSession session) {
        if (!isAdmin(session)) return ResponseEntity.status(403).body(Map.of("success", false));
        try {
            String useYn = userService.restoreUser(userId);
            return ResponseEntity.ok(Map.of("success", true, "useYn", useYn));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }

    /* ════════════════════════════════════════
       과목관리
    ════════════════════════════════════════ */
    @RequestMapping(value = "/admin/subject/list.do")
    public String subjectList(@RequestParam(value = "page", defaultValue = "1") int page,
                              HttpSession session, Model model) throws Exception {
        if (!isAdmin(session)) return "redirect:/main/main.do";
        Map<String, Object> paged = subjectService.getPagedSubjects(page);
        model.addAttribute("paged", paged);
        return "admin/subjectList";
    }

    @RequestMapping(value = "/admin/subject/register.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> subjectRegister(@RequestParam("name") String name,
                                                               HttpSession session) {
        if (!isAdmin(session)) return ResponseEntity.status(403).body(Map.of("success", false));
        try {
            subjectService.register(name, getSoopNick(session));
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }

    @RequestMapping(value = "/admin/subject/update.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> subjectUpdate(@RequestParam("docId") String docId,
                                                             @RequestParam("name") String name,
                                                             HttpSession session) {
        if (!isAdmin(session)) return ResponseEntity.status(403).body(Map.of("success", false));
        try {
            subjectService.update(docId, name);
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }

    @RequestMapping(value = "/admin/subject/delete.do", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> subjectDelete(@RequestParam("docId") String docId,
                                                             HttpSession session) {
        if (!isAdmin(session)) return ResponseEntity.status(403).body(Map.of("success", false));
        try {
            subjectService.delete(docId);
            return ResponseEntity.ok(Map.of("success", true));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("success", false));
        }
    }
}