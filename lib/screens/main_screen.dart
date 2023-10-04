import 'dart:async';
import 'package:ecart_driver/screens/home_screen.dart';
import 'package:ecart_driver/screens/settings_screen.dart';
import 'package:ecart_driver/screens/support_screen.dart';
import 'package:ecart_driver/screens/wallet_screen.dart';
import 'package:ecart_driver/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final StreamController<int> streamController =
    StreamController<int>.broadcast();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List _tabs = [];
  late StreamSubscription<int> streamSubscription;

  @override
  void initState() {
    streamSubscription = streamController.stream.listen((value) {
      controller!.jumpToPage(value);
      currentTab = value;
      if (mounted) setState(() {});
    });

    _tabs = [
      {"icon": "home", "title": AppConstants.home},
      {"icon": "wallet", "title": AppConstants.wallet},
      {"icon": "support", "title": AppConstants.support},
      {"icon": "settings", "title": AppConstants.settings},
    ];
    controller = PageController(initialPage: currentTab);
    super.initState();
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomNavigationBar(),
      body: _buildBody(),
    );
  }

  PageController? controller;

  Widget _buildBody() {
    return PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        HomeScreen(),
        WalletsScreen(),
        SupportScreen(),
        SettingsScreen(),
      ],
    );
  }

  Color selectedTabIconColor = const Color(0xff1B7575);
  Color unSelectedTabIconColor = const Color(0xff5C1F5A);
  Color unSelectedTabTextColor = const Color(0xff969696);
  Color tabBackColor = const Color(0xffE1F5E9);
  int currentTab = 0;

  Widget _bottomNavigationBar() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
                  4,
                  (index) =>
                      Expanded(child: _buildBottomItem(_tabs[index], index)))
              .toList(),
        ),
      );

  Widget _buildBottomItem(tabData, index) => ElevatedButton(
      onPressed: () {
        controller!.jumpToPage(index);
        if (mounted) {
          setState(() {});
          currentTab = index;
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: currentTab == index ? tabBackColor : Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 13)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "images/${tabData["icon"]}_icon.svg",
            // ignore: deprecated_member_use
            color: currentTab == index
                ? selectedTabIconColor
                : unSelectedTabIconColor,
          ),
          const SizedBox(height: 8),
          Text(
            tabData["title"],
            style: TextStyle(
                color: currentTab == index
                    ? selectedTabIconColor
                    : unSelectedTabTextColor,
                fontWeight: FontWeight.w600,
                fontFamily: "Inter-SemiBold"),
          ),
        ],
      ));
}
