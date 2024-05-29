import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NavItem {
  final String title;
  final IconData iconData;

  NavItem(this.title, this.iconData);
}

class FullAppController extends GetxController {
  var currentIndex = 0.obs;
  var pages = 4.obs;

  late TabController tabController;
  final TickerProvider tickerProvider;

  late List<NavItem> navItems;

  FullAppController(this.tickerProvider) {
    tabController =
        TabController(length: pages.value, vsync: tickerProvider, initialIndex: 0);

    navItems = [
      NavItem('Home', LucideIcons.home),
      NavItem('Collection', LucideIcons.grid),
      NavItem('Saved', LucideIcons.bookmark),
      NavItem('Profile', LucideIcons.user),
    ];
  }

  @override
  void onInit() {
    tabController.addListener(handleTabSelection);
    tabController.animation!.addListener(() {
      final aniValue = tabController.animation!.value;
      if (aniValue - currentIndex.value > 0.5) {
        currentIndex++;
        update();
      } else if (aniValue - currentIndex.value < -0.5) {
        currentIndex--;
        update();
      }
    });
    super.onInit();
  }

  handleTabSelection() {
    currentIndex.value = tabController.index;
  }
}
