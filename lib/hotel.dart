import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vibe_tribe/hotel_form.dart';
import 'package:vibe_tribe/hotel_model.dart';

class Hotel extends StatefulWidget {
  final HotelModel hotel;

  const Hotel({super.key, required this.hotel});

  @override
  State<Hotel> createState() => _HotelState();
}

class _HotelState extends State<Hotel> with SingleTickerProviderStateMixin {
  // Room Info
  String? selectedRoomType = "Single"; // Default room type
  int capacity = 2; // Default number of guests
  int roomCount = 1; // Default number of rooms
  final double taxRate = 0.18; // 18% GST

  // Facilities
  final List<Map<String, dynamic>> facilities = [
    {"name": "Free Wi-Fi", "enabled": true},
    {"name": "Parking", "enabled": true},
    {"name": "Restaurant", "enabled": true},
    {"name": "Air Conditioning", "enabled": true},
  ];

  // Timing
  TimeOfDay checkInTime = const TimeOfDay(hour: 14, minute: 0); // 2:00 PM
  TimeOfDay checkOutTime = const TimeOfDay(hour: 12, minute: 0); // 12:00 PM

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFacility(int index) {
    setState(() {
      facilities[index]["enabled"] = !facilities[index]["enabled"];
    });
  }

  void _incrementRooms() {
    setState(() {
      roomCount++;
    });
  }

  void _decrementRooms() {
    setState(() {
      if (roomCount > 1) roomCount--;
    });
  }

  void _incrementCapacity() {
    setState(() {
      capacity++;
    });
  }

  void _decrementCapacity() {
    setState(() {
      if (capacity > 1) capacity--;
    });
  }

  Future<void> _selectTime(BuildContext context, bool isCheckIn) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isCheckIn ? checkInTime : checkOutTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Colors.teal[700]!),
            dialogBackgroundColor: Colors.white,
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) checkInTime = picked; else checkOutTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double totalPrice = widget.hotel.discountPrice * roomCount * (1 + taxRate);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image with Fade Animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:AssetImage("assets/crowngoa.jpeg") as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Hotel Information
              _buildSectionTitle("Hotel Information"),
              const SizedBox(height: 16),

              _buildInfoCard([
                _buildDetailRow("Hotel Name", widget.hotel.name, null),
                _buildDetailRow("Location", widget.hotel.location, Icons.location_on),
                _buildDetailRow("Address", widget.hotel.address, Icons.map),
                _buildDetailRow("Description", widget.hotel.description, null, isDescription: true),
                _buildPriceRow("Price/Night", "₹${widget.hotel.discountPrice.toStringAsFixed(2)}"),
              ]),
              const SizedBox(height: 24),

              // Room & Guest Selection
              _buildSectionTitle("Room & Guest Details"),
              const SizedBox(height: 16),

              _buildSelectionCard([
                _buildDropdown("Room Type", ["Single", "Double", "Deluxe"], selectedRoomType,
                    (newValue) => setState(() => selectedRoomType = newValue)),
                _buildCounterRow("Number of Guests", capacity, _decrementCapacity, _incrementCapacity),
                _buildCounterRow("Number of Rooms", roomCount, _decrementRooms, _incrementRooms),
              ]),
              const SizedBox(height: 24),

              // Facilities
              _buildSectionTitle("Facilities"),
              const SizedBox(height: 16),

              _buildFacilityList(),
              const SizedBox(height: 24),

              // Check-in/Check-out Timing
              _buildSectionTitle("Check-in/Check-out Timing"),
              const SizedBox(height: 16),

              _buildTimingCard([
                _buildTimeRow("Check-in", checkInTime, () => _selectTime(context, true)),
                _buildTimeRow("Check-out", checkOutTime, () => _selectTime(context, false)),
              ]),
              const SizedBox(height: 24),

              // Total Price
              _buildTotalPriceCard(totalPrice),
              const SizedBox(height: 30),

              // Book Now Button with Scale Animation
              Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to HotelForm with booking details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelForm(
                            fullName: "", // Initially empty, to be filled by user
                            hotelName: widget.hotel.name,
                            roomType: selectedRoomType ?? "Single",
                            numberOfGuests: capacity,
                            numberOfRooms: roomCount,
                            checkInTime: checkInTime,
                            checkOutTime: checkOutTime,
                            totalPrice: totalPrice,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[700],
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                      shadowColor: Colors.teal.withOpacity(0.5),
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(
                        fontSize: 20,
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

  Widget _buildInfoCard(List<Widget> children) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value, IconData? icon, {bool isDescription = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Icon(icon, color: Colors.teal, size: 20),
          if (icon != null) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: isDescription
                ? Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  )
                : Text(
                    value,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String title, String price) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.currency_rupee, color: Colors.teal, size: 20),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(
              price,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal[900],
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionCard(List<Widget> children) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildDropdown(String title, List<String> items, String? value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.bed, color: Colors.teal, size: 20),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: DropdownButtonFormField<String>(
              value: value,
              onChanged: onChanged,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
              style: TextStyle(fontSize: 14, color: Colors.grey[800], fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounterRow(String title, int value, VoidCallback decrement, VoidCallback increment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.people, color: Colors.teal, size: 20),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline, color: Colors.teal),
                  onPressed: decrement,
                ),
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: Colors.teal),
                  onPressed: increment,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFacilityList() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: facilities.asMap().entries.map((entry) {
        final index = entry.key;
        final facility = entry.value;
        return ChoiceChip(
          label: Text(facility["name"], style: TextStyle(color: Colors.grey[800])),
          selected: facility["enabled"],
          onSelected: (selected) => _toggleFacility(index),
          selectedColor: Colors.teal[100],
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        );
      }).toList(),
    );
  }

  Widget _buildTimingCard(List<Widget> children) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildTimeRow(String title, TimeOfDay time, VoidCallback onTap) {
    return ListTile(
      leading: Icon(Icons.access_time, color: Colors.teal),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800])),
      subtitle: Text(
        time.format(context),
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit, color: Colors.teal),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildTotalPriceCard(double totalPrice) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[900]!, Colors.teal[600]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Total Price (Incl. 18% Tax)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.8,
                ),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "₹",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[100],
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  totalPrice.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}