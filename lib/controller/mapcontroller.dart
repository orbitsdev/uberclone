import 'package:get/get.dart';
import 'package:uberclone/model/address.dart';

class Mapcontroller extends GetxController {
  var pickUpLocation = Address().obs;



  void updatePickUpLocation(Address pickupaddress) {
      //print(pickupaddress.placeName);
    // pickUpLocation.update((newaddress) {
    //   newaddress!.latitude = pickupaddress.latitude;
    //   newaddress.longitude = pickupaddress.longitude;
    //   newaddress.

    // });
    pickUpLocation(pickupaddress);
    
 
    print(pickUpLocation.value.placeName);
  }
}
