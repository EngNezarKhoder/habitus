import 'package:checkit/model/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NoteController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController titleController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final Stream<QuerySnapshot> notesStream =
  //     FirebaseFirestore.instance.collection("notes").snapshots();
  Stream<QuerySnapshot> getTodayNotesStream() {
    String today = DateFormat('EEEE, MMMM d').format(DateTime.now());
    return _firestore
        .collection("notes")
        .where("date", isEqualTo: today)
        .where("id",
            isEqualTo:
                FirebaseAuth.instance.currentUser!.uid) // فلتر على التاريخ
        .snapshots();
  }

  bool isLoading = false;
  Future<void> addNote(String title, bool status, context) async {
    FocusScope.of(context).unfocus();
    isLoading = true;
    update();
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String formattedDate = DateFormat('EEEE, MMMM d').format(DateTime.now());
      String formattedTime = DateFormat('h:mm a').format(DateTime.now());
      Note note = Note(
          id: userId,
          title: title,
          status: status,
          date: formattedDate,
          time: formattedTime);
      await _firestore.collection("notes").add(note.toMap());
      Get.snackbar(
        "Success",
        "Note added successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xff7C2E84).withOpacity(0.8),
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 12,
        duration: const Duration(seconds: 4),
      );
      titleController.clear();
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteNote(String docId) async {
    try {
      await _firestore.collection("notes").doc(docId).delete();
      Get.snackbar("Deleted", "Note deleted successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
    }
  }

  Future<void> updateStatus(String docId, bool status) async {
    try {
      await _firestore
          .collection("notes")
          .doc(docId)
          .update({"status": status});
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
    }
  }

  Future<void> updateTitle(String docId, String newTitle) async {
    try {
      await _firestore
          .collection("notes")
          .doc(docId)
          .update({"title": newTitle});
      Get.snackbar("Updated", "Note updated successfully",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white);
    }
  }
}
