import 'package:chopper/chopper.dart';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/entry')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response> getPosts([
    // Parameter headers are suitable for ones which values need to change
    @Header('Authorization') String token,
  ]);

  @Get(path: '/{id}')
  // Query parameters are specified the same way as @Path
  // but obviously with a @Query annotation
  Future<Response> getPost(
      @Header('Authorization') String token,
      @Path('id') int id
  );

  @multipart
  @Post(headers: {'Connection':'Keep-Alive','Keep-Alive':'timeout=5, max=1000'})
  Future<Response> postPost(
      @Header('Authorization') String token,
      @Field('place') String place,
      @Field('comments') String comments,
      @PartFile('image') List<int> image,
  );

  static PostApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: 'http://192.168.0.101:80/Laravel_CRUD_API/public/api',
      services: [
        // The generated implementation
        _$PostApiService(),
      ],
      // Converts data to & from JSON and adds the application/json header.
      converter: JsonConverter(),
    );

    // The generated class with the ChopperClient passed in
    return _$PostApiService(client);
  }
}