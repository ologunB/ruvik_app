import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lendo/views/history/history.dart';
import 'package:lendo/views/widgets/colors.dart';

import 'home/home.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> get screens => const [
        HomeScreen(),
        HistoryScreen(),
        Center(child: Text('Profile')),
      ];

  int currentIndex = 0;
  List<GlobalKey<NavigatorState>> navigatorKeys = [];

  @override
  void initState() {
    navigatorKeys = List.generate(5, (index) => GlobalKey<NavigatorState>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens
            .map(
              (e) => Navigator(
                key: navigatorKeys[screens.indexOf(e)],
                onGenerateRoute: (settings) =>
                    MaterialPageRoute(builder: (context) => e),
              ),
            )
            .toList(),
      ),
      backgroundColor: AppColors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.black,
        unselectedItemColor: const Color(0xffB5B5B5),
        iconSize: 20.h,
        selectedLabelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xffB5B5B5),
        ),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() => currentIndex = i);
        },
        items: [0, 1, 2]
            .map(
              (a) => BottomNavigationBarItem(
                icon: Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Icon([Icons.home, Icons.history, Icons.person][a])),
                activeIcon: Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Icon([Icons.home, Icons.history, Icons.person][a])),
                label: ['Dining', 'History', 'Profile'][a],
              ),
            )
            .toList(),
      ),
    );
  }
}
