import 'package:flutter/cupertino.dart';
import 'package:tracking_app/Models/address.dart';

class AppData extends ChangeNotifier {
  Address _pickUpLocation;
  Address get pickUpLocation => _pickUpLocation;
  void updatePickupLocation(Address pickUpAddress) {
    _pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}
