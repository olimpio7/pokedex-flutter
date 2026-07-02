import 'package:dio/dio.dart';
import '../models/pokemon.dart';

class PokeApiRepository {
  final Dio _dio = Dio();

  Future<List<Pokemon>> fetchPokemons({int limit = 50}) async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon?limit=$limit');
      final List results = response.data['results'];
      
      List<Future<Pokemon>> tasks = results.map((e) async {
        final detailsResponse = await _dio.get(e['url']);
        final data = detailsResponse.data;
        
        final types = data['types'] as List;
        final typeName = types.isNotEmpty ? types[0]['type']['name'] : 'unknown';

        return Pokemon(
          id: data['id'],
          name: data['name'],
          image: data['sprites']['other']['official-artwork']['front_default'] ?? 
                 data['sprites']['front_default'] ?? '',
          type: typeName,
          height: data['height'],
          weight: data['weight'], 
        );
      }).toList();

      return await Future.wait(tasks);
    } catch (e) {
      throw Exception('Erro ao buscar pokémons: $e');
    }
  }
}
