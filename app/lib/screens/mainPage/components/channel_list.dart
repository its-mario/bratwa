import 'dart:async';

import 'package:drag_to_expand/drag_to_expand.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'channel_button.dart';

class ChannelsList extends StatefulWidget {
  final DragToExpandController dragToExpandController;
  final ChannelListController channelListController;

  ChannelsList({
    @required this.dragToExpandController,
    @required this.channelListController,
    Key key,
  }) : super(key: key);

  @override
  _ChannelsListState createState() => _ChannelsListState();
}

class _ChannelsListState extends State<ChannelsList> {
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  final String url = "https://picsum.photos/id/";

  Widget kEmptyBuilder(BuildContext context) {
    return Container(
      child: Center(
        child: Text("there is nothing here right now"),
      ),
    );
  }

  Widget kLoadingBuilder(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Loading..."),
      ),
    );
  }

  Widget kErrorBuilder(BuildContext context, Object object) {
    return Container(
      child: Center(
        child: Text("Something goes wrong..."),
      ),
    );
  }

  Widget kListBuilder(BuildContext context, List<Channel> channels) {
    return Column(
        children: channels.map((channel) {
      String title;
      if (channel.extraData.containsKey("name")) {
        title = channel.extraData["name"];
      } else {
        List<Member> members = channel.state.members;
        if (members.length == 2) {
          title = members[0].userId != StreamChat.of(context).user.id
              ? members[0].userId
              : members[1].userId;
        } else {
          title = "other " + (members.length - 1).toString() + " members";
        }
      }

      String lastTime =
          "${channel.lastMessageAt.hour.toString()}:${channel.lastMessageAt.minute.toString()}";
      String lastMessage = channel.state.lastMessage.text;
      String imageUrl;

      if (channel.memberCount == 2) {
        for (Member member in channel.state.members) {
          if (member.userId != StreamChat.of(context).user.id)
            imageUrl = member.user.extraData["image"];
          print("<Channel List> the image url for $imageUrl");
        }
      }

      return ChannelButton(
        title: title,
        lastDate: lastTime,
        lastMessage: lastMessage,
        channel: channel,
        urlAvatarImage: imageUrl,
      );
    }).toList());
  }

  bool shouldReload(Event event) => true;

  @override
  Widget build(BuildContext context) {
    final String userId = StreamChat.of(context).user.id;
    Timer(Duration(seconds: 2), () {
      widget.dragToExpandController.isOpened = true;
    });
    return Align(
      alignment: Alignment.bottomCenter,
      child: DragToExpand(
        //baseSide: BaseSide.top,
        clipOverflow: false,
        maxSize: MediaQuery.of(context).size.height * 0.82,
        minSize: MediaQuery.of(context).size.height * 0.65,
        controller: widget.dragToExpandController,
        draggable: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 7,
          ),
          decoration: BoxDecoration(
            color: Color(0xffFAFAFA),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(27),
              topRight: Radius.circular(27),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 6,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Center(
            child: Icon(Icons.remove),
          ),
        ),
        child: GestureDetector(
          onVerticalDragStart: (dragStartDetails) {
            widget.dragToExpandController.isOpened =
                !widget.dragToExpandController.isOpened;
            print("<Channel List> swipe vertical ");
          },
          onTap: () {
            widget.dragToExpandController.isOpened = true;
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 7,
            ),
            decoration: BoxDecoration(
              color: Color(0xffFAFAFA),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollnotification) {
                if (scrollnotification is ScrollStartNotification) {
                  widget.dragToExpandController.isOpened = true;
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 10,
                  ),
                  child: ChannelsBloc(
                    shouldAddChannel: shouldReload,
                    child: ChannelListCore(
                      channelListController: widget.channelListController,
                      filter: {
                        'members': {
                          '\$in': [userId],
                        }
                      },
                      sort: [SortOption('last_message_at')],
                      pagination: PaginationParams(
                        limit: 20,
                      ),
                      emptyBuilder: kEmptyBuilder,
                      loadingBuilder: kLoadingBuilder,
                      errorBuilder: kErrorBuilder,
                      listBuilder: kListBuilder,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
