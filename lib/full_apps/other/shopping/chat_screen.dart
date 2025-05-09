import 'dart:async';
import 'dart:math';

import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:sdock_fe/helpers/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomChatTheme {
  late Color backgroundColor,
      textFieldBackground,
      textOnTextField,
      hintTextOnTextField,
      iconOnTextField,
      btnColor,
      iconOnBtn,
      myChatBG,
      chatBG,
      onMyChat,
      onChat,
      appBarColor,
      onAppBar,
      onBackground,
      tickColor;

  static CustomChatTheme getWhatsAppTheme() {
    CustomChatTheme customChatTheme = CustomChatTheme();
    customChatTheme.backgroundColor = const Color(0xff343940);
    customChatTheme.textFieldBackground = const Color(0xff37404a);
    customChatTheme.textOnTextField = const Color(0xffebebeb);
    customChatTheme.hintTextOnTextField = const Color(0xffc2c2c2);
    customChatTheme.iconOnTextField = const Color(0xffb3b3b3);
    customChatTheme.btnColor = const Color(0xff01877c);
    customChatTheme.iconOnBtn = const Color(0xffebebeb);
    customChatTheme.myChatBG = const Color(0xff054640);
    customChatTheme.chatBG = const Color(0xff212e36);
    customChatTheme.onMyChat = const Color(0xfff5f5f5);
    customChatTheme.onChat = const Color(0xfff5f5f5);
    customChatTheme.appBarColor = const Color(0xff2e343b);
    customChatTheme.onAppBar = Colors.white;
    customChatTheme.onBackground = const Color(0xfff5f5f5);
    customChatTheme.tickColor = const Color(0xff33a3ca);

    return customChatTheme;
  }
}

class ChatModel {
  String message, from, timestamp, seenType;

  static const String myId = "myId";
  static const String otherId = "otherId";

  ChatModel(this.message, this.from, this.timestamp, this.seenType);
}

class ShoppingChatScreen extends StatefulWidget {
  @override
  _ShoppingChatScreenState createState() => _ShoppingChatScreenState();
}

class _ShoppingChatScreenState extends State<ShoppingChatScreen> {
  TextEditingController? _chatTextController;

  late ThemeData theme;
  CustomChatTheme customChatTheme = CustomChatTheme.getWhatsAppTheme();

  final List<ChatModel> _chatList = [];

  ScrollController? _scrollController;

  final List<Timer> _timers = [];

  @override
  initState() {
    super.initState();
    _chatTextController = TextEditingController();
    _scrollController = ScrollController();
    theme = AppTheme.theme;
    _chatList.add(ChatModel("How can i help you", ChatModel.otherId,
        DateTime.now().millisecondsSinceEpoch.toString(), "sent"));
  }

  @override
  dispose() {
    super.dispose();
    _scrollController!.dispose();
    for (Timer timer in _timers) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: customChatTheme.appBarColor,
        title: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                LucideIcons.chevronLeft,
                color: customChatTheme.onAppBar,
                size: 20,
              ),
            ),
            MySpacing.width(12),
            Icon(
              LucideIcons.bot,
              color: customChatTheme.onAppBar,
              size: 26,
            ),
            MySpacing.width(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyText.titleMedium(
                  "Bot",
                  color: customChatTheme.onAppBar,
                ),
                MyText.bodySmall(
                  "Private chat bot",
                  color: customChatTheme.onAppBar,
                  fontWeight: 400,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: customChatTheme.backgroundColor,
        padding: MySpacing.nTop(8),
        child: Column(
          children: <Widget>[
            Container(
              padding: MySpacing.xy(12, 8),
              margin: MySpacing.y(12),
              decoration: BoxDecoration(
                  color: customChatTheme.chatBG,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    LucideIcons.lock,
                    color: customChatTheme.onChat.withAlpha(200),
                    size: 12,
                  ),
                  MySpacing.width(4),
                  MyText.bodySmall("All chat is private",
                      color: customChatTheme.onChat.withAlpha(200)),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(0),
                itemCount: _chatList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: index == 0
                        ? MySpacing.only(top: 8, bottom: 3).add(_chatList[index]
                                    .from
                                    .compareTo(ChatModel.myId) ==
                                0
                            ? EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.2)
                            : EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.2))
                        : MySpacing.only(top: 3, bottom: 3).add(
                            _chatList[index].from.compareTo(ChatModel.myId) == 0
                                ? EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.2)
                                : EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width * 0.2)),
                    alignment:
                        _chatList[index].from.compareTo(ChatModel.myId) == 0
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    child: singleChat(index),
                  );
                },
              ),
            ),
            MySpacing.height(8),
            suggestions(),
            MySpacing.height(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: MySpacing.all(2),
                    decoration: BoxDecoration(
                        color: customChatTheme.textFieldBackground,
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white,
                              child: SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: Icon(
                                    LucideIcons.smile,
                                    size: 24,
                                    color: customChatTheme.iconOnTextField,
                                  )),
                              onTap: () {},
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: MySpacing.bottom(4),
                            child: TextField(
                              maxLines: 6,
                              minLines: 1,
                              style: MyTextStyle.bodyLarge(
                                  color: customChatTheme.textOnTextField),
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                isDense: true,
                                hintStyle: MyTextStyle.bodyMedium(
                                    color: customChatTheme.textOnTextField
                                        .withAlpha(220)),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                              controller: _chatTextController,
                              textCapitalization: TextCapitalization.sentences,
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.white,
                              child: SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: Transform.rotate(
                                    angle: -pi / 4,
                                    child: Icon(
                                      LucideIcons.paperclip,
                                      size: 24,
                                      color: customChatTheme.iconOnTextField,
                                    ),
                                  )),
                              onTap: () {
                                addBottomSheet(context);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MySpacing.width(8),
                ClipOval(
                  child: Material(
                    color: customChatTheme.btnColor,
                    child: InkWell(
                      splashColor: Colors.white,
                      child: SizedBox(
                          width: 42,
                          height: 42,
                          child: Container(
                            margin: MySpacing.left(4),
                            child: Icon(
                              LucideIcons.send,
                              size: 22,
                              color: customChatTheme.iconOnBtn,
                            ),
                          )),
                      onTap: () {
                        sendMessage(_chatTextController!.text);
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget singleChat(int index) {
    return Container(
        padding: MySpacing.xy(8, 4),
        decoration: BoxDecoration(
          color: _chatList[index].from.compareTo(ChatModel.myId) == 0
              ? customChatTheme.myChatBG
              : customChatTheme.chatBG,
          borderRadius: makeChatBubble(index),
        ),
        child: Padding(
          padding: MySpacing.x(2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  padding: MySpacing.y(2),
                  child: MyText.titleMedium(
                    _chatList[index].message,
                    color: _chatList[index].from.compareTo(ChatModel.myId) == 0
                        ? customChatTheme.onMyChat
                        : customChatTheme.onChat,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              Padding(
                padding: MySpacing.left(8),
                child: MyText.labelSmall(
                    getStringTimeFromMilliseconds(_chatList[index].timestamp),
                    letterSpacing: -0.1,
                    color: _chatList[index].from.compareTo(ChatModel.myId) == 0
                        ? customChatTheme.onMyChat
                        : customChatTheme.onChat),
              ),
              _chatList[index].from.compareTo(ChatModel.myId) != 0
                  ? Container()
                  : Container(
                      margin: MySpacing.left(2),
                      child: Icon(
                          _chatList[index].seenType.compareTo("seen") == 0
                              ? LucideIcons.check
                              : LucideIcons.checkCheck,
                          size: 14,
                          color: _chatList[index]
                                      .from
                                      .compareTo(ChatModel.myId) ==
                                  0
                              ? (_chatList[index].seenType.compareTo("seen") ==
                                      0
                                  ? customChatTheme.tickColor
                                  : customChatTheme.onMyChat)
                              : customChatTheme.onChat))
            ],
          ),
        ));
  }

  String getStringTimeFromMilliseconds(String timestamp) {
    try {
      int time = int.parse(timestamp);
      var date = DateTime.fromMillisecondsSinceEpoch(time);
      int hour = date.hour, min = date.minute;
      if (hour > 12) {
        if (min < 10) {
          return "${hour - 12}:0$min pm";
        } else {
          return "${hour - 12}:$min pm";
        }
      } else {
        if (min < 10) {
          return "$hour:0$min am";
        } else {
          return "$hour:$min am";
        }
      }
    } catch (e) {
      return "";
    }
  }

  BorderRadius makeChatBubble(int index) {
    if (_chatList[index].from.compareTo(ChatModel.myId) == 0) {
      if (index != 0) {
        if (_chatList[index - 1].from.compareTo(ChatModel.myId) == 0) {
          return BorderRadius.all(Radius.circular(8));
        } else {
          return BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topRight: Radius.circular(0));
        }
      } else {
        return BorderRadius.only(
            topLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            topRight: Radius.circular(0));
      }
    } else {
      if (index != 0) {
        if (_chatList[index - 1].from.compareTo(ChatModel.myId) != 0) {
          return BorderRadius.all(Radius.circular(8));
        } else {
          return BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topRight: Radius.circular(8));
        }
      } else {
        return BorderRadius.only(
            topLeft: Radius.circular(0),
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            topRight: Radius.circular(8));
      }
    }
  }

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        _chatTextController!.clear();
        _chatList.add(ChatModel(message, ChatModel.myId,
            DateTime.now().millisecondsSinceEpoch.toString(), "sent"));
        startTimer(_chatList.length - 1, message);
      });
      scrollToBottom(isDelayed: true);
    }
  }

  void startTimer(int index, String message) {
    const oneSec = Duration(seconds: 1);
    const twoSec = Duration(seconds: 2);
    Timer timerSeen = Timer.periodic(
        oneSec,
        (Timer timer) => {
              timer.cancel(),
              setState(() {
                _chatList[index].seenType = "seen";
              })
            });
    _timers.add(timerSeen);
    Timer timer = Timer.periodic(
        twoSec, (Timer timer) => {timer.cancel(), sentFromOther(message)});
    _timers.add(timer);
  }

  void sentFromOther(String message) {
    setState(() {
      _chatList.add(ChatModel(message, ChatModel.otherId,
          DateTime.now().millisecondsSinceEpoch.toString(), "sent"));
      scrollToBottom(isDelayed: true);
    });
  }

  scrollToBottom({bool isDelayed = false}) {
    final int delay = isDelayed ? 400 : 0;
    Future.delayed(Duration(milliseconds: delay), () {
      _scrollController!.animateTo(_scrollController!.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  void addBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            margin: MySpacing.only(bottom: 64, left: 16, right: 16),
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: Padding(
                padding: MySpacing.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  quickActionWidget(
                                    LucideIcons.textSelect,
                                    "Document",
                                  ),
                                  quickActionWidget(
                                    LucideIcons.music2,
                                    "Audio",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  quickActionWidget(
                                    LucideIcons.camera,
                                    "Camera",
                                  ),
                                  quickActionWidget(
                                    LucideIcons.mapPin,
                                    "Location",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  quickActionWidget(
                                    LucideIcons.image,
                                    "Gallery",
                                  ),
                                  quickActionWidget(
                                    LucideIcons.userSquare,
                                    "Contact",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget quickActionWidget(IconData iconData, String actionText) {
    return Container(
      margin: MySpacing.y(8),
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Material(
              color: customChatTheme.btnColor, // button color
              child: InkWell(
                splashColor: Colors.white,
                // inkwell color
                child: SizedBox(
                    width: 52,
                    height: 52,
                    child: Icon(
                      iconData,
                      color: customChatTheme.iconOnBtn,
                      size: 24,
                    )),
                onTap: () {},
              ),
            ),
          ),
          MySpacing.height(4),
          MyText.bodySmall(
            actionText,
            color: theme.colorScheme.onBackground,
            fontWeight: 600,
            letterSpacing: 0.3,
          )
        ],
      ),
    );
  }

  Widget suggestions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              sendMessage("Go to favourites");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                      color: customChatTheme.onBackground, width: 0.3)),
              padding: MySpacing.xy(12, 8),
              child: MyText.bodyMedium("Go to favourites",
                  color: customChatTheme.onBackground,
                  fontWeight: 400,
                  letterSpacing: 0.3),
            ),
          ),
          MySpacing.width(8),
          InkWell(
            onTap: () {
              sendMessage("Last order status");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                      color: customChatTheme.onBackground, width: 0.3)),
              padding: MySpacing.xy(12, 8),
              child: MyText.bodyMedium("Last order status",
                  color: customChatTheme.onBackground,
                  fontWeight: 400,
                  letterSpacing: 0.3),
            ),
          ),
          MySpacing.width(8),
          InkWell(
            onTap: () {
              sendMessage("Show my orders");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                      color: customChatTheme.onBackground, width: 0.3)),
              padding: MySpacing.xy(12, 8),
              child: MyText.bodyMedium("Show my orders",
                  color: customChatTheme.onBackground,
                  fontWeight: 400,
                  letterSpacing: 0.3),
            ),
          ),
          MySpacing.width(8),
          InkWell(
            onTap: () {
              sendMessage("Other services");
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                      color: customChatTheme.onBackground, width: 0.3)),
              padding: MySpacing.xy(12, 8),
              child: MyText.bodyMedium("Other services",
                  color: customChatTheme.onBackground,
                  fontWeight: 400,
                  letterSpacing: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}
