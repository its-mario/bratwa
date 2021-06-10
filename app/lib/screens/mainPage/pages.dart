import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class AccountSettings extends StatefulWidget {
  final User user;
  AccountSettings({Key key, this.user}) : super(key: key);

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  String imgUrl;

  @override
  Widget build(BuildContext context) {
    imgUrl = widget.user.extraData["image"];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.id),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            child: Image(
              image: imgUrl == null
                  ? AssetImage("assets/images/defaultAvatar.png")
                  : NetworkImage(imgUrl),
              fit: BoxFit.contain,
            ),
          ),
          TextField(
            onSubmitted: (text) {
              setState(() {
                imgUrl = text;
                widget.user.extraData['image'] = text;
                StreamChat.of(context).client.updateUser(widget.user);
              });
            },
          ),
        ],
      ),
    );
  }
}
