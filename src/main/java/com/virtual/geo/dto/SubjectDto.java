package com.virtual.geo.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SubjectDto {
    private Long   sq;        // 번호
    private String name;      // 과목명
    private String creator;   // 생성자 soopNick
    private String createDate;// 생성일 (YYYY-MM-DD)
    private String deleteYn;  // 삭제여부 (기본값 N)
    private String docId;     // Firestore 문서 ID
}
