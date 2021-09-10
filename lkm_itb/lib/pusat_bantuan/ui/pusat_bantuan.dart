import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/back_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class PusatBantuan extends StatefulWidget {
  PusatBantuan({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _PusatBantuanState createState() => _PusatBantuanState();
}

class _PusatBantuanState extends State<PusatBantuan> {


  Future<void> share(String phone, String message) async {
    var phoneNumber = '+' + phone;
    // ignore: non_constant_identifier_names
    var whatsappURl_android = "whatsapp://send?phone="+phoneNumber+"&text="+message;
    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));

    }
  }


  @override
  void initState() {
    super.initState();
  }

  Widget _contactButton(
      BuildContext context, String contactName, String phone) {
    return Container(
      margin: EdgeInsets.fromLTRB(80, 0, 80, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: ConstColor.darkGreen),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              share(phone,
                  'Halo kak $contactName.\nSaya mengalami beberapa kendala dalam penggunaan applikasi LKM ITB. Mohon Bantuannya.');
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(contactName,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: ConstColor.whiteBackground,
                        fontWeight: FontWeight.w400))),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(top: 40, left: 0, child: new CustomBackButton(title:'Pusat Bantuan')),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(60, 0, 60, 60),
                  child: Text(
                    'Informasi lebih lanjut dapat menghubungi panitia pelaksana melalui WhatsApp chat',
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: ConstColor.blackText,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  )),
              _contactButton(
                  context, 'Moh. Afri Kusma Septian F', '6285956648152'),
              _contactButton(context, 'Nike Lusiyani', '6285731357314')
            ],
          )
        ],
      ),
    ));
  }
}


