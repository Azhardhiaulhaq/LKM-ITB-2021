import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page11 extends StatefulWidget {
  Modul1Page11({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page11State createState() => _Modul1Page11State(role);
}

class _Modul1Page11State extends State<Modul1Page11> {
  final String role;

  _Modul1Page11State(this.role);

  void pushFunction(String next_route) {
    Navigator.pushNamed(context, next_route);
  }

  _contentMentor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Berilah penjelasan mengenai video tersebut!',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Dari video tersebut, dapat diketahui bahwa perbedaan pendapat bisa saling membuat konflik. Tono mengajarkan bahwa setiap pendapat bisa sama sama benar dan mengerucut ke sebuah kesimpulan yang harusnya dapat dipahami oleh setiap orang. Perilaku Tono adalah cerminan dari orang yang berpikir dialogis. Dialog yang terjadi dalam kehidupan sehari-hari kadang hanya menunjukkan keunggulan masing masing pendapat saja, tanpa mencari makna sebenarnya dari semua pendapat yang diutarakan. Sebagai calon pemimpin, haruslah kita mau berdialog dan tidak menutup hati serta pikiran kita bersama.',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Pemikir kritis harus mampu terlibat dalam dialog eksplorasi yang bermanfaat, mengusulkan ide, menggali akarnya, mempertimbangkan wawasan dan bukti materi pelajaran, menguji ide dan bergerak di antara berbagai sudut pandang.',
            textAlign: TextAlign.justify,
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.blackText),
          ),
        ],
      ),
    );
  }

  _contentMentee() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Dengarkan\nMentor ya!',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.roboto(fontSize: 34, color: ConstColor.blackText),
          ),
        ],
      ),
    );
  }

  _forMentor() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 80,
        ),
        _contentMentor(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        )
      ],
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _contentMentee(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 40,
              child: Text('Bagian 2',
                  style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: ConstColor.lightGreen,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            role == 'mentor' ? _forMentor() : Center(child: _forMentee()),
            Positioned(
                bottom: 70,
                child: CustomModuleButton(
                    pushFunction: () => pushFunction('/module/1/page/12')))
          ]),
    ));
  }
}
