import 'package:flutter/cupertino.dart';
import 'package:tracking_app/Models/address.dart';

class AppData extends ChangeNotifier {
  Address pickUpLocation,dropOfLocation;
  void updatePickupLocation(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}
