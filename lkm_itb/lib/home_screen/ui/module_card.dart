import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/models/module.dart';
import 'package:lkm_itb/presence/presence_builder.dart';

// ignore: must_be_immutable
class ModuleCard extends StatelessWidget {
  Module module;
  String role;

  ModuleCard({Key? key, required this.module, required this.role})
      : super(key: key);

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
                if (role == 'mentor') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PresenceBuilder(
                        eventID: module.modulID!,
                        type: 'module',
                      ),
                    ),
                  );
                } else {
                  Navigator.pushNamed(
                      context, '/module/' + module.modulID! + '/page/1');
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          color: ConstColor.lightGreen,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: module.banner!,
                                fit: BoxFit.fill,
                                width: SizeConfig.screenWidth,
                                placeholder: (context, url) => Center(
                                  child: LinearProgressIndicator(
                                    backgroundColor: ConstColor.boldGreyText,
                                    color: ConstColor.darkGreen,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 13),
                                child: Text(
                                    'Module ' +
                                        module.modulID! +
                                        ' - ' +
                                        module.name!,
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: ConstColor.whiteBackground,
                                        fontWeight: FontWeight.w700)),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 13),
                                child: Text(module.naration!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                    style: GoogleFonts.roboto(
                                        fontSize: 13,
                                        color: ConstColor.darkGreen,
                                        fontWeight: FontWeight.w400)),
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )))),
            ));
  }
}

// Wrap(
//                       direction: Axis.vertical,
//                       children: [
//                         Container(
//                             width: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     fit: BoxFit.fill,
//                                     image: NetworkImage(module.banner != ''
//                                         ? module.banner!
//                                         : 'https://www.searchpng.com/wp-content/uploads/2019/02/Deafult-Profile-Pitcher.png')))),
//                         SizedBox(width: 5),
//                         Container(
//                             width: MediaQuery.of(context).size.width * 0.55,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(module.name!,
//                                     overflow: TextOverflow.fade,
//                                     style: GoogleFonts.lato(
//                                         color: ConstColor.whiteBackground,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16)),
//                               ],
//                             ))
//                       ],
//                     ),