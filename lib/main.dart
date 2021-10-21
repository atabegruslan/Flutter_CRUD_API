import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/post_api_service.dart';
import 'data/auth_api_service.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PostApiService>(
          create: (_) => PostApiService.create(),
          dispose: (context, PostApiService service) => service.client.dispose(),
        ),
        Provider<AuthApiService>(
          create: (_) => AuthApiService.create(),
          dispose: (context, AuthApiService service) => service.client.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'Chopper Demo',
        home: Home(),
      ),
    );
  }
}