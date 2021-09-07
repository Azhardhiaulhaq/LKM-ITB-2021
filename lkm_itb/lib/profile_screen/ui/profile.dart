import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/repositories/user_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/profile_screen/ui/profile_detail.dart';
import 'package:lkm_itb/profile_screen/ui/profile_edit_form.dart';
import 'package:lkm_itb/profile_screen/ui/profile_form_builder.dart';
import 'package:lkm_itb/pusat_bantuan/ui/pusat_bantuan.dart';
import 'package:lkm_itb/tentang_kami/ui/tentang_kami.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class Profile extends StatefulWidget {
  final User user;
  Profile({Key? key, required this.title, required this.user})
      : super(key: key);

  final String title;

  @override
  _ProfileState createState() => _ProfileState(this.user);
}

class _ProfileState extends State<Profile> {
  final User user;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  _ProfileState(this.user);

  Widget _profileEntry(String title, String iconPath, String code) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            splashColor: Colors.transparent,
            onTap: () async {
              switch (code) {
                case 'infoPribadi':
                  print('info Pribadi');
                  pushNewScreen(
                    context,
                    screen: ProfileDetail(title: 'Profile Detail', user: user),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  break;
                case 'password':
                  print('password');
                  break;
                case 'editProfile':
                  print('EditProfile');
                  // pushNewScreen(
                  //   context,
                  //   screen: ProfileFormBuilder(user: user),
                  //   withNavBar: false, // OPTIONAL VALUE. True by default.
                  //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  // );
                  pushNewScreenWithRouteSettings(context,
                      screen: ProfileFormBuilder(user: user),
                      settings: RouteSettings(name: '/profile/edit'),
                      withNavBar: false);
                  break;
                case 'tentangKami':
                  pushNewScreen(
                    context,
                    screen: TentangKami(title: 'Tentang Kami'),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  break;
                case 'pusatBantuan':
                  pushNewScreen(
                    context,
                    screen: PusatBantuan(title: 'Pusat Bantuan'),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  break;
                case 'signOut':
                  await sharedPrefs.remove;
                  await UserRepository.signOut();
                  await Phoenix.rebirth(context);
                  break;
              }
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          title,
                          style: GoogleFonts.roboto(
                              color: ConstColor.blackText,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        )),
                    Container(
                        child: SvgPicture.asset(
                      iconPath,
                      width: 20,
                      height: 20,
                    ))
                  ],
                ))));
  }

  Stream<DocumentSnapshot> homeStream() {
    return users.doc(user.uid).snapshots();
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
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: ConstColor.appBarBackground,
          statusBarBrightness: Brightness.light,
        ));
        return Scaffold(
            body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: SizeConfig.screenWidth,
              minHeight: SizeConfig.screenHeight,
            ),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  Positioned(
                    top: SizeConfig.screenHeight * 0.08,
                    child: Image.asset(
                      "assets/images/profile_background.png",
                      width: MediaQuery.of(context).size.width,
                      height: SizeConfig.screenHeight * 0.3,
                    ),
                  ),
                  Positioned(
                    top: SizeConfig.screenHeight * 0.08,
                    left: 143,
                    right: 143,
                    child: Center(
                        child: CircleAvatar(
                      backgroundColor: ConstColor.lightGreen,
                      backgroundImage: NetworkImage(dataProfile['photo'] != null
                          ? dataProfile['photo']
                          : 'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/profile%2Fpngfind.com-default-image-png-6764065.png?alt=media&token=b5ed67d2-cf3b-41b0-804a-e51f4fbd008f'),
                      maxRadius: 45,
                    )),
                  ),
                  SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      16,
                      50,
                      16,
                      50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.17,
                        ),
                        Text(
                            dataProfile['name'].toUpperCase() ??
                                'Belum Ada Data'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: ConstColor.whiteBackground)),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.008,
                        ),
                        Text(user.email!,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: ConstColor.whiteBackground)),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.008,
                        ),
                        Text(dataProfile['organization'] ?? 'Belum Ada Data',
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: ConstColor.darkGreen)),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.05,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('PENGATURAN',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: ConstColor.greyText)),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.004,
                        ),
                        _profileEntry('Informasi pribadi',
                            'assets/svg/logo_person_black.svg', 'infoPribadi'),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.004,
                        ),
                        _profileEntry('Password',
                            'assets/svg/logo_lock_black.svg', 'password'),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.004,
                        ),
                        _profileEntry('Edit Profil',
                            'assets/svg/logo_person_black.svg', 'editProfile'),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.05,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.004,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text('TENTANG',
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: ConstColor.greyText)),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.004,
                        ),
                        _profileEntry('Tentang kami', 'assets/svg/info.svg',
                            'tentangKami'),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.004,
                        ),
                        _profileEntry('Pusat Bantuan',
                            'assets/svg/question.svg', 'pusatBantuan'),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.004,
                        ),
                        _profileEntry(
                            'Keluar', 'assets/svg/sign_out.svg', 'signOut'),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
