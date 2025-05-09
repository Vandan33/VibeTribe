import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService
{
  Future<Position> getCurrentLocation() async
  {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled)
    {
      return Future.error("Location Service is disabled");
    }

    permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied)
    {
    permission=await Geolocator.requestPermission();
    if(permission==LocationPermission.denied)
    {
      return Future.error("Location Permission is denied");
    }
    }
    if(permission==LocationPermission.deniedForever)
    {
      return Future.error("Location permission are permanently denied");
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );
  }
  
  Future<String> getAddressFromCoordinates(Position position) async
  {
    try
    {
        List<Placemark> placemarks=await placemarkFromCoordinates(position.latitude, position.longitude);
        Placemark place=placemarks[0];
        return "${place.street},${place.locality},${place.country}";
    }
    catch (e)
    {
      return "Address not found";
    }
  }
}