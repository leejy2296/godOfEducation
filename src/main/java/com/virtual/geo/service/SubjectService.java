package com.virtual.geo.service;

import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.Query;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import com.virtual.geo.dto.SubjectDto;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class SubjectService {

    private static final String COLLECTION = "subjects";
    private static final String META_DOC   = "meta";
    private static final DateTimeFormatter FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final int PAGE_SIZE = 15;

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

    /* ── 문서 → DTO ── */
    private SubjectDto toDto(QueryDocumentSnapshot doc) {
        SubjectDto dto = new SubjectDto();
        dto.setDocId(doc.getId());
        dto.setSq(doc.getLong("sq"));
        dto.setName(doc.getString("name"));
        dto.setCreator(doc.getString("creator"));
        dto.setCreateDate(doc.getString("createDate"));
        dto.setDeleteYn(doc.getString("deleteYn"));
        return dto;
    }

    /* ── 전체 조회 (sq 오름차순, deleteYn=N만) ── */
    private List<SubjectDto> fetchActive() throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        QuerySnapshot snapshot = db.collection(COLLECTION)
                .orderBy("sq", Query.Direction.ASCENDING)
                .get().get();

        List<SubjectDto> list = new ArrayList<>();
        for (QueryDocumentSnapshot doc : snapshot.getDocuments()) {
            if (META_DOC.equals(doc.getId())) continue;
            SubjectDto dto = toDto(doc);
            if ("N".equals(dto.getDeleteYn())) {
                list.add(dto);
            }
        }
        return list;
    }

    /* ── 페이징 ── */
    public Map<String, Object> getPagedSubjects(int page) throws Exception {
        List<SubjectDto> allList = fetchActive();

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

    /* ── 등록 ── */
    public void register(String name, String creatorNick) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        long sq = nextSq(db);

        Map<String, Object> data = new HashMap<>();
        data.put("sq",         sq);
        data.put("name",       name);
        data.put("creator",    creatorNick);
        data.put("createDate", today());
        data.put("deleteYn",   "N");

        db.collection(COLLECTION).document("subject_" + sq).set(data).get();
    }

    /* ── 수정 ── */
    public void update(String docId, String name) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(docId).update("name", name).get();
    }

    /* ── 삭제 (deleteYn = Y) ── */
    public void delete(String docId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(docId).update("deleteYn", "Y").get();
    }

    /* ── 전체 활성 과목 조회 (GNB용) ── */
    public List<SubjectDto> getAllActive() throws Exception {
        return fetchActive();
    }

}