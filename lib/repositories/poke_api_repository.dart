import 'package:dio/dio.dart';
import '../models/pokemon.dart';

class PokeApiRepository {
  final Dio _dio = Dio();

  Future<List<Pokemon>> fetchPokemons({int limit = 50}) async {
    try {
      final response = await _dio.get('https://pokeapi.co/api/v2/pokemon?limit=$limit');
      final List results = response.data['results'];
      
      // Mapeia cada pokemon da lista para fazer uma busca dos seus detalhes (altura, peso, tipo)
      List<Future<Pokemon>> tasks = results.map((e) async {
        final detailsResponse = await _dio.get(e['url']);
        final data = detailsResponse.data;
        
        final types = data['types'] as List;
        final typeName = types.isNotEmpty ? types[0]['type']['name'] : 'unknown';

        return Pokemon(
          id: data['id'],
          name: data['name'],
          // Pega a imagem oficial
          image: data['sprites']['other']['official-artwork']['front_default'] ?? 
                 data['sprites']['front_default'] ?? '',
          type: typeName,
          height: data['height'], // vem da API em decimetros
          weight: data['weight'], // vem da API em hectogramas
        );
      }).toList();

      // Aguarda todas as requisições de detalhes terminarem
      return await Future.wait(tasks);
    } catch (e) {
      throw Exception('Erro ao buscar pokémons: $e');
    }
  }
}
