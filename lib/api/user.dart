import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/secure_storage.dart';

Future<int> registerUser(
  String firstName,
  String lastName,
  String email,
  String address,
  String postalCode,
  String city,
  String password,
) async {
  var url = Uri.parse('${dotenv.env['API_BASE_URL']}/music/api/users');
  var headers = {
    'accept': 'application/ld+json',
    'Content-Type': 'application/ld+json'
  };
  var body = jsonEncode({
    'email': email,
    'roles': ['ROLE_USER'],
    'password': password,
    'lastName': lastName,
    'firstName': firstName,
    'address': address,
    'postalCode': postalCode,
    'city': city,
  });

  try {
    var response = await http.post(url, headers: headers, body: body);
    return response.statusCode;
  } catch (e) {
    // Ignored
  }
  return 500;
}

Future<int> loginUser(String email, String password) async {
  var url =
      Uri.parse('${dotenv.env['API_BASE_URL']}/music/api/authentication_token');
  var headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json'
  };
  var body = jsonEncode({
    'email': email,
    'password': password,
  });

  try {
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var token = jsonResponse['token'];
      final storage = SecureStorage();
      await storage.writeToken(token);
    }
    return response.statusCode;    
  } catch (e) {
    // Ignored
  }
  return 500;
}
