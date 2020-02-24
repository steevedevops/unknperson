import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:date_format/date_format.dart';

class Formatters {
  
  static String formatCPF(String value){
    var cpfController = new MaskedTextController(text: '$value', mask: '000.000.000-00');
    cpfController.updateMask('000.000.0000-0');
    return cpfController.text;
  }

  static String formatDateString(String value){
    DateTime todayDate = DateTime.parse(value);
    // print(formatDate(todayDate, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
    return formatDate(todayDate, [dd, '/', mm, '/', yyyy]);
  }

}