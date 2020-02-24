import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:unknperson/models/Fakeperson.dart';
import 'package:unknperson/models/FakepersonFields.dart';
import 'package:unknperson/services/api.dart';
import 'package:unknperson/utils/formatters.dart';

class FakepersonformScreen extends StatefulWidget {
  Fakeperson fakeperson = Fakeperson();
  FakepersonformScreen({Key key, this.fakeperson}) : super(key: key);
  @override
  _FakepersonformScreenState createState() => _FakepersonformScreenState();
}

class _FakepersonformScreenState extends State<FakepersonformScreen> {
  Fakeperson fakeperson = Fakeperson();
  FakepersonFields fakepersonFields = FakepersonFields();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var maskFormatter = new MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

  TextEditingController nameperson = TextEditingController();
  TextEditingController emailperson = TextEditingController();
  TextEditingController cpfperson = TextEditingController();
  TextEditingController ageperson = TextEditingController();
  TextEditingController descriptionperson = TextEditingController();
  TextEditingController genderperson = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.fakeperson != null) {
      fakeperson = Fakeperson.fromJson(widget.fakeperson.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    nameperson.text = fakeperson != null ? fakeperson.fakepersonfields.fpFullName : '';
    emailperson.text =
        fakeperson != null ? fakeperson.fakepersonfields.fpEmail : '';
    cpfperson.text = fakeperson != null
        ? Formatters.formatCPF(fakeperson.fakepersonfields.fpCpf)
        : '';
      descriptionperson.text = fakeperson != null
        ? fakeperson.fakepersonfields.fpDescription
        : '';

       ageperson.text = fakeperson != null
        ?  fakeperson.fakepersonfields.fpAge.toString()
        : '';

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
            title: fakeperson.pk != null
                ? Text('${fakeperson.fakepersonfields.fpFullName}')
                : Text('Adicionando fakeperson')),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            _saveData();

          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.save),
        ),
        body: SingleChildScrollView(
            child: Form(
                key: _scaffoldKey,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(
                              0.0,
                              (MediaQuery.of(context).size.height / (28.0)),
                              0.0,
                              0.0)),
                      Center(
                          child: InkWell(
                              onTap: () async {
                                var resimg = await Services.getRandomeimg();

                                setState(() {
                                  fakeperson.fakepersonfields.fpImage = resimg;
                                });
                              },
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width / (2.6)),
                                height: 160.3,
                                padding: EdgeInsets.all(10.0),
                                child: CachedNetworkImage(
                                  // imageUrl: "http://70c03a0d.ngrok.io${fakeperson.fakepersonfields != null ? fakeperson.fakepersonfields.fpImage : ''}",
                                  imageUrl: "",
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: (MediaQuery.of(context).size.width /
                                        (4.7)),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(70),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    width: (MediaQuery.of(context).size.width /
                                        (4.7)),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(70),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'lib/assets/images/no-image.jpg'),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                              ))),
                      SizedBox(
                        height: 32,
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: (MediaQuery.of(context).size.width /
                                      (1.2)),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      fakeperson.fakepersonfields.fpFullName =
                                          value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
                                      return null;
                                    },
                                    controller: nameperson,
                                    style: textStyle,
                                    decoration: InputDecoration(
                                        labelText: 'Nome',
                                        labelStyle: textStyle,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        suffixIcon: InkWell(
                                            onTap: () async {
                                              var resfulname =
                                                  await Services.getnewName();

                                              setState(() {
                                                fakeperson.fakepersonfields
                                                    .fpFullName = resfulname;
                                              });
                                            },
                                            child: Container(
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  12.5),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black38,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.refresh,
                                                size: 25.0,
                                              ),
                                            ))),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width /
                                      (1.2)),
                                  child: TextFormField(
                                    onChanged: (value) {
                                      fakeperson.fakepersonfields.fpEmail =
                                          value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
                                      return null;
                                    },
                                    controller: emailperson,
                                    style: textStyle,
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: textStyle,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        suffixIcon: InkWell(
                                            onTap: () async {
                                              var resemail =
                                                  await Services.getEmail(
                                                      fakeperson
                                                          .fakepersonfields
                                                          .fpFullName);
                                              setState(() {
                                                fakeperson.fakepersonfields
                                                    .fpEmail = resemail;
                                              });
                                            },
                                            child: Container(
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  12.5),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black38,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.refresh,
                                                size: 25.0,
                                              ),
                                            ))),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width /
                                      (1.2)),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
                                      return null;
                                    },
                                    inputFormatters: [maskFormatter],
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      print(maskFormatter.getUnmaskedText());
                                      fakeperson.fakepersonfields.fpCpf =
                                          maskFormatter.getUnmaskedText();
                                    },
                                    controller: cpfperson,
                                    style: textStyle,
                                    decoration: InputDecoration(
                                        labelText: 'Cpf',
                                        labelStyle: textStyle,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        suffixIcon: InkWell(
                                            onTap: () async {
                                              var rescpf =
                                                  await Services.getnewCpf();

                                              setState(() {
                                                fakeperson.fakepersonfields
                                                    .fpCpf = rescpf;
                                              });
                                            },
                                            child: Container(
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  12.5),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black38,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.refresh,
                                                size: 25.0,
                                              ),
                                            ))),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width /
                                      (1.2)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      fakeperson.fakepersonfields.fpAge =
                                          int.parse(value);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
                                      return null;
                                    },
                                    controller: ageperson,
                                    style: textStyle,
                                    decoration: InputDecoration(
                                        labelText: 'Age',
                                        labelStyle: textStyle,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        suffixIcon: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  12.5),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  left: BorderSide(
                                                    color: Colors.black38,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.refresh,
                                                size: 25.0,
                                              ),
                                            ))),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: (MediaQuery.of(context).size.width /
                                      (1.2)),
                                  height: (MediaQuery.of(context).size.height /
                                      (5)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 50,
                                    onChanged: (value) {
                                      fakeperson.fakepersonfields
                                          .fpDescription = value;
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return;
                                      }
                                      return null;
                                    },
                                    controller: descriptionperson,
                                    style: textStyle,
                                    decoration: InputDecoration(
                                        hintText: 'Description',
                                        labelStyle: textStyle,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0))),
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ))));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  Future<void> _saveData() async {
    if (fakeperson.pk != null) {
      print('Atualizando informacoes ${fakeperson.fakepersonfields.fpCpf} ');
      var result = await Services.updateFakeperson(fakeperson);

      if (result) {
        print('Atualizado com sucesso');
        moveToLastScreen();
      } else {
        print('Nao foi posivel atualizar registro');
      }
    } else {
      print('Salvando informacoes');
      var result = await Services.updateFakeperson(fakeperson);
      if (result) {
        print('Salvo com sucesso');
        moveToLastScreen();
      } else {
        print('Nao foi posivel atualizar registro');
      }
    }
  }
}
