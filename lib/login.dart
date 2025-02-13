import 'package:flutter/material.dart';
import 'package:vibe_tribe/Register.dart';
import 'package:vibe_tribe/preference.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
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
                    color: Colors.indigo,
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 105,left: 66),
                  child: Container(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.blue[100],
                        filled: true,
                        hintText: "Username",
                        prefixIcon: Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                          color: Colors.blueAccent,
                          width: 2,
                        ))
                      ),
                    )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 190,left: 66),
                  child: Container(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.blue[100],
                        filled: true,
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    )),
                ),
                
                Padding(
                  padding: const EdgeInsets.only(top: 280,left: 25),
                  child: Container(
                    width: 340,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => preference(),));
                    }, child: Text("login",style: TextStyle(
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
                  padding: const EdgeInsets.only(top: 400),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(fontWeight: FontWeight.w700),),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Register(),));
                      }, child: Text("Signup",style: TextStyle(color: Colors.blueAccent),))
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