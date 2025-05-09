import 'package:flutter/material.dart';
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/kashmir.dart';
import 'package:vibe_tribe/valleyofflowers.dart';

class my_trips extends StatefulWidget {
  const my_trips({super.key});

  @override
  State<my_trips> createState() => _my_tripsState();
}

class _my_tripsState extends State<my_trips> {
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
        ),
        body: Column(
          children: [
           Stack(
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.lime,
                child: Center(child: Text("My Trips",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),),
              ),
               Padding(
                    padding: const EdgeInsets.only(top: 50),
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
                  IconButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(),));
                  }, icon: Icon(Icons.arrow_back_ios)),
            Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => kashmir(),));
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
                        "assets/kashmir3.webp",
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
            ],
           )
          ],
        ),
    );
  }
}