import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/services/api.dart';

class UserinformationsScreen extends StatefulWidget {
  @override
  _UserinformationsScreenState createState() => _UserinformationsScreenState();
}

class _UserinformationsScreenState extends State<UserinformationsScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  bool _loadState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUserinformation();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return ModalProgressHUD(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(title: Text('Trocar dados do usuario')),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _updateUserinformations();
              }
            },
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(Icons.save),
          ),
          body: SingleChildScrollView(
              child: Form(
            key: _formKey,
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.0,
                            (MediaQuery.of(context).size.height / (4.6)),
                            0.0,
                            0.0)),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / (1.2)),
                      child: TextFormField(
                        onChanged: (value) {},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'campo nao pode estar vazio';
                          }
                          return null;
                        },
                        controller: firstname,
                        style: textStyle,
                        decoration: InputDecoration(
                          labelText: 'First name',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / (1.2)),
                      child: TextFormField(
                        onChanged: (value) {},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'campo nao pode estar vazio';
                          }
                          return null;
                        },
                        controller: lastname,
                        style: textStyle,
                        decoration: InputDecoration(
                          labelText: 'Last name',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      width: (MediaQuery.of(context).size.width / (1.2)),
                      child: TextFormField(
                        onChanged: (value) {},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'campo nao pode estar vazio';
                          }
                          return null;
                        },
                        controller: username,
                        style: textStyle,
                        decoration: InputDecoration(
                          labelText: 'User name',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                    ),
                  ],
                ))),
          ))),
      inAsyncCall: _loadState,
    );
  }

  Future<void> _getUserinformation() async {
    setState(() {
      _loadState = true;
    });
    var userinfo = await Services.getUserinformation();
    if (userinfo.isNotEmpty) {
      firstname.text = userinfo['first_name'];
      lastname.text = userinfo['last_name'];
      username.text = userinfo['username'];
    }
    setState(() {
      _loadState = false;
    });
  }

  Future<void> _updateUserinformations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _loadState = true;
    });

    Map data = {
      "first_name": firstname.text,
      "last_name": lastname.text,
      "username": username.text
    };
    var sucesse = await Services.changeUserinformation(data);

    if (sucesse) {
      _neverSatisfied(prefs.getString('msg_login'));
    } else {
      showInSnackBar(context, prefs.getString('msg_login'));
    }
    setState(() {
      _loadState = false;
    });
  }

  void showInSnackBar(BuildContext context, String value) {
    final snackBar = SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13.0, fontFamily: "WorkSansSemiBold"),
      ),
      duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<void> _neverSatisfied(String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sucesso!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$msg'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
