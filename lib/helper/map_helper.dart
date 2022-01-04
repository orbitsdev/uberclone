import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:uberclone/model/address.dart';
import 'package:uberclone/model/direction_details.dart';

class MapHelper {
  static const String GOOGLEMAP_API_KEY =
      "AIzaSyD3JfMJL1NDLUYikjiau2tPLY_l3ZBACoE";

  static Future<dynamic> getMapRequest(String url) async {
    var requesturl = Uri.parse(url);
    var response = await http.get(requesturl);

    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return 'failed';
      }
    } catch (e) {
      return 'failed';
    }
  }

  static Future<dynamic> getGeoRequest(Position position) async {
    Address? useraddress;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${GOOGLEMAP_API_KEY}";
    var data = await MapHelper.getMapRequest(url);

    if (data != "failed") {
      var holder = data["results"][0]["address_components"];
      var placename = holder[1]["long_name"] +
          " " +
          holder[2]["long_name"] +
          " " +
          holder[3]["long_name"];

      useraddress = Address(
        placeName: placename,
        longitude: position.longitude,
        latitude: position.latitude,
      );
      return useraddress;
    }
    return "null";
  }

  static Future<DirectionDetails> obtainPlaceDirection(LatLng initialpostion, LatLng finalPostion) async {
    String directionurl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialpostion.latitude},${initialpostion.longitude}&destination=${finalPostion.latitude},${finalPostion.longitude}&key=${GOOGLEMAP_API_KEY}";

    var response = await getMapRequest(directionurl);
  

    DirectionDetails directiondetails = DirectionDetails();

    var reskey = response["routes"][0];

    directiondetails.encodedPoints = reskey["overview_polyline"]["points"];
    directiondetails.distanceText = reskey["legs"][0]["distance"]["text"];
    directiondetails.distanceValue = reskey["legs"][0]["distance"]["value"];
    directiondetails.durationText = reskey["legs"][0]["duration"]["text"];
    directiondetails.durationValue = reskey["legs"][0]["duration"]["value"];

    return directiondetails;
  }


}
