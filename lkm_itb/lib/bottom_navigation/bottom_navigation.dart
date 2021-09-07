import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/detail_lkm/ui/detail_lkm.dart';
import 'package:lkm_itb/home_screen/ui/home_screen.dart';
import 'package:lkm_itb/list_lkm/ui/list_lkm.dart';
import 'package:lkm_itb/modules/1/module_1_page_1.dart';
import 'package:lkm_itb/modules/1/module_1_page_10.dart';
import 'package:lkm_itb/modules/1/module_1_page_2.dart';
import 'package:lkm_itb/modules/1/module_1_page_20.dart';
import 'package:lkm_itb/modules/1/module_1_page_3.dart';
import 'package:lkm_itb/modules/1/module_1_page_4.dart';
import 'package:lkm_itb/modules/1/module_1_page_5.dart';
import 'package:lkm_itb/modules/1/module_1_page_6.dart';
import 'package:lkm_itb/modules/1/module_1_page_7.dart';
import 'package:lkm_itb/modules/1/module_1_page_8.dart';
import 'package:lkm_itb/modules/1/module_1_page_9.dart';
import 'package:lkm_itb/modules/1/module_1_page_11.dart';
import 'package:lkm_itb/modules/1/module_1_page_12.dart';
import 'package:lkm_itb/modules/1/module_1_page_13.dart';
import 'package:lkm_itb/modules/1/module_1_page_14.dart';
import 'package:lkm_itb/modules/1/module_1_page_15.dart';
import 'package:lkm_itb/modules/1/module_1_page_16.dart';
import 'package:lkm_itb/modules/1/module_1_page_17.dart';
import 'package:lkm_itb/modules/1/module_1_page_18.dart';
import 'package:lkm_itb/modules/1/module_1_page_19.dart';
import 'package:lkm_itb/modules/1/module_1_page_21.dart';
import 'package:lkm_itb/modules/1/module_1_page_22.dart';
import 'package:lkm_itb/modules/1/module_1_page_23.dart';
import 'package:lkm_itb/modules/1/module_1_page_24.dart';
import 'package:lkm_itb/modules/1/module_1_page_25.dart';
import 'package:lkm_itb/modules/1/module_1_page_26.dart';
import 'package:lkm_itb/modules/2/module_2_page_1.dart';
import 'package:lkm_itb/modules/2/module_2_page_10.dart';
import 'package:lkm_itb/modules/2/module_2_page_11.dart';
import 'package:lkm_itb/modules/2/module_2_page_12.dart';
import 'package:lkm_itb/modules/2/module_2_page_13.dart';
import 'package:lkm_itb/modules/2/module_2_page_14.dart';
import 'package:lkm_itb/modules/2/module_2_page_15.dart';
import 'package:lkm_itb/modules/2/module_2_page_16.dart';
import 'package:lkm_itb/modules/2/module_2_page_17.dart';
import 'package:lkm_itb/modules/2/module_2_page_18.dart';
import 'package:lkm_itb/modules/2/module_2_page_19.dart';
import 'package:lkm_itb/modules/2/module_2_page_2.dart';
import 'package:lkm_itb/modules/2/module_2_page_20.dart';
import 'package:lkm_itb/modules/2/module_2_page_21.dart';
import 'package:lkm_itb/modules/2/module_2_page_22.dart';
import 'package:lkm_itb/modules/2/module_2_page_23.dart';
import 'package:lkm_itb/modules/2/module_2_page_24.dart';
import 'package:lkm_itb/modules/2/module_2_page_25.dart';
import 'package:lkm_itb/modules/2/module_2_page_26.dart';
import 'package:lkm_itb/modules/2/module_2_page_27.dart';
import 'package:lkm_itb/modules/2/module_2_page_28.dart';
import 'package:lkm_itb/modules/2/module_2_page_29.dart';
import 'package:lkm_itb/modules/2/module_2_page_3.dart';
import 'package:lkm_itb/modules/2/module_2_page_4.dart';
import 'package:lkm_itb/modules/2/module_2_page_5.dart';
import 'package:lkm_itb/modules/2/module_2_page_6.dart';
import 'package:lkm_itb/modules/2/module_2_page_7.dart';
import 'package:lkm_itb/modules/2/module_2_page_8.dart';
import 'package:lkm_itb/modules/2/module_2_page_9.dart';
import 'package:lkm_itb/modules/penilaian/penilaian_first.dart';
import 'package:lkm_itb/modules/penilaian/penilaian_last.dart';
import 'package:lkm_itb/nilai/ui/nilai_kelompok_screen.dart';
import 'package:lkm_itb/nilai/ui/nilai_mentee_screen.dart';
import 'package:lkm_itb/nilai/ui/nilai_screen.dart';
import 'package:lkm_itb/profile_screen/ui/profile.dart';
import 'package:lkm_itb/profile_screen/ui/profile_form_builder.dart';
import 'package:lkm_itb/progress/ui/progress_tab.dart';
import 'package:lkm_itb/pusat_bantuan/ui/pusat_bantuan.dart';
import 'package:lkm_itb/tentang_kami/ui/tentang_kami.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class BottomNavigation extends StatefulWidget {
  final User user;
  final BuildContext menuScreenContext;
  BottomNavigation(
      {Key? key, required this.menuScreenContext, required this.user})
      : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState(this.user);
}

class _BottomNavigationState extends State<BottomNavigation> {
  final User user;
  late PersistentTabController _controller;
  late bool _hideNavBar;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  _BottomNavigationState(this.user);

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  Future<DocumentSnapshot> homeStream() {
    return users.doc(user.uid).get();
  }

  List<Widget> _buildScreens() {
    return [
      new HomeScreen(title: 'Home Screen', user: user),
      new ProgressTab(user: user),
      new NilaiScreen(
        group: sharedPrefs.group,
        name: sharedPrefs.name,
        role: sharedPrefs.role,
      ),
      new Profile(title: 'Profile', user: user),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/images/logo_home_filled.png'),
        inactiveIcon: Image.asset('assets/images/logo_home.png'),
        title: "Utama",
        activeColorPrimary: ConstColor.lightGreen,
        inactiveColorPrimary: ConstColor.inactiveState,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/home',
          routes: {
            '/home': (context) => HomeScreen(title: 'Home', user: user),
            '/home/detaillkm': (context) => DetailLKM(title: 'Detail LKM'),
            '/home/listlkm': (context) => ListLKM(
                  title: 'List LKM',
                ),
            '/module/1/page/1': (context) =>
                Modul1Page1(title: 'Module 1 Page 1', role: sharedPrefs.role),
            '/module/1/page/2': (context) =>
                Modul1Page2(title: 'Module 1 Page 2', role: sharedPrefs.role),
            '/module/1/page/3': (context) =>
                Modul1Page3(title: 'Module 1 Page 3', role: sharedPrefs.role),
            '/module/1/page/4': (context) =>
                Modul1Page4(title: 'Module 1 Page 4', role: sharedPrefs.role),
            '/module/1/page/5': (context) =>
                Modul1Page5(title: 'Module 1 Page 5', role: sharedPrefs.role),
            '/module/1/page/6': (context) =>
                Modul1Page6(title: 'Module 1 Page 6', role: sharedPrefs.role),
            '/module/1/page/7': (context) =>
                Modul1Page7(title: 'Module 1 Page 7', role: sharedPrefs.role),
            '/module/1/page/8': (context) =>
                Modul1Page8(title: 'Module 1 Page 8', role: sharedPrefs.role),
            '/module/1/page/9': (context) =>
                Modul1Page9(title: 'Module 1 Page 9', role: sharedPrefs.role),
            '/module/1/page/10': (context) =>
                Modul1Page10(title: 'Module 1 Page 10', role: sharedPrefs.role),
            '/module/1/page/11': (context) =>
                Modul1Page11(title: 'Module 1 Page 11', role: sharedPrefs.role),
            '/module/1/page/12': (context) =>
                Modul1Page12(title: 'Module 1 Page 12', role: sharedPrefs.role),
            '/module/1/page/13': (context) =>
                Modul1Page13(title: 'Module 1 Page 13', role: sharedPrefs.role),
            '/module/1/page/14': (context) =>
                Modul1Page14(title: 'Module 1 Page 14', role: sharedPrefs.role),
            '/module/1/page/15': (context) =>
                Modul1Page15(title: 'Module 1 Page 15', role: sharedPrefs.role),
            '/module/1/page/16': (context) =>
                Modul1Page16(title: 'Module 1 Page 16', role: sharedPrefs.role),
            '/module/1/page/17': (context) =>
                Modul1Page17(title: 'Module 1 Page 17', role: sharedPrefs.role),
            '/module/1/page/18': (context) =>
                Modul1Page18(title: 'Module 1 Page 18', role: sharedPrefs.role),
            '/module/1/page/19': (context) =>
                Modul1Page19(title: 'Module 1 Page 19', role: sharedPrefs.role),
            '/module/1/page/20': (context) =>
                Modul1Page20(title: 'Module 1 Page 20', role: sharedPrefs.role),
            '/module/1/page/21': (context) =>
                Modul1Page21(title: 'Module 1 Page 21', role: sharedPrefs.role),
            '/module/1/page/22': (context) =>
                Modul1Page22(title: 'Module 1 Page 22', role: sharedPrefs.role),
            '/module/1/page/23': (context) =>
                Modul1Page23(title: 'Module 1 Page 23', role: sharedPrefs.role),
            '/module/1/page/24': (context) =>
                Modul1Page24(title: 'Module 1 Page 24', role: sharedPrefs.role),
            '/module/1/page/25': (context) =>
                Modul1Page25(title: 'Module 1 Page 25', role: sharedPrefs.role),
            '/module/1/page/26': (context) =>
                Modul1Page26(title: 'Module 1 Page 26', role: sharedPrefs.role),
            Modul2Page1.routeName: (context) =>
                Modul2Page1(role: sharedPrefs.role),
            Modul2Page2.routeName: (context) =>
                Modul2Page2(role: sharedPrefs.role),
            Modul2Page3.routeName: (context) =>
                Modul2Page3(role: sharedPrefs.role),
            Modul2Page4.routeName: (context) =>
                Modul2Page4(role: sharedPrefs.role),
            Modul2Page5.routeName: (context) =>
                Modul2Page5(role: sharedPrefs.role),
            Modul2Page6.routeName: (context) =>
                Modul2Page6(role: sharedPrefs.role),
            Modul2Page7.routeName: (context) =>
                Modul2Page7(role: sharedPrefs.role),
            Modul2Page8.routeName: (context) =>
                Modul2Page8(role: sharedPrefs.role),
            Modul2Page9.routeName: (context) =>
                Modul2Page9(role: sharedPrefs.role),
            Modul2Page10.routeName: (context) =>
                Modul2Page10(role: sharedPrefs.role),
            Modul2Page11.routeName: (context) =>
                Modul2Page11(role: sharedPrefs.role),
            Modul2Page12.routeName: (context) =>
                Modul2Page12(role: sharedPrefs.role),
            Modul2Page13.routeName: (context) =>
                Modul2Page13(role: sharedPrefs.role),
            Modul2Page14.routeName: (context) =>
                Modul2Page14(role: sharedPrefs.role),
            Modul2Page15.routeName: (context) =>
                Modul2Page15(role: sharedPrefs.role),
            Modul2Page16.routeName: (context) =>
                Modul2Page16(role: sharedPrefs.role),
            Modul2Page17.routeName: (context) =>
                Modul2Page17(role: sharedPrefs.role),
            Modul2Page18.routeName: (context) =>
                Modul2Page18(role: sharedPrefs.role),
            Modul2Page19.routeName: (context) =>
                Modul2Page19(role: sharedPrefs.role),
            Modul2Page20.routeName: (context) =>
                Modul2Page20(role: sharedPrefs.role),
            Modul2Page21.routeName: (context) =>
                Modul2Page21(role: sharedPrefs.role),
            Modul2Page22.routeName: (context) =>
                Modul2Page22(role: sharedPrefs.role),
            Modul2Page23.routeName: (context) =>
                Modul2Page23(role: sharedPrefs.role),
            Modul2Page24.routeName: (context) =>
                Modul2Page24(role: sharedPrefs.role),
            Modul2Page25.routeName: (context) =>
                Modul2Page25(role: sharedPrefs.role),
            Modul2Page26.routeName: (context) =>
                Modul2Page26(role: sharedPrefs.role),
            Modul2Page27.routeName: (context) =>
                Modul2Page27(role: sharedPrefs.role),
            Modul2Page28.routeName: (context) =>
                Modul2Page28(role: sharedPrefs.role),
                Modul2Page29.routeName: (context) =>
                Modul2Page29(role: sharedPrefs.role),
          },
        ),
      ),
      PersistentBottomNavBarItem(
          icon: Image.asset('assets/images/logo_progress_filled.png'),
          inactiveIcon: Image.asset(
            'assets/images/logo_progress.png',
          ),
          title: "Capaian",
          activeColorPrimary: ConstColor.lightGreen,
          inactiveColorPrimary: ConstColor.inactiveState,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: '/progress',
              onGenerateRoute: (RouteSettings settings) {
                if (settings.name == PenilaianFirst.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => PenilaianFirst(
                          menteeID: arg['menteeID'],
                          userID: arg['userID'],
                          moduleID: arg['moduleID']));
                } else if (settings.name == PenilaianLast.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => PenilaianLast(
                          menteeID: arg['menteeID'],
                          userID: arg['userID'],
                          moduleID: arg['moduleID']));
                } else if (settings.name == Modul1Page4.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page4(
                          menteeID: arg['menteeID'],
                          title: 'Penilaian Modul 1 Page 4',
                          role: 'mentee'));
                } else if (settings.name == Modul1Page6.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page6(
                          menteeID: arg['menteeID'],
                          title: 'Penilaian Modul 1 Page 4',
                          role: 'mentee'));
                } else if (settings.name == Modul1Page7.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page7(
                          menteeID: arg['menteeID'],
                          title: 'Penilaian Modul 1 Page 7',
                          role: 'mentee'));
                } else if (settings.name == Modul1Page10.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page10(
                          menteeID: arg['menteeID'],
                          title: 'Penilaian Modul 1 Page 10',
                          role: 'mentee'));
                } else if (settings.name == Modul1Page14.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page14(
                          menteeID: arg['menteeID'],
                          title: 'Penilaian Modul 1 Page 14',
                          role: 'mentee'));
                } else if (settings.name == Modul1Page16.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page16(
                          menteeID: arg['menteeID'],
                          title: 'Penilaian Modul 1 Page 16',
                          role: 'mentee'));
                } else if (settings.name == Modul1Page17.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page17(
                          menteeID: arg['menteeID'],
                          title: 'Penilaian Modul 1 Page 17',
                          role: 'mentee'));
                } else if (settings.name == Modul1Page20.routeName) {
                  var args = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page20(
                          menteeID: args['menteeID'],
                          title: 'Penilaian Modul 1 Page 20',
                          role: 'mentee'));
                } else if (settings.name == Modul1Page22.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page22(
                          menteeID: arg['menteeID'],
                          title: 'Penilaian Modul 1 Page 22',
                          role: 'mentee'));
                } else if (settings.name == Modul1Page24.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) => Modul1Page24(
                          menteeID: arg['menteeID'],
                          title: 'Penilaian Modul 1 Page 24',
                          role: 'mentee'));
                } else if (settings.name == '/progress') {
                  return MaterialPageRoute(
                    builder: (context) => ProgressTab(user: user),
                  );
                }
              })),
      PersistentBottomNavBarItem(
          icon: Image.asset('assets/images/logo_nilai_filled.png'),
          inactiveIcon: Image.asset(
            'assets/images/logo_nilai.png',
          ),
          title: "Nilai",
          activeColorPrimary: ConstColor.lightGreen,
          inactiveColorPrimary: ConstColor.inactiveState,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
              initialRoute: '/nilai',
              onGenerateRoute: (RouteSettings settings) {
                if (settings.name == NilaiKelompokScreen.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) =>
                          NilaiKelompokScreen(group: arg['group']));
                } else if (settings.name == NilaiScreen.routeName) {
                  return MaterialPageRoute(
                      builder: (context) => NilaiScreen(
                            group: sharedPrefs.group,
                            name: sharedPrefs.name,
                            role: sharedPrefs.role,
                          ));
                } else if (settings.name == NilaiMenteeScreen.routeName) {
                  var arg = settings.arguments as Map;
                  return MaterialPageRoute(
                      builder: (context) =>
                          NilaiMenteeScreen(menteeID: arg['menteeID']));
                }
              })),
      PersistentBottomNavBarItem(
        icon: Image.asset('assets/images/logo_profile_filled.png'),
        inactiveIcon: Image.asset(
          'assets/images/logo_profile.png',
        ),
        title: "Profil",
        activeColorPrimary: ConstColor.lightGreen,
        inactiveColorPrimary: ConstColor.inactiveState,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/profile',
          routes: {
            '/profile/edit' : (context) => ProfileFormBuilder(user: user),
            '/profile' : (context) => new Profile(title: 'Profile', user: user),
            '/profile/info': (context) => DetailLKM(title: 'Detail LKM'),
            '/profile/password': (context) => DetailLKM(title: 'Detail LKM'),
            '/profile/about': (context) => TentangKami(title: 'Tentang Kami'),
            '/profile/help': (context) => PusatBantuan(
                  title: 'Pusat Bantuan',
                ),
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 64,
      hideNavigationBarWhenKeyboardShows: true,
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0.0,
      hideNavigationBar: _hideNavBar,
      decoration:
          NavBarDecoration(colorBehindNavBar: Colors.indigo, boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 6))
      ]),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property
    );
  }
}
