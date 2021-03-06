import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uberclone/controller/mapcontroller.dart';
import 'package:uberclone/helper/map_helper.dart';
import 'package:uberclone/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const screenName = '/Home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double searchcontainerhieght = 300.0;
  double requestcontainerhieght = 0;
  var mapxcontroller = Get.put(Mapcontroller());
  Completer<GoogleMapController> _googlemapcontroller = Completer();
  GoogleMapController? _newgooglemapcontroller;
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  Position? currentPosition;
  double bottompading = 0;

  List<LatLng> plineCoordinates = [];
  Set<Polyline> polylinesSet = {};

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<void> _locatePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng latlingpostion =
        LatLng(currentPosition!.latitude, currentPosition!.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latlingpostion, zoom: 14);
    _newgooglemapcontroller!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

//    var geocodeaddress = await MapHelper.testGeoRequest(currentPosition as Position);

    //  print(geocodeaddress["results"][0]["formatted_address"]);
    var response = await MapHelper.getGeoRequest(currentPosition as Position);
    mapxcontroller.updatePickUpLocation(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: const Text('Map Test'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 165,
              child: DrawerHeader(
                child: Row(
                  children: [
                    Image.asset(
                      'name',
                      width: 65,
                      height: 65,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Profile Names',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text('Visit Profile'),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 1.0,
                      height: 1.0,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottompading),
            mapType: MapType.hybrid,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _kGooglePlex,
            polylines: polylinesSet,
            onMapCreated: (GoogleMapController mapController) {
              _googlemapcontroller.complete(mapController);
              _newgooglemapcontroller = mapController;
              setState(() {
                bottompading = 300.0;
              });
              _locatePosition();
            },
          ),
          Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  _scaffoldkey.currentState!.openDrawer();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.menu,
                      color: Colors.black54,
                    ),
                  ),
                  decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6.0,
                      spreadRadius: 0.6,
                      offset: Offset(0.7, 0.7),
                    )
                  ]),
                ),
              )),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SingleChildScrollView(
              child: Container(
                height: searchcontainerhieght,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 16.0,
                        spreadRadius: 0.6,
                        offset: Offset(0.7, 0.7),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 24,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'hi there',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          'Where ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            var response =
                                await Get.toNamed(SearchScreen.screenName);

                            if (response == "route is ready") {
                              var encodedPoints =
                                  await mapxcontroller.getPlaceDirection();

                              PolylinePoints polylinespoints = PolylinePoints();
                              List<PointLatLng> decodePolyLinePointsResult =
                                  polylinespoints.decodePolyline(encodedPoints);

                              plineCoordinates.clear();

                              if (decodePolyLinePointsResult.isNotEmpty) {
                                decodePolyLinePointsResult.forEach((points) {
                                  plineCoordinates.add(LatLng(
                                      points.latitude, points.longitude));
                                });
                              }

                              polylinesSet.clear();

                              setState(() {
                                Polyline polylnns = Polyline(
                                  color: Colors.pink,
                                  polylineId: PolylineId("polylindId"),
                                  jointType: JointType.round,
                                  points: plineCoordinates,
                                  width: 5,
                                  startCap: Cap.roundCap,
                                  endCap: Cap.roundCap,
                                  geodesic: true,
                                );

                                polylinesSet.add(polylnns);

                                searchcontainerhieght = 0;
                                requestcontainerhieght = 300;
                              });
                              var initiallocation =
                                  mapxcontroller.pickUpLocation.value;
                              var finalpostion =
                                  mapxcontroller.dropofflocation.value;

                              var pickuplatling = LatLng(
                                  initiallocation.latitude as double,
                                  initiallocation.longitude as double);

                              var dropofflatlng = LatLng(
                                  finalpostion.latitude as double,
                                  finalpostion.longitude as double);
                              LatLngBounds latLngBounds;

                              if (pickuplatling.latitude >
                                      dropofflatlng.latitude &&
                                  pickuplatling.longitude >
                                      dropofflatlng.longitude) {
                                latLngBounds = LatLngBounds(
                                    southwest: pickuplatling,
                                    northeast: dropofflatlng);
                              } else if (pickuplatling.longitude >
                                  dropofflatlng.longitude) {
                                latLngBounds = LatLngBounds(
                                    southwest: LatLng(pickuplatling.latitude,
                                        dropofflatlng.longitude),
                                    northeast: LatLng(dropofflatlng.latitude,
                                        pickuplatling.longitude));
                              } else if (pickuplatling.latitude >
                                  dropofflatlng.latitude) {
                                latLngBounds = LatLngBounds(
                                    southwest: LatLng(dropofflatlng.latitude,
                                        pickuplatling.longitude),
                                    northeast: LatLng(pickuplatling.latitude,
                                        dropofflatlng.longitude));
                              } else {
                                latLngBounds = LatLngBounds(
                                    southwest: pickuplatling,
                                    northeast: dropofflatlng);
                              }

                              _newgooglemapcontroller!.animateCamera(
                                  CameraUpdate.newLatLngBounds(
                                      latLngBounds, 70));
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.6,
                                  offset: Offset(0.7, 0.7),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Icon(Icons.search),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Search Drop Off')
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(
                                  () {
                                    return Text(
                                      mapxcontroller.pickUpLocation.value
                                                  .placeName ==
                                              ''
                                          ? "Add Home"
                                          : "${mapxcontroller.pickUpLocation.value.placeName}",
                                      overflow: TextOverflow.ellipsis,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Your living address',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: Theme.of(context).primaryColor,
                          height: 1.0,
                          thickness: 1.0,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.work,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Add Work'),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Office Workk address',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: requestcontainerhieght,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0.6,
                        blurRadius: 6.0,
                        color: Colors.black54,
                        offset: Offset(0.7, 0.7),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 25,
                  ),
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              polylinesSet.clear();
                              searchcontainerhieght = 300;
                              requestcontainerhieght = 0;
                            });
                          },
                          child: Text('Cancel')),
                      SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(onPressed: () {}, child: Text('Request'))
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
