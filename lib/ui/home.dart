import 'package:arbi/controller/user_controller.dart';
import 'package:arbi/ui/customer_drawer.dart';
import 'package:arbi/generated/l10n.dart';
import 'package:arbi/ui/customer_profile.dart';
import 'package:arbi/utils/app_utils.dart';
import 'package:flutter/material.dart';

import 'listing.dart';

// ignore: must_be_immutable
class HomePageScreen extends StatefulWidget {
  int currentTab;
  Widget currentPage = ListingWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  HomePageScreen({
    Key key,
    this.currentTab,
  }) {
    currentTab = currentTab != null ? currentTab : 0;
  }

  @override
  _HomePageScreenState createState() {
    return _HomePageScreenState();
  }
}

class _HomePageScreenState extends State<HomePageScreen> {
  initState() {
    super.initState();
    _selectTab(widget.currentTab);
  }

  @override
  void didUpdateWidget(HomePageScreen oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage =
              ListingWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          if (currentUser.value.auth)
            widget.currentPage = CustomerProfilePage();
          else {
            AppUtils.showMessage(context, S.of(context).app_name,
                S.of(context).login_to_continue);
            _selectTab(0);
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: CustomerDrawerWidget(),
        body: SafeArea(child: widget.currentPage),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          iconSize: 22,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          elevation: 0,
          showSelectedLabels: true,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text(S.of(context).home)),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text(S.of(context).profile))
          ],
        ),
      ),
    );
  }
}
