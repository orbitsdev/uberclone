import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uberclone/controller/mapcontroller.dart';
import 'package:uberclone/helper/map_helper.dart';
import 'package:uberclone/model/place_prediction.dart';

class SearchScreen extends StatefulWidget {
  static const screenName = "/search";

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var mapxcontroller = Get.find<Mapcontroller>();
  TextEditingController locationfield = TextEditingController();
  TextEditingController dropofffield = TextEditingController();
  List<PlacePrediction> placepredictionlist = [];

  @override
  Widget build(BuildContext context) {
    locationfield.text =
        mapxcontroller.pickUpLocation.value.placeName as String;
    dropofffield.text =
        mapxcontroller.dropofflocation.value.placeName as String;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            decoration: BoxDecoration(color: Colors.grey[200], boxShadow: [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 6.0,
                  spreadRadius: 0.6,
                  offset: Offset(0.7, 0.7))
            ]),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 25, top: 10, right: 25, bottom: 20),
              child: Column(
                children: [
                  SizedBox(width: 5.0, height: 0.0),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back)),
                      Center(
                        child: Text(
                          "Set drop Off",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextField(
                            controller: locationfield,
                            decoration: InputDecoration(
                                hintText: "Pickup Location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0)),
                          ),
                        ),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextField(
                            onChanged: (val) {
                              mapxcontroller.findPlace(dropofffield.text);
                            },
                            controller: dropofffield,
                            decoration: InputDecoration(
                                hintText: "Droff Location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0)),
                          ),
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            child: Obx(() {
              if (mapxcontroller.placepredictionlist.length > 0) {
                return ListView.builder(
                    itemCount: mapxcontroller.placepredictionlist.length,
                    itemBuilder: (contex, index) {
                      return PredictionTile(
                        placePrediction:
                            mapxcontroller.placepredictionlist[index],
                        getPlaceAddress: mapxcontroller.getPlaceAddress,
                      );
                    });
              } else {
                return Container();
              }
            }),
          )
        ]),
      ),
    ));
  }
}

class PredictionTile extends StatelessWidget {
  final Function getPlaceAddress;
  final PlacePrediction placePrediction;
  PredictionTile({
    required this.placePrediction,
    required this.getPlaceAddress,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
      getPlaceAddress(placePrediction.place_id);
      
      },
      child: Container(
        child: Column(children: [
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Icon(Icons.add_location),
              SizedBox(
                width: 14.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      placePrediction.main_text as String,
                      style: TextStyle(
                          fontSize: 16.0, overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      placePrediction.secondary_text as String,
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          )
        ]),
      ),
    );
  }
}
