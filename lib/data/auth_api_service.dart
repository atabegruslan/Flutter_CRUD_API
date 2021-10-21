import 'package:chopper/chopper.dart';

// Source code generation in Dart works by creating a new file which contains a "companion class".
// In order for the source gen to know which file to generate and which files are "linked", you need to use the part keyword.
part 'auth_api_service.chopper.dart';

@ChopperApi(baseUrl: '/login')
abstract class AuthApiService extends ChopperService {

  @Post()
  Future<Response> login(
      @Body() Map<String, dynamic> body,
  );

  static AuthApiService create() {
    final client = ChopperClient(
      // The first part of the URL is now here
      baseUrl: 'https://reqres.in/api', // Dummy for Testing
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