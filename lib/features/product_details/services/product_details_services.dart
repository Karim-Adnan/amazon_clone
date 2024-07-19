import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';
import '../../../constants/global_variables.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    try {
      Map<String, dynamic> body = {
        'id': product.id,
        'rating': rating,
      };

      Uri uri = Uri.http(baseUrl, '/api/rate-product');

      http.Response res = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(body),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(
        context: context,
        message: e.toString(),
      );
    }
  }
}
