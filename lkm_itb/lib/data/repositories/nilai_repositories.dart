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
      final stopwatch = Stopwatch()..start();
      String path = '';
      path = (await DownloadsPathProvider.downloadsDirectory)!.path;
      String outputFile = '$path/nilai_mentee.xlsx';
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Nilai Mentee'];
      List<String> columnID = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
      List<String> columnHeader = [
        'No',
        'Name',
        'Group',
        'ModuleID',
        'PageID',
        'QuestionNum',
        'Score'
      ];
      for (var i = 0; i < columnID.length; i++) {
        var cell = sheetObject.cell(CellIndex.indexByString(columnID[i] + "1"));
        cell.value = columnHeader[i];
      }
      int index = 2;
      for (var grup = 1; grup <= 20; grup++) {
        for (var i = 1; i <= 6; i++) {
          QuerySnapshot userGrades = await grades
              .doc(i.toString())
              .collection('users')
              .where('group', isEqualTo: grup.toString())
              .get();
          for (var userGrade in userGrades.docs) {
            var userQuestions = await grades
                .doc(i.toString())
                .collection('users')
                .doc(userGrade.id)
                .collection('questions')
                .get();
            var userData = await grades
                .doc(i.toString())
                .collection('users')
                .doc(userGrade.id)
                .get();
            var mapUser = userData.data() as Map<String, dynamic>;
            for (var question in userQuestions.docs) {
              var mapQuestion = question.data() as Map<String, dynamic>;
              var grades = List.from(mapQuestion['grades']);
              for (var j = 0; j < grades.length; j++) {
                sheetObject
                    .cell(CellIndex.indexByString('A' + index.toString()))
                    .value = index - 1;
                sheetObject
                    .cell(CellIndex.indexByString('B' + index.toString()))
                    .value = mapUser['name'];
                sheetObject
                    .cell(CellIndex.indexByString('C' + index.toString()))
                    .value = mapUser['group'];
                sheetObject
                    .cell(CellIndex.indexByString('D' + index.toString()))
                    .value = i;
                sheetObject
                    .cell(CellIndex.indexByString('E' + index.toString()))
                    .value = question.id;
                sheetObject
                    .cell(CellIndex.indexByString('F' + index.toString()))
                    .value = j + 1;
                sheetObject
                    .cell(CellIndex.indexByString('G' + index.toString()))
                    .value = grades[j];
                index = index + 1;
              }
            }
          }
        }
      }
      List<int>? fileBytes = excel.save();
      if (fileBytes != null) {
        File(outputFile)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
      }
      print('doSomething() executed in ${stopwatch.elapsed}');
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
