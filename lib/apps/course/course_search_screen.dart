import 'package:sdock_fe/apps/course/course_details_screen.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_container.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:sdock_fe/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CourseSearchScreen extends StatefulWidget {
  @override
  _CourseSearchScreenState createState() => _CourseSearchScreenState();
}

class _CourseSearchScreenState extends State<CourseSearchScreen> {
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
    return (width / 2 - 24) / ((width / 2 - 24) + 40);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          padding: MySpacing.top(MySpacing.safeAreaTop(context) + 20),
          children: <Widget>[
            Container(
              margin: MySpacing.horizontal(24),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MyContainer(
                      borderRadiusAll: 4,
                      padding: MySpacing.all(6),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 16),
                              child: TextField(
                                style: MyTextStyle.bodyMedium(
                                    letterSpacing: 0,
                                    color: theme.colorScheme.onBackground,
                                    fontWeight: 500),
                                decoration: InputDecoration(
                                  fillColor: customTheme.card,
                                  hintText: "Search courses skills and videos",
                                  hintStyle: MyTextStyle.bodySmall(
                                      letterSpacing: 0,
                                      color: theme.colorScheme.onBackground,
                                      fontWeight: 500),
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
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(0),
                                ),
                                textInputAction: TextInputAction.search,
                                textCapitalization:
                                    TextCapitalization.sentences,
                              ),
                            ),
                          ),
                          MyContainer.none(
                            paddingAll: 6,
                            color: theme.colorScheme.primary,
                            borderRadiusAll: 4,
                            child: Icon(
                              LucideIcons.search,
                              color: theme.colorScheme.onPrimary,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  MyContainer.bordered(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext buildContext) {
                            return FilterWidget();
                          });
                    },
                    margin: EdgeInsets.only(left: 16),
                    borderRadiusAll: 4,
                    color: Colors.transparent,
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      LucideIcons.slidersHorizontal,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: MySpacing.fromLTRB(20, 20, 0, 0),
              child: MyText.titleMedium("Category",
                  color: theme.colorScheme.onBackground, fontWeight: 700),
            ),
            Container(
              margin: MySpacing.fromLTRB(20, 20, 24, 0),
              child: GridView.count(
                physics: ClampingScrollPhysics(),
                padding: MySpacing.zero,
                crossAxisCount: 2,
                shrinkWrap: true,
                childAspectRatio: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: <Widget>[
                  singleCategory(
                      title: "UI",
                      image: './assets/images/apps/course/subject-1.jpg',
                      courses: 25),
                  singleCategory(
                      title: "Business",
                      image: './assets/images/apps/course/subject-2.jpg',
                      courses: 80),
                  singleCategory(
                      title: "Lifestyle",
                      image: './assets/images/apps/course/subject-3.jpg',
                      courses: 120),
                  singleCategory(
                      title: "Marketing",
                      image: './assets/images/apps/course/subject-4.jpg',
                      courses: 50),
                  singleCategory(
                      title: "UX",
                      image: './assets/images/apps/course/subject-5.jpg',
                      courses: 145),
                  singleCategory(
                      title: "Social",
                      image: './assets/images/apps/course/subject-6.jpg',
                      courses: 15),
                ],
              ),
            ),
            Container(
              margin: MySpacing.fromLTRB(20, 20, 20, 0),
              child: MyText.titleMedium("Recommended",
                  color: theme.colorScheme.onBackground, fontWeight: 700),
            ),
            GridView.count(
              physics: ClampingScrollPhysics(),
              crossAxisCount: 2,
              shrinkWrap: true,
              padding: MySpacing.all(20),
              childAspectRatio:
                  findAspectRatio(MediaQuery.of(context).size.width),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: <Widget>[
                singleResult(
                    title: "React",
                    image: "./assets/images/apps/course/subject-1.jpg",
                    price: 148),
                singleResult(
                    title: "Flutter",
                    image: "./assets/images/apps/course/subject-2.jpg",
                    price: 259),
                singleResult(
                    title: "Web",
                    image: "./assets/images/apps/course/subject-6.jpg",
                    price: 59),
                singleResult(
                    title: "UI / UX",
                    image: "./assets/images/apps/course/subject-4.jpg",
                    price: 99),
                singleResult(
                    title: "React Native",
                    image: "./assets/images/apps/course/subject-5.jpg",
                    price: 59),
              ],
            )
          ],
        ));
  }

  Widget singleResult(
      {required String title, required String image, int? price}) {
    return MyContainer.none(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CourseDetailsScreen()));
      },
      borderRadiusAll: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                child: Image(
                  image: AssetImage(image),
                ),
              ),
              Container(
                padding: MySpacing.fromLTRB(12, 6, 12, 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(240),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                child: MyText.titleSmall("\$ $price",
                    color: theme.colorScheme.onPrimary, fontWeight: 500),
              )
            ],
          ),
          Container(
            margin: MySpacing.all(8),
            child: MyText.bodyLarge(
              title,
              fontWeight: 600,
              color: theme.colorScheme.onBackground,
            ),
          )
        ],
      ),
    );
  }

  Widget singleCategory(
      {required String image, required String title, int? courses}) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CourseDetailsScreen()));
      },
      child: MyContainer.bordered(
        paddingAll: 0,
        child: Row(
          children: <Widget>[
            Container(
              margin: MySpacing.left(16),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  child: Image(
                    image: AssetImage(image),
                    height: 44,
                    width: 44,
                  )),
            ),
            Container(
              margin: MySpacing.horizontal(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  MyText.bodyMedium(title,
                      color: theme.colorScheme.onBackground, fontWeight: 600),
                  MyText.labelSmall("$courses+ Courses",
                      color: theme.colorScheme.onBackground,
                      letterSpacing: 0,
                      fontWeight: 500,
                      muted: true)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late CustomTheme customTheme;
  late ThemeData theme;

  late List<String> _course,
      _selectedCourse,
      _duration,
      _selectedDuration,
      _type,
      _selectedType;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;

    _course = [
      "Physics",
      "Biology",
      "Computer",
      "Maths",
      "Chemistry",
      "Economics",
      "Sport",
      "History",
      "English",
      "Art"
    ];

    _duration = ["1-2 Week", "3-4 Week", "2 Month", "3 Month"];
    _type = ["Beginner", "Intermediate", "Advanced", "Expert"];

    _selectedCourse = ["Maths"];
    _selectedDuration = ["3-4 Week"];
    _selectedType = ["Intermediate"];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> courseWidget = [], durationWidget = [], typeWidget = [];
    int i = 0;
    for (i = 0; i < _course.length; i++) {
      courseWidget.add(InkWell(
        onTap: () {
          setState(() {
            if (_selectedCourse.contains(_course[i])) {
              _selectedCourse.remove(_course[i]);
            } else {
              _selectedCourse.add(_course[i]);
            }
          });
        },
        child: optionCourseChip(
            option: _course[i],
            isSelected: _selectedCourse.contains(_course[i])),
      ));
    }

    for (i = 0; i < _duration.length; i++) {
      durationWidget.add(InkWell(
        onTap: () {
          setState(() {
            if (_selectedDuration.contains(_duration[i])) {
              _selectedDuration.remove(_duration[i]);
            } else {
              _selectedDuration.add(_duration[i]);
            }
          });
        },
        child: optionDurationChip(
            isSelected: _selectedDuration.contains(_duration[i]),
            option: _duration[i]),
      ));
    }
    for (i = 0; i < _type.length; i++) {
      typeWidget.add(optionTypeChip(
          isSelected: _selectedType.contains(_type[i]), option: _type[i]));
    }

    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        child: Padding(
          padding: EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 16),
          child: ListView(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: MyText.titleMedium("Filter",
                          color: theme.colorScheme.onBackground,
                          fontWeight: 700),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: MySpacing.all(6),
                      decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withAlpha(40),
                          shape: BoxShape.circle),
                      child: Icon(
                        LucideIcons.check,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: MySpacing.top(24),
                child: MyText.titleSmall("Course",
                    color: theme.colorScheme.onBackground, fontWeight: 600),
              ),
              Container(
                margin: MySpacing.top(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: courseWidget,
                ),
              ),
              Container(
                margin: MySpacing.top(24),
                child: MyText.titleSmall("Type",
                    color: theme.colorScheme.onBackground, fontWeight: 600),
              ),
              Container(
                margin: MySpacing.top(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: typeWidget,
                ),
              ),
              Container(
                margin: MySpacing.top(24),
                child: MyText.titleSmall("Duration",
                    color: theme.colorScheme.onBackground, fontWeight: 600),
              ),
              Container(
                margin: MySpacing.top(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 12,
                  children: durationWidget,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget optionCourseChip({required String option, required bool isSelected}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_selectedCourse.contains(option)) {
            _selectedCourse.remove(option);
          } else {
            _selectedCourse.add(option);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            border: Border.all(
                color:
                    isSelected ? theme.colorScheme.primary : customTheme.border,
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        padding: MySpacing.fromLTRB(10, 6, 10, 6),
        child: MyText.bodyMedium(option,
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onBackground),
      ),
    );
  }

  Widget optionTypeChip({required String option, required bool isSelected}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_selectedType.contains(option)) {
            _selectedType.remove(option);
          } else {
            _selectedType.add(option);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            border: Border.all(
                color:
                    isSelected ? theme.colorScheme.primary : customTheme.border,
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        padding: MySpacing.fromLTRB(10, 6, 10, 6),
        child: MyText.bodyMedium(option,
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onBackground),
      ),
    );
  }

  Widget optionDurationChip(
      {required String option, required bool isSelected}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_selectedDuration.contains(option)) {
            _selectedDuration.remove(option);
          } else {
            _selectedDuration.add(option);
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            border: Border.all(
                color:
                    isSelected ? theme.colorScheme.primary : customTheme.border,
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        padding: MySpacing.fromLTRB(10, 6, 10, 6),
        child: MyText.bodyMedium(option,
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onBackground),
      ),
    );
  }
}
