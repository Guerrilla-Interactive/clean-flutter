import 'package:flutter/material.dart';
import 'package:gskinner/command.dart';
import 'package:gskinner/models.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = false;

  void _handleRefreshPressed() async {
    setState(() {
      _isLoading = true;
      // Run command
    });
    await RefreshUserPosts().run(context.read<AppModel>().currentUser);
    setState(() {
      _isLoading = false;
    });
  }

  void _logoutHandler(){
   LogoutCommand().run();
  }

  @override
  Widget build(BuildContext context) {
    // Bind to UserModel.userPosts
    var users = context.select<UserModel, List<String>>((value) => value.userPosts);
    // Discard btn by remogin listeners when loading
    void Function()? btnHandler = _isLoading ? null : _handleRefreshPressed;
    // Reder list of widgets
    var listWidgets = users.map((post) => Text(post)).toList();
    return Scaffold(
      body: Column(children: [
        Flexible(child: ListView(children: listWidgets),),
        TextButton(onPressed: btnHandler, child: const Text("Refresh")),
        TextButton(onPressed: _logoutHandler, child: const Text("Logout"))
      ]),
    );
  }
}
