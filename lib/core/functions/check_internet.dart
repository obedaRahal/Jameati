import 'dart:io';

import 'package:flutter/material.dart';

checkInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      debugPrint("im at checkinternet and there isssssssssss");
      return true ; 
    }
  } on SocketException catch(_) {
    debugPrint("im at checkinternet and there is nooooooooooooo");
    return false ;
  }
}