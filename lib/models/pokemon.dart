class Pokemon {
  final int id;
  final String name;
  final String image;
  
  final int? height;
  final int? weight;
  final String? type;
  
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
