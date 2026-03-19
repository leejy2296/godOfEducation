package com.virtual.geo;

import com.virtual.geo.dto.ClassDto;
import com.virtual.geo.dto.NoticeDto;
import com.virtual.geo.service.ClassService;
import com.virtual.geo.service.NoticeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class MainController {

    private final NoticeService noticeService;
    private final ClassService  classService;

    @RequestMapping(value = "/")
    public String redirectMain() {
        return "redirect:/main/main.do";
    }

    @RequestMapping(value = "/main/main.do")
    public String main(Model model) {
        try {
            List<NoticeDto> recentNotices = noticeService.getRecentNotices();
            model.addAttribute("recentNotices", recentNotices);
        } catch (Exception e) {
            model.addAttribute("recentNotices", java.util.Collections.emptyList());
        }
        try {
            List<ClassDto> topClasses = classService.getTopClasses();
            model.addAttribute("topClasses", topClasses);
        } catch (Exception e) {
            model.addAttribute("topClasses", java.util.Collections.emptyList());
        }
        return "main";
    }
}