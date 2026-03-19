package com.virtual.geo.service;

import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.firebase.cloud.FirestoreClient;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AdminService {

    private static final String COLLECTION = "users";

    /* 전체 유저 목록 조회 */
    public List<Map<String, Object>> getUserList() throws Exception {
        Firestore db = FirestoreClient.getFirestore();

        List<QueryDocumentSnapshot> docs = db.collection(COLLECTION)
                .get().get().getDocuments();

        List<Map<String, Object>> list = new ArrayList<>();
        for (QueryDocumentSnapshot doc : docs) {
            Map<String, Object> user = new HashMap<>();
            user.put("userId",     doc.getString("userId"));
            user.put("email",      doc.getString("email"));
            user.put("userNick",   doc.getString("userNick"));
            user.put("streamerYn", doc.getString("streamerYn"));
            user.put("useYn",      doc.getString("useYn"));
            user.put("deleteYn",   doc.getString("deleteYn"));
            list.add(user);
        }
        return list;
    }

    /* useYn 변경 */
    public void updateUseYn(String userId, String useYn) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(userId)
                .update("useYn", useYn).get();
    }

    /* deleteYn 변경 */
    public void updateDeleteYn(String userId, String deleteYn) throws Exception {
        Firestore db = FirestoreClient.getFirestore();
        db.collection(COLLECTION).document(userId)
                .update("deleteYn", deleteYn).get();
    }
}
