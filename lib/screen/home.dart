import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unknperson/models/Fakeperson.dart';
import 'package:unknperson/screen/fakeperson-form.dart';
import 'package:unknperson/screen/login.dart';
import 'package:unknperson/services/api.dart';
import 'package:unknperson/utils/formatters.dart';
import 'package:unknperson/widget/sidebar/sidebar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name;
  String email;
  bool _loadState = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Fakeperson> fakepersonList;
  int countlist = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updatepersonListview();
    _getuserinformation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (prefs.getBool('statuslogin')) {
            Future.value(false);
          }
        },
        child: ModalProgressHUD(
            child: new Scaffold(
                key: _scaffoldKey,
                appBar: new AppBar(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                drawer: Sidebar(username: this.name, email: this.email),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {},
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(Icons.add),
                ),
                body: getHomeListView()),
            inAsyncCall: _loadState));
  }

  void showNotImplementedMessage() {
    Navigator.pop(context); // Dismiss the drawer.
    _scaffoldKey.currentState.showSnackBar(const SnackBar(
      content: Text("The drawer's items don't do anything"),
    ));
  }

  void _getuserinformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('fullname');
      email = prefs.getString('email');
    });
  }

  Future<void> _updatepersonListview() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      _loadState = true;
    });

    if (prefs.getBool('statuslogin')) {
      Future<List<Fakeperson>> fakepersonList = Services.getPersonFromapi();
      fakepersonList.then((result) {
        print(result);
        setState(() {
          this.fakepersonList = result;
          this.countlist = result.length;
          _loadState = false;
        });
      });
    } else {
      setState(() {
        _loadState = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  Widget getHomeListView() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ListView.builder(
          itemCount: countlist,
          itemBuilder: (BuildContext context, int position) {
            return InkWell(
                onTap: () async {
                  // formatnumber(position);

                  bool result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FakepersonformScreen(
                                fakeperson: fakepersonList[position],
                              )));
                  _updatepersonListview();
                  if (result == true) {/*Faca alima coisa*/}
                },
                child: Container(
                    child: Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: _cardListpendentes(context, position),
                )));
          },
        ));
  }

  // void navigateToAddVistoraItemsDetalhes() async {
  //   bool result =
  //       await Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return VisItemsDetalhesformScreen(
  //       vistoriaItemsDetalhes: null,
  //       title: 'Adicionar Detalhes',
  //       vistoriaItems: vistoriaItems,
  //     );
  //   }));
  //   _updateVistoriaDetalhesListView();
  //   if (result == true) {}
  // }

  Widget _cardListpendentes(BuildContext context, int position) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black38,
            width: 0.4,
          ),
        ),
      ),
      child: Container(
          padding: const EdgeInsets.all(0.0),
          child: SizedBox(
            // height: 80,
            height: (MediaQuery.of(context).size.height / (8.8)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl:
                      "http://d4169f38.ngrok.io${fakepersonList[position].fakepersonfields.fpImage}",
                  imageBuilder: (context, imageProvider) => Container(
                    width: (MediaQuery.of(context).size.width / (4.7)),
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.circular(60),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Container(
                    width: (MediaQuery.of(context).size.width / (4.3)),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('lib/assets/images/no-image.jpg'),
                            fit: BoxFit.fill)),
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 3.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  fakepersonList[position]
                                      .fakepersonfields
                                      .fpFullName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 2.0)),
                                AutoSizeText(
                                  fakepersonList[position]
                                      .fakepersonfields
                                      .fpEmail,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                  ),
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(bottom: 2.0)),
                                AutoSizeText(
                                  Formatters.formatCPF(fakepersonList[position]
                                      .fakepersonfields
                                      .fpCpf),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Icon(
                                          Icons.date_range,
                                          size: 12.0,
                                        ),
                                      ),
                                      Container(
                                        width: 5,
                                      ),
                                      Text(
                                        Formatters.formatDateString(
                                            fakepersonList[position]
                                                .fakepersonfields
                                                .fpBirthDate),
                                        //    fakepersonList[position]
                                        // .fakepersonfields
                                        // .fpBirthDate,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    // Status 1 e criado e status 2 e baixado
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 28.0,
                        color: Colors.grey,
                      ),
                    )),
              ],
            ),
          )),
    );
  }
}
