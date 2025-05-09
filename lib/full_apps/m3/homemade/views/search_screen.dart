import 'package:sdock_fe/loading_effect.dart';
import 'package:sdock_fe/full_apps/m3/homemade/controllers/search_controller.dart';
import 'package:sdock_fe/full_apps/m3/homemade/models/product.dart';
import 'package:sdock_fe/full_apps/m3/homemade/views/single_product_screen.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_card.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:sdock_fe/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ThemeData theme;

  late SearchController searchController;

  @override
  void initState() {
    super.initState();
    searchController = SearchController();
    theme = AppTheme.homemadeTheme;
  }

  Widget _buildSingleProduct(Product product) {
    return MyCard(
        paddingAll: 0,
        borderRadiusAll: 8,
        clipBehavior: Clip.hardEdge,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SingleProductScreen()),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                Image.asset(
                  product.url,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  height: 140,
                ),
              ],
            ),
            MyContainer(
              paddingAll: 8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.titleSmall(product.name, fontWeight: 500),
                  MySpacing.height(4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      MyText.bodySmall("Rs. ${product.price}", fontWeight: 700),
                      MyContainer(
                        color: theme.colorScheme.secondary.withAlpha(36),
                        padding:
                            MySpacing.symmetric(horizontal: 6, vertical: 4),
                        borderRadiusAll: 4,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              LucideIcons.star,
                              color: theme.colorScheme.secondary,
                              size: 10,
                            ),
                            MySpacing.width(4),
                            MyText.bodySmall(product.rating.toString(),
                                fontSize: 10,
                                color: theme.colorScheme.secondary,
                                fontWeight: 600),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  List<Widget> _buildProductList() {
    List<Widget> list = [];

    for (Product product in searchController.products) {
      list.add(_buildSingleProduct(product));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
        init: searchController,
        tag: 'search_controller',
        builder: (searchController) {
          return _buildBody();
        });
  }

  Widget _buildBody() {
    if (searchController.uiLoading) {
      return Container(
          margin: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
          child: LoadingEffect.getSearchLoadingScreen(
            context,
          ));
    } else {
      return Scaffold(
        key: searchController.scaffoldKey,
        endDrawer: _endDrawer(),
        body: ListView(
          padding: MySpacing.fromLTRB(24, 44, 24, 0),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: searchController.searchEditingController,
                    style: MyTextStyle.bodyMedium(
                        color: theme.colorScheme.onPrimaryContainer),
                    cursorColor: theme.colorScheme.onPrimaryContainer,
                    decoration: InputDecoration(
                      hintText: "Search your product",
                      hintStyle: MyTextStyle.bodyMedium(
                          color: theme.colorScheme.onPrimaryContainer),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: theme.colorScheme.primaryContainer,
                      prefixIcon: Icon(
                        LucideIcons.search,
                        size: 20,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.only(right: 16),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                MySpacing.width(16),
                MyContainer.bordered(
                    onTap: () {
                      searchController.openEndDrawer();
                    },
                    color: theme.colorScheme.secondary.withAlpha(28),
                    border: Border.all(
                        color: theme.colorScheme.secondary.withAlpha(120)),
                    borderRadiusAll: 8,
                    paddingAll: 13,
                    child: Icon(
                      LucideIcons.sliders,
                      color: theme.colorScheme.secondary,
                      size: 18,
                    )),
              ],
            ),
            GridView.count(
              padding: MySpacing.fromLTRB(0, 16, 0, 84),
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: searchController
                  .findAspectRatio(MediaQuery.of(context).size.width),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: _buildProductList(),
            ),
          ],
        ),
      );
    }
  }

  Widget _endDrawer() {
    return SafeArea(
      child: Container(
        margin: MySpacing.fromLTRB(16, 16, 16, 80),
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: theme.cardTheme.color,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Drawer(
          child: Container(
            color: theme.cardTheme.color,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: MySpacing.xy(16, 12),
                  color: theme.colorScheme.primary,
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: MyText(
                            "Filter",
                            fontWeight: 700,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                      MyContainer.rounded(
                          onTap: () {
                            searchController.closeEndDrawer();
                          },
                          paddingAll: 6,
                          color: theme.colorScheme.onPrimary.withAlpha(80),
                          child: Icon(
                            LucideIcons.x,
                            size: 12,
                            color: theme.colorScheme.onPrimary,
                          ))
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                  padding: MySpacing.all(16),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.bodyMedium(
                          "Type",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 600,
                        ),
                        MyText.bodySmall(
                          "${searchController.selectedChoices.length} selected",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 600,
                          xMuted: true,
                        ),
                      ],
                    ),
                    MySpacing.height(16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _buildType(),
                    ),
                    MySpacing.height(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.bodyMedium(
                          "Price Range",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 600,
                        ),
                        MyText.bodySmall(
                          "\$${searchController.selectedRange.start.toInt()} - \$${searchController.selectedRange.end.toInt()}",
                          color: theme.colorScheme.secondary,
                          fontWeight: 600,
                          letterSpacing: 0.35,
                        )
                      ],
                    ),
                    MySpacing.height(16),
                    RangeSlider(
                        activeColor: theme.colorScheme.primary,
                        inactiveColor:
                            theme.colorScheme.secondary.withAlpha(100),
                        max: 10000,
                        min: 0,
                        values: searchController.selectedRange,
                        onChanged: (RangeValues newRange) {
                          searchController.onChangePriceRange(newRange);
                        }),
                  ],
                )),
                Row(
                  children: [
                    Expanded(
                        child: MyContainer(
                      onTap: () {
                        searchController.closeEndDrawer();
                      },
                      padding: MySpacing.y(12),
                      child: Center(
                        child: MyText(
                          "Clear",
                          color: theme.colorScheme.secondary,
                          fontWeight: 600,
                        ),
                      ),
                    )),
                    Expanded(
                        child: MyContainer.none(
                      onTap: () {
                        searchController.closeEndDrawer();
                      },
                      padding: MySpacing.y(12),
                      color: theme.colorScheme.primary,
                      child: Center(
                        child: MyText(
                          "Apply",
                          color: theme.colorScheme.onPrimary,
                          fontWeight: 600,
                        ),
                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildType() {
    List<String> categoryList = [
      "ECom",
      "Automobile",
      "Crimes",
      "Business",
      "Fitness",
      "Astro",
      "Politics",
      "Relationship",
      "Food",
      "Electronics",
      "Health",
      "Tech",
      "Entertainment",
      "World",
      "Sports",
      "Other",
    ];

    List<Widget> choices = [];
    for (var item in categoryList) {
      bool selected = searchController.selectedChoices.contains(item);
      if (selected) {
        choices.add(MyContainer.none(
            color: theme.colorScheme.primary.withAlpha(28),
            bordered: true,
            borderRadiusAll: 12,
            paddingAll: 8,
            border: Border.all(color: theme.colorScheme.primary),
            onTap: () {
              searchController.removeChoice(item);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check,
                  size: 14,
                  color: theme.colorScheme.primary,
                ),
                MySpacing.width(6),
                MyText.bodySmall(
                  item,
                  fontSize: 11,
                  color: theme.colorScheme.primary,
                )
              ],
            )));
      } else {
        choices.add(MyContainer.none(
          // color: theme.colorScheme.border,
          borderRadiusAll: 12,
          padding: MySpacing.xy(12, 8),
          onTap: () {
            searchController.addChoice(item);
          },
          child: MyText.labelSmall(
            item,
            color: theme.colorScheme.onBackground,
            fontSize: 11,
          ),
        ));
      }
    }
    return choices;
  }
}
