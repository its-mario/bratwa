import 'package:http/http.dart' as http;
import 'package:md_messenger/models/key.dart';
import 'dart:convert';

import '../configs.dart';

class Backend {
  ///return key {token, id} using params {id, password}
  // ignore: missing_return
  static Future<KeyAcces> logIn(Map<String, String> params) async {
    print(
        "<BackEnd Service>: Trying to logIn with: \n -- ${params.toString()}");
    //try {
    String requestedUrl = backEndDomain + "/logIn";
    var url = Uri.parse(requestedUrl);
    var response = await http.get(url, headers: params);
    dynamic body = jsonDecode(response.body);
    if (response.statusCode != 200 && body.containsKey("error")) {
      return KeyAcces(error: body["error"]);
    } else if (response.statusCode == 200) {
      return KeyAcces(id: body["id"], token: body["token"]);
    }
    //} catch (error) {
    //  return KeyAcces(error: "Can't estabilish connection with backend");
    //}
  }

  /// register user in Backend using params{@req id,@req password, email, name}
  static Future<Map<String, String>> register(
      Map<String, String> params) async {
    print(
        "<BackEnd Service>: Trying to Register user with:\n -- ${params.toString()}");
    try {
      String requestedUrl = backEndDomain + "/register";
      var url = Uri.parse(requestedUrl);
      var response = await http.post(url, body: params);
      return jsonDecode(response.body);
    } catch (error) {
      return {"error": "Problem register user"};
    }
  }

  @Deprecated("repalced with logIn and register function")
  static Future<dynamic> getToken(Map<String, String> parameters) async {
    try {
      String requestedUrl = backEndDomain + "/auth";
      var url = Uri.parse(requestedUrl);
      var response = await http.post(url, body: parameters);
      return jsonDecode(response.body);
    } catch (error) {
      return {"error": true};
    } finally {
      print("post attempt");
    }
  }
}
