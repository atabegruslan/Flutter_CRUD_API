import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/post_api_service.dart';
import 'post.dart' as model;
import 'item_page.dart';
import 'create_page.dart';

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
        list.add(post);
      }

      return list;
    } else {
      print('Failed to load posts');
      return [];
    }
  }

  void _viewItem(BuildContext context, int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ItemPage(id: id, bearerToken: widget.bearerToken),
      ),
    );
  }

  void _create(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreatePage(bearerToken: widget.bearerToken),
      ),
    );
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
                      leading: Image.network(post.img_url),
                      onTap: () => _viewItem(context, post.id),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _create(context),
      ),
    );
  }
}
