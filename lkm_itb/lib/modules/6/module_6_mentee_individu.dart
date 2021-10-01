import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/modules/6/module_6_mentee_individu_question.dart';

// ignore: must_be_immutable
class Modul6MenteeIndividu extends StatefulWidget {
  Modul6MenteeIndividu({Key? key, required this.role, required this.menteeID})
      : super(key: key);
  final String role;
  final String menteeID;

  @override
  _Modul6MenteeIndividuState createState() =>
      _Modul6MenteeIndividuState(role, menteeID);
}

class _Modul6MenteeIndividuState extends State<Modul6MenteeIndividu> {
  final String role;
  final String menteeID;
  final List<String> listDate = [
    '4-10 Oktober 2021',
    '11-17 Oktober 2021',
    '18-24 Oktober 2021',
    '25-31 Oktober 2021',
    '1-7 Oktober 2021',
    '8-14 Oktober 2021'
  ];
  _Modul6MenteeIndividuState(this.role, this.menteeID);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) async {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _weekCard(int week, String dateString) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Modul6MenteeQuestion(
              menteeID: menteeID,
              role: role,
              week: week,
              dateString: dateString,
            ),
          ),
        );
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: SizeConfig.screenWidth,
              color: ConstColor.lightGreen,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: ConstColor.darkGreen,
                    child: Text('Minggu ' + week.toString(),
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground,
                            fontWeight: FontWeight.normal,
                            fontSize: 16)),
                  ),
                  Flexible(
                      child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: ConstColor.lightGreen,
                    child: Text(dateString,
                        style: GoogleFonts.roboto(
                            color: ConstColor.whiteBackground,
                            fontWeight: FontWeight.normal,
                            fontSize: 16)),
                  )),
                ],
              ),
            ),
          )),
    );
  }

  _forMentor() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          Text(
            'Silahkan laporkan hasil observasi mingguan yang kamu lakukan',
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: ConstColor.greyText,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          for (var i = 0; i < listDate.length; i++)
            _weekCard(i + 1, listDate[i]),
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
                    child: Text('Individu',
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
                      child: _forMentor()),
                ])))),
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
