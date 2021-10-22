import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'auth_api_service.chopper.dart';

@ChopperApi(baseUrl: '/token')
abstract class AuthApiService extends ChopperService with ChangeNotifier {
  var bearerToken;

  @Post()
  Future<Response> login(@Body() Map<String, dynamic> body);

  Future<String> loginUser(String email, String password) async {
    var result = await login(
        {
          'username':email,
          'password':password,
          'client_id':4,
          'client_secret':'HJ6A8hdMVI9TvtgJUXC6b4xNNtOmzaYO8Q0T61ey',
          'grant_type':'password'
        }
    );

    if (result.statusCode == 200) {
      this.bearerToken = json.decode(result.bodyString)['access_token'];
      notifyListeners();

      return Future.value(bearerToken);
    } else {
      this.bearerToken = null;

      return Future.value(null);
    }
  }

  Future getUser() {
    return Future.value(bearerToken);
  }

  static AuthApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: 'http://192.168.0.101:80/Laravel_CRUD_API/public/oauth',
      services: [
        // The generated implementation
        _$AuthApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$AuthApiService(client);
  }
}