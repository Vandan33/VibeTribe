import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibe_tribe/allhotels.dart';
import 'package:vibe_tribe/home.dart';
import 'package:vibe_tribe/location_selection.dart';
import 'package:vibe_tribe/profile.dart';



class TourPackageDateSelector extends StatefulWidget {
  @override
  _TourPackageDateSelectorState createState() => _TourPackageDateSelectorState();
}

class _TourPackageDateSelectorState extends State<TourPackageDateSelector> {
  DateTime? _startDate;
  DateTime? _endDate;
  int myindex = 1;
  String _formatDate(DateTime? date) {
    return date != null ? DateFormat('EEE, MMM d, yyyy').format(date) : "Not Selected";
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = isStartDate
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? _startDate?.add(Duration(days: 1)) ?? DateTime.now());
    DateTime firstDate = isStartDate ? DateTime.now() : (_startDate ?? DateTime.now());
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          _endDate = null;
        } else {
          _endDate = pickedDate;
        }
      });
    }
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
      bottomNavigationBar: Container(
        height: 60,
        child: BottomNavigationBar(
          backgroundColor: Colors.lightBlue[300],
          onTap: (index) {
            if (index != myindex) {
              if (index == 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => home()),
                );
              } else if (index == 2) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => profile()),
                );
              }
            }
          },
          currentIndex: myindex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.travel_explore_sharp), label: "Manual"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Pick Your Tour Dates", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold,color: Colors.blue.shade700)),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: _buildDateTile("Start Date", _startDate),
                  ),
                  GestureDetector(
                    onTap: _startDate == null ? null : () => _selectDate(context, false),
                    child: _buildDateTile("End Date", _endDate, enabled: _startDate != null),
                  ),
                  SizedBox(height: 15),

                  if(_startDate !=null && _endDate !=null)
                   Container(
                    height: 100,
                    width: 160,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blueAccent),
        ),
          child: Column(
          children: [
            Text(
              "Selected Dates:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade700),
            ),
            SizedBox(height: 5),
            Text(
              "${_formatDate(_startDate)} - ${_formatDate(_endDate)}",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ],
        ),
                   ),
                   SizedBox(height: 20,),
                  Row(
                    children: [
                      Container(
                        width: 120,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(),));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            textStyle: TextStyle(fontSize: 16),
                            backgroundColor: Colors.blue.shade700
                          ),
                          child: Text("Back",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        ),
                      ),
                      SizedBox(width: 40,),
                       Container(
                        width: 120,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => allhotels(),));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            textStyle: TextStyle(fontSize: 16),
                            backgroundColor: Colors.blue.shade700
                          ),
                          child: Text("Next",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTile(String title, DateTime? date, {bool enabled = true}) {
    return Container( 
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(       
        color: enabled ? Colors.white : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: enabled ? Colors.blue : Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title: ${_formatDate(date)}",
            style: TextStyle(fontSize: 16, color: enabled ? Colors.black : Colors.grey[600]),
          ),
          Icon(Icons.calendar_today, color: enabled ? Colors.blue : Colors.grey),
        ],
      ),
    );
  }
}