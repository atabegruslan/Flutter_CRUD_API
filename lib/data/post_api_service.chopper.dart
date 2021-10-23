// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$PostApiService extends PostApiService {
  _$PostApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = PostApiService;

  Future<Response> getPosts([String token]) {
    final $url = '/entry';
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getPost(String token, int id) {
    final $url = '/entry/${id}';
    final $headers = {'Authorization': token};
    final $request = Request('GET', $url, client.baseUrl, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> postPost(
      String token, String place, String comments, List<int> image) {
    final $url = '/entry';
    final $headers = {'Authorization': token,'Connection':'Keep-Alive','Keep-Alive':'timeout=5, max=1000'};
    final $body = {'place': place, 'comments': comments};
    final $parts = <PartValue>[PartValueFile<List<int>>('image', image)];
    final $request = Request('POST', $url, client.baseUrl,
        body: $body, parts: $parts, multipart: true, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
