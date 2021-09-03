import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lkm_itb/constants/const_colors.dart';
import 'package:lkm_itb/data/repositories/shared_pref_repositories.dart';
import 'package:lkm_itb/progress/ui/progress_screen.dart';

class ProgressTab extends StatefulWidget {
  final User user;
  ProgressTab({Key? key, required this.user}) : super(key: key);

  @override
  _ProgressTabState createState() {
    return _ProgressTabState(user: user);
  }
}

// ignore: must_be_immutable
class _ProgressTabState extends State<ProgressTab>
    with SingleTickerProviderStateMixin {
  final User user;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  late TabController _tabController;
  _ProgressTabState({
    required this.user,
  });

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text('Capaian',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.roboto(
                      color: ConstColor.blackText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 20,
            ),

            Container(
              height: 45,
              decoration: BoxDecoration(
                color: ConstColor.greyText,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: ConstColor.whiteBackground,
                ),
                labelColor: ConstColor.lightGreen,
                unselectedLabelColor: ConstColor.blackText,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Berjalan',
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Selesai',
                  ),
                ],
              ),
            ),
            // tab bar view here
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  ProgressScreen(
                    user: this.user,
                    grup: sharedPrefs.group,
                    status: 'progress',
                  ),
                  ProgressScreen(
                    user: this.user,
                    grup: sharedPrefs.group,
                    status: 'complete',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
