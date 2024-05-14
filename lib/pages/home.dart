import 'package:firebase_crud/pages/add_edit_note.dart';
import 'package:firebase_crud/services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final noteService = FirestoreServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddEditNote(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_outline,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
            stream: noteService.getNotes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(data['title'].toString()),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => AddEditNote(
                                      docId: data.id,
                                      title: data['title'],
                                      note: data['note'],
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                noteService.deleteNote(data.id);
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(data['note'].toString()),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
