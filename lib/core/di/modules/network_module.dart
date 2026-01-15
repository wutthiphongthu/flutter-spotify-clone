import 'package:injectable/injectable.dart';

import '../../network/api.dart';
import '../../storage/token_storage.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  ApiClient apiClient(TokenStorage tokenStorage) {
    return ApiClient(
      baseUrl: 'https://api.example.com',
      tokenProvider: tokenStorage.readAccessToken,
    );
  }
}
