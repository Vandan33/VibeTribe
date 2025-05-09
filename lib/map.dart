import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:vibe_tribe/location.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class map extends StatefulWidget {
  const map({super.key});

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {

  GoogleMapController? mapController;
  LatLng? selectedLocation;
  String address="Select a Location";
  Marker? locationMarker;

  void _onMapCreated(GoogleMapController controller)
  {
    mapController=controller;
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await LocationService().getCurrentLocation();
      String addr = await LocationService().getAddressFromCoordinates(position);

      setState(() {
        selectedLocation = LatLng(position.latitude, position.longitude);
        address = addr;
      });

      mapController?.animateCamera(CameraUpdate.newLatLng(selectedLocation!));
    } catch (e) {
      setState(() {
        address = "Error getting location";
      });
    }
  }

  void savelocation()
  {
    if(selectedLocation!=null)
    {
      Navigator.pop(
        context,{
          "latitude":selectedLocation!.latitude,
          "longitude":selectedLocation!.longitude,
          "address":address,
        }
      );
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Select a Location"),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: GoogleMap(
                                        onMapCreated: _onMapCreated,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(20.5937, 78.9629),
                                          zoom: selectedLocation!=null ? 15:5,
                                          ),
                                          onTap: (LatLng latLng) async
                                          {
                                            String addr=await LocationService().getAddressFromCoordinates(Position(
                                              longitude: latLng.longitude,
                                              latitude: latLng.latitude,
                                              timestamp: DateTime.now(),
                                              accuracy: 1.0,
                                              altitude: 1.0,
                                              altitudeAccuracy: 1.0,
                                              headingAccuracy: 1.0,
                                              heading: 1.0,
                                              speed: 1.0,
                                              speedAccuracy: 1.0)
                                            );
                                            
                                            setState(() {
                                              selectedLocation=latLng;
                                              address=addr;
                                              locationMarker=Marker(markerId: const MarkerId("Selected-Location"),
                                              position: selectedLocation!);
                                            });
                                            mapController?.animateCamera(CameraUpdate.newLatLng(latLng));
                                          },
                                         markers: locationMarker != null ? {locationMarker!} : {},
                                          ),
                                          ),
                                           Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: getCurrentLocation,
                  child: Text("Use My Current Location"),
                ),
                Text("Selected Address: $address"),     
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(onPressed: savelocation, child: Text("Save Loction"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}