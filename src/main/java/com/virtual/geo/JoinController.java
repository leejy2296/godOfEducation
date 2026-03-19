package com.virtual.geo;

import com.virtual.geo.dto.UserDto;
import com.virtual.geo.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Map;

@Controller
@RequiredArgsConstructor
public class JoinController {

    private final UserService userService;

    @RequestMapping(value = "/join/joinPage1.do")
    public String viewJoinPage1() {
        return "joinPage1";
    }

    @RequestMapping(value = "/join/joinPage2.do")
    public String viewJoinPage2() {
        return "joinPage2";
    }

    /* 아이디 중복체크 API */
    @RequestMapping(value = "/join/checkId.do", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkId(@RequestParam("userId") String userId) throws Exception {
        boolean duplicate = userService.isUserIdDuplicate(userId);
        return ResponseEntity.ok(Map.of("duplicate", duplicate));
    }

    /* 회원가입 처리 */
    @RequestMapping(value = "/join/register.do", method = RequestMethod.POST)
    public String register(@ModelAttribute UserDto dto, RedirectAttributes ra) throws Exception {
        try {
            userService.register(dto);
            return "redirect:/join/joinComplete.do";
        } catch (IllegalStateException e) {
            if ("ID_DUPLICATE".equals(e.getMessage())) {
                ra.addFlashAttribute("alertMsg", "이미 사용 중인 아이디입니다. 다른 아이디를 사용해주세요.");
            } else {
                ra.addFlashAttribute("alertMsg", "회원가입 중 오류가 발생했습니다.");
            }
            return "redirect:/join/joinPage2.do";
        }
    }

    @RequestMapping(value = "/join/joinComplete.do")
    public String joinComplete() {
        return "joinComplete";
    }
}