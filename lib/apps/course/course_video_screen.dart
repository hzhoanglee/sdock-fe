import 'dart:async';

import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CourseVideoScreen extends StatefulWidget {
  @override
  _CourseVideoScreenState createState() => _CourseVideoScreenState();
}

class _CourseVideoScreenState extends State<CourseVideoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    startTimer();
  }

  bool isPlaying = false;

  Timer? _timer;
  int duration = 200, repeatType = 0;
  int _position = 0;
  String _time = "0:00";

  convertTime() {
    int hour = (_position / 3600).floor();
    int minute = ((_position - 3600 * hour) / 60).floor();
    int second = (_position - 3600 * hour - 60 * minute);
    String time = "";
    if (second < 10) {
      time += "$minute:0$second";
    } else {
      time += "$minute:$second";
    }

    setState(() {
      _time = time;
    });
  }

  _onTrackDurationChange(double value) {
    setState(() {
      _position = value.floor();
    });
    convertTime();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_position >= (duration - 1)) {
            timer.cancel();
            _position += 1;
            convertTime();
            isPlaying = false;
            _animationController.reverse();
          } else {
            _position += 1;
            convertTime();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    if (_timer != null) _timer!.cancel();
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
              color: theme.colorScheme.onBackground,
              size: 24,
            ),
          ),
          title: MyText.bodyLarge("UI - Intro",
              color: theme.colorScheme.onBackground, fontWeight: 600),
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: customTheme.card,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              padding: MySpacing.fromLTRB(24, 0, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: const <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: Image(
                              image: AssetImage(
                                  './assets/images/apps/course/class-l1.jpg'))),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Icon(
                          LucideIcons.crop,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 16),
                          child: MyText.bodySmall(_time, fontWeight: 500)),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2.5,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 7),
                          ),
                          child: Slider(
                            value: _position.toDouble(),
                            onChanged: _onTrackDurationChange,
                            min: 0,
                            max: duration.toDouble(),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(right: 16),
                          child: MyText.bodySmall("3:20", fontWeight: 500)),
                    ],
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: customTheme.card,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              padding: MySpacing.fromLTRB(24, 16, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyText.bodyMedium(
                                "1.0 Introduction of UI Designing",
                                color: theme.colorScheme.onBackground,
                                fontWeight: 600),
                            Container(
                              margin: MySpacing.top(4),
                              child: MyText.bodySmall(
                                  "120 Views  \u2022  20 mins ago",
                                  color: theme.colorScheme.onBackground,
                                  fontWeight: 500,
                                  muted: true),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        LucideIcons.chevronDown,
                        color: theme.colorScheme.onBackground,
                      )
                    ],
                  ),
                  Container(
                    margin: MySpacing.top(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Icon(
                              LucideIcons.thumbsUp,
                              color: theme.colorScheme.primary,
                              size: 22,
                            ),
                            MyText.bodySmall("16 Likes",
                                fontSize: 12,
                                color: theme.colorScheme.primary,
                                fontWeight: 600,
                                letterSpacing: 0)
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              LucideIcons.messageSquare,
                              color: theme.colorScheme.onBackground,
                              size: 22,
                            ),
                            MyText.bodySmall("Comment",
                                color: theme.colorScheme.onBackground,
                                fontWeight: 500,
                                fontSize: 12,
                                letterSpacing: 0)
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Icon(
                              LucideIcons.download,
                              color: theme.colorScheme.onBackground,
                              size: 24,
                            ),
                            MyText.bodySmall("Download",
                                color: theme.colorScheme.onBackground,
                                fontWeight: 500,
                                letterSpacing: 0)
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  padding: MySpacing.fromLTRB(24, 16, 24, 0),
                  children: <Widget>[
                    MyText.bodyLarge("Next",
                        color: theme.colorScheme.onBackground, fontWeight: 600),
                    Container(
                      margin: MySpacing.top(16),
                      child: singleLecture(
                          time: "6:21", title: "Intro", info: "Start intro"),
                    ),
                    Container(
                      margin: MySpacing.top(16),
                      child: singleLecture(
                          time: "12:15",
                          title: "Lesson 1",
                          info: "Question type 1"),
                    ),
                    Container(
                      margin: MySpacing.top(16),
                      child: singleLecture(
                          time: "10:30",
                          title: "Lesson 2",
                          info: "Question type 2"),
                    ),
                    Container(
                      margin: MySpacing.top(16),
                      child: singleLecture(
                          time: "22:48",
                          title: "Lesson 3",
                          info: "Question type 3"),
                    ),
                    Container(
                      margin: MySpacing.top(24),
                      child: Center(
                        child: MyText.bodySmall("show all".toUpperCase(),
                            color: theme.colorScheme.primary, fontWeight: 600),
                      ),
                    )
                  ]),
            ),
          ],
        ));
  }

  Widget singleLecture(
      {required String title, required String info, required String time}) {
    return Row(
      children: <Widget>[
        Container(
          padding: MySpacing.all(10),
          decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(40),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Icon(
            LucideIcons.play,
            color: theme.colorScheme.primary,
          ),
        ),
        Expanded(
          child: Container(
            margin: MySpacing.left(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyText.bodyLarge(title,
                    color: theme.colorScheme.onBackground, fontWeight: 600),
                MyText.bodyMedium(info,
                    color: theme.colorScheme.onBackground,
                    fontWeight: 500,
                    muted: true),
              ],
            ),
          ),
        ),
        MyText.bodyMedium(time,
            color: theme.colorScheme.onBackground, muted: true, fontWeight: 600)
      ],
    );
  }
}
