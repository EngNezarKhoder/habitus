import 'package:checkit/controller/note_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageOne extends StatelessWidget {
  const HomePageOne({super.key});

  @override
  Widget build(BuildContext context) {
    NoteController noteController = Get.put(NoteController());
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "10".tr,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 126, 94, 129)),
          ),
          Expanded(
            child: StreamBuilder(
                stream: noteController.getTodayNotesStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 80,
                            color: Colors.red[400],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Oops! Something went wrong",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.red[600],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "We couldn't load your notes.\nPlease try again later.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red[400],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff7C2E84),
                      ),
                    );
                  }
                  final notes = snapshot.data!.docs;
                  if (notes.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_note_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "11".tr,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "12".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: notes.length,
                      itemBuilder: (context, index) {
                        var note = notes[index].data() as Map<String, dynamic>;
                        var noteId = notes[index].id;
                        return Card(
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          color: const Color.fromARGB(137, 168, 137, 209),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      note['title'] ?? 'no title',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Checkbox(
                                        value: note['status'] ?? false,
                                        onChanged: (value) {
                                          if (value != null) {
                                            noteController.updateStatus(
                                                noteId, value);
                                          }
                                        }),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(note['date'] ?? ''),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Confirm Delete"),
                                            content: const Text(
                                                "Are you sure you want to delete this note?"),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text("Cancel"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  noteController.deleteNote(
                                                      noteId); // الحذف فعليًا
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Delete"),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(note['time'] ?? ''),
                                    IconButton(
                                      onPressed: () {
                                        TextEditingController editController =
                                            TextEditingController(
                                                text: note['title']);
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text("Edit Note"),
                                              content: TextField(
                                                controller: editController,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Enter new title"),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Get.back(),
                                                  child: const Text("Cancel"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    noteController.updateTitle(
                                                        noteId,
                                                        editController.text);
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    Get.back();
                                                  },
                                                  child: const Text("Save"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.edit,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
