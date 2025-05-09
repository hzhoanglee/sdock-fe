import 'package:sdock_fe/loading_effect.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:sdock_fe/full_apps/other/dating/controllers/profile_controller.dart';

class DatingProfileScreen extends StatefulWidget {
  const DatingProfileScreen({Key? key}) : super(key: key);

  @override
  _DatingProfileScreenState createState() => _DatingProfileScreenState();
}

class _DatingProfileScreenState extends State<DatingProfileScreen> {
  late ThemeData theme;
  late CustomTheme customTheme;

  late DatingProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = DatingProfileController();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  Widget _buildSingleRow(String info, IconData icon) {
    return MyContainer(
      borderRadiusAll: 8,
      margin: MySpacing.bottom(16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: customTheme.datingSecondary,
          ),
          MySpacing.width(16),
          Expanded(
            child: MyText.bodySmall(
              info,
              fontWeight: 600,
            ),
          ),
          MySpacing.width(16),
          Icon(
            LucideIcons.chevronDown,
            color: theme.colorScheme.onBackground,
            size: 16,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DatingProfileController>(
        init: controller,
        tag: 'dating_profile_controller',
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
          body: Container(
              margin: MySpacing.top(24),
              child: LoadingEffect.getSearchLoadingScreen(
                context,
              )));
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          leading: InkWell(
            onTap: () {
              controller.goBack();
            },
            child: Icon(
              LucideIcons.chevronLeft,
              size: 20,
              color: theme.colorScheme.onBackground,
            ),
          ),
          title: MyText.titleMedium(
            'Profile',
            color: theme.colorScheme.onBackground,
            fontWeight: 600,
          ),
        ),
        body: Column(
          children: [
            MyContainer(
              borderRadiusAll: 8,
              margin: MySpacing.fromLTRB(24, 4, 24, 0),
              paddingAll: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyContainer.rounded(
                        paddingAll: 0,
                        margin: MySpacing.right(8),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          height: 64,
                          width: 64,
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/apps/dating/profile.jpg'),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText.bodyMedium(
                            'Taylor Swift, 22',
                            fontWeight: 600,
                          ),
                          MySpacing.height(4),
                          MyText.bodySmall(
                            'Project Manager, Cloud Infotech',
                            xMuted: true,
                            fontWeight: 600,
                          ),
                          MySpacing.height(4),
                          MyText.bodySmall(
                            'Bangkok, Malaysia',
                            fontWeight: 600,
                          ),
                        ],
                      ),
                    ],
                  ),
                  MySpacing.height(12),
                  Row(
                    children: [
                      MyContainer(
                        margin: MySpacing.right(8),
                        padding: MySpacing.xy(8, 4),
                        borderRadiusAll: 4,
                        color: customTheme.datingPrimary.withAlpha(30),
                        child: MyText.labelSmall(
                          'Travelling',
                          color: customTheme.datingPrimary,
                        ),
                      ),
                      MyContainer(
                        margin: MySpacing.right(8),
                        padding: MySpacing.xy(8, 4),
                        borderRadiusAll: 4,
                        color: customTheme.datingPrimary.withAlpha(30),
                        child: MyText.labelSmall(
                          'Diving',
                          color: customTheme.datingPrimary,
                        ),
                      ),
                      MyContainer(
                        margin: MySpacing.right(8),
                        padding: MySpacing.xy(8, 4),
                        borderRadiusAll: 4,
                        color: customTheme.datingPrimary.withAlpha(30),
                        child: MyText.labelSmall(
                          'Reading',
                          color: customTheme.datingPrimary,
                        ),
                      ),
                      MyContainer(
                        margin: MySpacing.right(8),
                        padding: MySpacing.xy(8, 4),
                        borderRadiusAll: 4,
                        color: customTheme.datingPrimary.withAlpha(30),
                        child: MyText.labelSmall(
                          'Trekking',
                          color: customTheme.datingPrimary,
                        ),
                      ),
                    ],
                  ),
                  MySpacing.height(16),
                  MyText.labelSmall(
                    'I\'m taylor from Texas. I am looking for special person also I want to meet different people and learn new things from different cultures and visit new places.',
                    xMuted: true,
                  ),
                ],
              ),
            ),
            Container(
              padding: MySpacing.all(24),
              child: Column(
                children: [
                  _buildSingleRow('Detailed Info', LucideIcons.alertCircle),
                  _buildSingleRow('Matches', LucideIcons.heart),
                  _buildSingleRow('Profile Stats', LucideIcons.activity),
                  _buildSingleRow('Notes', LucideIcons.scrollText),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
