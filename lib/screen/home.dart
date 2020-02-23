import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/widget/sidebar/sidebar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;
  String email;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getinformat();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (prefs.getString('sessionid') != null) {
            Future.value(false);
          }
        },
        child: new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          drawer: Sidebar(username: this.name, email: this.email),
          body: Container(
              child: Center(
            child: Text('Hello this is me ${name}'),
          )),
        ));
  }

  _getinformat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('fullname');
      email = prefs.getString('email');
    });

    print('email cadastrado e ${prefs.getString('email')}');
  }
}
