import 'package:flutter/material.dart';
import 'package:vibe_tribe/date_selection.dart';

class CountryStateCityDropdown extends StatefulWidget {
  @override
  _CountryStateCityDropdownState createState() => _CountryStateCityDropdownState();
}

class _CountryStateCityDropdownState extends State<CountryStateCityDropdown> {
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  // List of countries (Only India)
  List<String> countries = ["India"];

  // All Indian States
  Map<String, List<String>> states = {
    "India": [
      "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
      "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka",
      "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", 
      "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim", 
      "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", 
      "West Bengal"
    ]
  };

  // Cities for each State
  Map<String, List<String>> cities = {
    "Andhra Pradesh": ["Visakhapatnam", "Vijayawada", "Guntur"],
    "Arunachal Pradesh": ["Itanagar", "Tawang", "Ziro"],
    "Assam": ["Guwahati", "Dibrugarh", "Silchar"],
    "Bihar": ["Patna", "Gaya", "Muzaffarpur"],
    "Chhattisgarh": ["Raipur", "Bhilai", "Bilaspur"],
    "Goa": ["Panaji", "Margao", "Vasco da Gama"],
    "Gujarat": ["Ahmedabad", "Surat", "Vadodara"],
    "Haryana": ["Chandigarh", "Gurgaon", "Faridabad"],
    "Himachal Pradesh": ["Shimla", "Manali", "Dharamshala"],
    "Jharkhand": ["Ranchi", "Jamshedpur", "Dhanbad"],
    "Karnataka": ["Bangalore", "Mysore", "Hubli"],
    "Kerala": ["Thiruvananthapuram", "Kochi", "Kozhikode"],
    "Madhya Pradesh": ["Bhopal", "Indore", "Gwalior"],
    "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
    "Manipur": ["Imphal", "Thoubal", "Bishnupur"],
    "Meghalaya": ["Shillong", "Tura", "Jowai"],
    "Mizoram": ["Aizawl", "Lunglei", "Champhai"],
    "Nagaland": ["Kohima", "Dimapur", "Mokokchung"],
    "Odisha": ["Bhubaneswar", "Cuttack", "Puri"],
    "Punjab": ["Ludhiana", "Amritsar", "Jalandhar"],
    "Rajasthan": ["Jaipur", "Jodhpur", "Udaipur"],
    "Sikkim": ["Gangtok", "Namchi", "Mangan"],
    "Tamil Nadu": ["Chennai", "Coimbatore", "Madurai"],
    "Telangana": ["Hyderabad", "Warangal", "Nizamabad"],
    "Tripura": ["Agartala", "Dharmanagar", "Udaipur"],
    "Uttar Pradesh": ["Lucknow", "Kanpur", "Varanasi"],
    "Uttarakhand": ["Dehradun", "Haridwar", "Nainital"],
    "West Bengal": ["Kolkata", "Howrah", "Durgapur"]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Country, State & City")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Country Dropdown
            Text("Select Country"),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedCountry,
              hint: Text("Select Country"),
              items: countries.map((country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCountry = value;
                  selectedState = null; // Reset state selection
                  selectedCity = null; // Reset city selection
                });
              },
            ),

            SizedBox(height: 20),

            // State Dropdown
            Text("Select State"),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedState,
              hint: Text("Select State"),
              items: (selectedCountry != null)
                  ? states[selectedCountry]!.map((state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      );
                    }).toList()
                  : [],
              onChanged: (value) {
                setState(() {
                  selectedState = value;
                  selectedCity = null; // Reset city selection
                });
              },
            ),

            SizedBox(height: 20),

            // City Dropdown
            Text("Select City"),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedCity,
              hint: Text("Select City"),
              items: (selectedState != null)
                  ? cities[selectedState]!.map((city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList()
                  : [],
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
            ),

            SizedBox(height: 30),

            // Display selected values
            if (selectedCountry != null && selectedState != null && selectedCity != null)
              Text(
                "Selected Location: $selectedCountry > $selectedState > $selectedCity",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              ElevatedButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TourPackageDateSelector(),));
              }, child: Text("Back"))
          ],
        ),
      ),
    );
  }
}