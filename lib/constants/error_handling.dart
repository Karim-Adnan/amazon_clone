import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  int? statusCode = response.statusCode;
  if (statusCode == 200) {
    onSuccess();
  } else if (statusCode == 400) {
    showSnackBar(
      context: context,
      message: json.decode(response.body)['message'],
    );
  } else if (statusCode == 500) {
    showSnackBar(
      context: context,
      message: json.decode(response.body)['error'],
    );
  } else {
    showSnackBar(
      context: context,
      message: response.body,
    );
  }
}
