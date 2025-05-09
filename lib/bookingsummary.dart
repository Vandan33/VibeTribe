import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class PackageBookingSummary extends StatefulWidget {
  final String fullName;
  final String phoneNo;
  final String city;
  final String selectedPackage;
  final String date;
  final int noOfPeople;
  final double totalPrice;

  const PackageBookingSummary({
    super.key,
    required this.fullName,
    required this.phoneNo,
    required this.city,
    required this.selectedPackage,
    required this.date,
    required this.noOfPeople,
    required this.totalPrice,
  });

  @override
  State<PackageBookingSummary> createState() => _PackageBookingSummaryState();
}

class _PackageBookingSummaryState extends State<PackageBookingSummary> {
  Razorpay razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    razorpay.clear();
    super.dispose();
  }

  Future<void> _saveBookingToDatabase() async {
    final url = Uri.parse('http://192.168.249.97/register_api/insert_package_booking.php');
    try {
      final response = await http.post(
        url,
        body: {
          'fullName': widget.fullName,
          'phoneNo': widget.phoneNo,
          'city': widget.city,
          'selectedPackage': widget.selectedPackage,
          'date': widget.date,
          'noOfPeople': widget.noOfPeople.toString(),
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: "Payment Successful");
    await _saveBookingToDatabase();
    // Optionally navigate to a receipt screen
    // Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptScreen(...)));
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
        backgroundColor: Colors.lightBlue, // Light blue theme
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
                    _buildDetailRow(Icons.person, "Full Name", widget.fullName),
                    _buildDetailRow(Icons.phone, "Phone No", widget.phoneNo),
                    _buildDetailRow(Icons.location_city, "City", widget.city),
                    _buildDetailRow(Icons.card_travel, "Selected Package", widget.selectedPackage),
                    _buildDetailRow(Icons.calendar_today, "Date", widget.date),
                    _buildDetailRow(Icons.group, "Number of People", widget.noOfPeople.toString()),
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
                        'key': 'rzp_test_amOok42ADXLkQs', // Use your Razorpay key
                        'amount': (widget.totalPrice * 100).toInt(), // Convert to paise
                        'name': widget.fullName,
                        'description': 'Travel Package',
                        'prefill': {
                          'contact': widget.phoneNo,
                          'email': 'test@razorpay.com',
                        },
                      };
                      razorpay.open(options);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue, // Light blue theme
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                      shadowColor: Colors.lightBlue.withOpacity(0.5),
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
        color: Colors.lightBlue,
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
              color: Colors.lightBlue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.lightBlue, size: 20),
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
          colors: [Colors.lightBlue, Colors.lightBlue[300]!],
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
              "Total Price",
              style: TextStyle(
                fontSize: 16,
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
                  color: Colors.white,
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