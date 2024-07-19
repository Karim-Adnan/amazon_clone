import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';

class SearchServices {
  Future<List<Product>> fetchSearchedProducts({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      Uri uri = Uri.http(
        baseUrl,
        '/api/products/search/$searchQuery',
      );

      http.Response res = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          List<dynamic> productsData = jsonDecode(res.body);

          for (var productData in productsData) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  productData,
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(
        context: context,
        message: e.toString(),
      );
    }
    return productList;
  }
}
