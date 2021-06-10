import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'appbar.dart';
import 'message_input.dart';

class ChannelPage extends StatelessWidget {
  final Channel channel;
  const ChannelPage({Key key, @required this.channel}) : super(key: key);

  // ignore: missing_return
  String title(BuildContext context) {
    if (this.channel.extraData["name"] != null) {
      return this.channel.extraData["name"];
    } else {
      if (channel.memberCount == 2) {
        for (Member member in channel.state.members) {
          if (member.userId != StreamChat.of(context).client.state.user.id)
            return member.userId;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamChannel(
      channel: this.channel,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppBar(channelTitle: title(context)),
              Expanded(
                child: MessageListView(
                  messageBuilder: messageBuilder,
                ),
              ),
              MessageInputCustom(channel: this.channel),
            ],
          ),
        ),
      ),
    );
  }
}

Widget messageBuilder(
  BuildContext context,
  MessageDetails details,
  List<Message> messages,
) {
  final message = details.message;

  final isCurrentUser = StreamChat.of(context).user.id == message.user.id;

  final widthOfMessage = MediaQuery.of(context).size.width * 0.8;
  return Row(
    mainAxisAlignment:
        isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        constraints: BoxConstraints(
          maxWidth: widthOfMessage,
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isCurrentUser
              ? Theme.of(context).hoverColor
              : Theme.of(context).backgroundColor,
          boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.25),
            //   blurRadius: 1,
            //   spreadRadius: 0,
            // ),
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          message.text,
          softWrap: true,
          style: GoogleFonts.rubik(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: isCurrentUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    ],
  );
}
