import 'package:checkit/controller/note_controller.dart';
import 'package:checkit/view/components/my_note_button.dart';
import 'package:checkit/view/components/my_note_filed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageTwo extends StatelessWidget {
  const HomePageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    NoteController noteController = Get.put(NoteController());
    return Stack(
      children: [
        Form(
          key: noteController.formKey,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                MyNoteField(controller: noteController.titleController),
                const SizedBox(height: 15),
                MyNoteButton(onPressed: () {
                  noteController.addNote(
                      noteController.titleController.text, false, context);
                }),
              ],
            ),
          ),
        ),
        GetBuilder<NoteController>(builder: (controller) {
          return noteController.isLoading
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff7C2E84),
                    ),
                  ),
                )
              : const Text("");
        })
      ],
    );
  }
}
