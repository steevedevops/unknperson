import 'package:unknperson/models/FakepersonFields.dart';

class Fakeperson {
  String model;
  int pk;
  FakepersonFields fakepersonfields;

  Fakeperson({this.model, this.pk, this.fakepersonfields});

  Fakeperson.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fakepersonfields =
        json['fields'] != null ? new FakepersonFields.fromJson(json['fields']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['model'] = this.model;
    data['pk'] = this.pk;
    if (this.fakepersonfields != null) {
      data['fields'] = this.fakepersonfields.toJson();
    }
    return data;
  }
}
