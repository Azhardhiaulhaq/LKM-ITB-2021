import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/models/module.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/home_screen/ui/module_card.dart';

class ListLKM extends StatefulWidget {
  ListLKM({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ListLKMState createState() => _ListLKMState();
}

class _ListLKMState extends State<ListLKM> {
  CollectionReference modules =
      FirebaseFirestore.instance.collection('modules');

  Widget _contentTitle(String title) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {},
            child: Container(
                
                width: MediaQuery.of(context).size.width,
                child: Text(
                  title,
                  style: GoogleFonts.roboto(
                      color: ConstColor.blackText,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ))));
  }

  Stream<QuerySnapshot> moduleStream() {
    return modules.snapshots();
  }

  Widget _kumpulanModule() {
    return StreamBuilder<QuerySnapshot>(
      stream: moduleStream(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: ConstColor.darkGreen,
          ));
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        }
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: snapshot.data!.docs
              .map((e) => ModuleCard(
                  module: Module(
                      modulID: e.get('moduleID'),
                      banner: e.get('banner'),
                      naration: e.get('naration'),
                      name: e.get('name'),
                      questions: List.from(e.get('questions'))),
                  role : sharedPrefs.role))
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),
            _contentTitle('Kumpulan Modul'),
            SizedBox(height: 20,),
            _kumpulanModule(),
            SizedBox(
              height: 100,
            )
          ],
        ))
      ]),
    ));
  }
}
