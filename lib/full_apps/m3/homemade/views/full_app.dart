import 'package:sdock_fe/full_apps/m3/homemade/controllers/full_app_controller.dart';
import 'package:sdock_fe/full_apps/m3/homemade/views/chat_screen.dart';
import 'package:sdock_fe/full_apps/m3/homemade/views/home_screen.dart';
import 'package:sdock_fe/full_apps/m3/homemade/views/profile_screen.dart';
import 'package:sdock_fe/full_apps/m3/homemade/views/search_screen.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FullApp extends StatefulWidget {
  const FullApp({Key? key}) : super(key: key);

  @override
  _FullAppState createState() => _FullAppState();
}

class _FullAppState extends State<FullApp> with SingleTickerProviderStateMixin {
  late ThemeData theme;
  late FullAppController appController;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.homemadeTheme;
    appController = FullAppController(this /* save: false*/);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: appController,
        tag: 'app_controller',
        builder: (controller) {
          return Theme(
            data: theme.copyWith(
                colorScheme: theme.colorScheme
                    .copyWith(secondary: theme.colorScheme.primaryContainer)),
            child: Scaffold(
              body: Stack(
                children: [
                  TabBarView(
                    controller: appController.tabController,
                    children: const <Widget>[
                      HomeScreen(),
                      SearchScreen(),
                      ChatScreen(),
                      ProfileScreen()
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: MySpacing.xy(12, 8),
                      child: PhysicalModel(
                        color: theme.cardTheme.color!.withAlpha(200),
                        elevation: 12,
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                        shadowColor:
                            theme.colorScheme.onBackground.withAlpha(12),
                        shape: BoxShape.rectangle,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.cardTheme.color!.withAlpha(200),
                            borderRadius: BorderRadius.all(Radius.circular(32)),
                          ),
                          padding: MySpacing.xy(16, 12),
                          child: Row(
                            children: <Widget>[
                              singleItem(
                                  index: 0,
                                  iconData: LucideIcons.home,
                                  activeIconData: LucideIcons.home,
                                  title: "Home"),
                              singleItem(
                                  index: 1,
                                  iconData: LucideIcons.search,
                                  activeIconData: LucideIcons.search,
                                  title: "Search"),
                              singleItem(
                                  index: 2,
                                  activeIconData: LucideIcons.messageCircle,
                                  iconData: LucideIcons.messageCircle,
                                  title: "Chat"),
                              singleItem(
                                  index: 3,
                                  iconData: LucideIcons.user,
                                  activeIconData: LucideIcons.user,
                                  title: "Profile"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget singleItem(
      {required int index,
      required IconData iconData,
      required IconData activeIconData,
      required String title}) {
    double width = MediaQuery.of(context).size.width - 64;
    double selectedWidth = width * (1.5 / 4.5);
    double unSelectedWidth = width * (1 / 4.5);

    bool selected = index == appController.currentIndex;

    if (selected) {
      return Container(
        width: selectedWidth,
        padding: MySpacing.y(8),
        decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              activeIconData,
              size: 20,
              color: theme.colorScheme.onPrimary,
            ),
            MySpacing.width(8),
            MyText.bodyMedium(title,
                color: theme.colorScheme.onPrimary,
                letterSpacing: 0.3,
                fontWeight: 600),
          ],
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          appController.onTapped(index);
        },
        child: SizedBox(
          width: unSelectedWidth,
          child: Center(
              child: Icon(
            iconData,
            size: 20,
            color: theme.colorScheme.onBackground,
          )),
        ),
      );
    }
  }
}
