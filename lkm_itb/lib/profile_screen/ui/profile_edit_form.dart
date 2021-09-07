import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lkm_itb/constants/components/back_button.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/components/radio_tile.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/constants/data.dart';
import 'package:lkm_itb/constants/size_config.dart';
import 'package:lkm_itb/data/models/profile_data.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/profile_screen/bloc/profile_bloc.dart';
import 'package:lkm_itb/profile_screen/ui/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProfileEditForm extends StatefulWidget {
  ProfileEditForm({Key? key, required this.title, required this.user})
      : super(key: key);
  final User user;
  final String title;

  @override
  _ProfileEditFormState createState() => _ProfileEditFormState(this.user);
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController nimController = TextEditingController(text: "");
  ProfileData profile = ProfileData(email: '', userID: '', name: '');
  List<String> genderList = ['Laki-Laki', 'Perempuan'];
  String gender = 'Laki-Laki';
  String globalfaculty = 'FTI';
  String globalmajor = 'TK';
  String globalOrgType = 'HMJ';
  String globalOrg = 'TRITON ITB';
  bool isLoading = false;
  String dropdownValue = 'One';
  // File _imageFile = File('');
  final User user;
  final ImagePicker picker = ImagePicker();
  final GlobalKey<FormState> _profileFormKey = GlobalKey();
  late ProfileBloc _profileBloc;
  _ProfileEditFormState(this.user);
  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
  }

  _richText(String title) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: title,
            style: GoogleFonts.roboto(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: ConstColor.boldGreyText)),
        TextSpan(
            text: "*",
            style:
                GoogleFonts.roboto(fontSize: 16, color: ConstColor.redButton)),
      ]),
    );
  }

  _customTextField(String title, String entry, bool isName,
      TextEditingController controller, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: title,
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ConstColor.boldGreyText)),
            TextSpan(
                text: "*",
                style: GoogleFonts.roboto(
                    fontSize: 16, color: ConstColor.redButton)),
          ]),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        TextFormField(
          decoration: new InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: hintText,
          ),
          controller: controller,
          validator: (value) {
            if (value == null || value == '') {
              return 'Nilai tidak boleh kosong';
            }
            return null;
          },
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.03,
        ),
      ],
    );
  }

  getDropDownItems(String type) {
    if (type == 'faculty') {
      return AppData.mapFaculty.keys.map((String value) {
        return new DropdownMenuItem(
          value: value,
          child: Text(
            AppData.mapFaculty[value]! + ' (' + value + ')',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList();
    } else if (type == 'major') {
      return AppData.mapMajor[globalfaculty]!.keys.map((String value) {
        return new DropdownMenuItem(
          value: value,
          child: Text(
            AppData.mapMajor[globalfaculty]![value]! + ' (' + value + ')',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList();
    } else if (type == 'OrgType') {
      return AppData.mapOrgType.keys.map((String value) {
        return new DropdownMenuItem(
          value: value,
          child: Text(
            AppData.mapOrgType[value]!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList();
    } else if (type == 'Org') {
      return AppData.mapOrganization[globalOrgType]!.keys.map((String value) {
        return new DropdownMenuItem(
          value: value,
          child: Text(
            AppData.mapOrganization[globalOrgType]![value]! +
                ' (' +
                value +
                ')',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList();
    }
  }

  void _save() {
    final bool isValid = _profileFormKey.currentState!.validate();
    if (isValid) {
      profile.name = nameController.text;
      profile.gender = gender;
      profile.nim = nimController.text;
      profile.faculty = globalfaculty;
      profile.major = globalmajor;
      profile.organizationType = globalOrgType;
      profile.organization = globalOrg;
      _profileBloc.add(updateProfile(user: profile));
    }
  }

  Widget _saveButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: ConstColor.darkGreen),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.blueGrey,
            onTap: () async {
              _save();
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('SIMPAN',
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: ConstColor.whiteBackground,
                        fontWeight: FontWeight.w700))),
          )),
    );
  }

  _genderTile(List<String> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'Jenis Kelamin',
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ConstColor.boldGreyText)),
            TextSpan(
                text: "*",
                style: GoogleFonts.roboto(
                    fontSize: 16, color: ConstColor.redButton)),
          ]),
        ),
        for (String data in list)
          new LabeledRadio(
              label: data,
              padding: EdgeInsets.symmetric(horizontal: 5),
              groupValue: gender,
              value: data,
              onChanged: (String? value) {
                setState(() {
                  gender = value ?? '';
                });
              },
              activeColor: ConstColor.lightGreen),
        SizedBox(
          height: SizeConfig.screenHeight * 0.03,
        ),
      ],
    );
  }

  void setDropDownValue(String type, String value) {
    setState(() {
      if (type == 'faculty') {
        globalfaculty = value;
        globalmajor = AppData.mapMajor[globalfaculty]!.keys.elementAt(0);
      } else if (type == 'major') {
        globalmajor = value;
      } else if (type == 'OrgType') {
        globalOrgType = value;
        globalOrg = AppData.mapOrganization[globalOrgType]!.keys.elementAt(0);
      } else if (type == 'Org') {
        globalOrg = value;
      }
    });
  }

  Widget _dropDown(String title, String type, String globalfaculty) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: title,
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: ConstColor.boldGreyText)),
            TextSpan(
                text: "*",
                style: GoogleFonts.roboto(
                    fontSize: 16, color: ConstColor.redButton)),
          ]),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        Container(
          height: 50,
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  iconEnabledColor: ConstColor.lightGreen,
                  isExpanded: true,
                  value: globalfaculty,
                  isDense: true,
                  onChanged: (newValue) => setDropDownValue(type, newValue!),
                  items: getDropDownItems(type),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.03,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(listener: (context, state) {
      if (state is ProfileFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: 'Load Profile Gagal',
          titleColor: Colors.white,
          message: state.message,
          messageColor: Colors.white,
          duration: Duration(seconds: 2),
          backgroundColor: ConstColor.invalidEntry,
          flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,
          reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,
          leftBarIndicatorColor: Colors.blue[300],
        )..show(context);
      }
      if (state is ProfileLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is updateProfileSuccess) {
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pop();
      }
      if (state is ProfileSucceed) {
        setState(() {
          isLoading = false;
          profile = state.profile;
          nameController.text = profile.name;
          nimController.text = profile.nim ?? '';
          gender = profile.gender ?? 'Laki-Laki';
          globalfaculty = profile.faculty ?? 'FTI';
          globalmajor = profile.major ??
              AppData.mapMajor[globalfaculty]!.keys.elementAt(0);
          globalOrgType = profile.organizationType ?? 'HMJ';
          globalOrg = profile.organization ??
              AppData.mapOrganization[globalOrgType]!.keys.elementAt(0);
        });
      }
    }, child: BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
            body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Form(
                    key: _profileFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.1,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                                child: CircleAvatar(
                              backgroundColor: ConstColor.lightGreen,
                              backgroundImage: NetworkImage(
                                profile.photo != null
                                    ? profile.photo!
                                    : 'https://firebasestorage.googleapis.com/v0/b/lkmitb2021-eacb6.appspot.com/o/profile%2Fpngfind.com-default-image-png-6764065.png?alt=media&token=b5ed67d2-cf3b-41b0-804a-e51f4fbd008f',
                              ),
                              maxRadius: 45,
                            )),
                            Positioned(
                              bottom: 0,
                              left: 60,
                              right: 10,
                              child: MaterialButton(
                                onPressed: () async {
                                  final XFile? image = await picker
                                      .pickImage(source: ImageSource.gallery)
                                      .then((value) {
                                    _profileBloc.add(uploadImage(
                                        imageFile: File(
                                          value!.path,
                                        ),
                                        userID: profile.userID));
                                  });
                                },
                                color: ConstColor.darkGreen,
                                textColor: Colors.white,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                ),
                                padding: EdgeInsets.all(10),
                                shape: CircleBorder(),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: _richText('Upload Foto Profil'),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.08,
                        ),
                        _customTextField('Nama Lengkap', profile.name, true,
                            nameController, 'Masukkan Nama Lengkap'),
                        _genderTile(genderList),
                        _customTextField('NIM', profile.nim ?? '', true,
                            nimController, 'Masukkan NIM Mahasiswa'),
                        _dropDown('Fakultas', 'faculty', globalfaculty),
                        _dropDown('Program Studi', 'major', globalmajor),
                        _dropDown('Jenis Lembaga', 'OrgType', globalOrgType),
                        _dropDown('Nama Lembaga', 'Org', globalOrg),
                        _saveButton(context)
                      ],
                    ),
                  )),
              Positioned(
                  top: 40,
                  left: 0,
                  child: CustomBackButton(
                    title: 'Edit Profil',
                  )),
              LoadingProgress(isLoading: isLoading)
            ],
          ),
        ));
      },
    ));
  }
}
