import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'data/auth_api_service.dart';
import 'data/post_api_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AuthApiService>(
      child: MyApp(),
      create: (BuildContext context) {
        return AuthApiService.create();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PostApiService>(
          create: (_) => PostApiService.create(),
          dispose: (context, PostApiService service) => service.client.dispose(),
        ),
      ],
      child: MaterialApp(
        title: 'Travel Blog',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: FutureBuilder(
          // get the Provider, and call the getUser method
          future: Provider.of<AuthApiService>(context).getUser(),
          // wait for the future to resolve and render the appropriate
          // widget for HomePage or LoginPage
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.hasData ? Home(bearerToken: snapshot.data) : LoginPage();
            } else {
              return Container(color: Colors.white);
            }
          },
        ),
      ),
    );
  }
}
