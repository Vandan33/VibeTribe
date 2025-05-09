import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vibe_tribe/package_model.dart';

class Packagedetailscreen extends StatefulWidget {
  const Packagedetailscreen({super.key});

  @override
  State<Packagedetailscreen> createState() => _PackagedetailscreenState();
}

class _PackagedetailscreenState extends State<Packagedetailscreen> {

  late Future<Map<String, dynamic>> futurePackages;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    futurePackages = fetchPackages(); // Initial fetch
    // Start polling every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        futurePackages = fetchPackages(); // Refresh data
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when screen is disposed
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchPackages() async {
    final response = await http.get(Uri.parse('http://192.168.249.97/register_api/fetch_packages.php')); // Replace with your IP

   if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load packages: ${response.statusCode}');
    }
  }

  List<Package> parsePackages(Map<String, dynamic> json) {
    final List<dynamic> packageList = json['packages'];
    return packageList.map((data) => Package.fromJson(data)).toList();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Package Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futurePackages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!['packages'].isEmpty) {
            return Center(child: Text('No packages found'));
          } else {
            final packages = parsePackages(snapshot.data!);
            return SingleChildScrollView(
              child: Column(
                children: packages.map((package) {
                  
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [             
                            package.packageImage.isNotEmpty
                          ? Image.network(
                              package.packageImage,
                              height: 200,
                           // Adjust height as needed
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(child: CircularProgressIndicator());
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 200,
                                  color: Colors.grey,
                                  child: Center(child: Text('Image failed to load: $error')),
                                );
                              },
                            )
                          : Container(
                              height: 200,
                              color: Colors.grey,
                              child: Center(child: Text('No Image Available')),
                            ),     
                        Text(
                          'Package Name: ${package.packageName ?? 'No Name'}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Places: ${package.places ?? 'No Places'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text('Day Details:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        TextField(
                          decoration: InputDecoration(labelText: 'Day 1', border: OutlineInputBorder()),
                          controller: TextEditingController(text: package.day1 ?? ''),
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(labelText: 'Day 2', border: OutlineInputBorder()),
                          controller: TextEditingController(text: package.day2 ?? ''),
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(labelText: 'Day 3', border: OutlineInputBorder()),
                          controller: TextEditingController(text: package.day3 ?? ''),
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(labelText: 'Day 4', border: OutlineInputBorder()),
                          controller: TextEditingController(text: package.day4 ?? ''),
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(labelText: 'Day 5', border: OutlineInputBorder()),
                          controller: TextEditingController(text: package.day5 ?? ''),
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        TextField(
                          decoration: InputDecoration(labelText: 'Day 6', border: OutlineInputBorder()),
                          controller: TextEditingController(text: package.day6 ?? ''),
                          readOnly: true,
                        ),
                        SizedBox(height: 10,),
                        Text("Price: ${package.packagePrice ?? 'No Price'}"),
                        Divider(thickness: 2, color: Colors.grey),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}