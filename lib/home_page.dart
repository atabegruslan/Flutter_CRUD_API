import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/post_api_service.dart';
import 'post.dart' as model;

class Home extends StatefulWidget {
  final String bearerToken;

  Home({ Key key, this.bearerToken }): super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<model.Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts(widget.bearerToken);
  }

  Future<List<model.Post>> fetchPosts(String bearerToken) async {
    final response = await Provider.of<PostApiService>(context, listen: false).getPosts('Bearer ' + bearerToken);

    if (response.statusCode == 200) {
      List rawList = json.decode(response.bodyString)['data']['data'].toList();
      List<model.Post> list = [];

      for (int i = 0; i < rawList.length; i++) {
        model.Post post = model.Post.fromJson(rawList[i]);
        print(post.place);
        print(post.comments);
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
      appBar: AppBar(
        title: Text("Travel Blog"),
      ),
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
                        post.place,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(post.comments),
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
