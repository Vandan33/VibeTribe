import 'package:flutter/material.dart';
import 'package:vibe_tribe/brahmtal.dart';
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/kerala.dart';

class mywishlist extends StatefulWidget {
  const mywishlist({super.key});

  @override
  State<mywishlist> createState() => _mywishlistState();
}

class _mywishlistState extends State<mywishlist> {

  bool isLiked=true;

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
        body: Stack(
          children: [
            Container(
                height: 50,
                width: double.infinity,
                color: Colors.lime,
                child: Center(child: Text("My Whislist",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),),),              
              ),
                
               Padding(
                    padding: const EdgeInsets.only(top: 70,left: 15),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => kerala(),));
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
                        "assets/kerala1.jpg",
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
                                "Magical Kerala",
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
                    padding: const EdgeInsets.only(top: 310,left: 15),
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>brahmtal(),));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 0),
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
                   padding: const EdgeInsets.only(top: 85,left: 300),
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
                   padding: const EdgeInsets.only(top: 330,left: 300),
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
                 IconButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(),));
                  }, icon: Icon(Icons.arrow_back_ios)),
          ],
        ),
    );
  }
}