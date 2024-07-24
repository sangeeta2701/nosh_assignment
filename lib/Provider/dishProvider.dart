import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nosh_task/model/dishListData.dart';

class DishProvider with ChangeNotifier {
  List<DishListData> _dishData = [];
  bool _loading = false;

  List<DishListData> get items => _dishData;
  bool get loading => _loading;

  Future<void> fetchItems() async {
    _loading = true;
    notifyListeners();
    try {
      final response =
          await http.get(Uri.parse("https://fls8oe8xp7.execute-api.ap-south-1.amazonaws.com/dev/nosh-assignment")).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data == null || data.isEmpty) {
          print('Error: No data received');
        } else {
          print('Data received: $data');
        }
      } else {
        print('Error: Server Error ${response.statusCode}');
      }
    } on SocketException {
      // Handle no internet connection error
      throw FetchDataException("No Internet Connection");
    } on TimeoutException {
      // Handle connection timeout error
     throw FetchDataException("Connection Timeout");
    } on http.ClientException {
      // Handle client-side errors
      throw FetchDataException("Something went wrong please try again");
      // print('Error: Client-side error');
    } on Exception catch (e) {
      throw FetchDataException("{$e}");
      // Handle any other exceptions
      
    }

    // final response = await http.get(Uri.parse('https://newsapi.org/v2/everything?q=tesla&from=2024-06-17&sortBy=publishedAt&apiKey=00a3bb0bad3c4dbbb7f644fde89befe2'));

    // if (response.statusCode == 200) {
    //   final List<dynamic> data = json.decode(response.body);
    //   _dishData = data.map((item) => DishListData.fromJson(item)).toList();
    // } else {
    //   throw Exception('Failed to load items');
    // }

    _loading = false;
    notifyListeners();
  }
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);
}
