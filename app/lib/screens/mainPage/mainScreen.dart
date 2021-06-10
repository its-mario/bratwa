import 'package:flutter/material.dart';
import 'package:md_messenger/screens/startChannel.dart';
import 'package:md_messenger/services/provider.dart';

import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChannelListPage();
  }
}

class ChannelListPage extends StatefulWidget {
  @override
  _ChannelListPageState createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage> {
  @override
  Widget build(BuildContext context) {
    User user = StreamChat.of(context).user;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateChannel()),
          );
          setState(() {});
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text("BratWaVa"),
        actions: [IconButton(icon: Icon(Icons.exit_to_app), onPressed: (){
          context.read<AuthModel>().logOut();
        }),],
      ),
      body: ChannelsBloc(
        child: ChannelListView(
          swipeToAction: true,
          filter: {
            'members': {
              '\$in': [user.id],
            },
          },
          sort: [SortOption("last_message_at", direction: SortOption.DESC)],
          pagination: PaginationParams(
            limit: 20,
          ),
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}
