// import 'dart:math' as math;

import 'package:drag_to_expand/drag_to_expand.dart';
import 'package:flutter/material.dart';
import 'package:md_messenger/screens/mainPage/pages.dart';
//import 'package:md_messenger/screens/mainPage/mainScreen.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:md_messenger/services/provider.dart';
import 'package:provider/provider.dart';

import 'components/back_stage.dart';
import 'components/channel_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DragToExpandController _dragToExpandController;
  ChannelListController _channelListController;

  @override
  void initState() {
    _dragToExpandController = DragToExpandController();
    _channelListController = ChannelListController();

    super.initState();
  }

  @override
  dispose() {
    _dragToExpandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
        onPressed: () {
          print("<HomePage>: reload datas of channels");
          _channelListController.loadData();
        },
      ),
      backgroundColor: Color(0xffE8F1F5),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          BackGroundMenu(
            options: [
              MenuOptionDescription(
                  title: "Account",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AccountSettings(
                              user: StreamChat.of(context).user);
                        },
                      ),
                    );
                  }),
              MenuOptionDescription(title: "Settings"),
              MenuOptionDescription(
                  title: "Exit",
                  onTap: () {
                    context.read<AuthModel>().logOut();
                  }),
            ],
          ),
          ChannelsList(
            dragToExpandController: _dragToExpandController,
            channelListController: _channelListController,
          ),
        ],
      ),
    );
  }
}
