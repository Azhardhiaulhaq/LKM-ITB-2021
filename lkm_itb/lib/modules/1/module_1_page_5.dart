import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';

class Modul1Page5 extends StatefulWidget {
  Modul1Page5({Key? key, required this.title, required this.role}) : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page5State createState() => _Modul1Page5State(role);
}

class _Modul1Page5State extends State<Modul1Page5> {
  final String role;

  _Modul1Page5State(this.role);

  _Button(String next_route) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: ConstColor.blackText,
                        size: 30,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: ConstColor.greyText,
                      shape: StadiumBorder()),
                )),
            SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, next_route);
                  },
                  child: Row(
                    children: [
                      Text(
                        'Next',
                        style: GoogleFonts.roboto(
                            fontSize: 15, color: ConstColor.whiteBackground),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_outlined,
                        color: ConstColor.blackText,
                        size: 30,
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: ConstColor.lightGreen,
                      shape: StadiumBorder()),
                ))
          ],
        ));
  }

  _contentMentor() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Column(
        children: [
          Text(
            'Jelaskan arti kedua gambar tersebut!\n\n\nPerbedaan ini terjadi karena kita tidak melihatnya secara keseluruhan. Sehingga, kesimpulan yang diberikan kurang tepat atau tidak sesuai dengan apa yang sedang terjadi. Banyak hal yang tidak kita tahu dari kedua gambar tadi. Sebagai, mahasiswa yang nantinya akan jadi pemimpin, paling tidak untuk diri sendiri, haruslah mampu memberikan kesimpulan yang tidak merugikan bagi diri sendiri karena kurangnya informasi atau proses penarikan kesimpulan yang salah.',
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
            'Dengarkan\nMentor!',
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

        _contentMentor(),

      ],
    ));
  }

  _forMentee() {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _contentMentee(),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, alignment : Alignment.center,children: <Widget>[
        Positioned(top:40,child:        Text('Bagian 1',
            style: GoogleFonts.roboto(
              fontSize: 24,
              color: ConstColor.lightGreen,
              fontWeight: FontWeight.w700,
            )),),
        role == 'mentor' ? Center(child: _forMentor()) : Center(child: _forMentee()),
        Positioned(bottom: 70, child: _Button('/module/1/page/6'))
      ]),
    ));
    
  }
}
