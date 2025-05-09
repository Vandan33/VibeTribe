import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibe_tribe/bookingsummary.dart'; // For date formatting

class PackageBookingForm extends StatefulWidget {
  final String selectedPackage;
  final String date;
  final double packagePrice; // Price per person

  const PackageBookingForm({
    super.key,
    required this.selectedPackage,
    required this.date,
    required this.packagePrice,
  });

  @override
  State<PackageBookingForm> createState() => _PackageBookingFormState();
}

class _PackageBookingFormState extends State<PackageBookingForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneNoController;
  late TextEditingController _cityController;
  late TextEditingController _noOfPeopleController;
  DateTime? _selectedDate;
  double _totalPrice = 0.0; // Dynamic totalPrice

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _phoneNoController = TextEditingController();
    _cityController = TextEditingController();
    _noOfPeopleController = TextEditingController();
    _selectedDate = DateTime.parse(widget.date);

    // Add listener to noOfPeopleController to update totalPrice
    _noOfPeopleController.addListener(_updateTotalPrice);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNoController.dispose();
    _cityController.dispose();
    _noOfPeopleController.removeListener(_updateTotalPrice); // Clean up listener
    _noOfPeopleController.dispose();
    super.dispose();
  }

  // Update totalPrice based on noOfPeople
  void _updateTotalPrice() {
    final noOfPeople = int.tryParse(_noOfPeopleController.text) ?? 0;
    setState(() {
      _totalPrice = noOfPeople * widget.packagePrice;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _onNextPressed() {
    if (_formKey.currentState!.validate()) {
      final bookingData = {
        'fullName': _fullNameController.text,
        'phoneNo': _phoneNoController.text,
        'city': _cityController.text,
        'selectedPackage': widget.selectedPackage,
        'date': _selectedDate!.toIso8601String(),
        'noOfPeople': _noOfPeopleController.text,
        'totalPrice': _totalPrice.toString(), // Use dynamic totalPrice
      };
      print('Booking Data: $bookingData'); // For debugging
      // Example: Navigate to a payment or confirmation screen
      // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen(bookingData: bookingData)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Booking Form",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlue, // Light blue theme for app bar
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Form Fields Card
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

                      // Full Name
                      _buildTextFormField(
                        label: "Full Name",
                        controller: _fullNameController,
                        icon: Icons.person,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),

                      // Phone Number
                      _buildTextFormField(
                        label: "Phone No",
                        controller: _phoneNoController,
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Phone number must be at least 10 digits';
                          }
                          return null;
                        },
                      ),

                      // City
                      _buildTextFormField(
                        label: "Your City",
                        controller: _cityController,
                        icon: Icons.location_city,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),

                      // Selected Package (Display Only)
                      _buildDetailRow(Icons.card_travel, "Selected Package", widget.selectedPackage),

                      // Date
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: _buildTextFormField(
                            label: "Date",
                            controller: TextEditingController(
                              text: _selectedDate != null
                                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                                  : '',
                            ),
                            icon: Icons.calendar_today,
                            enabled: false, // Non-editable but clickable for date picker
                          ),
                        ),
                      ),

                      // Number of People
                      _buildTextFormField(
                        label: "Number of People",
                        controller: _noOfPeopleController,
                        icon: Icons.group,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter number of people';
                          }
                          if (int.tryParse(value) == null || int.parse(value) <= 0) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),

                      // Total Price (Display Only)
                      _buildDetailRow(Icons.currency_rupee, "Total Price",
                          "₹ ${_totalPrice.toStringAsFixed(2)}"),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Next Button
                Center(
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PackageBookingSummary(
                          fullName: _fullNameController.text,
          phoneNo: _phoneNoController.text,
          city: _cityController.text,
          selectedPackage: widget.selectedPackage,
          date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
          noOfPeople: int.parse(_noOfPeopleController.text),
          totalPrice: _totalPrice,
                        ),));
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
                        "Next",
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
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.lightBlue, // Light blue theme
        letterSpacing: 1.0,
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.lightBlue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.lightBlue[200]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.lightBlue[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.lightBlue, width: 2),
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
        enabled: enabled,
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
}