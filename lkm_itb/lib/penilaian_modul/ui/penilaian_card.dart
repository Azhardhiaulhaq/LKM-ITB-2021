import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/models/penilaian_modul.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/modules/penilaian/penilaian_first.dart';

// ignore: must_be_immutable
class PenilaianCard extends StatelessWidget {
  PenilaianModul penilaian;
  String moduleID;

  PenilaianCard({Key? key, required this.penilaian, required this.moduleID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return penilaian.userID == null
        ? Container(width: 5)
        : Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                // Navigator.pushNamed(context,'/home', arguments: );
                Navigator.pushNamed(context,PenilaianFirst.routeName,arguments: {'userID' : sharedPrefs.userid, 'menteeID' : penilaian.userID, 'moduleID' : moduleID});
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: Text(penilaian.nilai.toString(),
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        color: ConstColor.blackText,
                                        fontSize: 16))),
                            SizedBox(width: 10,),

                            Card(
                                color: penilaian.isComplete
                                    ? ConstColor.greenButton
                                    : ConstColor.redButton,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                elevation: 2,
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  
                                  child: Text(
                                      penilaian.isComplete ? 'SUDAH' : 'BELUM',
                                      style: GoogleFonts.roboto(
                                          color: ConstColor.whiteBackground,
                                          fontSize: 12)),
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
            ));
  }
}

