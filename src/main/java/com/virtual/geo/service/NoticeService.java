package com.virtual.geo.service;

import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.Query;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import com.virtual.geo.dto.NoticeDto;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class NoticeService {

    private static final String COLLECTION = "notices";
    private static final String META_DOC   = "meta";
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

    /* ── 문서 → DTO 변환 ── */
    private NoticeDto toDto(QueryDocumentSnapshot doc) {
        NoticeDto dto = new NoticeDto();
        dto.setDocId(doc.getId());
        dto.setSq(doc.getLong("sq"));
        dto.setTitle(doc.getString("title"));
        dto.setContent(doc.getString("content"));
        dto.setWriter(doc.getString("writer"));
        dto.setRegDate(doc.getString("regDate"));
        dto.setModifier(doc.getString("modifier"));
        dto.setModDate(doc.getString("modDate"));
        dto.setDeleteYn(doc.getString("deleteYn"));
        return dto;
    }

    private NoticeDto toDto(DocumentSnapshot doc) {
        NoticeDto dto = new NoticeDto();
        dto.setDocId(doc.getId());
        dto.setSq(doc.getLong("sq"));
        dto.setTitle(doc.getString("title"));
        dto.setContent(doc.getString("content"));
        dto.setWriter(doc.getString("writer"));
        dto.setRegDate(doc.getString("regDate"));
        dto.setModifier(doc.getString("modifier"));
        dto.setModDate(doc.getString("modDate"));
        dto.setDeleteYn(doc.getString("deleteYn"));
        return dto;
    }

    /* ── 전체 목록 조회 (sq 내림차순, meta 문서 제외) ── */
    private List<NoticeDto> fetchAll() throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        QuerySnapshot snapshot = db.collection(COLLECTION)
                .orderBy("sq", Query.Direction.DESCENDING)
                .get().get();

        List<NoticeDto> list = new ArrayList<>();
        for (QueryDocumentSnapshot doc : snapshot.getDocuments()) {
            if (META_DOC.equals(doc.getId())) continue;
            list.add(toDto(doc));
        }
        return list;
    }

    /* ── 메인 페이지용 최신 5개 (deleteYn=N, 코드 필터) ── */
    public List<NoticeDto> getRecentNotices() throws Exception {
        return fetchAll().stream()
                .filter(n -> "N".equals(n.getDeleteYn()))
                .limit(5)
                .collect(Collectors.toList());
    }

    /* ── 페이징 ── */
    public Map<String, Object> getPagedNotices(int page, boolean isAdmin) throws Exception {
        List<NoticeDto> allList = fetchAll();

        // 일반 유저는 deleteYn=N만
        if (!isAdmin) {
            allList = allList.stream()
                    .filter(n -> "N".equals(n.getDeleteYn()))
                    .collect(Collectors.toList());
        }

        int totalCount = allList.size();
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;
        if (page < 1) page = 1;
        if (page > totalPages) page = totalPages;

        int fromIdx = (page - 1) * PAGE_SIZE;
        int toIdx   = Math.min(fromIdx + PAGE_SIZE, totalCount);

        Map<String, Object> result = new HashMap<>();
        result.put("list",        allList.subList(fromIdx, toIdx));
        result.put("currentPage", page);
        result.put("totalPages",  totalPages);
        result.put("totalCount",  totalCount);
        return result;
    }

    /* ── 단건 조회 ── */
    public NoticeDto getNotice(String docId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot doc = db.collection(COLLECTION).document(docId).get().get();
        if (!doc.exists()) return null;
        return toDto(doc);
    }

    /* ── 등록 ── */
    public void register(NoticeDto dto, String writerNick) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        long sq = nextSq(db);

        Map<String, Object> data = new HashMap<>();
        data.put("sq",       sq);
        data.put("title",    dto.getTitle());
        data.put("content",  dto.getContent());
        data.put("writer",   writerNick);
        data.put("regDate",  today());
        data.put("modifier", "");
        data.put("modDate",  "");
        data.put("deleteYn", "N");

        db.collection(COLLECTION).document("notice_" + sq).set(data).get();
    }

    /* ── 수정 ── */
    public void update(String docId, NoticeDto dto, String modifierNick) throws Exception {
        Firestore db = FirestoreClient.getFirestore();

        Map<String, Object> data = new HashMap<>();
        data.put("title",    dto.getTitle());
        data.put("content",  dto.getContent());
        data.put("modifier", modifierNick);
        data.put("modDate",  today());

        db.collection(COLLECTION).document(docId).update(data).get();
    }

    /* ── 삭제 (deleteYn = Y) ── */
    public void delete(String docId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(docId).update("deleteYn", "Y").get();
    }

    /* ── 복구 (deleteYn = N) ── */
    public void restore(String docId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(docId).update("deleteYn", "N").get();
    }
}