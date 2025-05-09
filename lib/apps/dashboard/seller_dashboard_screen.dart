/*
* File : Seller Dashboard
* Version : 1.0.0
* */

import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SellerDashboardScreen extends StatefulWidget {
  @override
  _SellerDashboardScreenState createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  final List<String> _simpleChoice = [
    "New receipt",
    "Read all",
    "Cancel",
  ];

  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              LucideIcons.chevronLeft,
              size: 20,
            ),
          ),
          title: MyText.titleLarge("Seller", fontWeight: 600),
        ),
        body: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyText.bodySmall("OVERVIEW",
                      fontWeight: 600, letterSpacing: 0.3),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return _simpleChoice.map((String choice) {
                        return PopupMenuItem(
                          value: choice,
                          child: MyText.bodyMedium(
                            choice,
                            letterSpacing: 0.15,
                            color: theme.colorScheme.onBackground,
                          ),
                        );
                      }).toList();
                    },
                    icon: Icon(
                      LucideIcons.moreVertical,
                      size: 20,
                      color: theme.colorScheme.onBackground,
                    ),
                  )
                ],
              ),
            ),
            _SingleOverview(
              title: 'Today',
              sales: 234,
              units: 123,
              profit: 14.545,
            ),
            _SingleOverview(
              title: 'Yesterday',
              sales: 123,
              units: 63,
              profit: -25.2,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  MyText.bodySmall("NEW ORDERS",
                      fontWeight: 600, letterSpacing: 0.3),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return _simpleChoice.map((String choice) {
                        return PopupMenuItem(
                          value: choice,
                          child: MyText.bodyMedium(
                            choice,
                            letterSpacing: 0.15,
                            color: theme.colorScheme.onBackground,
                          ),
                        );
                      }).toList();
                    },
                    icon: Icon(
                      LucideIcons.moreVertical,
                      size: 20,
                      color: theme.colorScheme.onBackground,
                    ),
                  )
                ],
              ),
            ),
            _SingleOrder(
              name: 'Item - 1',
              image: './assets/images/profile/avatar.jpg',
              code: '#11D224S2SF2',
            ),
            _SingleOrder(
              name: 'Item - 2',
              image: './assets/images/profile/avatar_2.jpg',
              code: '#4AS1A3S6AS8',
            ),
            _SingleOrder(
              name: 'Item - 3',
              image: './assets/images/profile/avatar_3.jpg',
              code: '#S1D221XZX6A',
            ),
            _SingleOrder(
              name: 'Item - 4',
              image: './assets/images/profile/avatar_4.jpg',
              code: '#5SD1D5C1Z2X',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 24, bottom: 8),
              child: Center(
                child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            theme.colorScheme.primary),
                        strokeWidth: 1.5)),
              ),
            )
          ],
        ));
  }
}

class _SingleOverview extends StatelessWidget {
  final String title;
  final int units, sales;
  final double profit;

  const _SingleOverview(
      {Key? key,
      required this.title,
      required this.units,
      required this.sales,
      required this.profit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return MyContainer.bordered(
      color: Colors.transparent,
      borderRadiusAll: 8,
      margin: EdgeInsets.only(top: 8, bottom: 8, left: 20, right: 20),
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, bottom: 12),
            child: MyText.bodySmall(title.toUpperCase(),
                letterSpacing: 0.3, fontWeight: 600),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          MyText.titleSmall("\$",
                              color:
                                  theme.colorScheme.onBackground.withAlpha(220),
                              letterSpacing: 0.3,
                              fontWeight: 500),
                          MyText.titleLarge(sales.toString(),
                              color: theme.colorScheme.onBackground,
                              letterSpacing: 0.3,
                              fontWeight: 600)
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 2),
                          child: MyText.bodyMedium("Sales",
                              color:
                                  theme.colorScheme.onBackground.withAlpha(240),
                              letterSpacing: 0,
                              fontWeight: 500))
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  profit > 0
                      ? Icon(LucideIcons.arrowUp,
                          size: 18, color: theme.colorScheme.primary)
                      : Icon(LucideIcons.arrowDown,
                          size: 20, color: theme.colorScheme.error),
                  MyText.bodySmall(profit.abs().toStringAsFixed(2),
                      color: profit > 0
                          ? theme.colorScheme.primary
                          : theme.colorScheme.error,
                      fontWeight: 500)
                ],
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyText.titleLarge(units.toString(),
                          color: theme.colorScheme.onBackground,
                          letterSpacing: 0.3,
                          fontWeight: 600),
                      Container(
                          margin: EdgeInsets.only(top: 2),
                          child: MyText.bodyMedium("Units",
                              color:
                                  theme.colorScheme.onBackground.withAlpha(240),
                              letterSpacing: 0,
                              fontWeight: 500))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SingleOrder extends StatelessWidget {
  final String? name, code, image;

  const _SingleOrder({Key? key, this.name, this.code, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image:
                  DecorationImage(image: AssetImage(image!), fit: BoxFit.fill),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyText.bodyLarge(name!, fontWeight: 600, letterSpacing: 0),
                  MyText.bodyMedium(
                    code!,
                    fontWeight: 500,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              ClipOval(
                child: Material(
                  color: theme.colorScheme.error.withAlpha(28), // button color
                  child: InkWell(
                    splashColor: theme.colorScheme.error.withAlpha(100),
                    highlightColor: theme.colorScheme.error.withAlpha(28),
                    child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(
                          LucideIcons.x,
                          color: theme.colorScheme.error,
                        )),
                    onTap: () {},
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: ClipOval(
                  child: Material(
                    color:
                        theme.colorScheme.primary.withAlpha(28), // button color
                    child: InkWell(
                      splashColor: theme.colorScheme.primary.withAlpha(100),
                      highlightColor: theme.colorScheme.primary.withAlpha(28),
                      child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            LucideIcons.check,
                            color: theme.colorScheme.primary,
                          )),
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
