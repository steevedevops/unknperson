import 'package:flutter/material.dart';
import 'package:unknperson/src/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // INicializa o valor dele por primera vez
  // SharedPreferences.setMockInitialValues({});
  print('Iniciando aplicativo');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.blue,
        accentColor: Colors.cyan[600],
        // brightness: Brightness.dark,
        // primaryColor: Colors.lightBlue[800],
        primaryColor: Color(0xFF364f6b),
      ),
      home: LoginScreen(),
    );
  }
}