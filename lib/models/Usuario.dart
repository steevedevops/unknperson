class Usuario {
  String sessionid;
  String fullName;
  String email;
  String urlapi;
  bool logado;
  String msg_login;
  Usuario({this.sessionid, this.fullName, this.email, this.urlapi, this.logado, this.msg_login});

  Usuario.fromJson(Map<String, dynamic> json) {
    sessionid = json['sessionid'];
    fullName = json['fullName'];
    email = json['email'];
    urlapi = json['urlapi'];
    logado = json['logado'];
    msg_login = json['msg_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessionid'] = this.sessionid;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['urlapi'] = this.urlapi;
    data['logado'] = this.logado;
    data['msg_login'] = this.msg_login;

    return data;
  }
}
