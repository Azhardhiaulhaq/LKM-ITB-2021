import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';

class ModuleRepository {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference answers = firestore.collection('answers');
  static CollectionReference modules = firestore.collection('modules');
  static CollectionReference grades = firestore.collection('grades');
  static CollectionReference groupGrades = firestore.collection('group_grades');
  static CollectionReference users = firestore.collection('users');

  static Future<DocumentSnapshot<Object?>> getModuleQuestions(String moduleID) {
    try {
      return modules.doc(moduleID).get();
    } catch (e) {
      throw e;
    }
  }

  static Future<void> setGradeStatus(String moduleID, String menteeID) async {
    try {
      await grades
          .doc(moduleID)
          .collection('users')
          .doc(menteeID)
          .update({'isComplete': true});
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getGradedUserLength(String moduleID, String group) async {
    try {
      QuerySnapshot<Object?> listGraded = await grades
          .doc(moduleID)
          .collection('users')
          .where('isComplete', isEqualTo: true)
          .where('group', isEqualTo: group)
          .get();
      return listGraded.size;
    } catch (e) {
      throw e;
    }
  }

  static Future<List<QueryDocumentSnapshot<Object?>>> getModulesList() async {
    try {
      QuerySnapshot<Object?> listModules = await modules.get();
      List<QueryDocumentSnapshot> docs = listModules.docs;
      return docs;
    } catch (e) {
      throw e;
    }
  }

  static Future<bool?> getUserAnswerStatus(
      String moduleID, String userID) async {
    try {
      DocumentSnapshot usersAnswer =
          await answers.doc(moduleID).collection('users').doc(userID).get();
      if (usersAnswer.exists) {
        return usersAnswer.get('isComplete');
      } else {
        return null;
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<int> getModulesAnswer(String moduleID, String group) async {
    try {
      QuerySnapshot<Object?> listAnswer = await answers
          .doc(moduleID)
          .collection('users')
          .where('group', isEqualTo: group)
          .get();
      return listAnswer.size;
    } catch (e) {
      throw e;
    }
  }

  static Future<void> initiateModuleGrades(
      String moduleID, String menteeID) async {
    try {
      var userGrades =
          await grades.doc(moduleID).collection('users').doc(menteeID).get();
      if (!userGrades.exists) {
        await UserRepository.getUserDetail(menteeID).then((e) async {
          await grades.doc(moduleID).collection('users').doc(menteeID).set({
            'score': 0,
            'name': e.get('name'),
            'group': e.get('group'),
            'isComplete': false
          });

          var groupGrades = await grades
              .doc(moduleID)
              .collection('groups')
              .doc(e.get('group'))
              .get();
          if (!groupGrades.exists) {
            await grades
                .doc(moduleID)
                .collection('groups')
                .doc(e.get('group'))
                .set({
              'score': 0,
              'group': e.get('group'),
            });
          }
        });
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addModuleGrades(String moduleID, String questionID,
      List<int> listAnswers, String menteeID, String groupID) async {
    try {
      int diff = 0;
      for (var answer in listAnswers) {
        diff += answer;
      }
      DocumentSnapshot userGrade =
          await UserRepository.getUserGrade(moduleID, menteeID, questionID);
      if (userGrade.exists) {
        var listGrades = List.from(userGrade.get('grades'));

        for (num grade in listGrades) {
          diff -= grade.toInt();
        }
      }
      await grades
          .doc(moduleID)
          .collection('users')
          .doc(menteeID)
          .collection('questions')
          .doc(questionID)
          .set({'grades': listAnswers});

      await grades
          .doc(moduleID)
          .collection('users')
          .doc(menteeID)
          .update({'score': FieldValue.increment(diff)});
      await grades
          .doc(moduleID)
          .collection('groups')
          .doc(groupID)
          .update({'score': FieldValue.increment(diff)});
      await groupGrades
          .doc(groupID)
          .update({'total': FieldValue.increment(diff)});
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> setAnswerStatus(String moduleID, String menteeID) async {
    try {
      await answers
          .doc(moduleID)
          .collection('users')
          .doc(menteeID)
          .update({'isComplete': true});
    } catch (e) {
      throw e;
    }
  }

  static Future<void> addModuleAnswer(
      String moduleID, String questionID, List listAnswers) async {
    try {
      String userID = sharedPrefs.userid;
      String name = sharedPrefs.name;
      String group = sharedPrefs.group;
      var userAnswer =
          await answers.doc(moduleID).collection('users').doc(userID).get();
      if (!userAnswer.exists) {
        await answers.doc(moduleID).collection('users').doc(userID).set({
          'isComplete': false,
          'name': name,
          'group': group,
        });

        await answers
            .doc(moduleID)
            .collection('users')
            .doc(userID)
            .collection('questions')
            .doc(questionID)
            .set({'answers': listAnswers});
      } else {
        await answers
            .doc(moduleID)
            .collection('users')
            .doc(userID)
            .collection('questions')
            .doc(questionID)
            .set({'answers': listAnswers});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<int> getModuleGrade(String moduleID, String groupID) async {
    try {
      DocumentSnapshot moduleGrades =
          await grades.doc(moduleID).collection('groups').doc(groupID).get();

      if (moduleGrades.exists) {
        var data = moduleGrades.data() as Map<String, dynamic>;
        return data['score'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      throw e;
    }
  }
}
