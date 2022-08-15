import 'dart:math';

class UserService {
  Future<bool> login(String user, String pass) async{
    await Future.delayed(const Duration(seconds: 1));
    // Login succeds probabilistically 50% of the time
    return Random().nextInt(100) > 50;
  }
  Future<List<String>> getPosts(String user) async{
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(50, (index) => "Item ${Random().nextInt(999)}");
  }
}