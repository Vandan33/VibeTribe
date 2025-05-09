import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibe_tribe/location.dart';
import 'package:vibe_tribe/login.dart';
import 'package:http/http.dart' as http;
import 'package:custom_circular_progress/custom_circular_progress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:vibe_tribe/map.dart';

class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool passobsecure=true;
  bool confirmobescure=true;
  String selectedgender="Male";

  
  final TextEditingController isfullname=new TextEditingController();
  final TextEditingController ispassword=new TextEditingController();
  final TextEditingController isemail=new TextEditingController();
  final TextEditingController isconfirmpassword=new TextEditingController();
  final TextEditingController loc=new TextEditingController();

  GoogleMapController? mapController;
  LatLng? selectedLocation;
  String address="Select a Location";

  /*void onMapCreated(GoogleMapController controller)
  {
    mapController=controller;
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await LocationService().getCurrentLocation();
      String addr = await LocationService().getAddressFromCoordinates(position);

      setState(() {
        selectedLocation = LatLng(position.latitude, position.longitude);
        address = addr;
      });

      mapController?.animateCamera(CameraUpdate.newLatLng(selectedLocation!));
    } catch (e) {
      setState(() {
        address = "Error getting location";
      });
    }
  }*/
   

  final formkey=GlobalKey<FormState>();


  Future<void> registerUser() async {
    if(formkey.currentState!.validate())
    {
      if(selectedLocation==null)
      {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select Location"),));
        return;
      }
      const String apiUrl="http://192.168.249.97/register_api/register.php";

    Map<String,String> requestBody = {
      "fullname":isfullname.text,
      "email":isemail.text,
      "password":ispassword.text,
      "gender":selectedgender,
      "latitude":selectedLocation!.latitude.toString(),
      "longitude":selectedLocation!.longitude.toString(),
      "address":address,
    };

    try
    {
      showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (context)
        {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.blue),
              ),
            ),
          );
        }
        );
        final response=await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(requestBody),
        );

        final responseData=jsonDecode(response.body);

        if(responseData['status']=='success')
        {
           ScaffoldMessenger.of(context).showSnackBar(
          SnackBar( 
            backgroundColor: Colors.transparent,
            elevation: 0,
            behavior: SnackBarBehavior.floating,
            content: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,color: Colors.white,
                  size: 28,
                ),
                SizedBox(width: 12),
                Expanded(child: 
                Text("User Register Successfully",style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  ),))
              ],
            ),
          ),
          duration:  Duration(seconds: 3),
          ),
        );
          Navigator.push(context, MaterialPageRoute(builder: (context) => login(),));
        }
        else
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar( 
              backgroundColor: Colors.transparent,
              behavior: SnackBarBehavior.floating,
              elevation: 0,
              content:Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text("User Register Unsuccessful",style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),)
                    )
                  ],
                ),
              ) ,
              duration: Duration(seconds: 3),
              )
          );
        }
    }
    
    catch(e)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          content: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
                size: 28,
              ),
              SizedBox(width: 12),
              Expanded(child: Text(
                "User Register Unsuccessful",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ))
            ],
          ),
        ),
        duration: Duration(seconds: 3),
        ),
      );
    }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
            Image.asset('assets/mountain.jpg',),
            
          Center(
            child: Container(
              height: 550,
              width: 360,
              margin: EdgeInsets.only(top:290),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50),),
                boxShadow:[
                  BoxShadow(
                   offset: Offset(3, 3),
                   blurRadius: 6,
                   spreadRadius: 2,
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 12),
                     child: SizedBox(
                      width: double.infinity,
                       child: Text("Signup Here",textAlign:TextAlign.center,style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                       )),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top: 65),
                     child: SizedBox(
                      width: double.infinity,
                       child: Text("Create your account",style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,                     
                        fontWeight: FontWeight.bold,
                       ),
                       textAlign: TextAlign.center,),
                     ),
                   ),
                     Form(
                      key: formkey,
                       child: Column( 
                         children: [ 
                           Padding(
                             padding: const EdgeInsets.only(top: 110,left: 0),
                             child: Container(
                                width: 270,
                                
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                      offset: const Offset(0,4)
                                    ),
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.05),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                      offset: const Offset(0, -2),
                                    )
                                  ]
                                ),
                                child:TextFormField(
                                  controller: isfullname,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(13),
                                          borderSide: BorderSide.none,                    
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.blue,width: 1.5),
                                          borderRadius: BorderRadius.circular(13),
                                        ),    
                                        fillColor:Colors.lightBlue[50],
                                        filled: true,
                                        hintText: "FullName",
                                        prefixIcon: Icon(Icons.person,color: Colors.blue[900],),
                                        hintStyle: TextStyle(
                                          color: Colors.blue[600],
                                          fontWeight: FontWeight.w400
                                        ),
                                        labelText: "FullName",
                                        labelStyle: TextStyle(
                                          color: Colors.blue,
                                        ),                                    
                                        errorStyle: TextStyle(height: 1),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.red,width: 1.5),
                                          borderRadius: BorderRadius.circular(13),
                                        )
                                      ),
                                      validator:(value) {
                                        if(value!.isEmpty)
                                        {
                                          return "Name is required";
                                        }
                                        return null;
                                      },
                                      keyboardType: TextInputType.name,
                                    ),
                                
                                ),
                           ),
                            Padding(
                             padding: const EdgeInsets.only(top: 28,left: 0),
                             child: Container(
                                width: 270,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                      offset: const Offset(0,4)
                                    ),
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.05),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                      offset: const Offset(0, -2),
                                    )
                                  ]
                                ),
                                child: TextFormField(
                                  controller: isemail,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide.none,                    
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue,width: 1.5),
                                      borderRadius: BorderRadius.circular(13),
                                    ),    
                                    fillColor:Colors.lightBlue[50],
                                    filled: true,
                                    hintText: "Email",
                                    prefixIcon: Icon(Icons.email,color: Colors.blue[900],),
                                    hintStyle: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w400
                                    ),
                                    labelText: "Email",
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
                                  validator: (value) {
                                    if(value!.isEmpty)
                                    {
                                      return "Email is required";
                                    }
                                      String emailPattern =r'^[a-zA-Z0-9._%+-]+@gmail\.com$';
                                      RegExp regex = RegExp(emailPattern);
                                    
                                    if(!regex.hasMatch(value))
                                    {
                                      return "Enter a valid email address";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                )),
                           ),
                            Padding(
                             padding: const EdgeInsets.only(top: 28,left: 0),
                             child: Container(
                                width: 270,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                      offset: const Offset(0,4)
                                    ),
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.05),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                      offset: const Offset(0, -2),
                                    )
                                  ]
                                ),
                                child: TextFormField(
                                  controller: ispassword,
                                  obscureText: passobsecure,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide.none,                    
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue,width: 1.5),
                                      borderRadius: BorderRadius.circular(13),
                                    ),    
                                    fillColor:Colors.lightBlue[50],
                                    filled: true,
                                    hintText: "Password",
                                    prefixIcon: Icon(Icons.lock,color: Colors.blue[900],),
                                    hintStyle: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w400
                                    ),
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                      color: Colors.blue,
                                    ),
                                    suffixIcon: IconButton(onPressed: (){
                                      setState(() {
                                        passobsecure=!passobsecure;
                                      });
                                    }, icon: Icon(passobsecure ? Icons.visibility_off : Icons.visibility,color: Colors.blue[900],)),
                                    errorStyle: TextStyle(height: 1),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(13),
                                    )
                                  ),
                                  validator: (value) {
                                    if(value!.isEmpty)
                                    {
                                      return "Password is required";
                                    }
                                    if(value.length<8)
                                    {
                                      return "Password must be at least 8 characters";
                                    }
                                    if(!RegExp(r'[A-Z]').hasMatch(value))
                                    {
                                      return "Password must contain at least one uppercase letter";
                                    }
                                    if(!RegExp(r'[a-z]').hasMatch(value))
                                    {
                                      return "Password must contain at least one lowercase letter";
                                    }
                                    if(!RegExp(r'[0-9]').hasMatch(value))
                                    {
                                      return "Password must contain at least one number";
                                    }
                                    if(!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value))
                                    {
                                      return "Password must contain at least one special character";
                                    }

                                    return null;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                )),
                           ),
                            Padding(
                             padding: const EdgeInsets.only(top: 28,left: 0),
                             child: Container(
                                width: 270,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                      offset: const Offset(0,4)
                                    ),
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.05),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                      offset: const Offset(0, -2),
                                    )
                                  ]
                                ),
                                child: TextFormField(
                                  controller: isconfirmpassword,
                                  obscureText: confirmobescure,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide.none,                    
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue,width: 1.5),
                                      borderRadius: BorderRadius.circular(13),
                                    ),    
                                    fillColor:Colors.lightBlue[50],
                                    filled: true,
                                    hintText: "Confirm Password",
                                    prefixIcon: Icon(Icons.lock,color: Colors.blue[900],),
                                    hintStyle: TextStyle(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w400
                                    ),
                                    labelText: "Confirm Password",
                                    labelStyle: TextStyle(color: Colors.blue),
                                    suffixIcon: IconButton(onPressed: (){
                                      setState(() {
                                        confirmobescure=!confirmobescure;
                                      });
                                    }, icon: Icon(confirmobescure ? Icons.visibility_off : Icons.visibility,color: Colors.blue[900],)),
                                    errorStyle: TextStyle(height: 1),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                      borderRadius: BorderRadius.circular(13)
                                    )
                                  ),
                                  validator: (value) {
                                    if(value!.isEmpty)
                                    {
                                      return "Confirm Password is required";
                                    }
                                    if(value!=ispassword.text)
                                    {
                                      return "Password do not match";
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                )),
                           ),
                            Padding(
                             padding: const EdgeInsets.only(top: 28,left: 0),
                             child: Container(
                                width: 270,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                      offset: const Offset(0,4)
                                    ),
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.05),
                                      blurRadius: 8,
                                      spreadRadius: 0,
                                      offset: const Offset(0, -2),
                                    )
                                  ]
                                ),
                                child: DropdownButtonFormField(
                                  value: selectedgender,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      borderSide: BorderSide.none,
                                    ),
                                    prefixIcon: Icon(Icons.wc,color: Colors.blue[900],),
                                    fillColor: Colors.lightBlue[50],
                                    filled: true,
                                    labelText: "Gender",
                                    labelStyle: TextStyle(
                                      color: Colors.blue,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blue,width: 1.5),
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
                                  validator: (value)=>value == null ? 'Gender is required' : null,
                                  )
                                ),
                           ),
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
                                            padding: const EdgeInsets.only(top: 28,left: 0),
                                            child: Container(
                                               width: 270,
                                                                            decoration: BoxDecoration(
                                                                              boxShadow: [
                                                                                BoxShadow(
                                                                                  color: Colors.black.withOpacity(0.2),
                                                                                  blurRadius: 12,
                                                                                  spreadRadius: 1,
                                                                                  offset: const Offset(0,4)
                                                                                ),
                                                                                BoxShadow(
                                                                                  color: Colors.blue.withOpacity(0.05),
                                                                                  blurRadius: 8,
                                                                                  spreadRadius: 0,
                                                                                  offset: const Offset(0, -2),
                                                                                )
                                                                              ]
                                                                            ),
                                              child: TextFormField(
                                                controller: TextEditingController(text: address),
                                              decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(13),
                                                          borderSide: BorderSide.none,                    
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(color: Colors.blue,width: 1.5),                                                           borderRadius: BorderRadius.circular(13),
                                                          ),    
                                                          fillColor:Colors.lightBlue[50],
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
                           Padding(
                                         padding: const EdgeInsets.only(top: 40,left: 0),
                                         child: Container(
                                           width: 300,
                                           child: ElevatedButton(onPressed: registerUser, child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 18),),style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[500],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 8,
                                           ),
                                           ),
                                         ),
                                       ),
                                      /* GoogleMap(
                                        onMapCreated: _onMapCreated,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(20.5937, 78.9629),
                                          zoom: 5
                                          ),
                                          onTap: (LatLng latLng) async
                                          {
                                            String addr=await LocationService().getAddressFromCoordinates(Position(
                                              longitude: latLng.longitude,
                                              latitude: latLng.latitude,
                                              timestamp: DateTime.now(),
                                              accuracy: 1.0,
                                              altitude: 1.0,
                                              altitudeAccuracy: 1.0,
                                              headingAccuracy: 1.0,
                                              heading: 1.0,
                                              speed: 1.0,
                                              speedAccuracy: 1.0)
                                            );
                                            setState(() {
                                              selectedLocation=latLng;
                                              address=addr;
                                            });
                                          },
                                          markers: selectedLocation !=null?
                                          {
                                            Marker(
                                              markerId: MarkerId("Selected-Location"),
                                              position: selectedLocation!,
                                            ),
                                          }
                                          :{},
                                          ),
                                        ElevatedButton(onPressed: getCurrentLocation, child: Text("Use My Current Location")),
                                       */
                                     /* InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => map(),));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(5)),
                                          child: Text(address),
                                        ),
                                      ),*/
                                      
                                      Padding(
                                         padding: const EdgeInsets.only(top: 0,left: 10),
                                         child: Row(
                                           mainAxisAlignment: MainAxisAlignment.center,
                                           children: [
                        Text("Already have an account?",style: TextStyle(fontWeight: FontWeight.w700),),
                        SizedBox(width: 0,),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => login(),));
                        }, child: Text("login",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),))
                                           ],
                                         ),
                                       ),
                                       Container(
                                         height: 20,
                                         width: 20,
                                       ),
                         ],
                       ),
                     ),  
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}