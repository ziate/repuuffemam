class Brand {
  final int id;
  final String name;
  final String image;

  Brand({this.id, this.name, this.image});

  factory Brand.fromJson(Map<dynamic, dynamic> jsonData) {
    return Brand(
        image: jsonData['img'], id: jsonData['id'], name: jsonData['name']);
  }
}
