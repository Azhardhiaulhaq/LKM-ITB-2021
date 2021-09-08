import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      await users.doc(currentUser.uid).snapshots().listen((result) {
        sharedPrefs.setName(result['name']);
        sharedPrefs.setID(currentUser.uid);
        sharedPrefs.setRole(result['role']);
        sharedPrefs.setEmail(currentUser.email!);
        sharedPrefs.setGroup(result['grou[']);
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
}
