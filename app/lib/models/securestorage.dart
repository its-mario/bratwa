import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:md_messenger/models/key.dart';

class SecureSave {
  //use this to have universal acces
  final String idKey = "id";
  final String tokenKey = "token";

  final FlutterSecureStorage storage = new FlutterSecureStorage();

  void saveToken(KeyAcces key) async {
    //save user id
    await storage.write(key: idKey, value: key.id);
    //save token
    await storage.write(key: tokenKey, value: key.token);
  }

  void clearToken() async {
    await storage.deleteAll();
  }

  /// Called to get ex: {"userId" : "user", "token": "something.someting.something"}
  Future<KeyAcces> readToken() async {
    KeyAcces keyAcces = KeyAcces();
    keyAcces.id = await storage.read(key: idKey);
    keyAcces.token = await storage.read(key: tokenKey);
    if (keyAcces.id == null || keyAcces.token == null) {
      return KeyAcces(id: null, );
    } else{
      return keyAcces;
    }

  }
  ///check if token are saved on the device
  Future<bool> checkForToken() async{
    if (await storage.read(key: tokenKey) != null)
      return true;
    else
      return false;
  }
}
