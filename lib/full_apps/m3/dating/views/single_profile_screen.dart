import 'package:sdock_fe/full_apps/m3/dating/controllers/single_profile_controller.dart';
import 'package:sdock_fe/full_apps/m3/dating/models/profile.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/theme/constant.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:sdock_fe/loading_effect.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SingleProfileScreen extends StatefulWidget {
  final Profile profile;

  const SingleProfileScreen(this.profile, {Key? key}) : super(key: key);

  @override
  _SingleProfileScreenState createState() => _SingleProfileScreenState();
}

class _SingleProfileScreenState extends State<SingleProfileScreen> {
  late ThemeData theme;
  late SingleProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = SingleProfileController(widget.profile);
    theme = AppTheme.datingTheme;
  }

  List<Widget> _buildInterestList() {
    List<Widget> list = [];

    for (String interest in controller.profile.interests) {
      list.add(MyContainer.bordered(
        padding: MySpacing.xy(12, 8),
        borderRadiusAll: Constant.containerRadius.small,
        border: Border.all(color: theme.colorScheme.primary),
        color: theme.colorScheme.primaryContainer,
        child: MyText.bodySmall(
          interest,
          color: theme.colorScheme.primary,
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SingleProfileController>(
        init: controller,
        tag: 'single_profile_controller',
        builder: (controller) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (controller.uiLoading) {
      return Scaffold(
          body: Container(
              margin: MySpacing.top(24),
              child: LoadingEffect.getProductLoadingScreen(
                context,
              )));
    } else {
      return Scaffold(
        body: ListView(
          padding: MySpacing.fromLTRB(
              20, MySpacing.safeAreaTop(context) + 20, 20, 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyContainer.bordered(
                  onTap: () {
                    controller.goBack();
                  },
                  paddingAll: 8,
                  borderRadiusAll: Constant.containerRadius.small,
                  border: Border.all(color: theme.colorScheme.primary),
                  color: theme.colorScheme.primaryContainer,
                  child: Icon(
                    LucideIcons.chevronLeft,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                ),
                MyContainer.bordered(
                  onTap: () {
                    controller.goToSingleChatScreen();
                  },
                  paddingAll: 8,
                  borderRadiusAll: Constant.containerRadius.small,
                  border: Border.all(color: theme.colorScheme.primary),
                  color: theme.colorScheme.primaryContainer,
                  child: Icon(
                    LucideIcons.messageCircle,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            MySpacing.height(20),
            MyContainer(
              height: 400,
              paddingAll: 0,
              borderRadiusAll: Constant.containerRadius.large,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(controller.profile.image),
              ),
            ),
            MySpacing.height(16),
            Row(
              children: [
                Expanded(
                  child: MyText.titleMedium(
                    controller.profile.name,
                    fontWeight: 700,
                  ),
                ),
                MySpacing.width(16),
                Icon(
                  LucideIcons.instagram,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                MySpacing.width(12),
                Icon(
                  LucideIcons.facebook,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                MySpacing.width(2),
              ],
            ),
            MySpacing.height(4),
            MyText.bodyMedium(
              '${controller.profile.profession}, ${controller.profile.companyName}',
              xMuted: true,
            ),
            MySpacing.height(16),
            MyText.titleMedium(
              'About',
              fontWeight: 700,
              letterSpacing: 0.3,
            ),
            MySpacing.height(8),
            MyText.bodySmall(
              controller.profile.description,
              xMuted: true,
            ),
            MySpacing.height(16),
            MyText.titleSmall(
              'Interest',
              fontWeight: 700,
              letterSpacing: 0.3,
            ),
            MySpacing.height(16),
            Wrap(
              runSpacing: 16,
              spacing: 16,
              children: _buildInterestList(),
            ),
          ],
        ),
      );
    }
  }
}
