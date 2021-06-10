import 'package:md_messenger/services/backend.dart';

main() async {
  print("Testing Backend Method for getting id");

  // ignore: deprecated_member_use_from_same_package
  final token = await Backend.getToken({"id": "user", "password": "password"});
  if (token == null) {
    print("Error Null type");
  } else {
    print(token.toString());
    print('id: ${token['idUser']} ');
    print('token: ${token['token']} ');
  }
}
