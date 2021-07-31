// import 'package:flutter/material.dart';
// import 'package:md_messenger/services/auth.dart';
// import 'package:provider/provider.dart';

// class AuthModel extends ChangeNotifier {
//   Auth _auth = Auth();

//   Auth get auth => _auth;
// }

import 'package:md_messenger/models/key.dart';
import 'package:md_messenger/models/securestorage.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter/material.dart';
import 'backend.dart';

class AuthModel extends ChangeNotifier {
  final StreamChatClient _client;

  AuthModel(this._client);

  StreamChatClient get client => _client;

  //
  Stream<ConnectionStatus> get connected => _client.wsConnectionStatusStream;

  //amus incercam ceva dupa codul va fi sters daca nu merge
  Stream<Event> get events => _client.stream;

  Stream<OwnUser> get currentUser => _client.state.userStream;

  Future<bool> get savedToken => SecureSave().checkForToken();

  Future<void> logOut() async {
    _client.disconnect(clearUser: true);
    SecureSave().clearToken();
  }

  // ignore: missing_return
  Future<String> logIn({@required String id, @required String password}) async {
    KeyAcces key = await Backend.logIn({"id": id, "password": password});

    final user = User(id: key.id);

    if (key.error != null) {
      print("Error: ${key.error}");
      return key.error;
    } else {
      print("id: ${key.id}\ntoken:${key.token}");
      Event response = await _client.connectUser(user, key.token);
      print(" User Logged in : " + response.online.toString());
      final secureSave = SecureSave();
      secureSave.saveToken(key);
    }
  }

  Future<String> singUp(
      {@required String id,
      @required String password,
      String email,
      String name}) async {
    final registerResult = await Backend.register(
        {"id": id, "password": password, "email": email, "name": name});

    if (registerResult.containsKey("error")) {
      return registerResult["error"];
    } else {
      return "User succefully registred ✌";
    }
  }

  @Deprecated('After changing in backend this code was deprecated')
  Future<void> connect({@required String id, @required String password}) async {
    // key mean {id, token}
    //dynamic key = await Backend.getToken({"id": id, "password": password});

    // this.user = User(
    //   id: key["idUser"], // the idUser is the value that backend return
    //   //here could be added more params but for now is okey
    // );

    // Event eventStatus = await this._client.connectUser(user, key['token']);
    // if (eventStatus.me.online) isOnline = true;
    //
    // notifyListeners();
  }
}
