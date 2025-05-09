import 'package:sdock_fe/apps/food/food_product_screen.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FoodFavouriteScreen extends StatefulWidget {
  @override
  _FoodFavouriteScreenState createState() => _FoodFavouriteScreenState();
}

class _FoodFavouriteScreenState extends State<FoodFavouriteScreen> {
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
    return (width / 2 - 40) / ((width / 2 - 40) + 60);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: MyText.titleMedium("Favourite",
              color: theme.colorScheme.onBackground,
              letterSpacing: 0,
              fontWeight: 600),
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            GridView.count(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 16, left: 24, right: 24),
              crossAxisCount: 2,
              childAspectRatio:
                  findAspectRatio(MediaQuery.of(context).size.width),
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              children: <Widget>[
                singleFood(
                    image: './assets/images/apps/food/dessert-3.jpg',
                    name: 'Dessert',
                    price: 14.99),
                singleFood(
                    image: './assets/images/apps/food/beverage-3.jpg',
                    name: 'Beverage',
                    price: 14.99),
                singleFood(
                    image: './assets/images/apps/food/food-1.jpg',
                    name: 'Salad dish',
                    price: 16.59),
                singleFood(
                    image: './assets/images/apps/food/food-2.jpg',
                    name: 'Food dish',
                    price: 29.99),
                singleFood(
                    image: './assets/images/apps/food/food-9.jpg',
                    name: 'Pasta',
                    price: 14.99),
                singleFood(
                    image: './assets/images/apps/food/burger-2.jpg',
                    name: 'Burger',
                    price: 14.99),
                singleFood(
                    image: './assets/images/apps/food/food-3.jpg',
                    name: 'Pan Cake',
                    price: 24.29),
                singleFood(
                    image: './assets/images/apps/food/food-7.jpg',
                    name: 'Salad',
                    price: 14.99),
              ],
            ),
          ],
        ));
  }

  Widget singleFood(
      {required String image, required String name, double? price}) {
    return MyContainer.none(
      borderRadiusAll: 4,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FoodProductScreen()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(
              image: AssetImage(image),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: MySpacing.all(8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 4),
                        child: MyText.bodyLarge(name, fontWeight: 600),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2),
                        child: MyText.bodyMedium("\$$price",
                            fontWeight: 500, letterSpacing: 0),
                      )
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.heart,
                  color: theme.colorScheme.primary,
                  size: 22,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
