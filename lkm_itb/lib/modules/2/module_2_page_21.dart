import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul2Page21 extends StatefulWidget {
  Modul2Page21({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/21';

  @override
  _Modul2Page21State createState() => _Modul2Page21State(role);
}

class _Modul2Page21State extends State<Modul2Page21> {
  final String role;

  _Modul2Page21State(this.role);

  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    super.dispose();
  }

  _forMentee() {
    return Container(
      alignment: Alignment.center,
      height: SizeConfig.screenHeight,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        'Gambar yang menarik bukan pada section sebelumnya? \n\nPasti ada penjelasan menarik nih dibelakangnya.Yuk dengarkan dan perhatikan dengan saksama Mentormu perihal apa saja sih yang terkandung dalam foto itu! ',
        style: GoogleFonts.roboto(
          fontSize: 16,
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
          SizedBox(
            height: SizeConfig.screenHeight * 0.2,
          ),
          Text(
            'Mentor menjelaskan mengenai latar belakang foto tersebut. ',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Foto tersebut adalah Orasi Pelangi Keluarga Mahasiswa ITB pada pagelaran OSKM tahun 2018 yang bertempat di Sasana Budaya Ganesha. ',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Budaya organisasi merupakan kesepakatan (komitmen) bersama tentang nilai-nilai bersama dalam kehidupan organisasi dan mengikat semua orang dalam organisasi yang bersangkutan (Siagian,1995:126). Suatu sistem makna bersama yang dianut oleh anggota organisasi yang membedakan organisasi tsb dengan organisasi yang lain.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Konsekuensi budaya organisasi adalah sebagai berikut.\n\n - Melahirkan filosofis organisasi \n - Melahirkan identitas organisasi (AD/ART) \n - Melahirkan visi dan misi organisasi \n - Melahirkan struktur organisasi \n - Melahirkan rancangan kerja organisasi \n - Menentukan jenis teknologi yang dipakai \n - Sebagai pedoman normatif organisasi ',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'dan outputnya adalah membentuk KEBANGGAAN ORGANISASI (ORGANIZATIONAL PRIDE). Secara umum fungsi budaya organisasi adalah sebagai berikut.\n\n - Pembeda dengan organisasi lain\n - Identitas bagi anggota organisasi \n - Mengukuhkan komitmen bersama\n - Kemantapan sistem sosial sebagai perekat komponen organisasi \n - Mekanisme pembuat makna dan kendali organisasi\n - Mampu menetapkan aturan permainan (rule of the game)\n - Memberikan standar organisasi yang jelas',
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
                    child: Text('Bagian 5',
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
                          children: [
                            role == 'mentor' ? _forMentor() : _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/2/page/22')))
      ],
    ));
  }
}
