import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http; // New Code: Import http package
import 'ReceiptDownload.dart'; // Ensure this points to your ReceiptScreen file

class HotelForm extends StatefulWidget {
  final String fullName;
  final String hotelName;
  final String roomType;
  final int numberOfGuests;
  final int numberOfRooms;
  final TimeOfDay checkInTime;
  final TimeOfDay checkOutTime;
  final double totalPrice;

  const HotelForm({
    super.key,
    required this.fullName,
    required this.hotelName,
    required this.roomType,
    required this.numberOfGuests,
    required this.numberOfRooms,
    required this.checkInTime,
    required this.checkOutTime,
    required this.totalPrice,
  });

  @override
  State<HotelForm> createState() => _HotelFormState();
}

class _HotelFormState extends State<HotelForm> {
  Razorpay razorpay = Razorpay();

  String formatPrice(int price) {
    return NumberFormat('#,###').format(price);
  }

  late TextEditingController _fullNameController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: widget.fullName);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    razorpay.clear();
    super.dispose();
  }

  // New Code Start
  Future<void> _saveBookingToDatabase() async {
    final url = Uri.parse('http://192.168.249.97/register_api/insert_booking.php');
    try {
      final response = await http.post(
        url,
        body: {
          'fullName': _fullNameController.text.isEmpty ? "Vandan Kacha" : _fullNameController.text,
          'hotelName': widget.hotelName,
          'roomType': widget.roomType,
          'numberOfGuests': widget.numberOfGuests.toString(),
          'numberOfRooms': widget.numberOfRooms.toString(),
          'checkInTime': _formatTimeOfDay(widget.checkInTime),
          'checkOutTime': _formatTimeOfDay(widget.checkOutTime),
          'totalPrice': widget.totalPrice.toString(),
        },
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['status'] == 'success') {
          print('Booking saved successfully');
        } else {
          Fluttertoast.showToast(msg: "Failed to save booking: ${result['message']}");
        }
      } else {
        Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error saving booking: $e");
    }
  }

  // Helper method to format TimeOfDay
  String _formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
  // New Code End

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment Successful");
    // New Code Start
    await _saveBookingToDatabase(); // Save booking to database
    // New Code End
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptScreen(
          fullName: _fullNameController.text.isEmpty ? "Vandan Kacha" : _fullNameController.text,
          hotelName: widget.hotelName,
          roomType: widget.roomType,
          numberOfGuests: widget.numberOfGuests,
          numberOfRooms: widget.numberOfRooms,
          checkInTime: widget.checkInTime,
          checkOutTime: widget.checkOutTime,
          totalPrice: widget.totalPrice,
          paymentId: response.paymentId ?? "N/A",
        ),
      ),
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment Unsuccessful");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booking Summary",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.teal[900],
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Booking Details Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Booking Details"),
                    const SizedBox(height: 20),
                    _buildDetailRow(Icons.person, "Full Name", _fullNameController.text.isEmpty
                        ? "Vandan Kacha"
                        : _fullNameController.text),
                    _buildDetailRow(Icons.hotel, "Hotel Name", widget.hotelName),
                    _buildDetailRow(Icons.king_bed, "Room Type", widget.roomType),
                    _buildDetailRow(Icons.group, "Number of Guests", widget.numberOfGuests.toString()),
                    _buildDetailRow(Icons.door_front_door, "Number of Rooms", widget.numberOfRooms.toString()),
                    _buildDetailRow(Icons.login, "Check-in Time", widget.checkInTime.format(context)),
                    _buildDetailRow(Icons.logout, "Check-out Time", widget.checkOutTime.format(context)),
                    const SizedBox(height: 20),
                    _buildTotalPriceRow(),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Pay Now Button
              Center(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      var options = {
                        'key': 'rzp_test_amOok42ADXLkQs',
                        'amount': (widget.totalPrice * 100).toInt(),
                        'name': 'Vandan Kacha',
                        'description': 'Travel Package',
                        'prefill': {
                          'contact': '8888888888',
                          'email': 'test@razorpay.com',
                        },
                      };
                      razorpay.open(options);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[900],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                      shadowColor: Colors.teal.withOpacity(0.5),
                    ),
                    child: const Text(
                      "Pay Now",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.teal[900],
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.teal[900], size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPriceRow() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal[900]!, Colors.teal[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Total Price (Incl. 18% Tax)",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "₹",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                widget.totalPrice.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}