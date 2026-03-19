package com.virtual.geo.service;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;
import com.virtual.geo.dto.LoginDto;
import com.virtual.geo.dto.UserDto;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserService {

    private static final String COLLECTION = "users";
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    /* ──────────────── 회원가입 ──────────────── */
    public void register(UserDto dto) throws Exception {

        if (isUserIdDuplicate(dto.getUserId())) {
            throw new IllegalStateException("ID_DUPLICATE");
        }

        Firestore db = FirestoreClient.getFirestore();
        String hashedPw = passwordEncoder.encode(dto.getPassword());

        Map<String, Object> user = new HashMap<>();
        user.put("userId",     dto.getUserId());
        user.put("password",   hashedPw);
        user.put("email",      dto.getEmail());
        user.put("userNick",   dto.getUserNick());
        user.put("soopNick",   dto.getSoopNick() != null ? dto.getSoopNick() : "");
        user.put("streamerYn", dto.getStreamerYn());
        user.put("teacher",    dto.getTeacher() != null ? dto.getTeacher() : "N");
        user.put("useYn",      "N");
        user.put("deleteYn",   "N");

        if ("Y".equals(dto.getStreamerYn())) {
            user.put("soopAddr", dto.getSoopAddr());
        }

        DocumentReference docRef = db.collection(COLLECTION).document(dto.getUserId());
        ApiFuture<WriteResult> result = docRef.set(user);
        result.get();
    }

    /* ──────────────── 로그인 ──────────────── */
    public Map<String, Object> login(LoginDto dto) throws Exception {

        Firestore db = FirestoreClient.getFirestore();

        DocumentSnapshot doc = db.collection(COLLECTION)
                .document(dto.getLoginId())
                .get().get();

        if (!doc.exists() ||
            !passwordEncoder.matches(dto.getLoginPw(), doc.getString("password"))) {
            throw new IllegalArgumentException("ID_PW_MISMATCH");
        }

        String deleteYn = doc.getString("deleteYn");
        String useYn    = doc.getString("useYn");

        if ("Y".equals(deleteYn)) {
            throw new IllegalStateException("DELETED");
        }

        if ("N".equals(useYn) && !"admin".equals(dto.getLoginId())) {
            throw new IllegalStateException("NOT_APPROVED");
        }

        Map<String, Object> sessionUser = new HashMap<>();
        sessionUser.put("userId",    doc.getString("userId"));
        sessionUser.put("userNick",  doc.getString("userNick"));
        sessionUser.put("soopNick",  doc.getString("soopNick"));
        sessionUser.put("email",     doc.getString("email"));
        sessionUser.put("streamerYn", doc.getString("streamerYn"));
        sessionUser.put("teacher",   doc.getString("teacher"));
        return sessionUser;
    }

    /* ──────────────── 아이디 중복 확인 ──────────────── */
    public boolean isUserIdDuplicate(String userId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        DocumentSnapshot doc = db.collection(COLLECTION)
                .document(userId).get().get();
        return doc.exists();
    }

    /* ──────────────── 전체 유저 목록 조회 (admin 제외) ──────────────── */
    public List<UserDto> getAllUsers() throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        QuerySnapshot snapshot = db.collection(COLLECTION).get().get();

        List<UserDto> list = new ArrayList<>();
        for (QueryDocumentSnapshot doc : snapshot.getDocuments()) {
            String userId = doc.getString("userId");
            if ("admin".equals(userId)) continue;

            UserDto dto = new UserDto();
            dto.setUserId(userId);
            dto.setUserNick(doc.getString("userNick"));
            dto.setSoopNick(doc.getString("soopNick"));
            dto.setStreamerYn(doc.getString("streamerYn"));
            dto.setSoopAddr(doc.getString("soopAddr"));
            dto.setTeacher(doc.getString("teacher"));
            dto.setUseYn(doc.getString("useYn"));
            dto.setDeleteYn(doc.getString("deleteYn"));
            list.add(dto);
        }
        return list;
    }

    /* ──────────────── 승인 ──────────────── */
    public void approveUser(String userId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(userId).update("useYn", "Y").get();
    }

    /* ──────────────── 삭제 ──────────────── */
    public void deleteUser(String userId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(userId).update("deleteYn", "Y").get();
    }

    /* ──────────────── 복구 ──────────────── */
    public String restoreUser(String userId) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(userId).update("deleteYn", "N").get();
        DocumentSnapshot doc = db.collection(COLLECTION).document(userId).get().get();
        return doc.getString("useYn");
    }
}