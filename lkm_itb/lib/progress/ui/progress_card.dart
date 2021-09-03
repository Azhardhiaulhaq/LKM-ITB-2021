import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/models/module.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/penilaian_modul/ui/penilaian_modul_screen.dart';

// ignore: must_be_immutable
class ProgressCard extends StatelessWidget {
  Module module;

  ProgressCard({Key? key, required this.module}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return module.modulID == null
        ? Container(width: 5)
        : Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                if (sharedPrefs.role == 'mentor') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PenilaianModulScreen(
                                module: module,
                              )));
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: ConstColor.lightGreen,
                          child: Wrap(
                            direction: Axis.vertical,
                            children: [
                              Image.network(
                                  module.banner! != ''
                                      ? module.banner!
                                      : 'https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png',
                                  fit: BoxFit.fill,
                                  height: 100,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4),
                              SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Text(
                                        'Module ' +
                                            module.modulID! +
                                            ' - ' +
                                            module.name!,
                                        textAlign: TextAlign.start,
                                        maxLines: 2,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            color: ConstColor.whiteBackground,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(module.naration!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.justify,
                                        style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            color: ConstColor.darkGreen,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                ],
                              ),
                            ],
                          )))),
            ));
  }
}
