class Pokemon {
  final int id;
  final String name;
  final String image;
  
  // Campos que vêm apenas da API (não são salvos no banco local para economizar espaço)
  final int? height;
  final int? weight;
  final String? type;
  
  // Campos que são salvos no banco local
  final String? comment;
  final int? rating;

  Pokemon({
    required this.id,
    required this.name,
    required this.image,
    this.height,
    this.weight,
    this.type,
    this.comment,
    this.rating,
  });
}
