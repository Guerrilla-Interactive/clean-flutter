import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:gskinner/service.dart';
import 'package:gskinner/models.dart';
import 'package:gskinner/command.dart' as Commands;
import 'package:gskinner/screens/home.dart';
import 'package:gskinner/screens/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => AppModel()),
        ChangeNotifierProvider(create: (c) => UserModel()),
        Provider(create: (c) => UserService()),
      ],
      child: Builder(builder: (context){
        Commands.init(context);
        return MaterialApp(home: AppScaffold());
      }),
    ); 
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bind to AppModel.currentUser
    String currentUser = context.select<AppModel, String>((value) => value.currentUser);

    // Return the current view, based on currentUser value:
    return Scaffold(
      body: currentUser != "" ? const Home() : const Login(),
    );
  }
}