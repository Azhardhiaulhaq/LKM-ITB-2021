import 'package:cloud_firestore/cloud_firestore.dart';

class Seminar {
  String? seminarID;
  String? numSeminar;
  String? name;
  Timestamp? date;

  Seminar({this.seminarID,this.numSeminar,this.name,this.date});

}