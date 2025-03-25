import '../api/rest_api/public_client.dart';
import '../model/character.dart';
import '../utils/tools/requets_wrapper.dart';

class ContentRepository {
  final PublicClient _publicClient;

  ContentRepository(this._publicClient);

  Future<Characters?> getCharacters({required int page}) async =>
      appToastWrapper(() => _publicClient.getCharacters(page: page));
}
