import 'package:flutter/material.dart';
import 'package:vibe_tribe/brahmtal.dart';
import 'package:vibe_tribe/harkidun.dart';
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/kedarkantha.dart';
import 'package:vibe_tribe/kerala.dart';
import 'package:vibe_tribe/rupinpass.dart';
import 'package:vibe_tribe/uttrakhand.dart';
import 'package:vibe_tribe/valleyofflowers.dart';

class all_treks extends StatefulWidget {
  const all_treks({super.key});

  @override
  State<all_treks> createState() => _all_treksState();
}

class _all_treksState extends State<all_treks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
              Stack(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(),));
                  }, icon: Icon(Icons.arrow_back)),
                  Padding(
            padding: const EdgeInsets.only(top: 30,left: 55),
            child: Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  )
                ]
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "Search Destinations",
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 2,
                    )
                  )
                ),
                
              ),
            ),
          ),
              
                  Padding(
                    padding: const EdgeInsets.only(top: 80),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Kedarkantha(),));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Container(
                              height: 220,
                              width: 330,
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
                                "Kedarkantha Trek",
                                style: TextStyle(
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 320),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>brahmtal(),));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Container(
                              height: 220,
                              width: 330,
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
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Brahmtal Trek",
                                style: TextStyle(
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
                  ),  
                      Padding(
                    padding: const EdgeInsets.only(top: 560),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => harkidun(),));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Container(
                              height: 220,
                              width: 330,
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
                        "assets/harkidun.jpg",
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
                                "Har Ki Dun Trek (Summer)",
                                style: TextStyle(
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
                  ), 
                   Padding(
                    padding: const EdgeInsets.only(top: 800),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => rupinpass(),));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Container(
                              height: 220,
                              width: 330,
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
                        "assets/rupinpasstrek.avif",
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
                                "Rupin Pass Trek (Summer)",
                                style: TextStyle(
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
                  ),    
                   Padding(
                    padding: const EdgeInsets.only(top: 1040),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => valleyofflowers(),));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 15),
                            child: Container(
                              height: 220,
                              width: 330,
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
                        "assets/valleyofflowers.avif",
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
                                "Valley of flowers (Monsoon)",
                                style: TextStyle(
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
                          SizedBox(height: 30,),
                        ],
                      ),
                    ),
                  ),       
                ],
                
              )
          ],
        ),
      ),
    );
  }
}