// MinecraftChecker - @IndianBots - V0.0.1+a

import 'package:http/http.dart';
import 'package:uuid/uuid.dart';


class MinecraftChecker {

  String user = '';
  String password = '';
  
  MinecraftChecker(this.user, this.password) : assert(
    user != '',
    password != '',
  );

  Future<bool> check() async {
    if (user != null && password != null) {
      var randomGuid = Uuid().v4();
      var req = await post(
        Uri.parse('https://authserver.mojang.com/authenticate'),
        body: {
          'agent': "{'name': 'Minecraft','version': 1}",
          'username': user,
          'password': password,
          'clientToken': randomGuid,
        },
        headers: {
          'Cache-Control': 'no-cache',
          'Pragma': 'no-cache',
          'User-Agent': 'Java/1.8.0_281',
          'Host': 'authserver.mojang.com',
          'Accept': 'text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2',
          'Connection': 'keep-alive',
        }
      );
      if (req.body.contains('accessToken')) {
        return true;
      }
    }
    return false;
  }
}
