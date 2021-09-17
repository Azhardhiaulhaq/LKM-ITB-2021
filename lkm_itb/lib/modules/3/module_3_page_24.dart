import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';

class Modul3Page24 extends StatefulWidget {
  Modul3Page24({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/24';

  @override
  _Modul3Page24State createState() => _Modul3Page24State(role);
}

class _Modul3Page24State extends State<Modul3Page24> {
  final String role;

  _Modul3Page24State(this.role);

  // ignore: non_constant_identifier_names
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
        'Simak penjelasan Mentormu ya!',
        style: GoogleFonts.roboto(
          fontSize: 20,
          color: ConstColor.blackText,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  _forMentor() {
    return Container(
      height: SizeConfig.screenHeight,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.screenHeight*0.2,),
          Text(
            'Berikan penjelasan mengenai gambar yang sebelumnya ditampilkan!',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Pribadi pantang menyerah (tangguh) dan berdaya juang tinggi adalah sebutan bagi pribadi yang tidak merasa lemah terhadap sesuatu yang terjadi dan menimpanya. Pribadi tangguh ini, tidak lain merupakan pribadi yang memiliki kemampuan untuk bersyukur apabila ia mendapat sesuatu yang berkaitan dengan kebahagiaan, kesuksesan, mendapat rezeki, dll. Sebaliknya, jika ia mendapati sesuatu yang tidak diharapkan, entah itu berupa kesedihan, kegagalan, mendapat bala bencana, dll., maka ia memiliki ketahanan untuk selalu bersabar.',
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: ConstColor.blackText,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: SizeConfig.screenHeight*0.2,)
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
                  ) ,
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      width: SizeConfig.screenWidth,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            role == 'mentor' ? _forMentor() :
                             _forMentee()
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/3/page/25')))
      ],
    ));
  }
}
