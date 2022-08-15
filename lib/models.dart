import 'package:flutter/material.dart';

// Getters and setters are specially needeed 
// because we want to call notifyListeners 
// after all model chages
class AppModel extends ChangeNotifier{

    String _currentUser = "";
    String get currentUser => _currentUser;
    set currentUser(String currentUser){
      _currentUser = currentUser;
      notifyListeners();
    }
}

class UserModel extends ChangeNotifier{
  List<String> _userPosts = [];
  List<String> get userPosts => _userPosts;
  set userPosts(List<String> userPosts){
    _userPosts = userPosts;
    notifyListeners();
  }
}
