import 'package:flutter/material.dart';
import 'package:vibe_tribe/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
            Image.asset('assets/mountain.jpg'),
          Container(
            height: 600,
            width: 400,
            margin: EdgeInsets.only(top:325),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60),),
              boxShadow:[
                BoxShadow(
                 offset: Offset(3, 3),
                 blurRadius: 6,
                 spreadRadius: 2,
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 112,top: 16),
                    child: Text("Register Here",style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 60,left:66),
                    child: Container(
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          fillColor:Colors.blue[100],
                          filled: true,
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                        ),
                      )),
                  ),    
                  Padding(
                    padding: const EdgeInsets.only(top: 130,left: 66),
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
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      )),
                  ),     
                Padding(
                  padding: const EdgeInsets.only(top: 200,left: 66),
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
                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 270,left: 66),
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
                        hintText: "Confirm Password",
                        prefixIcon: Icon(Icons.lock),
                      ),
                    )),
                ), 
                Padding(
                  padding: const EdgeInsets.only(top: 405,left: 25),
                  child: Container(
                    width: 340,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => login()),);
                    }, child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 20),),style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[500],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 8,
                    ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}