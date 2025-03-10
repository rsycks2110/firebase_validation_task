import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_validation_task/model/notes_model.dart';
import 'package:flutter/material.dart';

class FirebaseProvider{
  static FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  static const String collectionNotes="notes";

  static addNotes(NotesModel newNote) async{
   //  var notesRef = await firebaseFireStore.collection(collectionNotes).add(newNote.);
   //  DocumentReference docRef = notesRef.doc();
   // await docRef.set({"notesID":docRef.id});
   firebaseFireStore.collection(collectionNotes).add(newNote.toDoc()).then((value)  {
      return firebaseFireStore.collection(collectionNotes).doc(value.id).update({"noteID":value.id});
    });
  }

 static Future<void> updateNotes(NotesModel updateNote) async{
   await firebaseFireStore.collection(collectionNotes).doc(updateNote.noteID).update(updateNote.toDoc());
  }

  static Future<void> deleteNotes(NotesModel deleteNotes) async{
    await firebaseFireStore.collection(collectionNotes).doc(deleteNotes.noteID).delete();
  }
  static Stream<QuerySnapshot<Map<String,dynamic>>> fetchAllNotes(){
    return firebaseFireStore.collection(collectionNotes).snapshots();
  }


}