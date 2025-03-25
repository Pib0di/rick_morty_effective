import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/character.dart';
import '../../utils/constants/endpoints.dart';

part 'public_client.g.dart';

@RestApi()
abstract class PublicClient {
  factory PublicClient(Dio dio) = _PublicClient;

  @GET(ApiEndpoints.characters)
  Future<Characters> getCharacters({@Query('page') required int page});
}
