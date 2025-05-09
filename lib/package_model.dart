class Package {
  final int packageId;
  final String packageImage;
  final String packageName;
  final String places;
  final String day1;
  final String day2;
  final String day3;
  final String day4;
  final String day5;
  final String day6;
  final double packagePrice;
  final String packageDate;
  final int duration;

  Package({
    required this.packageId,
    required this.packageImage,
    required this.packageName,
    required this.places,
    required this.day1,
    required this.day2,
    required this.day3,
    required this.day4,
    required this.day5,
    required this.day6,
    required this.packagePrice,
    required this.packageDate,
    required this.duration,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      packageId: json['package_id'],
      packageImage: json['package_image'],
      packageName: json['package_name'],
      places: json['places'],
      day1: json['day_1'],
      day2: json['day_2'],
      day3: json['day_3'],
      day4: json['day_4'],
      day5: json['day_5'],
      day6: json['day_6'],
      packagePrice: double.parse(json['package_price'].toString()),
      packageDate: json['package_date'],
      duration: int.parse(json['duration'].toString()),
    );
  }
}