import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/models/module.dart';
import 'package:lkm_itb/data/models/seminar.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/home_screen/ui/module_card.dart';
import 'package:lkm_itb/home_screen/ui/seminar_card.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  HomeScreen({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState(user);
}

class _HomeScreenState extends State<HomeScreen> {
  final User user;
  CollectionReference modules =
      FirebaseFirestore.instance.collection('modules');
  CollectionReference seminars =
      FirebaseFirestore.instance.collection('seminars');
  CollectionReference banners =
      FirebaseFirestore.instance.collection('banners');
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController searchController = TextEditingController(text: "");
  String role = 'mentor';
  String userID = '';

  _HomeScreenState(this.user);

  Widget _imageCarousel() {
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorColor: ConstColor.darkGreen,
      indicatorBackgroundColor: Colors.grey,
      children: [
        Image.network(
          'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/banner%2FBANNER%20BU%20REKTOR.png?alt=media&token=ed132b55-4eea-4d3e-b374-aaa32ad85fb8',
          fit: BoxFit.fitWidth,
        ),
        Image.network(
          'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/banner%2FBANNER%20LKM.png?alt=media&token=2d67ab9a-a982-4667-9b95-4a723dce91a2',
          fit: BoxFit.fitWidth,
        ),
        Image.network(
          'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/banner%2FBANNER%20DITMAWA.png?alt=media&token=89e3ad78-447b-4a1a-8ecf-d7ced67d400e',
          fit: BoxFit.fitWidth,
        ),
      ],
    );
  }

  Widget _contentTitle(String title) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              switch (title) {
                case 'Mengenal LKM':
                  Navigator.pushNamed(context, '/home/detaillkm');
                  break;
                case 'Kumpulan Modul':
                  Navigator.pushNamed(context, '/home/listlkm');
                  break;
              }
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(16, 5, 16, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          title,
                          style: GoogleFonts.roboto(
                              color: ConstColor.blackText,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start,
                        )),
                  ],
                ))));
  }

  Widget _timeline() {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 15, 16, 20),
        child: Center(
          child: SvgPicture.asset(
            'assets/svg/timeline_kegiatan.svg',
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
          ),
        ));
  }

  Widget _mengenalLKM() {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/home/detaillkm');
          },
          splashColor: Colors.transparent,
          child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 15),
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 3,
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Mahasiswa sebagai agen pembaharu menjadi objek penting dalam peningkatan kualitas bangsa dan negara. Mahasiswa ITB dengan kapasitas intelektualnya merupakan pemimpin harapan di masa depan yang dapat mengharumkan nama bangsa .... read more',
                        style: GoogleFonts.roboto(
                            color: ConstColor.blackText,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.justify,
                      )))),
        ));
  }

  Stream<QuerySnapshot> moduleStream() {
    return modules.limit(2).snapshots();
  }

  Stream<QuerySnapshot> seminarStream() {
    return seminars.snapshots();
  }

  Widget _kumpulanModule(String role) {
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
                  role: role))
              .toList(),
        );
      },
    );
  }

  Widget _presensiKelompok() {
    return StreamBuilder<QuerySnapshot>(
      stream: seminarStream(),
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
        return Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: SizedBox(
                height: 150,
                child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) =>
                        SeminarCard(
                          seminar: Seminar(
                              seminarID: snapshot.data!.docs[index].id,
                              numSeminar:
                                  snapshot.data!.docs[index].get('seminar_num'),
                              name: snapshot.data!.docs[index].get('name'),
                              date: snapshot.data!.docs[index].get('date')),
                        ))));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      userID = sharedPrefs.userid;
      role = sharedPrefs.role;
    });
  }

  Stream<DocumentSnapshot> homeStream() {
    return users.doc(user.uid).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: homeStream(),
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
        if(snapshot.hasData){
          sharedPrefs.setRole(snapshot.data!.get('role'));
          sharedPrefs.setGroup(snapshot.data!.get('group'));
          sharedPrefs.setName(snapshot.data!.get('name'));
        }
        return Scaffold(
            body: SafeArea(
          child: Stack(fit: StackFit.expand, children: <Widget>[
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _imageCarousel(),
                _contentTitle('Mengenal LKM'),
                _mengenalLKM(),
                _contentTitle('Timeline Kegiatan'),
                _timeline(),
                snapshot.data!.get('role') == 'mentor'
                    ? _contentTitle('Presensi Kelompok')
                    : Container(),
                snapshot.data!.get('role') == 'mentor'
                    ? _presensiKelompok()
                    : Container(),
                _contentTitle('Kumpulan Modul'),
                _kumpulanModule(snapshot.data!.get('role')),
                SizedBox(
                  height: 150,
                )
              ],
            ))
          ]),
        ));
      },
    );
  }
}
