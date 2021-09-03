
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';


class DetailLKM extends StatefulWidget {
  DetailLKM({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DetailLKMState createState() => _DetailLKMState();
}

class _DetailLKMState extends State<DetailLKM> {
  String pharagraph1 =
      'Mahasiswa sebagai agen pembaharu menjadi objek penting dalam peningkatan kualitas bangsa dan negara. Mahasiswa ITB dengan kapasitas intelektualnya merupakan pemimpin harapan di masa depan yang dapat mengharumkan nama bangsa dan memajukan negeri. Namun, kemampuan intelektual diatas rata-rata belum cukup untuk dapat menjadi pemimpin yang berpengaruh. Hal tersebut perlu dibarengi dengan attitude dan wawasan kepemimpinan.';
  
  String pharagraph2 = 'Kepemimpinan atau leadership adalah suatu kemampuan seseorang untuk dapat mempengaruhi tim maupun organisasi untuk mencapai suatu tujuan tertentu. Wawasan kepemimpinan menjadi penting bagi mahasiswa sebagai bekal pengetahuan, keterampilan dan sikap dalam manajemen diri sendiri, lingkungan sosial dan organisasi mahasiswa baik internal maupun antar perguruan tinggi.';
  String pharagraph3 = 'Direktorat Kemahasiswaan sebagai bagian dari ITB memiliki peran penting dalam mengelola hal-hal yang berkaitan dengan mahasiswa dan karakternya. Sadar akan amanah tersebut, Ditmawa terus menjalankan program pengembangan rutin yakni Latihan Kepemimpinan Mahasiswa (LKM) sebagai wadah bagi mahasiswa untuk membangun karakter pemimpin.';
  String pharagraph4 = 'Tahun ini merupakan pelaksanaan LKM VIII dengan mengusung tema “Creating Positive Leaders” yang akan diikuti oleh kurang lebih 220 peserta dan dilaksanakan secara daring pada September hingga November 2021.';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ConstColor.appBarBackground,
      statusBarBrightness: Brightness.light,
    ));
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
              Positioned(
                top: 80,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/logo_lkm_itb.png",
                      height: 36.69 * 1.2,
                      width: 85.61 * 1.2,
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "Latihan Kepemimpinan \nMahasiswa VIII \nITB 2021",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: ConstColor.blackText,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                child: Image.asset(
                  "assets/images/login_background.png",
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.2,
                left: 40,
                child: Image.asset(
                  "assets/images/ganesha_man.png",
                  height: 212 * 1.2,
                  width: 150 * 1.2,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.23,
                right: 15,
                child: Image.asset(
                  "assets/images/ganesha_woman.png",
                  height: 233 * 1.2,
                  width: 165 * 1.2,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.48,
                left: 80,
                child: SvgPicture.asset('assets/svg/Ellipse.svg'),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.54,
                right: 80,
                child: SvgPicture.asset('assets/svg/Ellipse.svg'),
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 500),
                      Container(
                          padding: EdgeInsets.fromLTRB(28, 20, 28, 50),
                          color: ConstColor.lightGreen,
                          width: MediaQuery.of(context).size.width,
                          height: 550,
                          child: Column(
                            children: [
                              Text('Mengenal LKM ITB',
                                  style: GoogleFonts.roboto(
                                      fontSize: 18,
                                      color: ConstColor.whiteBackground,
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                height: 20,
                              ),
                              Text(pharagraph1,
                              textAlign: TextAlign.justify,
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: ConstColor.whiteBackground,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(pharagraph2,
                              textAlign: TextAlign.justify,
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: ConstColor.whiteBackground,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(pharagraph3,
                              textAlign: TextAlign.justify,
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: ConstColor.whiteBackground,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                height: 10,
                              ),
                              Text(pharagraph4,
                              textAlign: TextAlign.justify,
                                  style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      color: ConstColor.whiteBackground,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
