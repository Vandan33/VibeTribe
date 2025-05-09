import 'package:flutter/material.dart';
import 'package:vibe_tribe/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:vibe_tribe/map.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:vibe_tribe/home.dart';

class edit_profile extends StatefulWidget {
  const edit_profile({super.key});

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {

  String selectedgender="Male";
  GoogleMapController? mapController;
  LatLng? selectedLocation;
  String address="Select a Location";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  width:double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: GestureDetector(
                                      onTap: pickimage,
                                      child: CircleAvatar(
                                        radius: 46,
                                        backgroundColor: Colors.white,
                                        backgroundImage: image != null ? FileImage(image!) : null,
                                        child: image==null ? Icon(Icons.add_a_photo,size: 30,color: Colors.blueGrey) : null,
                                      ),
                                    ),
                      ),
                      SizedBox(height: 10,),
                      Text("Change Profile Photo",style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),)
                    ],
                  )
                ),
                SizedBox(height: 35,),
                Container(
                  width: 250,
                  height: 50,
                  child: TextFormField(
                      decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue.shade300,width: 2)
                                  ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.orange,width: 1.5)
                                ),
                                hintText: "Full Name",
                                hintStyle: TextStyle(
                                  color: Colors.blueAccent.shade400,
                                ),
                                label: Text("Full Name"),
                                labelStyle: TextStyle(
                                  color: Colors.blueAccent.shade400,
                                ),
                                prefixIcon: Icon(Icons.person,color: Colors.blue[900],),
                                ),
                              
                    ),
                  ),
                  SizedBox(height: 20,),
                   Container(
                  width: 250,
                  height: 50,
                  child: TextFormField(
                      decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue.shade300,width: 2)
                                  ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.orange,width: 1.5)
                                ),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.blueAccent.shade400,
                                ),
                                label: Text("Email"),
                                labelStyle: TextStyle(
                                  color: Colors.blueAccent.shade400,
                                ),
                                 prefixIcon: Icon(Icons.email,color: Colors.blue[900],)
                                ),
                    ),
                  ),
                  SizedBox(height: 20,),
                   Container(
                  width: 250,
                  height: 50,
                  child: TextFormField(
                      decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue.shade300,width: 2)
                                  ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.orange,width: 1.5)
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.blueAccent.shade400,
                                ),
                                label: Text("Password"),
                                labelStyle: TextStyle(
                                  color: Colors.blueAccent.shade400,
                                ),
                                 prefixIcon: Icon(Icons.lock,color: Colors.blue[900],)
                                ),
                    ),
                  ),
                  SizedBox(height: 20,),
                   Container(
                width: 250,
                height: 50,
                child: TextFormField(
                    decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue.shade300,width: 2)
                                ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.orange,width: 1.5)
                              ),
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(
                                color: Colors.blueAccent.shade400,
                              ),
                              label: Text("Confirm Password"),
                              labelStyle: TextStyle(
                                color: Colors.blueAccent.shade400,
                              ),
                               prefixIcon: Icon(Icons.lock,color: Colors.blue[900],)
                              ),
                  ),
                ),
                SizedBox(height: 20,),
                 Container(
                  width: 250,
                   child: DropdownButtonFormField(
                                    value: selectedgender,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue.shade300,width: 2)
                                      ),
                                      fillColor: Colors.transparent,
                                      prefixIcon: Icon(Icons.wc,color: Colors.blue[900],),
                                      filled: true,
                                      labelText: "Gender",
                                      labelStyle: TextStyle(
                                        color: Colors.blue,
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.blue
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue.shade300,width: 2),
                                        borderRadius: BorderRadius.circular(13),
                                      ), 
                                      errorStyle: TextStyle(height: 1),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.5
                                        ),
                                        borderRadius: BorderRadius.circular(13)
                                      )
                                    ),
                                    items: ["Male","Female","Others"].map((selectedgender)=>DropdownMenuItem(child: Text(selectedgender),value: selectedgender,)).toList(),
                                    onChanged: (newvalue){
                                      setState(() {
                                        selectedgender=newvalue!;
                                      });
                                    },
                                    //validator: (value)=>value == null ? 'Gender is required' : null,
                                    ),
                 ),
                SizedBox(height: 20,),
                            GestureDetector(
                                        onTap: () async {
                                          var result=await Navigator.push(context, MaterialPageRoute(builder: (context) => map()),                            
                                          );
                                          if(result!=null)
                                          {
                                            setState(() {
                                              selectedLocation=LatLng(result["latitude"], result["longitude"]);
                                              address=result["address"];
                                            });
                                          }
                                        },
                                        
                                        child: AbsorbPointer(
                                          child: Padding(
                                            padding: const EdgeInsets.only(),
                                            child: Container(
                                               width: 250,
                                              child: TextFormField(
                                                controller: TextEditingController(text: address),
                                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(color: Colors.blue.shade300,width: 2)
                                  ),
                                                            
                                                          fillColor:Colors.transparent,
                                                          filled: true,
                                                          hintText: "Location",
                                                          prefixIcon: Icon(Icons.location_on,color: Colors.blue[900],),
                                                          hintStyle: TextStyle(
                                                          color: Colors.blue[600],
                                                          fontWeight: FontWeight.w400
                                                          ),
                                                          labelText: "Location",
                                                          labelStyle: TextStyle(
                                                          color: Colors.blue,
                                                          ),
                                                          errorStyle: TextStyle(height: 1),
                                                          errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1.5
                                                          ),
                                                          borderRadius: BorderRadius.circular(13)
                                                          )
                                                         ),                                         
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        width: 300,
                                        child: ElevatedButton(onPressed: (){
                                        
                                        }, child: Text("Update Profile",style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        ),),style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue.shade600,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),        
                                          ),
                                          elevation: 5,
                                        ),),
                                      ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 730,left: 26),
              child: Row(
                children: [
                   IconButton(onPressed: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => home(),));
                          }, icon: Icon(Icons.arrow_back,size: 26,))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}