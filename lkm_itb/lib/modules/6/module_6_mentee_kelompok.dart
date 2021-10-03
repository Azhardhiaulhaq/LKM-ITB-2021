import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:flowder/flowder.dart';
import 'package:lkm_itb/data/repositories/module_repositories.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

// ignore: must_be_immutable
class Modul6Menteekelompok extends StatefulWidget {
  Modul6Menteekelompok({Key? key, required this.role}) : super(key: key);
  final String role;

  @override
  _Modul6MenteekelompokState createState() => _Modul6MenteekelompokState(role);
}

class _Modul6MenteekelompokState extends State<Modul6Menteekelompok> {
  final String role;
  CollectionReference answers =
      FirebaseFirestore.instance.collection('answers');
  final List<String> listDoc = [
    'Proposal',
    'Laporan Akhir',
  ];
  final List<String> templateLink = [
    'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/template%2FFormat%20Proposal%20LKM%20VIII%20ITB.docx?alt=media&token=72297eea-2e1f-4ff1-bfe7-00fb5a07d204',
    'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/template%2FFormat%20Laporan%20Akhir%20Proyek%20LKM%20VIII%20ITB.docx?alt=media&token=1ccd9244-9fb9-457e-9aca-f650f0e6d713'
  ];
  late DownloaderUtils options;
  late DownloaderCore core;
  late final String path;
  bool isLoading = false;
  bool isUploading = false;
  double percent = 0.0;
  _Modul6MenteekelompokState(this.role);

  // ignore: non_constant_identifier_names
  void pushFunction(String next_route) async {
    Navigator.pushNamed(context, next_route);
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    _setPath();
    if (!mounted) return;
  }

  void _setPath() async {
    path = (await DownloadsPathProvider.downloadsDirectory)!.path;
  }

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
      file: File('$path/$name'),
      progress: ProgressImplementation(),
      onDone: () {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isLoading = false;
          });
        });
        OpenFile.open('$path/$name');
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

  Widget _docCard(int index, String docString) {
    String type = '';
    docString == 'Proposal' ? type = 'proposal' : type = 'laporan';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf', 'docx', 'doc'],
            );

            if (result != null) {
              File file = File(result.files.single.path!);
              setState(() {
                isUploading = true;
              });
              await ModuleRepository.uploadFile(
                      sharedPrefs.group, type, file, file.path.split('/').last)
                  .then((value) {
                setState(() {
                  isUploading = false;
                });
              }).catchError((onError) {
                new Flushbar(
                  title: 'Upload Error',
                  titleColor: Colors.white,
                  message: onError.toString(),
                  messageColor: Colors.white,
                  duration: Duration(seconds: 3),
                  backgroundColor: ConstColor.redButton,
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.FLOATING,
                  reverseAnimationCurve: Curves.decelerate,
                  forwardAnimationCurve: Curves.elasticOut,
                  leftBarIndicatorColor: Colors.blue[300],
                )..show(context);
              });
            } else {
              // User canceled the picker
            }
          },
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: SizeConfig.screenWidth,
                  color: ConstColor.lightGreen,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: ConstColor.darkGreen,
                          child: Text(docString,
                              style: GoogleFonts.roboto(
                                  color: ConstColor.whiteBackground,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        color: ConstColor.lightGreen,
                        child: Text('Unggah',
                            style: GoogleFonts.roboto(
                                color: ConstColor.whiteBackground,
                                fontWeight: FontWeight.normal,
                                fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              )),
        ),
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'Untuk format ' + docString + ' bisa diunduh ',
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: ConstColor.boldGreyText)),
            TextSpan(
                text: "di sini",
                style: GoogleFonts.roboto(
                    fontSize: 12, color: ConstColor.blueLink),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    downloadFile(
                        templateLink[index], 'Template $docString LKM.docx');
                  }),
          ]),
        ),
        SizedBox(
          height: 8,
        ),
        _kumpulanLaporan(type)
      ],
    );
  }

  Stream<QuerySnapshot> docStream(String type) {
    return answers
        .doc('6')
        .collection('groups')
        .doc(sharedPrefs.group)
        .collection(type)
        .snapshots();
  }

  Widget _kumpulanLaporan(String type) {
    return StreamBuilder<QuerySnapshot>(
      stream: docStream(type),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: ConstColor.darkGreen,
          ));
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Data'),
          );
        }
        if (snapshot.data!.size == 0) {
          return Center(
              child: Text(
            'Belum Ada Data $type',
            style:
                GoogleFonts.roboto(fontSize: 14, color: ConstColor.blackText),
          ));
        }
        QueryDocumentSnapshot Doc = snapshot.data!.docs.first;
        return fileCard(Doc.get('url'), Doc.get('name'));
      },
    );
  }

  Widget fileCard(String url, String fileName) {
    String type = fileName.split('.').last;
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  SizedBox(
                    width: 5,
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
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  File('$path/$fileName').existsSync()
                      ? InkWell(
                          splashColor: Colors.transparent,
                          onTap: () {
                            OpenFile.open('$path/$fileName');
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 5),
                            child: Icon(Icons.remove_red_eye_outlined,
                                color: ConstColor.darkGreen),
                          ))
                      : Container(),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        downloadFile(url, fileName);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                        child:
                            Icon(Icons.download, color: ConstColor.darkGreen),
                      ))
                ],
              )),
        ));
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
              color: ConstColor.blackText,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          for (var i = 0; i < listDoc.length; i++) _docCard(i, listDoc[i]),
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
                    child: Text('Kelompok',
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
        isLoading
            ? Container(
                color: ConstColor.whiteBackground,
                padding: EdgeInsets.all(10),
                child: CircularPercentIndicator(
                  radius: 120.0,
                  lineWidth: 10.0,
                  animation: true,
                  percent: percent / 100,
                  center: Text(
                    percent.toStringAsFixed(2) + "%",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  backgroundColor: Colors.grey[300]!,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: ConstColor.lightGreen,
                ))
            : Container(),
        new LoadingProgress(isLoading: isUploading),
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
