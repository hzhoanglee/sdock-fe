/*
* File : Whatsapp Chat
* Version : 1.0.0
* */

import 'dart:async';
import 'dart:math';

import 'package:sdock_fe/helpers/theme/app_theme.dart';
import 'package:sdock_fe/helpers/theme/custom_chat_theme.dart';
import 'package:sdock_fe/helpers/widgets/my_spacing.dart';
import 'package:sdock_fe/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ChatWhatsAppPage extends StatefulWidget {
  @override
  _ChatWhatsAppPageState createState() => _ChatWhatsAppPageState();
}

class ChatModel {
  String message, from, timestamp, seenType;

  static const String myId = "myId";
  static const String otherId = "otherId";

  ChatModel(this.message, this.from, this.timestamp, this.seenType);
}

class _ChatWhatsAppPageState extends State<ChatWhatsAppPage> {
  TextEditingController? _chatTextController;
  late ThemeData theme;
  CustomChatTheme customChatTheme = CustomChatTheme.getWhatsAppTheme();

  final List<ChatModel> _chatList = [];

  ScrollController? _scrollController;

  final List<String> _simpleChoice = ["Create shortcut", "Clear chat"];

  final List<Timer> _timers = [];

  @override
  initState() {
    super.initState();
    theme = AppTheme.darkTheme;
    _chatTextController = TextEditingController();
    _scrollController = ScrollController();

    _chatList.add(ChatModel("Hii", ChatModel.myId,
        DateTime.now().millisecondsSinceEpoch.toString(), "seen"));
    _chatList.add(ChatModel("Hii", ChatModel.otherId,
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
    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: customChatTheme.appBarColor,
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white,
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(
                          LucideIcons.chevronLeft,
                          color: customChatTheme.onAppBar,
                          size: 24,
                        )),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("./assets/images/profile/avatar_1.jpg"),
                      fit: BoxFit.fill),
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyText.titleMedium(
                        "Alysia Finney",
                        fontWeight: 600,
                        color: customChatTheme.onAppBar,
                      ),
                      MyText.bodySmall(
                        "last seen yesterday at 9:09 pm",
                        color: customChatTheme.onAppBar,
                        fontWeight: 400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (dynamic choice) {
                onSelectedMenu(choice);
              },
              itemBuilder: (BuildContext context) {
                return _simpleChoice.map((String choice) {
                  return PopupMenuItem(
                    value: choice,
                    child: MyText(
                      choice,
                      letterSpacing: 0.15,
                      color: theme.colorScheme.onBackground,
                    ),
                  );
                }).toList();
              },
              color: customChatTheme.backgroundColor,
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('./assets/images/apps/chat/whatsapp-bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Color(0x33000000),
              child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        margin: EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            color: customChatTheme.chatBG,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0))),
                        child: MyText.bodySmall("TODAY",
                            color: customChatTheme.onChat!.withAlpha(200),
                            letterSpacing: 0.3),
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
                                  ? EdgeInsets.only(top: 8, bottom: 3).add(
                                      _chatList[index].from.compareTo(ChatModel.myId) == 0
                                          ? EdgeInsets.only(
                                              left: MediaQuery.of(context).size.width *
                                                  0.2)
                                          : EdgeInsets.only(
                                              right: MediaQuery.of(context).size.width *
                                                  0.2))
                                  : EdgeInsets.only(top: 3, bottom: 3).add(
                                      _chatList[index].from.compareTo(ChatModel.myId) == 0
                                          ? EdgeInsets.only(
                                              left: MediaQuery.of(context).size.width * 0.2)
                                          : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2)),
                              alignment: _chatList[index]
                                          .from
                                          .compareTo(ChatModel.myId) ==
                                      0
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: singleChat(index),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: customChatTheme.textFieldBackground,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(24.0))),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    ClipOval(
                                      child: Material(
                                        color: Colors.transparent,
                                        // button color
                                        child: InkWell(
                                          splashColor: Colors.white,
                                          // inkwell color
                                          child: SizedBox(
                                              width: 44,
                                              height: 44,
                                              child: Icon(
                                                LucideIcons.smile,
                                                size: 24,
                                                color: customChatTheme
                                                    .iconOnTextField,
                                              )),
                                          onTap: () {},
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 4),
                                        child: TextField(
                                          maxLines: 6,
                                          minLines: 1,
                                          style: theme.textTheme.bodyLarge!
                                              .merge(TextStyle(
                                                  color: customChatTheme
                                                      .textOnTextField)),
                                          decoration: InputDecoration(
                                            hintText: "Type a message...",
                                            isDense: true,
                                            hintStyle: theme
                                                .textTheme.titleMedium!
                                                .merge(TextStyle(
                                                    color: customChatTheme
                                                        .textOnTextField!
                                                        .withAlpha(220))),
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                          ),
                                          controller: _chatTextController,
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                        ),
                                      ),
                                    ),
                                    ClipOval(
                                      child: Material(
                                        color: Colors.transparent,
                                        // button color
                                        child: InkWell(
                                          splashColor: Colors.white,
                                          // inkwell color
                                          child: SizedBox(
                                              width: 44,
                                              height: 44,
                                              child: Transform.rotate(
                                                angle: -pi / 4,
                                                child: Icon(
                                                  LucideIcons.paperclip,
                                                  size: 24,
                                                  color: customChatTheme
                                                      .iconOnTextField,
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
                            Container(
                                margin: EdgeInsets.only(left: 8),
                                child: ClipOval(
                                  child: Material(
                                    color: customChatTheme.btnColor,
                                    child: InkWell(
                                      splashColor: Colors.white,
                                      // inkwell color
                                      child: SizedBox(
                                          width: 42,
                                          height: 42,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 4),
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
                                ))
                          ],
                        ),
                      )
                    ],
                  )),
            )),
      ),
    );
  }

  Widget singleChat(int index) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: _chatList[index].from.compareTo(ChatModel.myId) == 0
              ? customChatTheme.myChatBG
              : customChatTheme.chatBG,
          borderRadius: makeChatBubble(index),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
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
                padding: EdgeInsets.only(left: 8.0),
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
                      margin: EdgeInsets.only(left: 2),
                      child: Icon(
                          _chatList[index].seenType.compareTo("seen") == 0
                              ? LucideIcons.checkCheck
                              : LucideIcons.check,
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
          return BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topRight: Radius.circular(8));
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
          return BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
              topRight: Radius.circular(8));
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

  void onSelectedMenu(choice) {
    if (choice.toString().compareTo(_simpleChoice[0]) == 0) {
    } else if (choice.toString().compareTo(_simpleChoice[1]) == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return deleteAllChatDialog();
          });
    } else {}
  }

  Widget deleteAllChatDialog() {
    return Dialog(
      backgroundColor: customChatTheme.backgroundColor,
      child: Container(
        padding: EdgeInsets.only(top: 24, bottom: 0, left: 24, right: 0),
        decoration: BoxDecoration(
          color: customChatTheme.backgroundColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 24),
              child: MyText.titleMedium(
                  "Are you sure to clear messages in this chat",
                  fontWeight: 400,
                  letterSpacing: 0),
            ),
            Container(
                margin: EdgeInsets.only(top: 8),
                alignment: AlignmentDirectional.centerEnd,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(MySpacing.xy(16, 0))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: MyText(
                          "Cancel".toUpperCase(),
                        )),
                    TextButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(MySpacing.xy(16, 0))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: MyText(
                          "clear".toUpperCase(),
                        )),
                  ],
                )),
          ],
        ),
      ),
    );
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
            margin: EdgeInsets.only(bottom: 64, left: 16, right: 16),
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              child: Padding(
                padding: EdgeInsets.all(16),
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
                                    LucideIcons.clipboardList,
                                    'Document',
                                  ),
                                  quickActionWidget(
                                    LucideIcons.music2,
                                    'Audio',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  quickActionWidget(
                                    LucideIcons.camera,
                                    'Camera',
                                  ),
                                  quickActionWidget(
                                    LucideIcons.mapPin,
                                    'Location',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  quickActionWidget(
                                    LucideIcons.image,
                                    'Gallery',
                                  ),
                                  quickActionWidget(
                                    LucideIcons.userSquare2,
                                    'Contact',
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
      margin: EdgeInsets.only(top: 8, bottom: 8),
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
                      size: 25,
                    )),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 4),
            child: MyText.bodySmall(
              actionText,
              color: theme.colorScheme.onBackground,
            ),
          )
        ],
      ),
    );
  }
}
