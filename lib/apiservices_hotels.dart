import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package_model.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.10.97/register_api/fetch_hotels.php'; // Replace with your local IP

  Future<List<Package>> fetchPackages() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((data) => Package.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load packages');
    }
  }
}