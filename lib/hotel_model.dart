class HotelModel {
  final int id;
  final String image;
  final String name;
  final String location;
  final String address;
  final String description;
  final double originalPrice;
  final double discountPrice;

  HotelModel({
    required this.id,
    required this.image,
    required this.name,
    required this.location,
    required this.address,
    required this.description,
    required this.originalPrice,
    required this.discountPrice,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: int.parse(json['id'].toString()),
      image: json['hotel_image'] ?? '',
      name: json['hotel_name'] ?? '',
      location: json['hotel_location'] ?? '',
      address: json['hotel_address'] ?? '',
      description: json['hotel_description'] ?? '',
      originalPrice: double.parse(json['original_price']?.toString() ?? '0.0'),
      discountPrice: double.parse(json['discount_price']?.toString() ?? '0.0'),
    );
  }
}