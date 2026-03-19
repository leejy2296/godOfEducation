package com.virtual.geo.service;

import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.FieldValue;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.Query;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import com.virtual.geo.dto.ClassDto;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
public class ClassService {

    private static final String COLLECTION         = "classes";
    private static final String SUBJECT_COLLECTION = "subjects";
    private static final String META_DOC           = "meta";
    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final int PAGE_SIZE = 5;

    private String today() {
        return LocalDate.now().format(FMT);
    }

    /* ── sq 채번 ── */
    private long nextSq(Firestore db) throws Exception {
        DocumentReference metaRef = db.collection(COLLECTION).document(META_DOC);
        DocumentSnapshot  meta    = metaRef.get().get();
        long next = 1L;
        if (meta.exists() && meta.getLong("lastSq") != null) {
            next = meta.getLong("lastSq") + 1;
        }
        Map<String, Object> m = new HashMap<>();
        m.put("lastSq", next);
        metaRef.set(m).get();
        return next;
    }

    /* ── 과목 docId → 과목명 매핑 맵 조회 ── */
    private Map<String, String> getSubjectMap(Firestore db) throws Exception {
        Map<String, String> map = new HashMap<>();
        QuerySnapshot snapshot = db.collection(SUBJECT_COLLECTION).get().get();
        for (QueryDocumentSnapshot doc : snapshot.getDocuments()) {
            if (META_DOC.equals(doc.getId())) continue;
            String name = doc.getString("name");
            if (name != null) map.put(doc.getId(), name);
        }
        return map;
    }

    /* ── 유튜브 썸네일 URL 추출 ── */
    public String extractThumbnail(String videoUrl) {
        if (videoUrl == null || videoUrl.isEmpty()) return "";
        Pattern p = Pattern.compile(
            "(?:youtu\\.be/|youtube\\.com/(?:watch\\?v=|embed/|v/))([\\w-]{11})"
        );
        Matcher m = p.matcher(videoUrl);
        if (m.find()) {
            return "https://img.youtube.com/vi/" + m.group(1) + "/mqdefault.jpg";
        }
        return "";
    }

    /* ── 유튜브 embed URL 변환 ── */
    public String toEmbedUrl(String videoUrl) {
        if (videoUrl == null || videoUrl.isEmpty()) return "";
        Pattern p = Pattern.compile(
            "(?:youtu\\.be/|youtube\\.com/(?:watch\\?v=|embed/|v/))([\\w-]{11})"
        );
        Matcher m = p.matcher(videoUrl);
        if (m.find()) {
            return "https://www.youtube.com/embed/" + m.group(1);
        }
        return videoUrl;
    }

    /* ── 문서 → DTO (과목명 매핑 포함) ── */
    private ClassDto toDto(QueryDocumentSnapshot doc, Map<String, String> subjectMap) {
        ClassDto dto = new ClassDto();
        dto.setDocId(doc.getId());
        dto.setSq(doc.getLong("sq"));
        dto.setTitle(doc.getString("title"));
        dto.setSummary(doc.getString("summary"));
        String subjectDocId = doc.getString("subjectDocId");
        dto.setSubjectDocId(subjectDocId);
        dto.setSubjectName(subjectMap.getOrDefault(subjectDocId, ""));
        dto.setVideoUrl(doc.getString("videoUrl"));
        dto.setWriter(doc.getString("writer"));
        dto.setWriterId(doc.getString("writerId"));
        dto.setRegDate(doc.getString("regDate"));
        dto.setModifier(doc.getString("modifier"));
        dto.setModDate(doc.getString("modDate"));
        dto.setDeleteYn(doc.getString("deleteYn"));
        dto.setViewCount(doc.getLong("viewCount") != null ? doc.getLong("viewCount") : 0L);
        dto.setThumbnailUrl(extractThumbnail(doc.getString("videoUrl")));
        return dto;
    }

    private ClassDto toDto(DocumentSnapshot doc, Map<String, String> subjectMap) {
        ClassDto dto = new ClassDto();
        dto.setDocId(doc.getId());
        dto.setSq(doc.getLong("sq"));
        dto.setTitle(doc.getString("title"));
        dto.setSummary(doc.getString("summary"));
        String subjectDocId = doc.getString("subjectDocId");
        dto.setSubjectDocId(subjectDocId);
        dto.setSubjectName(subjectMap.getOrDefault(subjectDocId, ""));
        dto.setVideoUrl(doc.getString("videoUrl"));
        dto.setWriter(doc.getString("writer"));
        dto.setWriterId(doc.getString("writerId"));
        dto.setRegDate(doc.getString("regDate"));
        dto.setModifier(doc.getString("modifier"));
        dto.setModDate(doc.getString("modDate"));
        dto.setDeleteYn(doc.getString("deleteYn"));
        dto.setViewCount(doc.getLong("viewCount") != null ? doc.getLong("viewCount") : 0L);
        dto.setThumbnailUrl(extractThumbnail(doc.getString("videoUrl")));
        return dto;
    }

    /* ── 전체 조회 (deleteYn=N, 과목명 매핑 포함) ── */
    private List<ClassDto> fetchAll() throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, String> subjectMap = getSubjectMap(db);

        QuerySnapshot snapshot = db.collection(COLLECTION)
                .orderBy("sq", Query.Direction.DESCENDING)
                .get().get();

        List<ClassDto> list = new ArrayList<>();
        for (QueryDocumentSnapshot doc : snapshot.getDocuments()) {
            if (META_DOC.equals(doc.getId())) continue;
            ClassDto dto = toDto(doc, subjectMap);
            if ("N".equals(dto.getDeleteYn())) list.add(dto);
        }
        return list;
    }

    /* ── 검색 + 정렬 + 페이징 ── */
    public Map<String, Object> getPagedClasses(int page,
                                               String titleKw, String teacherKw, String subjectDocId,
                                               String sortCol, String sortDir) throws Exception {
        List<ClassDto> list = fetchAll();

        final String tKw = (titleKw     != null) ? titleKw.trim().toLowerCase()   : "";
        final String wKw = (teacherKw   != null) ? teacherKw.trim().toLowerCase() : "";
        final String sub = (subjectDocId != null) ? subjectDocId.trim()            : "";

        list = list.stream().filter(c -> {
            boolean titleOk   = tKw.isEmpty() || (c.getTitle()      != null && c.getTitle().toLowerCase().contains(tKw));
            boolean teacherOk = wKw.isEmpty() || (c.getWriter()     != null && c.getWriter().toLowerCase().contains(wKw));
            // subject 검색은 docId로 비교
            boolean subjectOk = sub.isEmpty() || sub.equals(c.getSubjectDocId());
            return titleOk && teacherOk && subjectOk;
        }).collect(Collectors.toList());

        Comparator<ClassDto> comp;
        switch (sortCol == null ? "" : sortCol) {
            case "writer":    comp = Comparator.comparing(c -> c.getWriter()  != null ? c.getWriter()  : ""); break;
            case "regDate":   comp = Comparator.comparing(c -> c.getRegDate() != null ? c.getRegDate() : ""); break;
            case "viewCount": comp = Comparator.comparingLong(c -> c.getViewCount() != null ? c.getViewCount() : 0L); break;
            default:          comp = Comparator.comparingLong(c -> c.getSq() != null ? c.getSq() : 0L); break;
        }
        list.sort("asc".equals(sortDir) ? comp : comp.reversed());

        int totalCount = list.size();
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        int fromIdx = (page - 1) * PAGE_SIZE;
        int toIdx   = Math.min(fromIdx + PAGE_SIZE, totalCount);

        Map<String, Object> result = new HashMap<>();
        result.put("list",        list.subList(fromIdx, toIdx));
        result.put("currentPage", page);
        result.put("totalPages",  totalPages);
        result.put("totalCount",  totalCount);
        result.put("titleKw",     tKw);
        result.put("teacherKw",   wKw);
        result.put("subject",     sub);  // subjectDocId를 subject 키로 유지 (JSP 호환)
        result.put("sortCol",     sortCol != null ? sortCol : "sq");
        result.put("sortDir",     sortDir != null ? sortDir : "desc");
        return result;
    }

    /* ── 단건 조회 ── */
    public ClassDto getClass(String docId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, String> subjectMap = getSubjectMap(db);
        DocumentSnapshot doc = db.collection(COLLECTION).document(docId).get().get();
        if (!doc.exists()) return null;
        return toDto(doc, subjectMap);
    }

    /* ── 조회수 증가 ── */
    public void increaseViewCount(String docId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(docId)
                .update("viewCount", FieldValue.increment(1)).get();
    }

    /* ── 등록 ── */
    public void register(ClassDto dto, String writerNick, String writerId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        long sq = nextSq(db);

        Map<String, Object> data = new HashMap<>();
        data.put("sq",           sq);
        data.put("title",        dto.getTitle());
        data.put("summary",      dto.getSummary());
        data.put("subjectDocId", dto.getSubjectDocId()); // 과목 docId 저장
        data.put("videoUrl",     dto.getVideoUrl());
        data.put("writer",       writerNick);
        data.put("writerId",     writerId);
        data.put("regDate",      today());
        data.put("modifier",     "");
        data.put("modDate",      "");
        data.put("deleteYn",     "N");
        data.put("viewCount",    0L);

        db.collection(COLLECTION).document("class_" + sq).set(data).get();
    }

    /* ── 수정 ── */
    public void update(String docId, ClassDto dto, String modifierNick) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        Map<String, Object> data = new HashMap<>();
        data.put("title",        dto.getTitle());
        data.put("summary",      dto.getSummary());
        data.put("subjectDocId", dto.getSubjectDocId()); // 과목 docId 저장
        data.put("videoUrl",     dto.getVideoUrl());
        data.put("modifier",     modifierNick);
        data.put("modDate",      today());
        db.collection(COLLECTION).document(docId).update(data).get();
    }

    /* ── 삭제 ── */
    public void delete(String docId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(docId).update("deleteYn", "Y").get();
    }

    /* ── 메인용 조회수 상위 4개 ── */
    public List<ClassDto> getTopClasses() throws Exception {
        return fetchAll().stream()
                .sorted(Comparator.comparingLong(
                        (ClassDto c) -> c.getViewCount() != null ? c.getViewCount() : 0L).reversed())
                .limit(4)
                .collect(Collectors.toList());
    }
}