/*
* File : Music Queue
* Version : 1.0.0
* */

import 'dart:async';

import 'package:sdock_fe/helpers/theme/app_notifier.dart';
import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class MusicQueueScreen extends StatefulWidget {
  @override
  _MusicQueueScreenState createState() => _MusicQueueScreenState();
}

class _MusicQueueScreenState extends State<MusicQueueScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ThemeData themeData;
  bool isPlaying = false;
  Timer? _timer;
  int duration = 200, _position = 0;
  String _time = "0:00";

  final List<String> _queueChoice = [
    "Move to Top",
    "Move to Bottom",
    "Remove",
    "Download"
  ];

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

  late CustomTheme customTheme;
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
  }

  _onPlay() {
    startTimer();
  }

  _onPause() {
    _timer!.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    if (_timer != null) _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNotifier>(
      builder: (BuildContext context, AppNotifier value, Widget? child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      LucideIcons.chevronLeft,
                    ),
                  ),
                  title: MyText.titleLarge("Queue", fontWeight: 700),
                ),
                body: ListView(
                  children: <Widget>[
                    Container(
                      color: themeData.colorScheme.background,
                      padding: EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image(
                                    image: AssetImage(
                                        './assets/images/apps/music/singer-3.jpg'),
                                    fit: BoxFit.cover,
                                    height: 56,
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    MyText.titleSmall("Bed on My Mind",
                                        fontWeight: 600),
                                    MyText.bodyMedium(
                                      "Paul McCartney",
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          side: BorderSide.none),
                                      child: InkWell(
                                        splashColor:
                                            themeData.colorScheme.primary,
                                        child: SizedBox(
                                            height: 48,
                                            width: 48,
                                            child: Icon(
                                              LucideIcons.skipBack,
                                              color: themeData
                                                  .colorScheme.onBackground,
                                              size: 28,
                                            )),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(48),
                                      boxShadow: [
                                        BoxShadow(
                                            color: themeData.colorScheme.primary
                                                .withAlpha(42),
                                            spreadRadius: 1,
                                            blurRadius: 6,
                                            offset: Offset(0, 6))
                                      ]),
                                  child: ClipOval(
                                    child: Material(
                                      elevation: 5,
                                      color: themeData.colorScheme.primary,
                                      child: InkWell(
                                        splashColor: Colors.white,
                                        child: IconButton(
                                          iconSize: 28,
                                          icon: AnimatedIcon(
                                            icon: AnimatedIcons.play_pause,
                                            progress: _animationController,
                                          ),
                                          onPressed: () {
                                            if (isPlaying) {
                                              _animationController.reverse();
                                              _onPause();
                                              setState(() {
                                                isPlaying = false;
                                              });
                                            } else {
                                              _animationController.forward();
                                              _onPlay();
                                              setState(() {
                                                isPlaying = true;
                                              });
                                            }
                                          },
                                        ),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 8),
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(28),
                                          side: BorderSide.none),
                                      child: InkWell(
                                        splashColor:
                                            themeData.colorScheme.primary,
                                        child: SizedBox(
                                            height: 48,
                                            width: 48,
                                            child: Icon(
                                              LucideIcons.skipForward,
                                              color: themeData
                                                  .colorScheme.onBackground,
                                              size: 28,
                                            )),
                                        onTap: () {},
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 8),
                            child: Row(
                              children: <Widget>[
                                ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    // button color
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        side: BorderSide.none),
                                    child: InkWell(
                                      splashColor:
                                          themeData.colorScheme.primary,
                                      // inkwell color
                                      child: SizedBox(
                                          height: 36,
                                          width: 36,
                                          child: Icon(
                                            LucideIcons.shuffle,
                                            color: themeData
                                                .colorScheme.onBackground,
                                          )),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: MyText.bodySmall(_time,
                                        fontWeight: 600)),
                                Expanded(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 2.5,
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
                                    child: MyText.bodySmall("3:20",
                                        fontWeight: 600)),
                                ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    // button color
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                        side: BorderSide.none),
                                    child: InkWell(
                                      splashColor:
                                          themeData.colorScheme.primary,
                                      // inkwell color
                                      child: SizedBox(
                                          height: 36,
                                          width: 36,
                                          child: Icon(
                                            LucideIcons.volume1,
                                            color: themeData
                                                .colorScheme.onBackground,
                                          )),
                                      onTap: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(24),
                      child: MyText.titleSmall("Up Next", fontWeight: 700),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 24, right: 16),
                      child: Column(
                        children: <Widget>[
                          _SingleQueueWidget(
                            image: './assets/images/apps/music/singer-2.jpg',
                            name: 'Queue two',
                            singer: 'Singer - 2',
                            choice: _queueChoice,
                          ),
                          Divider(),
                          _SingleQueueWidget(
                            image: './assets/images/apps/music/singer-1.jpg',
                            name: 'Queue three',
                            singer: 'Singer - 3',
                            choice: _queueChoice,
                          ),
                          Divider(),
                          _SingleQueueWidget(
                            image: './assets/images/apps/music/singer-4.jpg',
                            name: 'Queue four',
                            singer: 'Singer - 4',
                            choice: _queueChoice,
                          ),
                          Divider(),
                          _SingleQueueWidget(
                            image: './assets/images/apps/music/event-1.jpg',
                            name: 'Queue five',
                            singer: 'Singer - 5',
                            choice: _queueChoice,
                          ),
                        ],
                      ),
                    )
                  ],
                )));
      },
    );
  }
}

class _SingleQueueWidget extends StatelessWidget {
  final String image, name, singer;

  final List<String> choice;

  const _SingleQueueWidget(
      {Key? key,
      required this.image,
      required this.name,
      required this.singer,
      required this.choice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 2, bottom: 2),
      child: Row(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
                height: 56,
                width: 56,
              )),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyText.bodyLarge(name, fontWeight: 600),
                  MyText.titleSmall(
                    singer,
                  )
                ],
              ),
            ),
          ),
          ClipOval(
            child: Material(
              color: themeData.colorScheme.primary.withAlpha(16),
              child: InkWell(
                splashColor: themeData.colorScheme.primary.withAlpha(100),
                // inkwell color
                child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(
                      LucideIcons.heart,
                      color: themeData.colorScheme.primary,
                      size: 20,
                    )),
                onTap: () {},
              ),
            ),
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return choice.map((String choice) {
                return PopupMenuItem(
                  value: choice,
                  child: MyText.bodyMedium(
                    choice,
                  ),
                );
              }).toList();
            },
            icon: Icon(
              LucideIcons.moreVertical,
              color: themeData.colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
