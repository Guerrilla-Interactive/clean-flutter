// BaseCommand (a mixin) provides dependencies our commands need
import 'package:flutter/material.dart';
import 'package:gskinner/models.dart';
import 'package:gskinner/service.dart';
import 'package:provider/provider.dart';

late BuildContext _mainContext;

// Init to be called once at the beginning from something like the 
// app's main.dart
void init(BuildContext c) => _mainContext = c;

class BaseCommand{
  // Models
  UserModel userModel = _mainContext.read();
  AppModel appModel = _mainContext.read();

  // Services
  UserService userService = _mainContext.read();

}


class LoginCommand extends BaseCommand{
  Future<bool> run(String user, String pass) async {
    var loginSuccess =  await userService.login(user, pass);
    if (loginSuccess){
      // We're instanting a command  object instead of making it a singleton
      await RefreshUserPosts().run(user);
    }
    appModel.currentUser = loginSuccess ? user : "";
    return loginSuccess;
  }
}

class LogoutCommand extends BaseCommand{
  run() async {
    appModel.currentUser = "";
    return true;
  }
}

class RefreshUserPosts extends BaseCommand{
  Future<List<String>> run(String user) async {
    List<String> posts = await userService.getPosts(user);
    userModel.userPosts = posts;

    // Return user posts in case the caller needs
    return posts;

  }
}