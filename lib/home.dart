import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibe_tribe/aboutus.dart';
import 'package:vibe_tribe/all_packages.dart';
import 'package:vibe_tribe/all_treks.dart';
import 'package:vibe_tribe/brahmtal.dart';
import 'package:vibe_tribe/date_selection.dart';
import 'package:vibe_tribe/edit_profile.dart';
import 'package:vibe_tribe/kedarkantha.dart';
import 'package:vibe_tribe/kerala.dart';
import 'package:vibe_tribe/login.dart';
import 'package:vibe_tribe/message.dart';
import 'package:vibe_tribe/my_trips.dart';
import 'package:vibe_tribe/mywishlist.dart';
import 'package:vibe_tribe/packagedetailscreen.dart';
import 'package:vibe_tribe/preference.dart';
import 'package:vibe_tribe/manali.dart';
import 'package:vibe_tribe/goa.dart';
import 'package:vibe_tribe/profile.dart';
import 'package:vibe_tribe/tourpackages.dart';
import 'package:vibe_tribe/uttrakhand.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  //remove below code
  TextEditingController searchpackage=new TextEditingController();

  List<Map<String,dynamic>> allpackages=[
    {"name":"Manali","image":"assets/shimla_manali.png"},
    {"name":"Goa","image":"assets/goa.png"},
    {"name":"Kerala","image":"assets/kerala1.jpg"},
    {"name":"Uttrakhand","image":"assets/uttrakhand.webp"},
  ];

  List<Map<String,dynamic>> filteredpackage=[];

  @override
  void initState()
  {
    super.initState();
    filteredpackage=List.from(allpackages);
  }

  void filterresult(String query)
  {
    if(query.isEmpty)
    {
      setState(() {
        filteredpackage=List.from(allpackages);
      });
    }
    else
    {
      setState(() {
        filteredpackage=allpackages.where((package) => package["name"].toLowerCase()).toList();
      });
    }
  }


  int? selectedIndex;
  int myindex=0;

  File? image;

  Future<void> pickimage() async
  {
    final pickedFile=await ImagePicker().pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  final List<String> imagelist=[
    'assets/uttrakhand1.jpg',
    'assets/waterfall.jpg',
    'assets/kerala3.jpg',

  ];
  
  String fullname="Vandan Kacha";
  String email="vandankacha135@gmail.com";

  /*@override
  void initState()
  {
    super.initState();
    fetchdata();
    
  }*/

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("VibeTribe",style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black),),
        centerTitle: true,
        toolbarHeight: 38,
        backgroundColor: Colors.lightBlue[300],
        
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => message(),));
          }, icon: Icon(Icons.chat_rounded))
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: BottomNavigationBar(
          backgroundColor:Colors.lightBlue[300],
          onTap: (index){
            setState(() {
              myindex=index;
            });

            if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TourPackageDateSelector()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => profile()),
      );
    }
          },
          currentIndex: myindex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore_sharp),
            label: "Manual"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),      
            label: "Profile"
          )
        ]),
      ),
      drawer: Drawer(
       child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(fullname),
            accountEmail: Text(email),
            currentAccountPicture: GestureDetector(
              onTap: pickimage,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: image != null ? FileImage(image!) : null,
                child: image==null ? Icon(Icons.add_a_photo,size: 30,color: Colors.grey) : null,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
            ),
            SizedBox(height: 16,),
          Container(
            height: 35,
            child: ElevatedButton.icon(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => edit_profile(),));
            },
            icon: Icon(Icons.edit,color: Colors.white,), 
            label: Text("Edit Profile"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[700],
              foregroundColor: Colors.white,
            ),),
          ),
          SizedBox(height: 20,),
           Padding(
             padding: const EdgeInsets.only(left: 15),
             child: ListTile(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => my_trips(),));
              },
              leading: Icon(Icons.flight_outlined,size: 26,color: Colors.blueAccent,),
              title: Text("My Trips",style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),),
             ),
           ),
           SizedBox(height: 10,),
            Padding(
             padding: const EdgeInsets.only(left: 15),
             child: ListTile(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mywishlist(),));
              },
              leading: Icon(Icons.favorite,size: 26,color: Colors.blueAccent,),
              title: Text("My Wishlist",style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
             ),
           ),
            SizedBox(height: 10,),
            Padding(
             padding: const EdgeInsets.only(left: 15),
             child: ListTile(
              leading: Icon(Icons.info,size: 26,color: Colors.blueAccent,),
              title: Text("About us",style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => aboutus(),));
              },
             ),
           ),
            SizedBox(height: 10,),
            Padding(
             padding: const EdgeInsets.only(left: 15),
             child: ListTile(
              leading: Icon(Icons.logout,size: 26,color: Colors.blueAccent,),
              title: Text("logout",style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),),
             ),
           ),
        ],
       ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [          
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
          
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 260,left: 30),
                child: Text("Trending Packages",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),),
              ),
            ],
          ),
        
          Padding(
            padding: const EdgeInsets.only(top: 280,left: 15),
            child: SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(             
                    children:[                  
                      Container(
                        height: 140,
                        width: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => manali(),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(1, 5)
                                )
                              ]
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset("assets/shimla_manali.png",height: 90,width: 140),
                              ),
                          )),      
                        ),
                      
                      
                      Container(
                        margin: EdgeInsets.only(right: 12),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => goa(),));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(1, 5)
                                )
                              ]
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset("assets/goa.png",height: 90,)),
                          ))
                        ),
                      
                         Container(
                          margin: EdgeInsets.only(right: 12),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => kerala(),));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(1, 5)
                                  )
                                ]
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("assets/kerala1.jpg",height: 90,)),
                            ))
                          ),
                      
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => uttrakhand(),));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black45,
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(1, 5)
                                  )
                                ]
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset("assets/uttrakhand.webp",height: 90,)),
                            ))
                    ],
                ),
              ),
            ),
          ),
        
           Padding(
            padding: const EdgeInsets.only(top: 415,left: 300),
            child: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => tourpackages(),));
              },
              child: Text("see all",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),),
            ),
          ),
        
        Padding(
          padding: const EdgeInsets.only(top: 440,left: 30),
          child: Text("Trek & Explore",style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
        ),

        Row(
          children: [
            Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Kedarkantha(),));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 230, left: 30),
                              child: Container(
                                height: 150,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      color: Colors.grey,
                                      offset: Offset(3, 2)
                                    )
                                  ] 
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Column(
                                    children: [
                                      Expanded(
                        flex: 4, 
                        child: Image.asset(
                          "assets/trek1.jpeg",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                                      ),
                                      Expanded(
                        flex: 1, 
                        /*child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          alignment: Alignment.center,
                          */child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 22),
                                child: Text(
                                  "Kedarkantha",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
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
                    ),
                    SizedBox(width: 10,),
                     Padding(
                      padding: const EdgeInsets.only(top: 250),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => brahmtal(),));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 220, left: 20),
                              child: Container(
                                height: 150,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      color: Colors.grey,
                                      offset: Offset(3, 2)
                                    )
                                  ] 
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Column(
                                    children: [
                                      Expanded(
                        flex: 4, 
                        child: Image.asset(
                          "assets/brahmatal.webp",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                                      ),
                                      Expanded(
                        flex: 1, 
                        /*child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          alignment: Alignment.center,
                          */child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 34),
                                child: Text(
                                  "Brahmtal",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
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
                    ),
          ],
        ),

         Padding(
            padding: const EdgeInsets.only(top: 635,left: 300),
            child: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => tourpackages(),));
              },
              child: Text("see all",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),),
            ),
          ),
          /*ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Packagedetailscreen(),));
          }, child: Text("Package")),*/
          /*Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => tourpackages(),));
            },child:Text("All Packages")),
          )*/
        /*  Padding(
            padding: const EdgeInsets.only(top: 1180),
            child: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => preference(),));
            }, icon: Icon(Icons.arrow_back)),
          ),
        
          Padding(
            padding: const EdgeInsets.only(top: 495,left: 300),
            child: InkWell(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => all_packages(),));
              },
              child: Text("see all",style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),),
            ),
          ),
        
          Padding(
            padding: const EdgeInsets.only(top: 530,left: 30),
            child: Column(
              children: [
                Text("Summer Special",style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
          ),
         Row(
              children: [
                Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => kerala(),));
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 500, left: 20),
                                  child: Container(
                                    height: 210,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          color: Colors.grey,
                                          offset: Offset(3, 2)
                                        )
                                      ] 
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Column(
                                        children: [
                                          Expanded(
                            flex: 4, 
                            child: Image.asset(
                              "assets/kashmir1.jpg",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                                          ),
                          Expanded(
                            flex: 1, 
                            /*child: Container(
                              width: double.infinity,
                              color: Colors.white,
                              alignment: Alignment.center,
                              */child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Kashmir",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
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
                        ),
                        
                        SizedBox(width: 6,),
                         Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => kerala(),));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 500, left: 20),
                              child: Container(
                                height: 210,
                                width: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      color: Colors.grey,
                                      offset: Offset(3, 2)
                                    )
                                  ] 
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Column(
                                    children: [
                                      Expanded(
                        flex: 4, 
                        child: Image.asset(
                          "assets/mussoorie1.jpg",
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                                      ),
                      Expanded(
                        flex: 1, 
                        /*child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          alignment: Alignment.center,
                          */child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Mussoorie",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
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
                    ),
                  
              ],
            ),
          
                  SizedBox(height: 50,),
                  
                            Padding(
            padding: const EdgeInsets.only(top: 1180,left: 80),
            child: ElevatedButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TourPackageDateSelector(),));
            }, child: Text("Create Package Manually",style: TextStyle(
              color: Colors.white,
            ),),style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              )
            ),),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 840,left: 30),
            child: Column(
              children: [
                Text("Trek & Explore",style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),)
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 315),
            child: Row(
              children: [
                 Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => kerala(),));
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 500, left: 20),
                                  child: Container(
                                    height: 210,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          color: Colors.grey,
                                          offset: Offset(3, 2)
                                        )
                                      ] 
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Column(
                                        children: [
                                          Expanded(
                            flex: 4, 
                            child: Image.asset(
                              "assets/trek1.jpeg",
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                                          ),
                          Expanded(
                            flex: 1, 
                            /*child: Container(
                              width: double.infinity,
                              color: Colors.white,
                              alignment: Alignment.center,
                              */child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Kedarkantha",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
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
                        ),
                        
              ],
            ),
          )*/
          ],
        ),
      ),
    );
  }
}