import 'dart:io';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vibe_tribe/package_form.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class uttrakhand extends StatefulWidget {
  const uttrakhand({super.key});

  @override
  State<uttrakhand> createState() => _uttrakhandState();
}

class _uttrakhandState extends State<uttrakhand> {

  bool isLiked=false;

   ScreenshotController screenshotController=ScreenshotController();

    Future<void> shareScreenshot() async
    {
      final directory=await getApplicationDocumentsDirectory();
      final filePath='${directory.path}/screenshot.png';

       screenshotController.capture().then((image) async {
      if (image != null) {
        final file = File(filePath);
        await file.writeAsBytes(image);
        await Share.shareXFiles([XFile(file.path)], text: 'Check out this screen!');
      }
    }).catchError((e) {
      print('Error capturing screenshot: $e');
    });
    }


   final List<String> imagelist=[
    'assets/uttrakhand1.jpeg',
    'assets/uttrakhand2.jpeg',
    'assets/uttrakhand3.jpeg',
    'assets/uttrakhand4.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    return Screenshot(
       controller: screenshotController,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
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
           drawer: Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.black,
                    child: ClipOval(
                      child: SizedBox(
                        width: 95,
                        height: 95,
                        child: Image.asset('assets/virat.avif',),                  
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25,top: 20),
                  child: ListTile(
                    leading: Icon(Icons.account_circle,size: 30,color: Colors.blue,),
                    title: const Text("Profile",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,left: 25),
                  child: ListTile(
                    leading: Icon(Icons.settings,size: 30,color: Colors.blue,),
                    title: const Text("Settings",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,left: 25),
                  child: ListTile(
                    leading: Icon(Icons.info,size: 30,color: Colors.blue,),
                    title: const Text("About us",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,left: 25),
                  child: ListTile(
                    leading: Icon(Icons.logout,size: 30,color: Colors.blue,),
                    title: const Text("logout",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Stack(
              children: [     
                Positioned.fill(child: 
                TabBarView(children:[
                  ItineraryScreen(),
                  PricesScreen(),
                  DatesScreen(),
                  InclusionScreen(),
                ]),),
               CarouselSlider(
                options: CarouselOptions(
                  scrollPhysics: const BouncingScrollPhysics(),
                  height: 230.0,
                  autoPlay: true,
                  aspectRatio: 2,
                  enableInfiniteScroll: true,
                  viewportFraction: 1,
                ),
                items: imagelist.map((path) {
                  return ClipRRect(
                    child: Image.asset(
                      path,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 260,left: 20),
                child: Text("Kedarnath & Badrinath",style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 12,left: 305),
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle
                  ),
                  child: IconButton(onPressed: shareScreenshot, icon: Icon(Icons.share,size: 18,color: Colors.white,))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12,left: 260),
                child: Container(
                   width: 35,
                  height: 34,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle
                  ),
                  child: IconButton(onPressed: (){
                    setState(() {
                      isLiked=!isLiked;
                    });
                  }, icon: Icon(Icons.favorite),
                      color: isLiked? Colors.red : Colors.grey.shade100,iconSize: 20,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300,left: 20),
                child: Row(
                  children: [
                    Icon(Icons.wb_sunny,color: Colors.amber,),
                    SizedBox(width: 10,),
                    Text("9 Days & 8 Nights",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 330,left: 20),
                child: Text("Haridwar , Rishikesh , chopta , kedarnath,",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),),
              ),   
               Padding(
                padding: const EdgeInsets.only(top: 350,left: 20),
                child: Text("Badrinath , Tungnath",style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),),
              ),        
             Padding(
               padding: const EdgeInsets.only(top: 370,),
               child: Divider(
                color: Colors.grey[300], 
                thickness: 1.5,       
                indent: 20,         
                endIndent: 20,    
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 396,left: 20),
               child: Text("TOUR INCLUDES",style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
               ),),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 440,left: 50),
               child: Row(
                children: [
                  Container(
                    height: 105,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),                  
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.apartment_outlined,color: Colors.orangeAccent,size: 40,),
                        SizedBox(height: 5,),
                        Text(
                          "Hotel",style: TextStyle(
                            fontSize: 15
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 40,),
                  Container(
                    height: 105,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                        
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions_bus_filled_outlined,color: Colors.orangeAccent,size: 40,),
                        SizedBox(height: 5,),
                        Text(
                          "Transport",style: TextStyle(
                            fontSize: 15
                          ),
                        )
                      ],
                    ),
                  ),
                ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 570,left: 50),
               child: Row(
                children: [
                  Container(
                    height: 105,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),                  
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fastfood_outlined,color: Colors.orangeAccent,size: 40,),
                        SizedBox(height: 5,),
                        Text(
                          "Meals",style: TextStyle(
                            fontSize: 15
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 40,),
                  Container(
                    height: 105,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset(3, 3),
                        ),
                        
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined,color: Colors.orangeAccent,size: 40,),
                        SizedBox(height: 5,),
                        Text(
                          "Sightseeing",style: TextStyle(
                            fontSize: 15
                          ),
                        )
                      ],
                    ),
                  ),
                ],
               ),
             ),
              Padding(
                padding: const EdgeInsets.only(top: 700),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,             
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      ),
                    ]
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child:TabBar(
                        isScrollable: true,
                        /*indicator: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),*/
                        labelColor: Colors.orange,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            child: Row(
                              children: [
                                Icon(Icons.train),
                                SizedBox(width: 8,),
                                Text("Itinerary"),
                              ],
                            ),
                          ),
                           Tab(
                            child: Row(
                              children: [
                                Icon(Icons.currency_rupee_sharp),
                                SizedBox(width: 8,),
                                Text("Prices"),
                              ],
                            ),
                          ),
                           Tab(
                            child: Row(
                              children: [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 8,),
                                Text("Dates"),
                              ],
                            ),
                          ),
                           Tab(
                            child: Row(
                              children: [
                                Icon(Icons.checklist),
                                SizedBox(width: 8,),
                                Text("Inclusion"),
                              ],
                            ),
                          ),                       
                        ],
                      ),
                    ),
                  ),                            
                ),
              
            Padding(
              padding: const EdgeInsets.only(top: 1000),
              child: Container(
                height: 100,
                width: 100,
              ),
            ),     
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, -2),
                    )
                   ]
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Price Per Person \n ₹15,499/-",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: ElevatedButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => package_form(),));
                    }, child: Text("BOOK NOW",style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      )
                    ),),
                  ),
                  ],
                ),
              ),
            )   ,                            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItineraryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> itnerarydata=[
    {
      "day": "DAY 1",
      "title": "Ahmedabad - Delhi",
      "details": [
       "Train from Ahmedabad To Delhi",
       "Overnight Journey",
      ],
    },
      {
      "day": "DAY 2",
      "title": "Delhi - Haridwar/Rishikesh",
      "details": [
       "Pick up from Delhi and transfers to Haridwar/Rishikesh",
       "Visit Har Ki Pauri at Haridwar",
       "Take Part in Ganga Aarti",
       "Check-in to Hotel",
       "Dinner",
       "Overnight stay at Hotel",
      ],
    },
    {
      "day": "DAY 3",
      "title": "Haridwar - Guptkashi",
      "details": [
       "Rishikesh/ Haridwar -Rudraprayag/Guptkashi",
       "Morning after breakfast drive to Rudraprayag",
       "Enroute visit Devprayag & Rudraprayag Sangam",
       "On arrival check-in at Hotel, take some rest",
       "Dinner",
       "Overnight stay at hotel",
      ],
    },
     {
      "day": "DAY 4",
      "title": "Guptkashi - Kedarnath",
      "details": [
        "Rudraprayag/Guptkashi – Sitapur - Kedarnath (35 Kms & 22 Kms trek)",
        "Early morning checkout from the hotel and drive to Sitapur",
        "From here, we will start 22Kms trek to Kedarnath. Either by walk, Doli or by horse at own cost.",
        "In the evening visit Shankaracharya Samadhi behind the temple and take a part in evening Aarti.",
        "Stay at Kedarnath ( by your own )",
      ],
    },
    {
      "day": "DAY 5",
      "title": "Kedarnath - Chopta",
      "details": [
       "Kedarnath - Chopta (22 Kms Down Trek & 35 Kms 3 hrs approx by Road)",
       "Early morning (4:00 AM) go for temple darshan, and then trek down to Sitapur.",
       "Reach cab parking at Sitapur then proceed to Chopta.",
       "On arrival check-in the Camps.",
       "Dinner",
       "Overnight stay at the Camps.",
      ],
    },
     {
      "day": "DAY 6",
      "title": "Chopta - Tungnath - Pipalkoti/Joshimath",
      "details": [
       "Wake up early & witness the beautiful sunrise.",
       "Have breakfast & Checkout from Camps.",
       "Start your trek of 5 Km to Tungnath.",
       "Reach Tungnath & pay your respect at the highest abode of Lord Shiva.",
       "Then start your journey to most astonished Chandrashila peak (if weather permits)",
       "Proceed to Pipalkoti/Joshimath",
       "Check-in to Hotel",
       "Dinner",
       "Stay at Hotel",
      ],
    },
    {
      "day": "DAY 7",
      "title": "Badrinath",
      "details": [
       "Morning proceed to Badrinath take bath in Tapt Kund it’s also called Suryakund. Then go for temple darshan.",
       "After a short break go for interesting sightseeing of Mana Village (the firstvillage beforethe Tibetan border).",
       "Visit Vasudhara Waterfall, Vyas Gufa, Ganesh Gufa, Bhim pul and the Mukh of the Saraswati river.",
       "Evening return to Hotel, Dinner & Overnight stay at hotel",
      ],
    },
     {
      "day": "DAY 8",
      "title": "Pipalkoti/Joshimath - Haridwar",
      "details": [
       "Pipalkoti/Joshimath - Rishikesh/Haridwar",
       "Morning after breakfast drive to Rishikesh",
       "Reach Rishikesh & visit Laxman Jhula, Ram Jhula",
       "In evening take part in aarti in Triveni Ghat (if time permits)",
       "After aarti darshan return back to hotel for overnight stay.",
      ],
    },  
     {
      "day": "DAY 9",
      "title": "Haridwar - Delhi",
      "details": [
        "Rishikesh/Haridwar - Delhi (250 kms approx).",
        "After breakfast checkout from hotel",
        "Early Morning depart for Delhi",
        "Drop at Delhi",
        "Board train to Your City",
        "Trips End with wonderful Blessings & Everlasting Memories.",
      ],
    },      
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 780),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: itnerarydata.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.orange, width: 1),
              ),
              color: Colors.orange[50],
              child: ExpansionTile(
                tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                childrenPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  "${itnerarydata[index]["day"]} - ${itnerarydata[index]["title"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                children: itnerarydata[index]["details"].map<Widget>((detail) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Icon(Icons.circle, size: 8, color: Colors.orange),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            detail,
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
 
    );
  }
}

class PricesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Stack(
            children: [
                Padding(
                  padding: const EdgeInsets.only(top: 810,left: 25),
                  child: Text("DETAILED TOUR PRICE",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 840,left: 20),
                  child: Container(
                    height: 110,
                    width: 325,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),                  
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Column(
                        children: [
                          Text("₹ 15,499",style: TextStyle(
                            color: Colors.orange,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),),
                          SizedBox(height: 2,),
                          Text("Starting Price Per Person",style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                          ),),                      
                        ],
                      ),
                    ),
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.only(top: 960,left: 20),
                   child: Column(
                     children: [
                       Container(
                          height: 50,
                          width: 325,
                          color: Colors.grey[300],
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text("Room Sharing",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),),                      
                              ),
                              SizedBox(width: 50,),
                              Text("Basic Price",style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 18
                              ),)
                            ],
                          ),                   
                        ),
                        Container(
                    height: 50,
                    width: 325,
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Icon(Icons.person,color: Colors.orange,size: 28,),
                        ),
                        SizedBox(width: 6,),
                        Text("Single",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),),
                        SizedBox(width: 90,),
                        Text("₹ 24,999 /-",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                ),
                Container(
                    height: 50,
                    width: 325,
                    color: Colors.grey[300],
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Icon(Icons.supervisor_account,color: Colors.orange,size: 28,),
                        ),
                        SizedBox(width: 6,),
                        Text("Sharing",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),),
                        SizedBox(width: 80,),
                        Text("₹ 15,499 /-",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                ),
                Container(
                    height: 80,
                    width: 325,
                    color: Colors.white,
                        ),     
                     ],
                   ),
                 ),        
            ],
          ),
      ),
    );
  }
}
class DatesScreen extends StatelessWidget {
  const DatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 780,),
                child: Text("Departures:",style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month,color: Colors.orange,size: 25,),
                    SizedBox(width: 10,),
                    Text("May 2025",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[300], 
                thickness: 1.5,       
                indent: 20,         
                endIndent: 20,
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children:[ 
                    Container(
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      border: Border.all(
                        color: Colors.green,
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("10-May",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Text("7 Seats Available",style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(width: 19,),
                  Container(
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      border: Border.all(
                        color: Colors.green,
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("20-May",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Text("38 Seats Available",style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
                  ),
                  ]
                ),
              ),
              SizedBox(height: 15,),
                Padding(
                padding: const EdgeInsets.only(left: 30,),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month,color: Colors.orange,size: 25,),
                    SizedBox(width: 10,),
                    Text("June 2025",style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              ),
               Divider(
                color: Colors.grey[300], 
                thickness: 1.5,       
                indent: 20,         
                endIndent: 20,
              ),
              SizedBox(height: 10,),
               Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children:[ 
                    Container(
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      border: Border.all(
                        color: Colors.green,
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("6-June",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Text("30 Seats Available",style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(width: 19,),
                  Container(
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      border: Border.all(
                        color: Colors.green,
                        width: 1
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("21-June",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        SizedBox(height: 10,),
                        Text("10 Seats Available",style: TextStyle(
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
                  ),
                  ]
                ),
              ),  
              SizedBox(height: 60,),       
            ],
        ),
      ),
    );
  }
}

class InclusionScreen extends StatelessWidget {
  const InclusionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          children: [
            TabBarView(
              children: [
                inclusion(),
                exclusion(),
              ],
            ),
             Padding(
                padding: const EdgeInsets.only(top: 780,left: 30),
                child: Container(
                  width: 300,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,             
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      ),
                    ]
                  ),
                    child:TabBar(
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.blueAccent,
                        tabs: [
                          Tab(
                            child: Row(
                              children: [
                                Icon(Icons.check_circle),
                                SizedBox(width: 8,),
                                Text("Inclusion"),
                              ],
                            ),
                          ),
                           Tab(
                            child: Row(
                              children: [
                                Icon(Icons.cancel),
                                SizedBox(width: 8,),
                                Text("Exclusion"),
                              ],
                            ),
                          ),                
                        ],
                      ),
                    ),
                  ),                            
          ],
        ),
      ),
    );
  }
}

class inclusion extends StatelessWidget {
  const inclusion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 850),
        child: SingleChildScrollView(
          child: Column(
            children: [
             Padding(
               padding: const EdgeInsets.only(left: 30,top: 8),
               child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset:Offset(4, 4),
                      spreadRadius: 1,
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(Icons.local_taxi,color: Colors.blue[400],),
                      SizedBox(width: 20,),
                      Text("All Parking and Permit Charges",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
               ),
             ),
             SizedBox(height: 10,),
              Padding(
               padding: const EdgeInsets.only(left: 31,top: 8),
               child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset:Offset(4, 4),
                      spreadRadius: 1,
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.account_balance,color: Colors.green,),
                      SizedBox(width: 20,),
                      Text("All Transport and Toll Taxes",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
               ),
             ),
              SizedBox(height: 10,),
              Padding(
               padding: const EdgeInsets.only(left: 31,top: 8),
               child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset:Offset(4, 4),
                      spreadRadius: 1,
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.local_fire_department_rounded,color: Colors.yellow[600],),
                      SizedBox(width: 20,),
                      Text("Bonefire",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
               ),
             ),
             SizedBox(height: 10,),
              Padding(
               padding: const EdgeInsets.only(left: 31,top: 8),
               child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset:Offset(4, 4),
                      spreadRadius: 1,
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.hotel,color: Colors.purple,),
                      SizedBox(width: 20,),
                      Text("Hotel Accommodation",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
               ),
             ),
             SizedBox(height: 10,),
              Padding(
               padding: const EdgeInsets.only(left: 31,top: 8),
               child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset:Offset(4, 4),
                      spreadRadius: 1,
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.restaurant,color: Colors.brown,),
                      SizedBox(width: 20,),
                      Text("Meals",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}

class exclusion extends StatelessWidget {
  const exclusion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 850),
        child: SingleChildScrollView(
          child: Column(
            children: [
             Padding(
               padding: const EdgeInsets.only(left: 30,top: 8),
               child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset:Offset(4, 4),
                      spreadRadius: 1,
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(Icons.local_taxi,color: Colors.blue[400],),
                      SizedBox(width: 20,),
                      Text("4*4 Vehicle",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
               ),
             ),
             SizedBox(height: 10,),
              Padding(
               padding: const EdgeInsets.only(left: 31,top: 8),
               child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset:Offset(4, 4),
                      spreadRadius: 1,
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.home_outlined,color: Colors.green,),
                      SizedBox(width: 20,),
                      Text("Not Mentioned in Inclusion",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
               ),
             ),
              SizedBox(height: 10,),
              Padding(
               padding: const EdgeInsets.only(left: 31,top: 8),
               child: Container(
                height: 45,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset:Offset(4, 4),
                      spreadRadius: 1,
                    ),
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.terrain,color: Colors.brown,),
                      SizedBox(width: 20,),
                      Text("Cost of Additional Activities",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      ),)
                    ],
                  ),
                ),
               ),
             ),
            ],
          ),
        ),
      ),
    );
  }
}