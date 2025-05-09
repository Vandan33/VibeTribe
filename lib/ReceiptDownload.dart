import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

class ReceiptScreen extends StatelessWidget {
  final String fullName;
  final String hotelName;
  final String roomType;
  final int numberOfGuests;
  final int numberOfRooms;
  final TimeOfDay checkInTime;
  final TimeOfDay checkOutTime;
  final double totalPrice;
  final String paymentId;

  const ReceiptScreen({
    super.key,
    required this.fullName,
    required this.hotelName,
    required this.roomType,
    required this.numberOfGuests,
    required this.numberOfRooms,
    required this.checkInTime,
    required this.checkOutTime,
    required this.totalPrice,
    required this.paymentId,
  });

  // Helper method to format TimeOfDay manually for PDF
  String _formatTimeOfDay(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    final period = time.hour < 12 ? 'AM' : 'PM';
    final hour12 = time.hour % 12 == 0 ? 12 : time.hour % 12;
    return '$hour12:$minutes $period';
  }

  Future<void> _downloadReceipt(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "Booking Receipt",
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            pw.Text("Full Name: $fullName", style: pw.TextStyle(fontSize: 16)),
            pw.Text("Hotel Name: $hotelName", style: pw.TextStyle(fontSize: 16)),
            pw.Text("Room Type: $roomType", style: pw.TextStyle(fontSize: 16)),
            pw.Text("Number of Guests: $numberOfGuests", style: pw.TextStyle(fontSize: 16)),
            pw.Text("Number of Rooms: $numberOfRooms", style: pw.TextStyle(fontSize: 16)),
            // Use _formatTimeOfDay instead of checkInTime.format(context)
            pw.Text("Check-in Time: ${_formatTimeOfDay(checkInTime)}", style: pw.TextStyle(fontSize: 16)),
            pw.Text("Check-out Time: ${_formatTimeOfDay(checkOutTime)}", style: pw.TextStyle(fontSize: 16)),
            pw.Text(
              "Total Price (Incl. 18% Tax): ₹${totalPrice.toStringAsFixed(2)}",
              style: pw.TextStyle(fontSize: 16),
            ),
            pw.Text("Payment ID: $paymentId", style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 20),
            pw.Text(
              "Thank you for booking with VibeTribe!",
              style: pw.TextStyle(fontSize: 14), // Use fontItalic
            ),
          ],
        ),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/booking_receipt_${DateTime.now().millisecondsSinceEpoch}.pdf");
    await file.writeAsBytes(await pdf.save());

    Fluttertoast.showToast(msg: "Receipt downloaded to ${file.path}");
    OpenFile.open(file.path); // Optional: Open the PDF file
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booking Receipt",
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
                    _buildSectionTitle("Booking Receipt"),
                    const SizedBox(height: 20),
                    _buildDetailRow(Icons.person, "Full Name", fullName),
                    _buildDetailRow(Icons.hotel, "Hotel Name", hotelName),
                    _buildDetailRow(Icons.king_bed, "Room Type", roomType),
                    _buildDetailRow(Icons.group, "Number of Guests", numberOfGuests.toString()),
                    _buildDetailRow(Icons.door_front_door, "Number of Rooms", numberOfRooms.toString()),
                    _buildDetailRow(Icons.login, "Check-in Time", checkInTime.format(context)),
                    _buildDetailRow(Icons.logout, "Check-out Time", checkOutTime.format(context)),
                    _buildDetailRow(Icons.payment, "Payment ID", paymentId),
                    const SizedBox(height: 20),
                    _buildTotalPriceRow(),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _downloadReceipt(context),
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
                      "Download Receipt",
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
                  color: Colors.teal[100],
                ),
              ),
              const SizedBox(width: 4),
              Text(
                totalPrice.toStringAsFixed(2),
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