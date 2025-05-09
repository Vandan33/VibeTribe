import 'package:flutter/material.dart';
import 'package:vibe_tribe/package_form.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class ladakh extends StatefulWidget {
  const ladakh({super.key});

  @override
  State<ladakh> createState() => _ladakhState();
}

class _ladakhState extends State<ladakh> {

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
              Image.asset("assets/ladakh.jpg",),
              Padding(
                padding: const EdgeInsets.only(top: 260,left: 20),
                child: Text("Ladakh",style: TextStyle(
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
                padding: const EdgeInsets.only(top: 300,left: 20),
                child: Row(
                  children: [
                    Icon(Icons.wb_sunny,color: Colors.amber,),
                    SizedBox(width: 10,),
                    Text("12 Days & 11 Nights",style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 330,left: 20),
                child: Text("Amritsar , Srinagar , Kargil , Leh , Nubra , Pangong , Manali",style: TextStyle(
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
                      child: Text("Price Per Person \n ₹30,499/-",style: TextStyle(
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
      "title": "Your City - Delhi",
      "details": [
      "Train from your city to Delhi.",
      "Overnight Journey"
      ],
    },
      {
      "day": "DAY 2",
      "title": "Delhi - Amritsar",
      "details": [  
      "Pickup from Delhi & proceed to Amritsar",
      "Evening reach at Amritsar",
      "Check-in to Hotel",
      "Visit Golden Temple by own",
      "Overnight stay at Amritsar"
      ],
    },
    {
      "day": "DAY 3",
      "title": "Amritsar - Srinagar",
      "details": [
        "Morning 6:00 AM checkout from Hotel & proceed to Srinagar",
        "Enroute Breakfast",
        "Will pass through Syama Prasad Mookerjee Tunnel (Longest road tunnel of India, 9.35KM)",
        "Evening reach to Srinagar",
        "Check-in to Hotel",
        "Dinner",
        "Overnight stay at Srinagar",
      ],
    },
     {
      "day": "DAY 4",
      "title": "Srinagar Local Seightseeing",
      "details": [
        "After breakfast checkout from hotel and Proceed for Local sightseeing of Srinagar",
        "Visit Mughal Gardens: Nishant Bagh, Shalimar Bagh & Shri Shankaracharya Temple",
        "Check-in to House Boat",
        "Enjoy 1 Hour of Shikara Ride",
        "Dinner",
        "Overnight stay at House Boat"
      ],
    },
    {
      "day": "DAY 5",
      "title": "Srinagar to Kargil",
      "details": [
        "Breakfast",
        "Checkout and proceed to Kargil enroute visit Sonmarg",
        "The route towards Sonamarg takes us on a picturesque countryside drive where we will come across rolling hills, green forests, clear water streams and blooming rice fields.",
        "Then head towards Drass, the coldest inhabited place in India & often called as Gateway to Ladakh, via the Zoji La Pass.",
        "In the evening reach at Kargil",
        "Dinner & Stay at Kargil",
      ],
    },
     {
      "day": "DAY 6",
      "title": "Kargil - Leh",
      "details": [
        "Breakfast",
        "Checkout and proceed to Leh",
        "Enroute visit Visit Lamayuru Moonland of Ladakh Magnetic Hill, Pathar Sahib Gurudwara, Sangam of The Zanskar & Indus River & Rafting Point",
        "Check-in and rest in leisure",
        "Prepare yourself for Adventure of Ladakh",
        "Stay at Leh",

      ],
    },
     {
      "day": "DAY 7",
      "title": "Leh to Nubra",
      "details": [
        "Breakfast",
        "Checkout and proceed to Nubra Valley",
        "Crosses famous Khardung La Pass (Second highest accessible motorable Pass)",
        "Enjoy & Feel the cold desert of Ladakh at Hunder",
        "Feel free to Enjoy Double hump Camel ride in Hunder (by own)",
        "Have Dinner with Music Party & Bonfire",
        "Overnight stay at Camps"
      ],
    },
     {
      "day": "DAY 8",
      "title": "Nubra to Pongong",
      "details": [
       "After Breakfast checkout from Camp",
       "Visit Diskit Monastery",
       "Proceed to Pangong Lake via Shyok Valley",
       "On arrival at Pangong, check-in to Camps & enjoy the coolest breeze of Lake",
       "Dinner",
       "Stay at Camps"
      ],
    },
     {
      "day": "DAY 9",
      "title": "Pongong to Leh",
      "details": [
      "Breakfast",
      "Checkout and Proceed Back to Leh, Will pass through ChangLa Pass",
      "Enroute visit Hemis Monastery, 3 Idiot School & Shey Palace",
      "Reach Leh by Evening",
      "Visit Shanti Stupa, Leh Palace and Explore Leh Market",
      "Check-in at Hotel",
      "Dinner",
      ],
    },
    {
      "day": "DAY 10",
      "title": "Leh to Manali",
      "details": [
        "After breakfast checkout from hotel",
        "Proceed to Manali at 6:00 AM",
        "Pass through 3 passes : Taglang La, Lachalung La & Baralacha La",
        "En-route explore More Plains, Gata Loops, Atal Tunnel",
        "Reach Manali by Evening",
        "Check-in to Hotel",
        "Dinner",
        "Overnight stay at Hotel"
      ],
    },
     {
      "day": "DAY 11",
      "title": "Manali to Delhi",
      "details": [
        "After breakfast checkout from hotel",
        "Visit Hadimba temple, Van Vihar, Buddhist Monastery & Mall Road",
        "Evening departure from Manali to Delhi",
        "Overnight Journey",
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
                          Text("₹ 30,499",style: TextStyle(
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
                        Text("₹ 30,499 /-",style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),)
                      ],
                    ),
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
                    Text("July 2025",style: TextStyle(
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
                          child: Text("5-July",style: TextStyle(
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
                          child: Text("15-July",style: TextStyle(
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
                    Text("July 2025",style: TextStyle(
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
                          child: Text("10-July",style: TextStyle(
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
                          child: Text("20-July",style: TextStyle(
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
