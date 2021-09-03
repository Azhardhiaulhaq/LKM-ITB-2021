import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/models/nilai_mentee.dart';
import 'package:lkm_itb/nilai/ui/nilai_mentee_screen.dart';

// ignore: must_be_immutable
class NilaiKelompokCard extends StatelessWidget {
  NilaiMentee penilaian;

  NilaiKelompokCard({Key? key, required this.penilaian}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return penilaian.ID == null
        ? Container(width: 5)
        : Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.pushNamed(context, NilaiMenteeScreen.routeName,
                    arguments: {'menteeID': penilaian.ID});
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(penilaian.name,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  color: ConstColor.blackText, fontSize: 16))),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Text(penilaian.totalNilai.toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        color: ConstColor.blackText,
                                        fontSize: 16))),
                            SizedBox(
                              width: 10,
                            ),
                            Card(
                                color: ConstColor.lightGreen,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text('LIHAT',
                                      style: GoogleFonts.roboto(
                                          color: ConstColor.whiteBackground,
                                          fontSize: 14)),
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
            ));
  }
}
