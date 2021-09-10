import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/module_button.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Modul1Page9 extends StatefulWidget {
  Modul1Page9({Key? key, required this.title, required this.role})
      : super(key: key);

  final String title;
  final String role;

  @override
  _Modul1Page9State createState() => _Modul1Page9State(role);
}

class _Modul1Page9State extends State<Modul1Page9> {
  final String role;
  // ignore: non_constant_identifier_names
  String youtube_link = 'https://www.youtube.com/watch?v=5W4ihu1yiY8';
  late YoutubePlayerController _youtubeController;

  _Modul1Page9State(this.role);
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
    return Scaffold(
        body: SafeArea(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text('Bagian 2',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      color: ConstColor.lightGreen,
                      fontWeight: FontWeight.w700,
                    )),
                SizedBox(
                  height: 40,
                ),
                Text(
                    role == 'mentor'
                        ? 'Minta mentee menyimak video yang tersedia!'
                        : 'Tonton dan simaklah video berikut!',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: ConstColor.blackText,
                      fontWeight: FontWeight.w400,
                    )),
                SizedBox(
                  height: 40,
                ),
                _videoModule(youtube_link),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Sumber: Santoon TV Youtube Channel',
                  style: GoogleFonts.roboto(
                      color: ConstColor.blackText,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
        Positioned(
            bottom: 70,
            child: new CustomModuleButton(
                pushFunction: () => pushFunction('/module/1/page/10')))
      ]),
    ));
  }
}
