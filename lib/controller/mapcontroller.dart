import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uberclone/dialog/notificationdialog.dart';
import 'package:uberclone/helper/map_helper.dart';
import 'package:uberclone/model/address.dart';
import 'package:uberclone/model/place_prediction.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Mapcontroller extends GetxController {
  var pickUpLocation = Address().obs;
  var dropofflocation = Address().obs;
  var placepredictionlist = <PlacePrediction>[].obs;



  void updatePickUpLocation(dynamic pickupaddress) {
    if (pickupaddress != 'failed') {
      pickUpLocation(pickupaddress);
    }
  }

  void findPlace(String placeName) async {
    var placelist;
    if (placeName.length > 1) {
      String autocompleteurl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${placeName}&radius=50000&key=${MapHelper.GOOGLEMAP_API_KEY}&components=country:ph";

      var response = await MapHelper.getMapRequest(autocompleteurl);

      if (response != 'failed') {
        var prediction = response["predictions"];
        placelist = (prediction as List)
            .map((e) => PlacePrediction.fromJsom(e))
            .toList()
            .obs;
        placepredictionlist.value = placelist;
      }
    }
  }

  void getPlaceAddress(String placeId) async {
    print('________________ place id');
    print(placeId);
    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeId}&key=${MapHelper.GOOGLEMAP_API_KEY}";
    progressDialog('Selecting Drop off...');

    var response = await MapHelper.getMapRequest(placeDetailsUrl);

    print('________________ response');

    if (response != "failed") {
      Address address = Address();
      address.placeName = response["result"]["name"];
      address.placeId = placeId;
      address.latitude = response["result"]["geometry"]["location"]["lat"];
      address.longitude = response["result"]["geometry"]["location"]["lng"];
      dropofflocation(address);
      Get.back();
      Get.back(result: "route is ready");
    }
  }

  Future<String> getPlaceDirection() async {
    var initiallocation = pickUpLocation;
    var finalpostion = dropofflocation;

    var pickuplatling = LatLng(initiallocation.value.latitude as double,
        initiallocation.value.longitude as double);

    var dropofflatlng = LatLng(finalpostion.value.latitude as double,
        finalpostion.value.longitude as double);

    progressDialog('Setting your route...');

    var directiondetails =
        await MapHelper.obtainPlaceDirection(pickuplatling, dropofflatlng);
    Get.back();

    print('__________ encoded point');
    print(directiondetails.encodedPoints);
    return directiondetails.encodedPoints as String;


    // PolylinePoints polylinespoints = PolylinePoints();
    // List<PointLatLng> decodePolyLinePointsResult = polylinespoints
    //     .decodePolyline(directiondetails.encodedPoints as String);
    
    
    // plineCoordinates.clear();

    // if (decodePolyLinePointsResult.isNotEmpty) {
    //   decodePolyLinePointsResult.forEach((points) {
    //     plineCoordinates.add(LatLng(points.latitude, points.longitude));
    //   });
    // }

    // polylinesSet.clear();

    // Polyline polylnns = Polyline(
    //   color: Colors.pink,
    //   polylineId: PolylineId("polylindId"),
    //   jointType: JointType.round,
    //   points: plineCoordinates,
    //   width: 5,
    //   startCap: Cap.roundCap,
    //   endCap: Cap.roundCap,
    //   geodesic: true,
    // );

    // polylinesSet.add(polylnns);
  }
}
