import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igor/services/firestore/firestore_chat_message.dart';
import 'package:igor/services/firestore/firestore_constants.dart';
import 'package:igor/services/firestore/firestore_exceptions.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Future<void> addChatMessage(
      String userId, FirestoreChatMessage chatMessage) async {
    try {
      await _firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(userId)
          .collection(FirestoreConstants.chatHistoryCollection)
          .add(chatMessage.toDocument());
    } catch (e) {
      throw FirestoreWriteException(e.toString());
    }
  }

  Stream<List<FirestoreChatMessage>> getChatHistory(String userId) {
    try {
      return _firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(userId)
          .collection(FirestoreConstants.chatHistoryCollection)
          .orderBy(FirestoreConstants.timestampField, descending: true)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs
            .map((doc) => FirestoreChatMessage.fromDocument(doc))
            .toList();
      });
    } catch (e) {
      throw FirestoreReadException(e.toString());
    }
  }

  Future<void> clearChatHistory(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(userId)
          .collection(FirestoreConstants.chatHistoryCollection)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw FirestoreWriteException(e.toString());
    }
  }
}
