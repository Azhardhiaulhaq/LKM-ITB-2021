import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventRepository {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference seminars = firestore.collection('seminars');
  static CollectionReference modules = firestore.collection('modules');

  static Future<String> getSeminarTitle(String seminarID) async {
    try{
      var doc = await seminars.doc(seminarID).get();
      var data = doc.data() as Map<String, dynamic>;
      return data['name'] != null ? data['name'] : "";
    } catch(e){
      throw e;
    }
  }

  static Future<String> getModulTitle(String seminarID) async {
    try{
      var doc = await modules.doc(seminarID).get();
      var data = doc.data() as Map<String, dynamic>;
      return data['name'] != null ? data['name'] : "";
    } catch(e){
      throw e;
    }
  }

}