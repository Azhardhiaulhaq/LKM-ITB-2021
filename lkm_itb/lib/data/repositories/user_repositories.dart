import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:lkm_itb/data/models/presence.dart';
import 'package:lkm_itb/data/models/profile_data.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:path/path.dart';

class UserRepository {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference users = firestore.collection('users');
  static CollectionReference precenses = firestore.collection('precenses');
  static CollectionReference statistics = firestore.collection('statistics');
  static CollectionReference grades = firestore.collection('grades');
  static CollectionReference groupGrades = firestore.collection('group_grades');
  static CollectionReference answers = firestore.collection('answers');
  static CollectionReference seminars = firestore.collection('seminars');
  // Sign In with email and password

  static Future<String?> uploadImage(File imageFile) async {
    try {
      String fileName = basename(imageFile.path);
      var firebaseStorageRef =
          FirebaseStorage.instance.ref().child('profile').child('$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      var taskSnapshot = await uploadTask.whenComplete(() {});
      var urlDownload = await taskSnapshot.ref.getDownloadURL();
      return urlDownload;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> updateImageProfile(String link, String userID) async {
    try {
      await users.doc(userID).update({
        'photo': link,
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getUserGrades(
      String moduleID, String userID) async {
    try {
      QuerySnapshot<Object?> listGrades = await grades
          .doc(moduleID)
          .collection('users')
          .doc(userID)
          .collection('questions')
          .get();

      List<QueryDocumentSnapshot> docs = listGrades.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> updateProfile(ProfileData profile) async {
    try {
      await users.doc(profile.userID).update({
        'name': profile.name,
        'email': profile.email,
        'gender': profile.gender,
        'nim': profile.nim,
        'faculty': profile.faculty,
        'major': profile.major,
        'organizationType': profile.organizationType,
        'organization': profile.organization,
        'photo': profile.photo,
        'role': profile.role,
        'group': profile.group
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getUserTotalGrade(String moduleID, String userID) async {
    try {
      int grade = 0;
      DocumentSnapshot userGrades =
          await grades.doc(moduleID).collection('users').doc(userID).get();
      if (userGrades.exists) {
        Map<String, dynamic> map = userGrades.data() as Map<String, dynamic>;
        grade = map['score'] ?? 0;
      }

      return grade;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  static Future<DocumentSnapshot<Object?>> getUserDetail(String userID) {
    try {
      return users.doc(userID).get();
    } catch (e) {
      throw e;
    }
  }

  static Future<DocumentSnapshot<Object?>> getUserAnswers(
      String moduleID, String userID, String docID) {
    try {
      return answers
          .doc(moduleID)
          .collection('users')
          .doc(userID)
          .collection('questions')
          .doc(docID)
          .get();
    } catch (e) {
      throw e;
    }
  }

  static Future<DocumentSnapshot<Object?>> getUserGrade(
      String moduleID, String userID, String docID) {
    try {
      return grades
          .doc(moduleID)
          .collection('users')
          .doc(userID)
          .collection('questions')
          .doc(docID)
          .get();
    } catch (e) {
      throw e;
    }
  }

  static Future<DocumentSnapshot<Object?>> getGroupGrade(String groupID) {
    try {
      return groupGrades.doc(groupID).get();
    } catch (e) {
      throw e;
    }
  }

  static Future<bool?> getGradeStatus(String moduleID, String userID) async {
    try {
      DocumentSnapshot statusDoc =
          await grades.doc(moduleID).collection('users').doc(userID).get();
      bool status = statusDoc.get('isComplete');
      return status;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      var auth = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      sharedPrefs.setID(auth.user!.uid);
      sharedPrefs.setEmail(auth.user!.email!);

      return auth.user;
    } catch (e) {
      print(e.toString());
    }
  }

  // Sign Out
  static Future<void> sendForgetPassRequest(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  // check Sign In
  static Future<bool> isSignedIn() async {
    // ignore: await_only_futures
    var currentUser = await firebaseAuth.currentUser;
    if (currentUser != null) {
      // ignore: await_only_futures
      await users.doc(currentUser.uid).snapshots().listen((result) {
        sharedPrefs.setName(result['name']);
        sharedPrefs.setID(currentUser.uid);
        sharedPrefs.setRole(result['role']);
        sharedPrefs.setEmail(currentUser.email!);
        sharedPrefs.setGroup(result['group']);
      });
    }
    return currentUser != null;
  }

  //get current user

  static Future<User?> getCurrentUser() async {
    // ignore: await_only_futures
    return await firebaseAuth.currentUser;
  }

  static Future<bool> checkSameID(String id) async {
    // ignore: await_only_futures
    var currentUser = await firebaseAuth.currentUser;

    return currentUser!.uid == id;
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getGroupedUser(
      String group) async {
    try {
      QuerySnapshot<Object?> listUser = await users
          .where('group', isEqualTo: group)
          .where('role', isEqualTo: 'mentee')
          .get();
      List<QueryDocumentSnapshot> docs = listUser.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getGroupLength(String group) async {
    try {
      QuerySnapshot<Object?> listUser = await users
          .where('group', isEqualTo: group)
          .where('role', isEqualTo: 'mentee')
          .get();
      return listUser.size;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getUserinGroup(
      String group) async {
    try {
      QuerySnapshot<Object?> listUser = await users
          .where('group', isEqualTo: group)
          .where('role', isEqualTo: 'mentee')
          .get();
      return listUser.docs;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getPresencedSeminarUser(
      String eventID, String group) async {
    try {
      QuerySnapshot<Object?> listUser = await precenses
          .doc(eventID)
          .collection('group')
          .doc(group)
          .collection('users')
          .get();
      List<QueryDocumentSnapshot> docs = listUser.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> updatePrecense(
      String eventID, String group, Presence userPresence) async {
    try {
      var doc = await precenses
          .doc(eventID)
          .collection('group')
          .doc(group)
          .collection('users')
          .doc(userPresence.userID)
          .get();
      var data = doc.data() as Map<String, dynamic>;
      if (data['is_precense'] != userPresence.isPresence) {
        await precenses
            .doc(eventID)
            .collection('group')
            .doc(group)
            .collection('users')
            .doc(userPresence.userID)
            .update({
          'is_precense': userPresence.isPresence,
          'updatedAt': Timestamp.fromDate(DateTime.now())
        });
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addPrecense(
      String eventID, String group, Presence userPresence) async {
    try {
      await precenses
          .doc(eventID)
          .collection('group')
          .doc(group)
          .collection('users')
          .doc(userPresence.userID)
          .set({
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'is_precense': userPresence.isPresence,
        'updatedAt': Timestamp.fromDate(DateTime.now())
      });
    } catch (e) {
      throw e;
    }
  }

  static Future<String> downloadSeminarPresence(String group) async {
    try {
      final stopwatch = Stopwatch()..start();
      String path = '';
      path = (await DownloadsPathProvider.downloadsDirectory)!.path;
      String outputFile = '$path/presensi_mentee.xlsx';
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Presensi Seminar'];
      List<String> columnID = ['A', 'B', 'C', 'D', 'E', 'F'];
      List<String> columnHeader = [
        'No',
        'SeminarID',
        'SeminarTitle',
        'Name',
        'Group',
        'Time'
      ];
      for (var i = 0; i < columnID.length; i++) {
        var cell = sheetObject.cell(CellIndex.indexByString(columnID[i] + "1"));
        cell.value = columnHeader[i];
      }
      int index = 2;
      var seminarRef = await seminars.get();
      var listSeminars = seminarRef.docs;
      var userRef = await users.get();
      var listUser = userRef.docs;
      for (var i = 901; i <= 907; i++) {
        var seminarInfo = listSeminars
            .firstWhere((element) => element.id == i.toString())
            .data() as Map<String, dynamic>;
        for (var grup = 1; grup <= 20; grup++) {
          QuerySnapshot presenceUser = await precenses
              .doc(i.toString())
              .collection('group')
              .doc(grup.toString())
              .collection('users')
              .where('is_precense', isEqualTo: true)
              .get();
          for (var presence in presenceUser.docs) {
            var userInfo = listUser
                .firstWhere((element) => element.id == presence.id)
                .data() as Map<String, dynamic>;
            var presenceMap = presence.data() as Map<String, dynamic>;
            sheetObject
                .cell(CellIndex.indexByString('A' + index.toString()))
                .value = index - 1;
            sheetObject
                .cell(CellIndex.indexByString('B' + index.toString()))
                .value = i;
            sheetObject
                .cell(CellIndex.indexByString('C' + index.toString()))
                .value = seminarInfo['name'];
            sheetObject
                .cell(CellIndex.indexByString('D' + index.toString()))
                .value = userInfo['name'];
            sheetObject
                .cell(CellIndex.indexByString('E' + index.toString()))
                .value = grup;
            sheetObject
                    .cell(CellIndex.indexByString('F' + index.toString()))
                    .value =
                DateFormat('MM/dd/yyyy, hh:mm a')
                    .format((presenceMap['updatedAt'] as Timestamp).toDate());
            index = index + 1;
          }
        }
      }
      print('PResensi Mentoring');
      Sheet sheetObject2 = excel['Presensi Mentoring'];
      List<String> columnID2 = ['A', 'B', 'C', 'D', 'E'];
      List<String> columnHeader2 = [
        'No',
        'ModuleID',
        'Name',
        'Group',
        'Time'
      ];
      for (var i = 0; i < columnID2.length; i++) {
        var cell = sheetObject2.cell(CellIndex.indexByString(columnID[i] + "1"));
        cell.value = columnHeader2[i];
      }
      int index2 = 2;
      for (var i = 1; i <= 6; i++) {
        for (var grup = 1; grup <= 20; grup++) {
          QuerySnapshot presenceUser = await precenses
              .doc(i.toString())
              .collection('group')
              .doc(grup.toString())
              .collection('users')
              .where('is_precense', isEqualTo: true)
              .get();
          for (var presence in presenceUser.docs) {
            var userInfo = listUser
                .firstWhere((element) => element.id == presence.id)
                .data() as Map<String, dynamic>;
            var presenceMap = presence.data() as Map<String, dynamic>;
            sheetObject2
                .cell(CellIndex.indexByString('A' + index2.toString()))
                .value = index2 - 1;
            sheetObject2
                .cell(CellIndex.indexByString('B' + index2.toString()))
                .value = i;
            sheetObject2
                .cell(CellIndex.indexByString('C' + index2.toString()))
                .value = userInfo['name'];
            sheetObject2
                .cell(CellIndex.indexByString('D' + index2.toString()))
                .value = grup;
            sheetObject2
                    .cell(CellIndex.indexByString('E' + index2.toString()))
                    .value =
                DateFormat('MM/dd/yyyy, hh:mm a')
                    .format((presenceMap['updatedAt'] as Timestamp).toDate());
            index2 = index2 + 1;
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
}
