import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul2Page25 extends StatefulWidget {
  Modul2Page25({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/25';

  @override
  _Modul2Page25State createState() => _Modul2Page25State(role);
}

class _Modul2Page25State extends State<Modul2Page25> {
  final String role;

  _Modul2Page25State(this.role);

  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _forMentee() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Yuk dengarkan dan perhatikan Mentormu dengan saksama!',
        style: GoogleFonts.roboto(
          fontSize: 22,
          color: ConstColor.blackText,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Text(
            'Mentor mengulas sedikit tentang pentingnya membentuk semangat berkolaborasi. ',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Sebagaimana kolaborasi itu adalah sebuah kerja sama dimana sekelompok orang berkumpul dan menyumbangkan keahlian mereka untuk kepentingan tujuan, proyek, atau misi bersama, maka menumbuhkan semangat kolaborasi itu sangat penting baik dalam konteks terdekatnya adalah kalian sebagai sesame kelompok mentoring LKM maupun nanti ketika kalian mengimplementasikan semangat kolaborasi ini di organisasi masing-masing. Kolaborasi yang baik dalam suatu organisasi akan meningkatkan prosentase keberhasilan suatu organisasi untuk mencapai tujuannya terlebih sebagai entitas yang harmonis dan memiliki kecerdasan sosial yang tinggi.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                    child: Stack(alignment: Alignment.center, children: [
                  Positioned(
                    top: SizeConfig.screenHeight * 0.1,
                    child: Text('Bagian 6',
                        style: GoogleFonts.roboto(
                          fontSize: 24,
                          color: ConstColor.lightGreen,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      alignment: Alignment.center,
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            role == 'mentor' ? _forMentor() : _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: CustomModuleButton(
                pushFunction: () => pushFunction('/module/2/page/26')))
      ],
    ));
  }
}
