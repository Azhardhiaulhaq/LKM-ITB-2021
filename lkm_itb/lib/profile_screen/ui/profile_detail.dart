import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/back_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/data.dart';
import 'package:lkm_itb/constants/size_config.dart';

class ProfileDetail extends StatefulWidget {
  ProfileDetail({Key? key, required this.title, required this.user})
      : super(key: key);
  final User user;
  final String title;

  @override
  _ProfileDetailState createState() => _ProfileDetailState(user);
}

class _ProfileDetailState extends State<ProfileDetail> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final User user;

  _ProfileDetailState(this.user);
  @override
  void initState() {
    super.initState();
  }

  Stream<DocumentSnapshot> homeStream() {
    return users.doc(user.uid).snapshots();
  }

  _field(String title, String entry, bool isName) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Text(title,
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: ConstColor.boldGreyText)),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(isName ? entry.toUpperCase() : entry,
              textAlign: TextAlign.start,
              style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ConstColor.blackText)),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.03,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        Map dataProfile = snapshot.data!.data() as Map;
        String role = dataProfile['role'] ?? 'Belum Ada Status';
        String group = dataProfile['group'] ?? 'Belum Ada Kelompok';
        String faculty = dataProfile['faculty'] ?? 'Belum Ada Fakultas';
        String major = AppData.mapMajor[faculty]?[dataProfile['major']] ??
            'Belum Ada Program Jurusan';

        return Scaffold(
            body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.15,
                        ),
                        Container(
                          width: SizeConfig.screenWidth,
                          alignment: Alignment.center,
                          child: Center(
                              child: CircleAvatar(
                            backgroundColor: ConstColor.lightGreen,
                            backgroundImage: NetworkImage(dataProfile[
                                        'photo'] !=
                                    null
                                ? dataProfile['photo']
                                : 'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/profile%2Fpngfind.com-default-image-png-6764065.png?alt=media&token=b5ed67d2-cf3b-41b0-804a-e51f4fbd008f'),
                            maxRadius: 45,
                          )),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.08,
                        ),
                        _field('Nama Lengkap',
                            dataProfile['name'] ?? 'Belum Ada Nama', true),
                        _field('NIM', dataProfile['nim'] ?? 'Belum Ada NIM',
                            false),
                        _field('Program Studi/Fakultas', major + '/' + faculty,
                            false),
                        _field(
                            'Lembaga',
                            AppData.mapOrganization[
                                        dataProfile['organizationType']]
                                    ?[dataProfile['organization']] ??
                                'Belum Ada Lembaga',
                            false),
                        _field('Status/Kelompok', role + '/' + group, false),
                        _field(
                            'Email', user.email ?? 'Belum Ada Lembaga', false),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Image.asset(
                      "assets/images/footer_profile.png",
                      fit: BoxFit.fitWidth,
                      width: SizeConfig.screenWidth,
                    ),
                  ),
                  Positioned(
                      top: 40,
                      left: 0,
                      child: new CustomBackButton(
                        title: 'Informasi Pribadi',
                      )),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
