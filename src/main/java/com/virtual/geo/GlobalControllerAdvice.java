package com.virtual.geo;

import com.virtual.geo.dto.SubjectDto;
import com.virtual.geo.service.SubjectService;
import lombok.RequiredArgsConstructor;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@ControllerAdvice
@RequiredArgsConstructor
public class GlobalControllerAdvice {

    private final SubjectService subjectService;

    /* 모든 컨트롤러 요청 전에 자동으로 과목 목록을 model에 주입 */
    @ModelAttribute
    public void addGlobalAttributes(Model model) {
        try {
            List<SubjectDto> subjects = subjectService.getAllActive();
            // 가나다 순 정렬
            subjects.sort(Comparator.comparing(SubjectDto::getName,
                    java.text.Collator.getInstance(java.util.Locale.KOREAN)));
            model.addAttribute("gnbSubjects", subjects);
        } catch (Exception e) {
            model.addAttribute("gnbSubjects", new ArrayList<>());
        }
    }
}
