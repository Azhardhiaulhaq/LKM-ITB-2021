import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Modul4Page14 extends StatefulWidget {
  Modul4Page14({Key? key, required this.role}) : super(key: key);

  final String role;
  static const routeName = '/module/4/page/14';

  @override
  _Modul4Page14State createState() => _Modul4Page14State(role);
}

class _Modul4Page14State extends State<Modul4Page14> {
  final String role;
  // ignore: non_constant_identifier_names
  String youtube_link = 'https://www.youtube.com/watch?v=sKpBJjsZ7EE';
  late YoutubePlayerController _youtubeController;

  _Modul4Page14State(this.role);

  // ignore: non_constant_identifier_names
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

  // ignore: non_constant_identifier_names
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
                    child: Text('Bagian 5',
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.2,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                role == 'mentor'
                                    ? 'Untuk memudahkan mengerti apa itu resiliensi, minta mentee menonton video berikut!'
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
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  'Sumber: The Learning Lab YouTube Channel',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: ConstColor.blackText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.justify,
                                )),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  role == 'mentor'
                                      ? 'Setelah menonton video, ajak Mentee untuk mendiskusikan terkait arti resiliensi. Tanyakan juga, pernah ga sih mereka melakukan hal terkait resilien ini?'
                                      : 'Bagaimana pendapatmu tentang hal tersebut? Yuk diskusi dengan Mentor dan kelompokmu!',
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: ConstColor.blackText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.justify,
                                )),
                            SizedBox(
                              height: SizeConfig.screenHeight * 0.2,
                            )
                          ])),
                ])))),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/4/page/15')))
      ],
    ));
  }
}
