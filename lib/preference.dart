import 'package:flutter/material.dart';
import 'package:vibe_tribe/login.dart';
import 'package:vibe_tribe/home.dart';
class preference extends StatefulWidget {
  const preference({super.key});

  @override
  State<preference> createState() => _preferenceState();
}

class _preferenceState extends State<preference> {
  bool isSelected=false;
  bool isSelected1=false;
  bool camping=false;
  bool skydiving=false;
  bool skiing=false;
  bool running=false;
  bool swimming=false;
  bool cricket=false;
  bool cycling=false;
  bool golfing=false;
  bool yoga=false;
  bool spa=false;
  bool sunbath=false;
  bool museum=false;
  bool festival=false;
  bool crafts=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(        
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 33),
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => login(),));
            }, icon: Icon(Icons.arrow_back),color: Colors.black,iconSize: 25,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 75),
                child: Text("What are your intrests?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 130,left: 16),
                child: Text("Adventure",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 170,left: 16),
                    child: InputChip(label: Text("zip-line"),
                    avatar: CircleAvatar(backgroundImage:AssetImage('assets/zip.jpg'),),
                    selected: isSelected,
                    onPressed: (){
                      setState(() {
                        isSelected=!isSelected;
                      });
                    },
                    selectedColor: Colors.green.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 170,left: 12),
                    child: InputChip(label: Text("Hiking"),
                    selected: isSelected1,
                    avatar: CircleAvatar(backgroundImage: AssetImage('assets/hiking.jpeg'),),
                    onPressed: (){
                        setState(() {
                          isSelected1=!isSelected1;
                        });
                    },
                    selectedColor: Colors.green.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 170,left: 12),
                    child: InputChip(label: Text("Camping"),
                    selected: camping,
                    onPressed: (){
                      setState(() {
                        camping=!camping;
                      },);
                    },
                    selectedColor: Colors.green.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    avatar: CircleAvatar(backgroundImage: AssetImage('assets/camping.jpg'),),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 225,left: 16),
                    child: InputChip(label: Text("Sky-Diving"),
                    selected: skydiving,
                    onPressed: (){
                      setState(() {
                        skydiving=!skydiving;
                      });
                    },
                    selectedColor: Colors.green.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    avatar: CircleAvatar(backgroundImage: AssetImage('assets/skydiving.jpg'),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 225,left: 12),
                    child: InputChip(label: Text("Skiing"),
                    selected: skiing,
                    onPressed: (){
                      setState(() {
                        skiing=!skiing;
                      });
                    },
                    selectedColor: Colors.green.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    avatar: CircleAvatar(backgroundImage: AssetImage('assets/skiing1.jpg'),),
                    ),
                  )
                ],
              ),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 300,left: 16),
                    child: Text("Sports & Fitness",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  )
                ],
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 340,left: 16),
                    child: InputChip(label: Text("Running"),
                    selected: running,
                    onPressed: (){
                      setState(() {
                        running=!running;
                      });
                    },
                    selectedColor: Colors.green.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    avatar: CircleAvatar(backgroundImage: AssetImage('assets/running.png'),),),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 340,left: 12),
                    child: InputChip(label: Text("Cricket"),
                    selected: cricket,
                    onPressed: (){
                      setState(() {
                        cricket=!cricket;
                      });
                    },
                    selectedColor: Colors.green.shade100,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    avatar: CircleAvatar(backgroundImage: AssetImage('assets/cricket.jpg'),),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 340,left: 12),
                    child: InputChip(label: Text("Golfing"),
                    selected: golfing,
                    onPressed: (){
                      setState(() {
                        golfing=!golfing;
                      });
                    },
                    selectedColor: Colors.green.shade200,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    avatar: CircleAvatar(backgroundImage: AssetImage('assets/golfing.jpg'),),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 395,left: 16),
                     child: InputChip(label: Text("Swimming"),
                     selected: swimming,
                     onPressed: (){
                      setState(() {
                        swimming=!swimming;
                      });
                     },
                     selectedColor: Colors.green.shade200,
                     avatar: CircleAvatar(backgroundImage: AssetImage('assets/swimming.jpg'),),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 395,left: 12),
                     child: InputChip(label: Text("Cycling"),
                     selected: cycling,
                     onPressed: (){
                      setState(() {
                        cycling=!cycling;
                      });
                     },
                     selectedColor: Colors.green.shade200,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                     avatar: CircleAvatar(backgroundImage: AssetImage('assets/cycling.jpg'),),
                     ),
                   )
                ],
              ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 470,left: 16),
                  child: Text("Relaxation & Wellness",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                )
              ],
            ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 510,left: 16),
                child: InputChip(label: Text("Yoga"),
                selected: yoga,
                onPressed: (){
                  setState(() {
                    yoga=!yoga;
                  });
                },
                selectedColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                avatar: CircleAvatar(backgroundImage: AssetImage('assets/Yoga.jpg'),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 510,left: 12),
                child: InputChip(label: Text("Spa"),
                selected: spa,
                onPressed: (){
                  setState(() {
                    spa=!spa;
                  });
                },
                selectedColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                avatar: CircleAvatar(backgroundImage: AssetImage('assets/spa.jpg'),),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 510,left: 12),
                child: InputChip(label: Text("Sunbathing"),
                selected: sunbath,
                onPressed: (){
                  setState(() {
                    sunbath=!sunbath;
                  });
                },
                selectedColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                avatar: CircleAvatar(backgroundImage: AssetImage('assets/sunbathing.jpg'),),
                ),
              )
            ],
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 580,left: 16),
                child: Text("Cultural & Historical ",style:TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),),
              )
            ],
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 620,left: 16),
                child: InputChip(label: Text("Museum Visit"),
                selected: museum,
                onPressed: (){
                  setState(() {
                    museum=!museum;
                  });
                },
                selectedColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                avatar: CircleAvatar(backgroundImage: AssetImage('assets/museum.avif'),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 620,left: 12),
                child: InputChip(label: Text("Cultural Festivals"),
                selected: festival,
                onPressed: (){
                  setState(() {
                    festival=!festival;
                  });
                },
                selectedColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                avatar: CircleAvatar(backgroundImage: AssetImage('assets/festival.jpg'),),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 675,left: 16),
                child: InputChip(label: Text("Traditional Crafts"),
                selected: crafts,
                onPressed: (){
                  setState(() {
                    crafts=!crafts;
                  });
                },
                selectedColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                avatar: CircleAvatar(backgroundImage: AssetImage('assets/craft.jpg'),),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 710),
            child: Center(
              child: Container(
                width: 340,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => home(),));
                }, child: Text("Next",style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[500],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                  elevation: 8,
                ),)),
            ),
          )
        ],
      ),
    );
  }
}