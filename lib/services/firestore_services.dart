import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  //Get collection of notes
  final CollectionReference notes = FirebaseFirestore.instance.collection(
    'notes',
  );

  //Create: Add a new note
  Future<void> addNote(String title, String description) {
    return notes.add({
      'title': title,
      'note': description,
      'timestamp': Timestamp.now(),
    });
  }

  //Read: Get note from database
  Stream<QuerySnapshot> getNotes() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
  }

  //Update: Update notes given a doc id
  void updateNote(
    String docId,
    String title,
    String keyNote,
  ) {
    notes.doc(docId).update({
      'title': title,
      'note': keyNote,
      'timestamp': Timestamp.now(),
    });
  }

  //Delete: Delete notes given a doc id
  Future<void> deleteNote(String docId) {
    return notes.doc(docId).delete();
  }
}
