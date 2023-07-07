import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igor/services/firestore/firestore_constants.dart';

class FirestoreChatMessage {
  final String id;
  final String message;
  final DateTime timestamp;
  final String userId;
  final bool isFromUser;

  FirestoreChatMessage({
    required this.id,
    required this.message,
    required this.timestamp,
    required this.userId,
    required this.isFromUser,
  });

  // Convert a Firestore document to a FirestoreChatMessage.
  factory FirestoreChatMessage.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    return FirestoreChatMessage(
      id: document.id,
      message: data[FirestoreConstants.messageField] as String,
      timestamp:
          (data[FirestoreConstants.timestampField] as Timestamp).toDate(),
      userId: data[FirestoreConstants.userIdField] as String,
      isFromUser: data[FirestoreConstants.isUserMessageField] as bool,
    );
  }

  // Convert a FirestoreChatMessage to a Firestore document.
  Map<String, dynamic> toDocument() {
    return {
      FirestoreConstants.messageField: message,
      FirestoreConstants.timestampField: Timestamp.fromDate(timestamp),
      FirestoreConstants.userIdField: userId,
      FirestoreConstants.isUserMessageField: isFromUser,
    };
  }
}
