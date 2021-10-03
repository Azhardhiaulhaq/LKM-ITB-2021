import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:excel/excel.dart';
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

  static Future<String> downloadGrades(String group) async {
    try {
      String path = '';
      path = (await DownloadsPathProvider.downloadsDirectory)!.path;
      String outputFile = '$path/nilai_kelompok_$group.xlsx';
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Nilai Mentee'];
      List<String> columnID = ['A', 'B', 'C', 'D', 'E'];
      List<String> columnHeader = [
        'No',
        'ModuleID',
        'Nama',
        'Kelompok',
        'Nilai'
      ];
      for (var i = 0; i < columnID.length; i++) {
        var cell = sheetObject.cell(CellIndex.indexByString(columnID[i] + "1"));
        cell.value = columnHeader[i];
      }
      int index = 2;
      for (var i = 1; i <= 6; i++) {
        QuerySnapshot userGrades = await grades
            .doc(i.toString())
            .collection('users')
            .where('group', isEqualTo: group)
            .get();
        for (var userGrade in userGrades.docs) {
          var userData = await grades
              .doc(i.toString())
              .collection('users')
              .doc(userGrade.id)
              .get();
          var map = userData.data() as Map<String, dynamic>;
          sheetObject
              .cell(CellIndex.indexByString('A' + index.toString()))
              .value = index - 1;
          sheetObject
              .cell(CellIndex.indexByString('B' + index.toString()))
              .value = i;
          sheetObject
              .cell(CellIndex.indexByString('C' + index.toString()))
              .value = map['name'];
          sheetObject
              .cell(CellIndex.indexByString('D' + index.toString()))
              .value = group;
          sheetObject
              .cell(CellIndex.indexByString('E' + index.toString()))
              .value = map['score'];
          index = index + 1;
        }
      }
      List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File(outputFile)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
      }
      return outputFile;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getGroups() async {
    try {
      QuerySnapshot<Object?> listGroups =
          await groups.orderBy('name', descending: false).get();

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
      QuerySnapshot<Object?> listGrades =
          await groupGrades.orderBy('id', descending: false).get();

      List<QueryDocumentSnapshot> docs = listGrades.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getGroupedUser(
      String moduleID, String group) async {
    try {
      QuerySnapshot<Object?> listGrades = await grades
          .doc(moduleID)
          .collection('users')
          .where('group', isEqualTo: group)
          .get();

      List<QueryDocumentSnapshot> docs = listGrades.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }
}
