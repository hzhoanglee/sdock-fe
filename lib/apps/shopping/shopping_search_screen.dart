import 'package:sdock_fe/apps/shopping/shopping_product_screen.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/utils/generator.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_star_rating.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:sdock_fe/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ShoppingSearchScreen extends StatefulWidget {
  final BuildContext rootContext;

  const ShoppingSearchScreen({Key? key, required this.rootContext})
      : super(key: key);

  @override
  _ShoppingSearchScreenState createState() => _ShoppingSearchScreenState();
}

class _ShoppingSearchScreenState extends State<ShoppingSearchScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  double findAspectRatio(double width) {
    //Logic for aspect ratio of grid view
    return (width / 2 - 24) / ((width / 2 - 24) + 74);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      tag: 'shopping_search_screen',
      builder: (controller) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            key: _scaffoldKey,
            endDrawer: _EndDrawer(
              scaffoldKey: _scaffoldKey,
            ),
            body: ListView(
              padding: MySpacing.fromLTRB(
                  20, MySpacing.safeAreaTop(context) + 20, 20, 0),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        style: MyTextStyle.titleSmall(
                            letterSpacing: 0, fontWeight: 500),
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: MyTextStyle.titleSmall(
                              letterSpacing: 0, fontWeight: 500),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4),
                              ),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: theme.colorScheme.background,
                          prefixIcon: Icon(
                            LucideIcons.search,
                            size: 22,
                            color:
                                theme.colorScheme.onBackground.withAlpha(150),
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.only(right: 16),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                    ),
                    MySpacing.width(20),
                    MyContainer.bordered(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext buildContext) {
                              return SortBottomSheet();
                            });
                      },
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        LucideIcons.arrowUpDown,
                        color: theme.colorScheme.primary,
                        size: 22,
                      ),
                    ),
                    MySpacing.width(20),
                    MyContainer.bordered(
                      onTap: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      padding: EdgeInsets.all(12),
                      child: Icon(
                        LucideIcons.slidersHorizontal,
                        color: theme.colorScheme.primary,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: MySpacing.y(20),
                  child: MyText.bodyMedium("Result for \"Cosmetics\"",
                      fontWeight: 600),
                ),
                GridView.count(
                    padding: MySpacing.zero,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio:
                        findAspectRatio(MediaQuery.of(context).size.width),
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: <Widget>[
                      _ProductListWidget(
                        name: "Yellow cake",
                        image:
                            './assets/images/apps/shopping/product/product-1.jpg',
                        shopName: 'Agus Bakery',
                        star: 4,
                        price: 15000,
                        rootContext: widget.rootContext,
                      ),
                      _ProductListWidget(
                        name: "Cosmic bang",
                        image:
                            './assets/images/apps/shopping/product/product-7.jpg',
                        shopName: 'Den cosmics',
                        star: 4.5,
                        price: 12000,
                        rootContext: widget.rootContext,
                      ),
                      _ProductListWidget(
                        name: "Sweet Gems",
                        image:
                            './assets/images/apps/shopping/product/product-5.jpg',
                        shopName: 'El Primo',
                        star: 3,
                        price: 14700,
                        rootContext: widget.rootContext,
                      ),
                      _ProductListWidget(
                        name: "Lipsticks",
                        image:
                            './assets/images/apps/shopping/product/product-3.jpg',
                        shopName: 'Bee Lipstore',
                        star: 4,
                        price: 14785,
                        rootContext: widget.rootContext,
                      ),
                      _ProductListWidget(
                        name: "Colorful sandal",
                        image:
                            './assets/images/apps/shopping/product/product-8.jpg',
                        shopName: 'Lee Shop',
                        star: 3.8,
                        price: 14780,
                        rootContext: widget.rootContext,
                      ),
                      _ProductListWidget(
                        name: "Toffees",
                        image:
                            './assets/images/apps/shopping/product/product-2.jpg',
                        shopName: 'Toffee Bakery',
                        star: 5,
                        price: 12500,
                        rootContext: widget.rootContext,
                      ),
                    ]),
              ],
            ));
      },
    );
  }
}

class SortBottomSheet extends StatefulWidget {
  @override
  _SortBottomSheetState createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  int _radioValue = 0;
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
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Padding(
          padding: EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 8),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        setState(() {
                          _radioValue = 0;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (dynamic value) {
                              setState(() {
                                _radioValue = 0;
                              });
                            },
                            groupValue: _radioValue,
                            value: 0,
                            visualDensity: VisualDensity.compact,
                            activeColor: theme.colorScheme.primary,
                          ),
                          MyText.titleSmall("Price - ", fontWeight: 600),
                          MyText.titleSmall("High to Low", fontWeight: 500),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _radioValue = 1;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (dynamic value) {
                              setState(() {
                                _radioValue = 1;
                              });
                            },
                            groupValue: _radioValue,
                            value: 1,
                            visualDensity: VisualDensity.compact,
                            activeColor: theme.colorScheme.primary,
                          ),
                          MyText.titleSmall("Price - ", fontWeight: 600),
                          MyText.titleSmall("Low to High", fontWeight: 500),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _radioValue = 2;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (dynamic value) {
                              setState(() {
                                _radioValue = 2;
                              });
                            },
                            groupValue: _radioValue,
                            value: 2,
                            visualDensity: VisualDensity.compact,
                            activeColor: theme.colorScheme.primary,
                          ),
                          MyText.titleSmall("Name - ", fontWeight: 600),
                          MyText.titleSmall("A to Z", fontWeight: 500),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _radioValue = 3;
                        });
                      },
                      child: Row(
                        children: <Widget>[
                          Radio(
                            onChanged: (dynamic value) {
                              setState(() {
                                _radioValue = 3;
                              });
                            },
                            groupValue: _radioValue,
                            value: 3,
                            visualDensity: VisualDensity.compact,
                            activeColor: theme.colorScheme.primary,
                          ),
                          MyText.titleSmall("Name - ", fontWeight: 600),
                          MyText.titleSmall("Z to A", fontWeight: 500),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductListWidget extends StatefulWidget {
  final String name, image, shopName;
  final double star;
  final int price;
  final BuildContext rootContext;

  const _ProductListWidget(
      {Key? key,
      required this.name,
      required this.image,
      required this.shopName,
      required this.star,
      required this.price,
      required this.rootContext})
      : super(key: key);

  @override
  __ProductListWidgetState createState() => __ProductListWidgetState();
}

class __ProductListWidgetState extends State<_ProductListWidget> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    String key = Generator.randomString(10);
    theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            widget.rootContext,
            MaterialPageRoute(
                builder: (context) => ShoppingProductScreen(
                      heroTag: key,
                      image: widget.image,
                    )));
      },
      child: MyContainer.bordered(
        color: Colors.transparent,
        paddingAll: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: key,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    child: Image.asset(
                      widget.image,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    right: 8,
                    top: 8,
                    child: Icon(
                      LucideIcons.heart,
                      color: theme.colorScheme.onBackground.withAlpha(160),
                      size: 20,
                    ))
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MyText.bodyLarge(widget.name,
                      fontWeight: 700, letterSpacing: 0),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        MyStarRating(
                            rating: widget.star,
                            size: 16,
                            activeColor: Color(0xffffd208),
                            inactiveColor: theme.colorScheme.onBackground),
                        Container(
                          margin: EdgeInsets.only(left: 4),
                          child: MyText.bodyMedium(widget.star.toString(),
                              fontWeight: 600),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    child: MyText.bodyMedium("\$ ${widget.price}",
                        fontWeight: 700, letterSpacing: 0),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EndDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const _EndDrawer({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  __EndDrawerState createState() => __EndDrawerState();
}

class __EndDrawerState extends State<_EndDrawer> {
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      color: theme.colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 24),
              alignment: Alignment.center,
              child: Center(
                child: MyText.titleMedium("FILTER",
                    fontWeight: 700, color: theme.colorScheme.primary),
              )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: _CategoryDrawerWidget()),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: MyText.bodyLarge("Rating",
                    fontWeight: 600, letterSpacing: 0),
              ),
              Container(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                  child: _RatingDrawerWidget()),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: MyText.bodyLarge("Price Range",
                    fontWeight: 600, letterSpacing: 0),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 0),
                child: _PriceRangeDrawerWidget(),
              ),
              Container(
                margin: EdgeInsets.all(24),
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withAlpha(24),
                        blurRadius: 3,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(MySpacing.xy(16, 0))),
                    child: MyText.bodyMedium("APPLY",
                        fontWeight: 600,
                        color: theme.colorScheme.onPrimary,
                        letterSpacing: 0.3),
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

class _CategoryDrawerWidget extends StatefulWidget {
  final List<String> reportList = [
    "Men",
    "Women",
    "Sale",
    "Food",
    "Other",
  ];

  @override
  _CategoryDrawerWidgetState createState() => _CategoryDrawerWidgetState();
}

class _CategoryDrawerWidgetState extends State<_CategoryDrawerWidget> {
  List<String> selectedChoices = ["Women", "Food"];

  late ThemeData theme;

  _buildChoiceList() {
    List<Widget> choices = [];
    for (var item in widget.reportList) {
      choices.add(Container(
        padding: EdgeInsets.all(6),
        child: ChoiceChip(
          backgroundColor: theme.colorScheme.background,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          selectedColor: theme.colorScheme.primary,
          label: MyText.bodyMedium(item,
              color: selectedChoices.contains(item)
                  ? theme.colorScheme.onSecondary
                  : theme.colorScheme.onBackground,
              fontWeight: selectedChoices.contains(item) ? 700 : 500),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
            });
          },
        ),
      ));
    }
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class _RatingDrawerWidget extends StatefulWidget {
  @override
  _RatingDrawerWidgetState createState() => _RatingDrawerWidgetState();
}

class _RatingDrawerWidgetState extends State<_RatingDrawerWidget> {
  final List<bool?> _star = [false, true, true, true, true];

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: _star.length,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              setState(() {
                _star[index] = _star[index];
              });
            },
            child: Row(
              children: <Widget>[
                Checkbox(
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: _star[index],
                  activeColor: theme.colorScheme.primary,
                  onChanged: (bool? value) {
                    setState(() {
                      _star[index] = value;
                    });
                  },
                ),
                Container(
                    margin: EdgeInsets.only(left: 4),
                    child: MyStarRating(
                        rating: (index + 1).toDouble(),
                        inactiveColor: theme.colorScheme.onBackground))
              ],
            ),
          );
        });
  }
}

class _PriceRangeDrawerWidget extends StatefulWidget {
  @override
  _PriceRangeDrawerWidgetState createState() => _PriceRangeDrawerWidgetState();
}

class _PriceRangeDrawerWidgetState extends State<_PriceRangeDrawerWidget> {
  double _starValue = 10;
  double _endValue = 80;
  final double _multiFactor = 1500;
  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Column(
      children: <Widget>[
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 3,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
          ),
          child: RangeSlider(
            values: RangeValues(_starValue, _endValue),
            min: 0.0,
            max: 100.0,
            onChanged: (values) {
              setState(() {
                _starValue = values.start.roundToDouble();
                _endValue = values.end.roundToDouble();
              });
            },
          ),
        ),
        MyText.bodyMedium(
            "${(_starValue * _multiFactor).floor()} - ${(_endValue * _multiFactor).floor()}",
            fontWeight: 500)
      ],
    );
  }
}
