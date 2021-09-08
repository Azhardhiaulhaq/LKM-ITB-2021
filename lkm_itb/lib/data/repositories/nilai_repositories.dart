import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NilaiRepository {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users = firestore.collection('users');
  static CollectionReference precenses = firestore.collection('precenses');
  static CollectionReference statistics = firestore.collection('statistics');
  static CollectionReference grades = firestore.collection('grades');
  static CollectionReference groupGrades = firestore.collection('group_grades');
  static CollectionReference groups = firestore.collection('groups');


  static Future<List<QueryDocumentSnapshot<Object?>>> getGroups() async {
    try {
      QuerySnapshot<Object?> listGroups = await groups.orderBy('name', descending: false).get();

      List<QueryDocumentSnapshot> docs = listGroups.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }
  static Future<List<QueryDocumentSnapshot<Object?>>> getGradeModules() async {
    try {
      QuerySnapshot<Object?> listGrades = await grades.get();


      List<QueryDocumentSnapshot> docs = listGrades.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getGroupGrade() async {
    try {
      QuerySnapshot<Object?> listGrades = await groupGrades.orderBy('id',descending: false).get();


      List<QueryDocumentSnapshot> docs = listGrades.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }


  static Future<List<QueryDocumentSnapshot<Object?>>> getGroupedUser(String moduleID, String group) async {
    try {
      QuerySnapshot<Object?> listGrades = await grades.doc(moduleID).collection('users').where('group', isEqualTo: group).get();

      List<QueryDocumentSnapshot> docs = listGrades.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }
}