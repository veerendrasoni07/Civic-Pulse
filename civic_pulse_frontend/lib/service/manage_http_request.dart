import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

void showSnackBar(BuildContext context, String title,String message,ContentType contentType){
  final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
      content: AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: contentType
      )
  );

  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);

}


void manageHttpRequest( {
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}){
  final statusCode = response.statusCode;
  switch(statusCode){
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, "Bad Request", jsonDecode(response.body)['msg'], ContentType.warning);
      break;
    case 500:
      showSnackBar(context, "Error Occurred!", jsonDecode(response.body)['msg'], ContentType.failure);
      break;
    case 401:
      showSnackBar(context, "Unauthorized", jsonDecode(response.body)['msg'], ContentType.failure);
      break;
    case 404:
      showSnackBar(context, "Not Found", jsonDecode(response.body)['msg'], ContentType.failure);
      break;
    default:
      showSnackBar(context, "Something went wrong", jsonDecode(response.body)['msg'], ContentType.help);
  }
}