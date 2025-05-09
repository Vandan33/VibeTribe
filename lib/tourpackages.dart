import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/message.dart';
import 'package:vibe_tribe/package_details.dart';
import 'package:vibe_tribe/package_model.dart';

class tourpackages extends StatefulWidget {
  const tourpackages({super.key});

  @override
  State<tourpackages> createState() => _tourpackagesState();
}

class _tourpackagesState extends State<tourpackages> {
  late Future<Map<String, dynamic>> futurePackages;
  Timer? _timer;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    futurePackages = fetchPackages();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        futurePackages = fetchPackages();
      });
    });
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchPackages() async {
    final response = await http.get(Uri.parse('http://192.168.249.97/register_api/fetch_packages.php'));

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

  List<Package> sortPackages(List<Package> packages) {
    if (_searchQuery.isEmpty) {
      return packages;
    }
    final sortedPackages = List<Package>.from(packages);
    sortedPackages.sort((a, b) {
      final aName = a.packageName?.toLowerCase() ?? '';
      final bName = b.packageName?.toLowerCase() ?? '';
      final aMatches = aName.contains(_searchQuery);
      final bMatches = bName.contains(_searchQuery);
      if (aMatches && !bMatches) {
        return -1; // a comes before b
      } else if (!aMatches && bMatches) {
        return 1; // b comes before a
      }
      return 0; // maintain original order for non-matching or both matching
    });
    return sortedPackages;
  }

  bool hasMatchingPackages(List<Package> packages) {
    if (_searchQuery.isEmpty) {
      return true;
    }
    return packages.any((package) {
      final packageName = package.packageName?.toLowerCase() ?? '';
      return packageName.contains(_searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "VibeTribe",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 38,
        backgroundColor: Colors.lightBlue[300],
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => home(),));
        }, icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => message()),
              );
            },
            icon: const Icon(Icons.chat_rounded),
          ),
        
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search packages...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: const Icon(Icons.search, color: Colors.teal),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.teal),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal[200]!, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.teal[200]!, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.teal, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                ),
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: futurePackages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!['packages'].isEmpty) {
                  return const Center(child: Text('No packages found'));
                } else {
                  final packages = parsePackages(snapshot.data!);
                  if (_searchQuery.isNotEmpty && !hasMatchingPackages(packages)) {
                    return const Center(child: Text('Package is not available'));
                  }
                  final sortedPackages = sortPackages(packages);
                  return SingleChildScrollView(
                    child: Column(
                      children: sortedPackages.map((package) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => package_details(package: package),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 0),
                                  child: Container(
                                    height: 220,
                                    width: 330,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          color: Colors.grey,
                                          offset: Offset(3, 2),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Image.asset(
                                              "assets/kerala1.jpg",
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    '${package.packageName ?? 'No Name'}',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}