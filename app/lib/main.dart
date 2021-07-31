import 'package:flutter/material.dart';
import 'package:md_messenger/constants.dart';
import 'package:md_messenger/models/securestorage.dart';
import 'package:md_messenger/screens/loading_component.dart';
import 'package:md_messenger/screens/logInPage/login_screen.dart';
import 'package:md_messenger/screens/mainPage/mainScreen.dart';
import 'package:md_messenger/screens/mainPage/mainScreendesign.dart';
import 'package:md_messenger/services/provider.dart';
import 'package:provider/provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final apiKey = 'b9kb7e5cs576';
  final client = StreamChatClient(apiKey, logLevel: Level.INFO);

  runApp(MyApp(client));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  MyApp(this.client, {Key key}) : super(key: key) {
    initStateConnection();
  }

  ///take AccesKey from secureStorage and use it to connect
  void initStateConnection() async {
    final secureSave = SecureSave();
    final key = await secureSave.readToken();
    if (key.id != null && key.token != null) {
      final User user = User(id: key.id);
      client.connectUser(user, key.token);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultColors = defaultThemeData;
    StreamChatThemeData themeData = StreamChatThemeData(
      colorTheme: ColorTheme.light(
        accentBlue: defaultColors.accentColor,
      ),
    );

    return ChangeNotifierProvider(
      create: (context) => AuthModel(this.client),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: defaultThemeData,
        title: "BRATWAVA",
        builder: (context, widget) => StreamChat(
          streamChatThemeData: themeData,
          client: client,
          child: widget,
        ),
        initialRoute: "/",
        routes: {
          '/': (ctx) => ChangeNotifierProvider(
                create: (context) => AuthModel(this.client),
                child: ConnectionWrapper(),
              ),
          '/logIn': (ctx) => LogInPage(),
          '/main': (ctx) => MainPage(),
          // '/intro': (ctx) => Introduction(),
        },
      ),
    );
  }
}

// class ConnectionWrapper extends StatefulWidget {
//   @override
//   _ConnectionWrapperState createState() => _ConnectionWrapperState();
// }
//
// class _ConnectionWrapperState extends State<ConnectionWrapper> {
//   String connectedStatus = "offline";
//   Color connectedColor = Colors.red;
//
//   @override
//   Widget build(BuildContext context) {
//     if (context.watch<AuthModel>().isOnline) {
//       return MainPage(); //MainPage()
//     } else {
//       return LogInPage();
//     }
//   }
// }

class ConnectionWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: context.watch<AuthModel>().connected,
        builder: (BuildContext context, snapshot) {
          print("<ConnectionWrapper>: New Snapshot");
          if (snapshot.hasData) {
            print("<ConnectionWrapper>: snapshot Data");
          }

          if (snapshot.hasData && snapshot.data == ConnectionStatus.connected) {
            return HomePage();
          } else {
            return LogInPage();
          }
        });
  }
}

// class EventWrapper extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: context.watch<AuthModel>().connected,
//       builder: (
//         BuildContext context,
//         AsyncSnapshot<ConnectionStatus> snapshot,
//       ) {
//         if (snapshot.hasData) {
//           final ConnectionStatus connectionStatus = snapshot.data;

//           if(){}
//         } else {
//           return LoadingPage();
//         }
//       },
//     );
//   }
// }
