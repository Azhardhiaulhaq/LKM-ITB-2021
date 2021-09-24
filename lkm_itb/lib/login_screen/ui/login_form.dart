import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/bottom_navigation/bottom_navigation.dart';
import 'package:lkm_itb/constants/components/loading_progress.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:email_validator/email_validator.dart';
import 'package:lkm_itb/login_screen/bloc/login_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  final GlobalKey<FormState> _loginFormKey = GlobalKey();
  late LoginBloc _loginBloc;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  void _login() {
    final bool isValid = _loginFormKey.currentState!.validate();
    if (isValid) {
      _loginBloc.add(SignInButtonPressed(
          email: emailController.text, password: passwordController.text));
    }
  }

  Widget _forgotPasswordLabel() {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => SignupScreen()));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(15),
          alignment: Alignment.bottomCenter,
          child: Text('Forgot Password?',
              style: GoogleFonts.roboto(
                  fontSize: 12, fontWeight: FontWeight.w300)),
        ));
  }

  Widget _loginButton(BuildContext context) {
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
              _login();
            },
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('LOGIN',
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        color: ConstColor.whiteBackground,
                        fontWeight: FontWeight.w700))),
          )),
    );
  }

  Widget _emailEntryField(String hintText, TextEditingController controller,
      {bool isPassword = false, Widget? entryIcon}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          TextFormField(
              controller: controller,
              obscureText: isPassword,
              validator: (value) {
                if (value == null) {
                  return 'Please type your email address';
                } else if (!EmailValidator.validate(value)) {
                  return 'Invalid email address';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ConstColor.darkGreen, width: 50),
                    borderRadius: BorderRadius.circular(20)),
                prefixIcon: entryIcon,
                fillColor: ConstColor.whiteBackground,
                filled: true,
                hintText: hintText,
              )),
        ],
      ),
    );
  }

  Widget _passwordEntryField(String hintText, TextEditingController controller,
      {bool isPassword = false, Widget? entryIcon}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          TextFormField(
              controller: controller,
              obscureText: isPassword,
              validator: (value) {
                if (value == null) {
                  return 'Please type your password';
                } else if (value.length < 8) {
                  return 'Password at least contain 8 characters';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ConstColor.darkGreen, width: 50),
                    borderRadius: BorderRadius.circular(20)),
                prefixIcon: entryIcon,
                fillColor: ConstColor.whiteBackground,
                filled: true,
                hintText: hintText,
              )),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          _emailEntryField("email", emailController,
              entryIcon: Image.asset(
                "assets/images/logo_person.png",
                width: 24,
                height: 24,
              )),
          _passwordEntryField("password", passwordController,
              isPassword: true,
              entryIcon: Image.asset(
                "assets/images/logo_lock.png",
                width: 24,
                height: 24,
              )),
          _loginButton(context),
          _forgotPasswordLabel(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ConstColor.appBarBackground,
      statusBarBrightness: Brightness.light,
    ));
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state is LoginFailed) {
        setState(() {
          isLoading = false;
        });
        Flushbar(
          title: 'Login Gagal',
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
      if (state is LoginLoading) {
        setState(() {
          isLoading = true;
        });
      }
      if (state is LoginSucceed) {
        setState(() {
          isLoading = false;
        });
        pushNewScreen(
                      context,
                      screen: BottomNavigation(menuScreenContext: context,user:state.user),
                      withNavBar: true, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
            body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 80,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/logo_lkm_itb.png",
                          height: 36.69 * 1.2,
                          width: 85.61 * 1.2,
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Text(
                          "Latihan Kepemimpinan Mahasiswa\nVIII ITB 2021",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: ConstColor.blackText,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      color: ConstColor.lightGreen,
                    ),
                  ),
                  Positioned(
                    top: 44,
                    bottom: 131,
                    child: Image.asset("assets/images/login_background.png",
                        fit: BoxFit.fitWidth),
                  ),
                  Positioned(
                    top: 250,
                    left: 25,
                    child: Image.asset(
                      "assets/images/ganesha_man.png",
                      height: 232 * 1.2,
                      width: 164 * 1.2,
                    ),
                  ),
                  Positioned(
                    top: 225,
                    right: 15,
                    child: Image.asset(
                      "assets/images/ganesha_woman.png",
                      height: 209 * 1.2,
                      width: 148 * 1.2,
                    ),
                  ),
                  Positioned(
                    top: 510,
                    left: 80,
                    child: SvgPicture.asset('assets/svg/Ellipse.svg'),
                  ),
                  Positioned(
                    top: 460,
                    right: 80,
                    child: SvgPicture.asset('assets/svg/Ellipse2.svg'),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .5),
                          // _title(),
                          SizedBox(height: 100),
                          _loginForm()
                        ],
                      ),
                    ),
                  ),
                  new LoadingProgress(isLoading: isLoading),
                ],
              ),
            ),
          ),
        ));
      },
    ));
  }
}
