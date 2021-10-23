import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/post_api_service.dart';

class ItemPage extends StatelessWidget {
  final int id;
  final String bearerToken;

  const ItemPage({
    Key key,
    this.id,
    this.bearerToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Blog'),
      ),
      body: FutureBuilder<Response>(
        future: Provider.of<PostApiService>(context).getPost('Bearer ' + bearerToken, id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final Map post = json.decode(snapshot.data.bodyString)['data'];
            return _buildPost(post);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Padding _buildPost(Map post) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            post['place'],
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(post['comments']),
          Image.network(post['img_url']),
        ],
      ),
    );
  }
}