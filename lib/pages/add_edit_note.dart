import 'package:firebase_crud/services/firestore_services.dart';
import 'package:firebase_crud/utils/consts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddEditNote extends StatelessWidget {
  String? docId;
  String? title;
  String? note;
  AddEditNote({
    super.key,
    this.docId,
    this.title,
    this.note,
  });

  final service = FirestoreServices();

  final titleController = TextEditingController();
  final noteController = TextEditingController();

  void addNote() {
    final title = titleController.text.trim();
    final note = noteController.text.trim();
    service.addNote(title, note);
    titleController.clear();
    noteController.clear();
  }

  updateNote(docId) {
    final title = titleController.text.trim();
    final note = noteController.text.trim();
    service.updateNote(docId, title, note);
    titleController.clear();
    noteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = title ?? '';
    noteController.text = note ?? '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add or Edit Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                focusedBorder: customBorder,
                enabledBorder: customBorder,
                border: customBorder,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: noteController,
              decoration: InputDecoration(
                hintText: 'Note',
                focusedBorder: customBorder,
                enabledBorder: customBorder,
                border: customBorder,
              ),
            ),
            const SizedBox(height: 20),
            TextButton.icon(
              onPressed: () {
                title == null && docId == null && note == null
                    ? addNote()
                    : updateNote(
                        docId,
                      );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.save_alt),
              label: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  final customBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: kMainColor),
  );
}
