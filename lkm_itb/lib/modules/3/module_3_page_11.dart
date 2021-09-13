import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Modul3Page11 extends StatefulWidget {
  Modul3Page11({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/3/page/11';

  @override
  _Modul3Page11State createState() => _Modul3Page11State(role);
}

class _Modul3Page11State extends State<Modul3Page11> {
  final String role;
  String youtube_link = 'https://www.youtube.com/watch?v=NDfew0YcDTo';
  late YoutubePlayerController _youtubeController;

  _Modul3Page11State(this.role);

  Widget _videoModule(String youtube_link) {
    String? videoID = YoutubePlayer.convertUrlToId(youtube_link) != null
        ? YoutubePlayer.convertUrlToId(youtube_link)
        : '';
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    return Material(
      color: Colors.transparent,
      child: InkWell(
          splashColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: YoutubePlayer(
              controller: _youtubeController,
              showVideoProgressIndicator: true,
              progressIndicatorColor: ConstColor.darkGreen,
              progressColors: ProgressBarColors(
                  playedColor: ConstColor.darkGreen,
                  handleColor: ConstColor.lightGreen),
            ),
          )),
    );
  }

  void pushFunction(String next_route) {
    _youtubeController.pause();
    Navigator.pushNamed(context, next_route);
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
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
                    child: Text('Bagian 3',
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
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.2,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                role == 'mentor'
                                    ? 'Minta mentee menonton video yang tersedia dan minta untuk mengemukakan pendapatnya!'
                                    : 'Yuk simak video berikut!',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: ConstColor.blackText,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            _videoModule(youtube_link),
                            SizedBox(height: 10,),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                               'Sumber : EducationDynamics Youtube Channel',
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  color: ConstColor.blackText,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.justify,
                              )),
                              SizedBox(height: 50,),
                            role == 'mentee' ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                               'Kemukakan pendapatmu, menurutmu pesan apa yang bisa dipetik dari video tersebut?',
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: ConstColor.blackText,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.justify,
                              )) : Container(),
                              SizedBox(height: SizeConfig.screenHeight*0.2,)
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/3/page/12')))
      ],
    ));
  }
}
