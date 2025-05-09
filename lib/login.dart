import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibe_tribe/Register.dart';
import 'package:vibe_tribe/preference.dart';
import 'package:custom_circular_progress/custom_circular_progress.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
 
  //remove above line if not working
 

  final TextEditingController isemail=new TextEditingController();
  final TextEditingController ispassword=new TextEditingController();

  final formkey=GlobalKey<FormState>();
  bool isobsecure=true;
  bool loading=false;


  Future<void> loginuser() async
  {
    if(formkey.currentState!.validate())
    {
      setState(() {
        loading=true;
      });

      String apiurl="http://192.168.249.97/register_api/login.php";

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
        final response=await http.post
        (
          Uri.parse(apiurl),
          headers: {"Content-Type": "application/json"},
          body:jsonEncode({
            "email":isemail.text,
            "password":ispassword.text,
          })
        );
        final responseData=jsonDecode(response.body);

        if(responseData["status"]=="success")
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
                  color: Colors.green,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text("Login Successful",style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),)
                    )
                  ],
                ),
              ) ,
              duration: Duration(seconds: 3),
              ),              
          );
          //remove above if condition if it not working
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => preference(),));
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
                      child: Text("Login Unsuccessful",style: TextStyle(
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
                      child: Text("Login Unsuccessful",style: TextStyle(
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
      setState(() {
        loading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset("assets/mountain.jpg"),
          Container(
            height: 600,
            width: 400,
            margin: EdgeInsets.only(top: 325),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(3, 3),
                  blurRadius: 6,
                  spreadRadius: 2,
                )
              ]
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25,left: 45),
                  child: Text("Login Here",style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),),
                ),
               Form(
                 child: Form(
                  key: formkey,
                   child: Column(
                    children: [
                      Padding(
                               padding: const EdgeInsets.only(top: 100,left: 44),
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
                               padding: const EdgeInsets.only(top: 30,left: 44),
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
                                    obscureText: isobsecure,
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
                                          isobsecure=!isobsecure;
                                        });
                                      }, icon: Icon(isobsecure ? Icons.visibility_off : Icons.visibility,color: Colors.blue[900],))
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
                    ],
                   ),
                 ),
               ),
               
                Padding(
                  padding: const EdgeInsets.only(top: 300,left: 10),
                  child: Container(
                    width: 340,
                    child: ElevatedButton(onPressed: loginuser, child: Text("login",style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[500],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        elevation: 8,
                      )
                    )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 350),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(fontWeight: FontWeight.w700),),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                      }, child: Text("Signup",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),))
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}