class FakepersonFields {
  String fpGender;
  String fpImage;
  String fpCpf;
  String fpFullName;
  String fpEmail;
  int fpAge;
  String fpBirthDate;
  String fpLatitude;
  String fpLongitude;
  String fpDescription;
  // int user;

  FakepersonFields(
      {this.fpGender,
      this.fpImage,
      this.fpCpf,
      this.fpFullName,
      this.fpEmail,
      this.fpAge,
      this.fpBirthDate,
      this.fpLatitude,
      this.fpLongitude,
      this.fpDescription,
      // this.user
      });

  FakepersonFields.fromJson(Map<String, dynamic> json) {
    fpGender = json['fp_gender'];
    fpImage = json['fp_image'];
    fpCpf = json['fp_cpf'];
    fpFullName = json['fp_fullName'];
    fpEmail = json['fp_email'];
    fpAge = json['fp_age'];
    fpBirthDate = json['fp_birthDate'];
    fpLatitude = json['fp_latitude'];
    fpLongitude = json['fp_longitude'];
    fpDescription = json['fp_description'];
    // user = json['User'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fp_gender'] = this.fpGender;
    data['fp_image'] = this.fpImage;
    data['fp_cpf'] = this.fpCpf;
    data['fp_fullName'] = this.fpFullName;
    data['fp_email'] = this.fpEmail;
    data['fp_age'] = this.fpAge;
    data['fp_birthDate'] = this.fpBirthDate;
    data['fp_latitude'] = this.fpLatitude;
    data['fp_longitude'] = this.fpLongitude;
    data['fp_description'] = this.fpDescription;
    // data['User'] = this.user;
    return data;
  }
}
