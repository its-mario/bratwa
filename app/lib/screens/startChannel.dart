import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class CreateChannel extends StatefulWidget {
  @override
  _CreateChannelState createState() => _CreateChannelState();
}

class _CreateChannelState extends State<CreateChannel> {
  TextEditingController controller;

  void initState() {
    controller = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () async {
                final client = StreamChat.of(context).client;
                var userQuery = await client.queryUsers();
                var users = userQuery.users;
                for (var user in users) {
                  print("id: ${user.id}");
                }
              })
        ],
        title: Text("Users"),
        // TextField(
        //   controller: controller,
        // ),
      ),
      body: UsersBloc(
        child: UserListView(
          sort: [SortOption('last_message_at')],
          pagination: PaginationParams(
            limit: 20,
          ),
          onUserTap: (user, widget) async {
            final client = StreamChat.of(context).client;
            var channel = client.channel(
              "messaging",
              extraData: {
                "members": [user.id, StreamChat.of(context).user.id],
              },
            );
            await channel.watch().then((state) {
              channel.sendMessage(Message(text: "Hi! 👋"));
            });

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
