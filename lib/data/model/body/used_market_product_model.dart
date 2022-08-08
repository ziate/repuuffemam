class UsedMarketProductModel {
  final int id;
  final String name;
  final String description;
  final String price;
  final String address;
  final String phone;
  final String image;

  UsedMarketProductModel(
      {this.description,
      this.address,
      this.id,
      this.name,
      this.price,
      this.phone,
      this.image});

  factory UsedMarketProductModel.fromJson(Map<dynamic, dynamic> jsonData) {
    return UsedMarketProductModel(
      id: jsonData['id'],
      description: jsonData['description'],
      address: jsonData['address'],
      name: jsonData['name'],
      phone: jsonData['phone'],
      price: jsonData['price'],
      image: jsonData['image'],
    );
  }
}
