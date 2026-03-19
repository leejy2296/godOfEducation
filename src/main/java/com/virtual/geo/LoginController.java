package com.virtual.geo;

import com.virtual.geo.dto.LoginDto;
import com.virtual.geo.service.UserService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class LoginController {

    private final UserService userService;

    /* 로그인 페이지 */
    @RequestMapping(value = "/login/loginPage.do")
    public String viewLoginPage() {
        return "loginPage";
    }

    /* 로그인 처리 */
    @RequestMapping(value = "/login/loginProc.do", method = RequestMethod.POST)
    public String loginProc(@ModelAttribute LoginDto dto,
                            HttpSession session,
                            RedirectAttributes ra) {
        try {
            Map<String, Object> sessionUser = userService.login(dto);

            // 세션에 유저 정보 저장
            session.setAttribute("loginUser", sessionUser);
            return "redirect:/main/main.do";

        } catch (IllegalArgumentException e) {
            // 아이디 or 비밀번호 불일치
            ra.addFlashAttribute("alertMsg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "redirect:/login/loginPage.do";

        } catch (IllegalStateException e) {
            String msg = switch (e.getMessage()) {
                case "DELETED"       -> "삭제 처리된 계정입니다.";
                case "NOT_APPROVED"  -> "아직 승인되지 않은 계정입니다.";
                default              -> "로그인 중 오류가 발생했습니다.";
            };
            ra.addFlashAttribute("alertMsg", msg);
            return "redirect:/login/loginPage.do";

        } catch (Exception e) {
            ra.addFlashAttribute("alertMsg", "로그인 중 오류가 발생했습니다.");
            return "redirect:/login/loginPage.do";
        }
    }

    /* 로그아웃 */
    @RequestMapping(value = "/login/logout.do")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/main/main.do";
    }
}