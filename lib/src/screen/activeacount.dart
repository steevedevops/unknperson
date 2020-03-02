import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/services/api.dart';
import 'package:unknperson/src/screen/login.dart';
import 'package:unknperson/src/screen/subscribe.dart';

class ActiveacountScreen extends StatefulWidget {
  @override
  _ActiveacountScreenState createState() => _ActiveacountScreenState();
}

class _ActiveacountScreenState extends State<ActiveacountScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController activationcode = TextEditingController();

  bool _loadState = false;
  String emailuse;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    _setEmail();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    // username.text = "dornel.fabio2@gmail.com";
    // username.text = "fil20105@eoopy.com";

    return WillPopScope(
        onWillPop: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (prefs.getBool('statuslogin')) {
            Future.value(false);
          }
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
                                height: 370,
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              0.0, 25.0, 0.0, 0.0)),
                                      Container(
                                        width: 250.0,
                                        child: Text(
                                          'Email to activate: ${emailuse}',
                                          style: TextStyle(
                                              fontSize: 13.0,
                                              fontFamily: "WorkSansSemiBold"),
                                        ),
                                      ),
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
                                          controller: activationcode,
                                          style: textStyle,
                                          decoration: InputDecoration(
                                              labelStyle: textStyle,
                                              labelText: 'Activation code',
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0))),
                                        ),
                                      ),
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
                                                  _doActivate();
                                                }
                                              },
                                              color: Color(0xFFfc5185),
                                              padding: EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Activate",
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
                                      Container(
                                          width: 250,
                                          child: Center(
                                            child: FlatButton(
                                              shape: new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          5.0)),
                                              onPressed: () async {
                                                _resendCodActivations();
                                              },
                                              color: Color(0xFFfc5185),
                                              padding: EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Reenviar codigo",
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
                                               Navigator.push(context, MaterialPageRoute(builder: (context) => SubscribeScreen()));
                                              },
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              padding: EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    "Voltar",
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

  _doActivate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _loadState = true;
    });

    Map data = {"email": prefs.getString('email'), "code": activationcode.text};

    var activate = await Services.getActivate(data);

    if (activate) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      showInSnackBar(context, prefs.getString('msg_login'));
    }
    setState(() {
      _loadState = false;
    });
  }

  _resendCodActivations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _loadState = true;
    });

    Map data = {
      "email": emailuse
    };

    var activate = await Services.resendCodActivations(data);

    if (activate) {
      showInSnackBar(context, prefs.getString('msg_login'));
    } else {
      showInSnackBar(context, prefs.getString('msg_login'));
    }
    setState(() {
      _loadState = false;
    });
  }

  Future<void> _setEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      emailuse = prefs.getString('email');
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
