import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/stepper.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class tourdetails extends StatefulWidget {

  final String fullname;
  final String phoneno;
  final String city;
  final String selectedpackage;
  final String nooftravellers;
  final int totalprice;

  tourdetails(
    {
      required this.fullname,
      required this.phoneno,
      required this.city,
      required this.selectedpackage,
      required this.nooftravellers,
      required this.totalprice,
    }
  );

  @override
  State<tourdetails> createState() => _tourdetailsState();
}

class _tourdetailsState extends State<tourdetails> {

  Razorpay razorpay=Razorpay();
  
  
  String formatPrice(int price)
  {
    return NumberFormat('#,###').format(price);
  }

  

  @override
  Widget build(BuildContext context) {

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
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

        body: Stack(
          children: [     
           Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: stepper(currentstep: 2),
              ),
            ],
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
                          Text("Confirm Details & Payment",style:TextStyle(
                            fontSize: 22,
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
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,                 
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 40),
                                        child: Text("Details",style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("Payment",style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Full Name: ${widget.fullname}",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 16,
                                        //fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Phone no: ${widget.phoneno}",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 16,
                                        //fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("City: ${widget.city}",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 16,
                                       // fontWeight: FontWeight.w400,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Selected Package: ${widget.selectedpackage}",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 14,
                                        //fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("No. of People: ${widget.nooftravellers}",style: TextStyle(
                                          fontSize: 16,
                                         fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 16,
                                       // fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                         Divider(
                           color: Colors.grey[300], 
                           thickness: 1.5,       
                           indent: 20,         
                           endIndent: 20, 
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Total Price: ",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                      SizedBox(width: 105,),
                                       Text("₹${widget.totalprice}",style: TextStyle(
                                        fontSize: 16,                                       
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),                         
                        ],
                      ),
                    )
            ),

            Padding(
              padding: const EdgeInsets.only(top: 663),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    color: Colors.white,
                    width: double.infinity,
                    child: Container(
                      width: 300,
                      color: Colors.white,
                      child: ElevatedButton(onPressed: (){
                        var options = {
                              'key': 'rzp_test_amOok42ADXLkQs',
                              'amount': (widget.totalprice * 100).toInt(), 
                              'name': 'Vandan Kacha',
                              'description': 'Travel Package',
                              'prefill': {
                              'contact': '8888888888',
                              'email': 'test@razorpay.com',
                        }                     
                                        };
                      razorpay.open(options);
                      }, child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text("₹${widget.totalprice}",style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),),
                          ),
                          SizedBox(width: 80,),
                          Container(
                            height: 44,
                            width: 120,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(child: Text("Book Now",style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),)),
                          )
                        ],
                      )),
                    ),
                  )
                ],
              ),
            )
          
            /*Text("Full name: ${widget.fullname}"),
            Text("Phone no: ${widget.phoneno}"),
            Text("City: ${widget.city}"),
            Text("Package: ${widget.selectedpackage}"),
            Text("travellers: ${widget.nooftravellers}"),
            Text("total price: ${widget.totalprice}"),*/
          ],
        ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Successful");
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(),));
  // Do something when payment succeeds
}

void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Unsuccessful");
  // Do something when payment fails
}

  @override
  void dispose()
  {
    super.dispose();

    try
    {
      razorpay.clear();
    }
    catch(e)
    {
      print(e);
    }
  }
}
/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibe_tribe/stepper.dart';

class tourdetails extends StatefulWidget {

  final String fullname;
  final String phoneno;
  final String city;
  final String selectedpackage;
  final String nooftravellers;
  final int totalprice;

  tourdetails(
    {
      required this.fullname,
      required this.phoneno,
      required this.city,
      required this.selectedpackage,
      required this.nooftravellers,
      required this.totalprice,
    }
  );

  @override
  State<tourdetails> createState() => _tourdetailsState();
}

class _tourdetailsState extends State<tourdetails> {
  
  String formatPrice(int price)
  {
    return NumberFormat('#,###').format(price);
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

        body: Stack(
          children: [     
           Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: stepper(currentstep: 2),
              ),
            ],
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
                          Text("Confirm Details & Payment",style:TextStyle(
                            fontSize: 22,
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
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,                 
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 40),
                                        child: Text("Details",style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("Payment",style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Full Name: ${widget.fullname}",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 16,
                                        //fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Phone no: ${widget.phoneno}",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 16,
                                        //fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("City: ${widget.city}",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 16,
                                       // fontWeight: FontWeight.w400,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Selected Package: ${widget.selectedpackage}",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 16,
                                        //fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("No. of People: ${widget.nooftravellers}",style: TextStyle(
                                          fontSize: 16,
                                         fontWeight: FontWeight.w400,
                                        ),),
                                      ),
                                      SizedBox(width: 100,),
                                       Text("",style: TextStyle(
                                        fontSize: 16,
                                       // fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                         Divider(
                           color: Colors.grey[300], 
                           thickness: 1.5,       
                           indent: 20,         
                           endIndent: 20, 
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Container(
                                  height: 40,
                                  width: 300,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Total Price: ",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                      SizedBox(width: 105,),
                                       Text("₹${widget.totalprice}",style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),                         
                        ],
                      ),
                    )
            ),

            Padding(
              padding: const EdgeInsets.only(top: 663),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    
                  )
                ],
              ),
            )
          
            /*Text("Full name: ${widget.fullname}"),
            Text("Phone no: ${widget.phoneno}"),
            Text("City: ${widget.city}"),
            Text("Package: ${widget.selectedpackage}"),
            Text("travellers: ${widget.nooftravellers}"),
            Text("total price: ${widget.totalprice}"),*/
          ],
        ),
    );
  }
}*/

