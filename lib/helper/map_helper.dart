import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:uberclone/model/address.dart';

class MapHelper {
  static const String GOOGLEMAP_API_KEY =
      "AIzaSyD3JfMJL1NDLUYikjiau2tPLY_l3ZBACoE";

  static Future<dynamic> getGeoRequest(Position position) async {
    Address? useraddress;
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${GOOGLEMAP_API_KEY}");

    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var holder = data["results"][0]["address_components"];
        var placename = holder[1]["long_name"] +
            " " +
            holder[4]["long_name"] +
            " " +
            holder[4]["long_name"];

        print('_____________ inside Map Helper');
        print(placename);

        useraddress = Address(
          placeName: placename,
          longitude: position.longitude,
          latitude: position.latitude,
        );
        return useraddress;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
    }
    // }
  }
}
