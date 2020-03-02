import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/src/screen/activeacount.dart';
import 'package:unknperson/services/api.dart';
import 'package:unknperson/src/screen/login.dart';
import 'package:unknperson/src/screen/recoverycode.dart';

class RecoverypassScreen extends StatefulWidget {
  @override
  _RecoverypassScreenState createState() => _RecoverypassScreenState();
}

class _RecoverypassScreenState extends State<RecoverypassScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController username = TextEditingController();

  bool _loadState = false;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: ModalProgressHUD(
              child: SingleChildScrollView(
                  child: new Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Container(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            
                            Container(
                                decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 10,
                                      blurRadius: 30,
                                      offset: Offset(
                                          1, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(23),
                                ),
                                width: MediaQuery.of(context).size.width / 1.3,
                                height: 230,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0.0, 25.0, 0.0, 0.0)),
                                      Container(
                                        width: 250.0,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Campo nāo pode estar vazío';
                                            }
                                            return null;
                                          },
                                          controller: username,
                                          style: textStyle,
                                          decoration: InputDecoration(
                                              labelStyle: textStyle,
                                              labelText: 'Username',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0.0, 25.0, 0.0, 0.0)),
                                      Container(
                                          width: 250,
                                          height: 80,
                                          child: Center(
                                            child: FlatButton(
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          5.0)),
                                              onPressed: () async {
                                                print(_formKey.currentState
                                                    .validate());
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  _doRecoverypass();
                                                }
                                              },
                                              color: Color(0xFFfc5185),
                                              padding: EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Recuperar senha",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                )),
                          ],
                        )),
                      ))),
              inAsyncCall: _loadState),
        ));
  }

  _doRecoverypass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _loadState = true;
    });

    Map data = {"email": username.text};

    var recovery = await Services.recoverypass(data);

    if (recovery) {
      debugPrint('codo sending for email');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => RecoverycodeScreen()));
      // showInSnackBar(context, prefs.getString('msg_login'));
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
}
