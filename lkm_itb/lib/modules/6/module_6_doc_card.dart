import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flowder/flowder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class DocCard extends StatefulWidget {
  DocCard({Key? key, required this.fileName, required this.url}) : super(key: key);
  final String fileName;
  final String url;

  @override
  _DocCardState createState() => _DocCardState(fileName: fileName,url: url);
}

// ignore: must_be_immutable
class _DocCardState extends State<DocCard> {
  String fileName;
  String url;
    late DownloaderUtils options;
  late DownloaderCore core;
  late final String path;
  bool isLoading = false;
  double percent = 0.0;
  _DocCardState({Key? key, required this.fileName, required this.url});

  downloadFile(var link, String name) async {
    setState(() {
      percent = 0.0;
      isLoading = true;
    });
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    options = DownloaderUtils(
      progressCallback: (current, total) {
        final progress = (current / total) * 100;

        setState(() {
          percent = progress;
        });
      },
      file: File('$path/$name.docx'),
      progress: ProgressImplementation(),
      onDone: () {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isLoading = false;
          });
        });

        new Flushbar(
          title: 'Download Selesai',
          titleColor: Colors.white,
          message:
              'Proses Download Selesai. File terdapat pada folder Download dengan nama $name',
          messageColor: Colors.white,
          duration: Duration(seconds: 3),
          backgroundColor: ConstColor.lightGreen,
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      },
      deleteOnCancel: true,
    );
    core = await Flowder.download(link, options);
  }
  
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    String type = fileName.split('.').last;
    return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            downloadFile(
                        url, fileName);
          },
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      color: ConstColor.lightGrey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            type == 'pdf'
                                ? 'assets/images/icon_pdf.png'
                                : 'assets/images/icon_docx.png',
                            fit: BoxFit.fitHeight,
                          ),
                          Flexible(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                fileName,
                                style: GoogleFonts.roboto(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )))),
        ));
        
  }
}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
