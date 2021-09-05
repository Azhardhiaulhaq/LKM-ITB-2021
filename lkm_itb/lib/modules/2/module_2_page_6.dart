import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul2Page6 extends StatefulWidget {
  Modul2Page6({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/2/page/6';

  @override
  _Modul2Page6State createState() => _Modul2Page6State(role);
}

class _Modul2Page6State extends State<Modul2Page6> {
  final String role;

  _Modul2Page6State(this.role);

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
        'Yuk perhatikan Mentormu dengan saksama dan antusias yang luar biasa!',
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
            'Rangkum dan beri tanggapan apresiatif terhadap antusias mentee kemudian jelaskan bagian tersirat dari gambar tersebut dengan gaya Mentor masing-masing dengan narasi informasi berikut ini.',
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
            'Gambar tersebut mengilustrasikan sebuah bentuk semangat inklusifitas dan fleksibilitas dalam merespon keberagaman dan kedinamisan ruang interaksi manusia atau masyarakat terlebih dalam konteks kehidupan bermasyarakat. ',
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
            'Inklusif dalam konteks ini adalah selalu melibatkan semua orang lain baik dalam bekerja, prioritas, atensi, dll tanpa membeda-bedakan dengan yang lain atau mengklasifikasikan kelompok-kelompok tertentu dengan ciri khas yang berlebihan atau cenderung arogan. Semangat inklusifitas disini juga bermaksud untuk menjaga semangat bekerja sama meskipun memiliki latar belakang yang beragam atau berbeda beda. ',
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
            'Sedangkan untuk fleksibel adalah luwes atau mudah menyesuaikan diri dengan keadaan atau lingkungan yang heterogen dan dinamis. Semangat fleksibilitas ini akan melunturkan ego terhadap mementingkan diri sendiri dan kelompok tertentu karena untuk menjadi fleksibel dituntut untuk mendengarkan atau melihat terlebih dahulu sistem secara holistik lalu coba memetakan atau menyesuaikan diri dengan lingkungan tersebut secara praktis atau cepat dan tepat.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
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
                    child: Text('Bagian 1',
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
                pushFunction: () => pushFunction('/module/2/page/7')))
      ],
    ));
  }
}
