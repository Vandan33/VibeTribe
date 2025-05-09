import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/tourdetails.dart';
import 'package:vibe_tribe/stepper.dart';

class package_form extends StatefulWidget {
  const package_form({super.key});

  @override
  State<package_form> createState() => _package_formState();
}

class _package_formState extends State<package_form> {
 
  //1
  TextEditingController fullname=new TextEditingController();
  TextEditingController phoneno=new TextEditingController();
  TextEditingController city=new TextEditingController();
  TextEditingController nooftravellers=new TextEditingController();

 Map<String, int> packages = {
  "Himachal From Ahmedabad": 12599,
  "Goa": 8899,
  "Kerala": 16299,
  "Kedarnath & Badrinath": 15499,
  "Kedarkantha Trek": 11450,
  "Brahmatal Trek": 11450,
  "Har-ki-Dun Trek": 12950,
  "Rupin pass Trek": 12950,
  "Valley of flowers":11950,
  "Kashmir":17799,
  "Ladakh":30499,
};

  Map<String, List<String>> packagedates={
    "Himachal From Ahmedabad" : ["21 May 2025","28 May 2025"],
    "Goa" : ["10 June 2025","20 June 2025"],
    "Kerala" : ["10 May 2025","20 May 2025"],
    "Kedarnath & Badrinath" : ["1 May 2025","2 May 2025"],
    "Kedarkantha Trek": ["21 May 2025","26 May 2025"],
    "Brahmatal Trek": ["1 Jan 2025","10 Jan 2025"],
    "Har-ki-Dun Trek": ["10 May 2025","20 May 2025"],
    "Rupin pass Trek": ["20 May 2025","30 May 2025"],
    "Valley of flowers": ["5 June 2025","15 June 2025"],
    "Kashmir":["5 dec 2025","15 dec 2025"],
    "Ladakh":["5 July 2025","15 July 2025"],
  };

  String selectedpackage="Kerala";
  int selectedprice=16299;
  List<String> availabledates=[];
  String? selecteddate;
  int totalprice=16299;

  void updatetotalprice()
  {
    int travellers=int.tryParse(nooftravellers.text) ?? 1;
    setState(() {
      totalprice=selectedprice*travellers;
    });
  }

   String formatPrice(int price) {
    return NumberFormat('#,###').format(price.toInt());
    }

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
         drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.black,
                  child: ClipOval(
                    child: SizedBox(
                      width: 95,
                      height: 95,
                      child: Image.asset('assets/virat.avif',),                  
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25,top: 20),
                child: ListTile(
                  leading: Icon(Icons.account_circle,size: 30,color: Colors.blue,),
                  title: const Text("Profile",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,left: 25),
                child: ListTile(
                  leading: Icon(Icons.settings,size: 30,color: Colors.blue,),
                  title: const Text("Settings",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,left: 25),
                child: ListTile(
                  leading: Icon(Icons.info,size: 30,color: Colors.blue,),
                  title: const Text("About us",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5,left: 25),
                child: ListTile(
                  leading: Icon(Icons.logout,size: 30,color: Colors.blue,),
                  title: const Text("logout",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 600,
              ),
              child: Stack(
                children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 18),
                     child: stepper(currentstep: 1),
                   ),
                  
                  Padding(
                    padding: const EdgeInsets.only(top: 90,left: 22),
                    child: Container(
                      height: 620,
                      width: 315,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              spreadRadius: 5,
                              color: Colors.grey.shade400,
                              offset: Offset(2, 2)
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Text("Tour Registration",style:TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent.shade400
                          ),),
                          Divider(
                           color: Colors.grey[300], 
                           thickness: 1.5,       
                           indent: 20,         
                           endIndent: 20, 
                          ),
                          SizedBox(height: 10,),
                          Container(
                            width: 260,
                            height: 50,
                            child: TextFormField(
                              controller: fullname,
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
                              )
                              ),
                            ),
                          ),
                          SizedBox(height: 14,),
                          Container(
                            width: 260,
                            height: 50,
                            child: TextFormField(
                              controller: phoneno,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue.shade300,width: 2)
                                ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.orange,width: 1.5)
                              ),
                              hintText: "Phone Number",
                              hintStyle: TextStyle(
                                color: Colors.blueAccent.shade400,
                              ),
                              label: Text("Phone Number"),
                              labelStyle: TextStyle(
                                color: Colors.blueAccent.shade400,
                              )
                              ),
                            ),
                          ),
                          SizedBox(height: 14,),
                          Container(
                            width: 260,
                            height: 50,
                            child: TextFormField(
                              controller: city,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue.shade300,width: 2)
                                ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.orange,width: 1.5)
                              ),
                              hintText: "Your City",
                              hintStyle: TextStyle(
                                color: Colors.blueAccent.shade400,
                              ),
                              label: Text("Your City"),
                              labelStyle: TextStyle(
                                color: Colors.blueAccent.shade400,
                              )
                              ),
                            ),
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 29),
                                child: Text("Select Package:",style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade700
                                ),),
                              ),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 29),
                    child: Container(
              width: 260,
              padding: EdgeInsets.symmetric(horizontal: 5), 
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(10), 
                border: Border.all(color: Colors.blue.shade300, width: 2), 
              ),
              child: DropdownButtonHideUnderline( 
                child: DropdownButton<String>(
                  value: selectedpackage,
                  onChanged: (newValue) {
                    setState(() {
                      selectedpackage = newValue!;
                      selectedprice = packages[newValue] ?? 0;
                      availabledates = packagedates[newValue] ?? [];                    
                    });
                    updatetotalprice();
                  },
                  dropdownColor: Colors.lightBlue.shade50,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.blue, size: 30),
                  style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                  items: packages.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
                    ),
                  ),
                ],
              ),
                SizedBox(height: 14,),
                 Text("Available Dates:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),

            availabledates.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: availabledates.map((date) => Text(date, style: TextStyle(fontSize: 16))).toList(),
                  )
                : Text("No dates available", style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                SizedBox(height: 14,),
                          Container(
                            width: 260,
                            height: 50,
                            child: TextFormField(
                              controller: nooftravellers,
                              keyboardType: TextInputType.number,
                              onChanged: (value) => updatetotalprice(),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.blue.shade300,width: 2)
                                ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.orange,width: 1.5)
                              ),
                              hintText: "No. of travellers",
                              hintStyle: TextStyle(
                                color: Colors.blueAccent.shade400,
                              ),
                              label: Text("No. of travellers"),
                              labelStyle: TextStyle(
                                color: Colors.blueAccent.shade400,
                              )
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          /*Text(
                            "Total Price: ${formatPrice(totalprice)}",
                          ),*/
                         /*Text(
                    'Price: ₹${formatPrice(selectedprice)}', // Formatting applied here
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                  ),*/
                  SizedBox(height: 20,),
                      Container(
                        width: 200,
                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => tourdetails(
                            fullname: fullname.text,
                            phoneno: phoneno.text,
                            city: city.text,
                            selectedpackage: selectedpackage,
                            nooftravellers: nooftravellers.text,
                            totalprice: totalprice,
                          ),));
                        }, child: Text("Next",style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),), style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.orange,
                                            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                                            shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                                            )
                                          ),),
                      ),  
                        ],
                      ),
                    ),
                  ),              
                ],
              ),
            ),
          ),
        ),
    );
  }
}