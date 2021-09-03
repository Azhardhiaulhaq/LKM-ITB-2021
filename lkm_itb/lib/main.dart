import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lkm_itb/Authentication/bloc/auth_bloc.dart';
import 'package:lkm_itb/bottom_navigation/bottom_navigation.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/login_screen/ui/login_screen.dart';
import 'package:lkm_itb/splash_screen/ui/splash_screen.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await sharedPrefs.init();
  runApp(Phoenix(child: MaterialApp(
    title: 'LKM ITB 2021',
    debugShowCheckedModeBanner: false,
    theme:
        ThemeData(appBarTheme: AppBarTheme(color: ConstColor.appBarBackground)),
    initialRoute: '/splash',
    routes: {
      '/': (context) => MyApp(),
      '/splash': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/bottomnav/detaillkm' : (context) => LoginScreen()
    },
  ),));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => AuthBloc()..add(AppLoaded()),
        child: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(listener: (context, state) {
      if (state is UnAuthenticateState) {
        Navigator.pushNamed(context, '/login');
      } else if (state is AuthenticateState) {
        pushNewScreen(context, screen: BottomNavigation(menuScreenContext: context,user: state.user,),);
      }
    }, child: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container();
      },
    ));
  }
}
