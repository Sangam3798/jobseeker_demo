import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/pages/HomeScreen.dart';
import 'package:untitled/pages/SignupScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  FutureBuilder<bool>(
          future: screen_redirection(),
          builder: (context,snapshot)
          {
            if(snapshot.hasData && snapshot.data!)
            {
              return HomeScreen();
            }
            else
            {
              return SignupScreen();
            }
          }),
    );
  }
  Future<bool> screen_redirection() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringValue =   prefs.getString('signupStatus');
    debugPrint("value $stringValue");
    if(stringValue == 'true')
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}

