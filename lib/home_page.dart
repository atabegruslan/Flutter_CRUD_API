import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/post_api_service.dart';
import 'data/auth_api_service.dart';
import 'post.dart' as model;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<model.Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  Future<List<model.Post>> fetchPosts() async {

    final auth = await Provider.of<AuthApiService>(context, listen: false).login({'email': 'eve.holt@reqres.in', 'password': 'cityslicka'});
    String token = 'Bearer ';

    if (auth.statusCode == 200) {
      token += json.decode(auth.bodyString)['token'];
    } else {
      print('Failed to authenticate');
      token += '';
    }

    final response = await Provider.of<PostApiService>(context, listen: false).getPosts(token);
    //print(response.body);

    if (response.statusCode == 200) {
      List rawList = json.decode(response.bodyString)['data'].toList();
      print(rawList);
      List<model.Post> list = [];

      for (int i = 0; i < rawList.length; i++) {
        model.Post post = model.Post.fromJson(rawList[i]);
        print(post.name);
        print(post.color);
        list.add(post);
      }

      return list;
    } else {
      print('Failed to load posts');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<model.Post>>(
          future: futurePosts,
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.done) {
              List<model.Post> posts = snapshot.data ?? [];

              return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    model.Post post = posts[index];
                    return new ListTile(
                      title: new Text(
                        post.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(post.color),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

          }
      ),
    );
  }
}
