import 'package:flutter/cupertino.dart';
import 'package:tracking_app/Models/address.dart';

class AppData extends ChangeNotifier {
  Address pickupLocation;
  void updatePickupLocation(Address pickupAddress) {
    pickupLocation = pickupAddress;
    notifyListeners();
  }
}
