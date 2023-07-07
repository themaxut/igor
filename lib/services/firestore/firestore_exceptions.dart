class FirestoreException implements Exception {
  final String? message;

  FirestoreException({this.message});
}

class FirestoreReadException extends FirestoreException {
  FirestoreReadException(String message) : super(message: message);
}

class FirestoreWriteException extends FirestoreException {
  FirestoreWriteException(String message) : super(message: message);
}

class FirestoreUpdateException extends FirestoreException {
  FirestoreUpdateException(String message) : super(message: message);
}

class FirestoreDeleteException extends FirestoreException {
  FirestoreDeleteException(String message) : super(message: message);
}
