/*
* File : Shopping App
* Version : 1.0.0
* */

import 'package:sdock_fe/apps/health/health_activity_screen.dart';
import 'package:sdock_fe/apps/health/health_home_screen.dart';
import 'package:sdock_fe/apps/health/health_profile_screen.dart';
import 'package:sdock_fe/apps/health/health_schedule_screen.dart';
import 'package:sdock_fe/helpers/theme/app_notifier.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/utils/my_shadow.dart';
import 'package:sdock_fe/helpers/widgets/my_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HealthFullApp extends StatefulWidget {
  @override
  _HealthFullAppState createState() => _HealthFullAppState();
}

class _HealthFullAppState extends State<HealthFullApp>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late CustomTheme customTheme;
  late ThemeData theme;

  TabController? _tabController;

  _handleTabSelection() {
    setState(() {
      _currentIndex = _tabController!.index;
    });
  }

  @override
  void initState() {
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController!.addListener(_handleTabSelection);
    _tabController!.animation!.addListener(() {
      final aniValue = _tabController!.animation!.value;
      if (aniValue - _currentIndex > 0.5) {
        setState(() {
          _currentIndex = _currentIndex + 1;
        });
      } else if (aniValue - _currentIndex < -0.5) {
        setState(() {
          _currentIndex = _currentIndex - 1;
        });
      }
    });
    super.initState();
  }

  onTapped(value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Scaffold(
            bottomNavigationBar: BottomAppBar(
                elevation: 0,
                shape: CircularNotchedRectangle(),
                child: MyCard.none(
                  color: theme.colorScheme.background,
                  shadow: MyShadow(
                      position: MyShadowPosition.top, elevation: 2, alpha: 20),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: theme.colorScheme.primary,
                    tabs: <Widget>[
                      Container(
                        child: (_currentIndex == 0)
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    Icons.home,
                                    color: theme.colorScheme.primary,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.5))),
                                    height: 5,
                                    width: 5,
                                  )
                                ],
                              )
                            : Icon(
                                Icons.home_outlined,
                                color: theme.colorScheme.onBackground,
                              ),
                      ),
                      Container(
                          child: (_currentIndex == 1)
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.directions_run,
                                      color: theme.colorScheme.primary,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.5))),
                                      height: 5,
                                      width: 5,
                                    )
                                  ],
                                )
                              : Icon(
                                  Icons.directions_run_outlined,
                                  color: theme.colorScheme.onBackground,
                                )),
                      Container(
                          child: (_currentIndex == 2)
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.calendar_month,
                                      color: theme.colorScheme.primary,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.5))),
                                      height: 5,
                                      width: 5,
                                    )
                                  ],
                                )
                              : Icon(
                                  Icons.calendar_month_outlined,
                                  color: theme.colorScheme.onBackground,
                                )),
                      Container(
                          child: (_currentIndex == 3)
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.person,
                                      color: theme.colorScheme.primary,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 4),
                                      decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.5))),
                                      height: 5,
                                      width: 5,
                                    )
                                  ],
                                )
                              : Icon(
                                  Icons.person_outline,
                                  color: theme.colorScheme.onBackground,
                                )),
                    ],
                  ),
                )),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                HealthHomeScreen(),
                HealthActivityScreen(),
                HealthScheduleScreen(),
                HealthProfileScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}
