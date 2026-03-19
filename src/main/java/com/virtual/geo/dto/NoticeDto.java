package com.virtual.geo.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeDto {

    private Long   sq;           // 게시글 번호
    private String title;        // 제목
    private String content;      // 내용
    private String writer;       // 작성자 soopNick
    private String regDate;      // 등록날짜 (YYYY-MM-DD)
    private String modifier;     // 수정자 soopNick
    private String modDate;      // 수정날짜 (YYYY-MM-DD)
    private String deleteYn;     // 삭제여부 (기본값 N)
    private String docId;        // Firestore 문서 ID (sq 기반)
}
