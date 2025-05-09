import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vibe_tribe/hotel.dart';
import 'package:vibe_tribe/hotel_model.dart';

class allhotels extends StatefulWidget {
  const allhotels({super.key});

  @override
  State<allhotels> createState() => _allhotelsState();
}

class _allhotelsState extends State<allhotels> {
  late Future<Map<String, dynamic>> futureHotels;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    futureHotels = fetchHotels();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        futureHotels = fetchHotels();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<Map<String, dynamic>> fetchHotels() async {
    final response = await http.get(Uri.parse('http://192.168.249.97/register_api/fetch_hotels.php'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load hotels: ${response.statusCode}');
    }
  }

  List<HotelModel> parseHotels(Map<String, dynamic> json) {
    final List<dynamic> hotelList = json['hotels'] ?? [];
    return hotelList.map((data) => HotelModel.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<Map<String, dynamic>>(
            future: futureHotels,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || (snapshot.data!['hotels'] as List?)!.isEmpty ?? true) {
                return const Center(child: Text('No hotels found'));
              } else {
                final hotels = parseHotels(snapshot.data!);
                return SingleChildScrollView(
                  child: Column(
                    children: hotels.map((hotel) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  Hotel(hotel:hotel)),
                              );
                            },
                            child: Container(
                              height: 405,
                              width: 315,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.asset(
                                      "assets/taj.jpg",
                                      //'http://192.168.249.97/${hotel.image}',
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: 180,
                                          color: Colors.grey,
                                          child: const Center(child: Text('Image not available')),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: 20,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Colors.blueAccent.shade400,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "4.2",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "Very Good",
                                        style: TextStyle(
                                          color: Colors.blueAccent.shade400,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(width: 7),
                                      const Text(
                                        "(4853 Ratings)",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          hotel.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Icon(Icons.star, size: 15),
                                      ),
                                      const Icon(Icons.star, size: 14),
                                      const Icon(Icons.star, size: 14),
                                      const Icon(Icons.star, size: 14),
                                      const Icon(Icons.star, size: 14),
                                     
                                    ],
                                  ),
                                  const SizedBox(height: 0),
                                  Column(
                                    children: [
                                      Divider(
                                        thickness: 1,
                                        color: Colors.grey.shade400,
                                        indent: 10,
                                        endIndent: 150,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: Text(
                                          hotel.location,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                    
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 200),
                                        child: Text(
                                          "₹${hotel.originalPrice.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            decoration: TextDecoration.lineThrough,
                                            decorationColor: Colors.red,
                                            decorationThickness: 2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                       Padding(
                                        padding: const EdgeInsets.only(left: 170),
                                        child: Text(
                                          "₹${hotel.discountPrice.toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 23,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 215),
                                        child: Text(
                                          "(Per Night)",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:vibe_tribe/hotel.dart';

class allhotels extends StatefulWidget {
  const allhotels({super.key});

  @override
  State<allhotels> createState() => _allhotelsState();


}

class _allhotelsState extends State<allhotels> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
       appBar: AppBar(
        title: Text("VibeTribe",style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black),),
        centerTitle: true,
        toolbarHeight: 38,
        backgroundColor: Colors.lightBlue[300],
        
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.person))
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Hotel(),));
                    },
                    child: Container(
                      height: 410,
                      width: 315,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                           ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          child: Image.asset("assets/taj.jpg"),),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 20,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blueAccent.shade400,
                                  ),
                                  child: Center(
                                    child: Text("4.2",style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8,),
                              Text("Very Good",style: TextStyle(
                                color: Colors.blueAccent.shade400,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),),
                              SizedBox(width: 7,),
                              Text("(4853 Ratings)",style: TextStyle(
                                //color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),)
                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("Taj Skyline Ahmedabad",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                                ),),
                              ),
                            ],
                          ),
                         /*Row(
                            children: [                   
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Image.asset("assets/ratings1.webp",height: 65,width: 65,),
                              )
                            ],
                          ),*/
                          SizedBox(height: 3,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Icon(Icons.star,size: 15,),
                              ),
                              Icon(Icons.star,size: 14,),
                              Icon(Icons.star,size: 14,),
                              Icon(Icons.star,size: 14,),
                              Icon(Icons.star,size: 14,),                          
                              Padding(
                                padding: const EdgeInsets.only(left: 148),
                                child: Text("₹15,599",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.red,
                                  decorationThickness: 2
                                ),),
                              )
                            ],
                          ),
                          SizedBox(height: 0,),
                           Column(
                            children: [
                              Divider(
                                thickness: 1,
                                color: Colors.grey.shade400,
                                indent: 10,      // space from left
                                endIndent: 150
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text("Ahmedabad,Gujarat",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                                ),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 70),
                                child: Text("₹10,599",style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                    fontSize: 23,
                                ),),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 215),
                                child: Text("(Per Night)",style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}*/