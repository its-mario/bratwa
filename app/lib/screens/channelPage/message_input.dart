import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MessageInputCustom extends StatefulWidget {
  final Channel channel;
  MessageInputCustom({Key key, this.channel}) : super(key: key);

  @override
  _MessageInputCustomState createState() => _MessageInputCustomState();
}

class _MessageInputCustomState extends State<MessageInputCustom> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void sendMessage(){
    final message = Message(
      text: _controller.text
    );
    widget.channel.sendMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border(
            top: BorderSide(
              color: Theme.of(context).accentColor,
              width: 6,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                cursorColor: Theme.of(context).hoverColor,
                cursorRadius: Radius.circular(5),
                cursorWidth: 1.5,
                maxLines: 5,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: "text",
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(fontSize: 18),
              ),
            ),
            Material(
              child: Ink(
                decoration: ShapeDecoration(
                  color: Theme.of(context).hoverColor,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.white,
                  onPressed: () {
                    print("<TextField Input>: this is the text that you printed \"${_controller.text}\" ");
                    sendMessage();
                    _controller.clear();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}