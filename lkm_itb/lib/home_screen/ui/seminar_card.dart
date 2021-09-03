import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/models/seminar.dart';
import 'package:lkm_itb/presence/presence_builder.dart';

// ignore: must_be_immutable
class SeminarCard extends StatelessWidget {
  Seminar seminar;
  bool isExpired = false;

  SeminarCard({Key? key, required this.seminar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (seminar.date!.millisecondsSinceEpoch <=
        DateTime.now().millisecondsSinceEpoch + 900000) {
      isExpired = true;
    } else {
      isExpired = false;
    }
    final df = new DateFormat.yMd();
    return seminar.seminarID == null
        ? Container(width: 5)
        : Wrap(
            children: [
              Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      if (!isExpired) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PresenceBuilder(
                              eventID: seminar.seminarID!,
                              type: 'seminar',
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        margin:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                color: isExpired
                                    ? Colors.grey
                                    : ConstColor.darkGreen,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        padding: EdgeInsets.all(5),
                                        alignment: Alignment.center,
                                        child: Text(
                                          seminar.numSeminar!,
                                          style: GoogleFonts.roboto(
                                              fontSize: 20,
                                              color: isExpired
                                                  ? ConstColor.blackText
                                                  : ConstColor.whiteBackground,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      height: 100,
                                      color: isExpired
                                          ? ConstColor.greyText
                                          : ConstColor.lightGreen,
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(seminar.name!,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  color: isExpired
                                                      ? ConstColor.blackText
                                                      : ConstColor.darkGreen,
                                                  fontWeight: FontWeight.w700)),
                                          Text(df.format(seminar.date!.toDate()),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  color: isExpired
                                                      ? ConstColor.blackText
                                                      : ConstColor.whiteBackground,
                                                  fontWeight: FontWeight.w700))
                                        ],
                                      ),
                                    ),
                                  ],
                                )))),
                  ))
            ],
          );
  }
}
