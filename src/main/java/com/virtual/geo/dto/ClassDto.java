package com.virtual.geo.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ClassDto {
    private Long   sq;          // 번호
    private String title;       // 강의명
    private String summary;     // 강의 요약
    private String subjectDocId;// 과목 docId (Firestore subjects 컬렉션의 문서 ID)
    private String subjectName; // 과목명 (표시용 - 조회 시 매핑)
    private String videoUrl;    // 영상 주소
    private String writer;      // 작성자 userNick
    private String writerId;    // 작성자 userId (수정/삭제 권한 체크용)
    private String regDate;     // 작성일 (YYYY-MM-DD)
    private String modifier;    // 수정자 userNick
    private String modDate;     // 수정일 (YYYY-MM-DD)
    private String deleteYn;    // 삭제여부 (기본값 N)
    private Long   viewCount;   // 조회수
    private String docId;       // Firestore 문서 ID
    private String thumbnailUrl;// 썸네일 URL (영상주소에서 파싱)
}