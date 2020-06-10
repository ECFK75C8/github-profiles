import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/users.dart';
import './screens/github_users_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        var focusNode = FocusScope.of(context);
        if (!focusNode.hasPrimaryFocus) {
          focusNode.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Github profiles',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => ChangeNotifierProvider.value(
                value: Users(),
                child: GithubUsersScreen(title: 'Github profiles'),
              ),
        },
      ),
    );
  }
}
