import 'package:flutter/material.dart';

class DateConverter{
  String convertDate(String date){
    RegExp regExp = new RegExp(r"(\d{2}\s\w{3}\s\d{4})",caseSensitive: false);
    var dateExp = regExp.stringMatch(date);
    var splitted = dateExp.split(" ");
    List month = ['Jan', 'Feb', 'Mar', 'Apr', 'May','Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];
    var number = 1;
    for(int i = 0; i < month.length; i++){
      if(month[i] == splitted[1]){
        break;
      }
      number++;
    }
    return number.toString() + '/' + splitted[0] + '/' + splitted[2];
  }
}