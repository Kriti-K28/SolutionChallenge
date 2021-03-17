import 'package:flutter/cupertino.dart';
import 'package:tracking_app/Models/address.dart';

class AppData extends ChangeNotifier {
  String _pickUpLocation="BBSR";
  String get pickUpLocation => _pickUpLocation;
  void updatePickupLocation(String pickUpAddress) {
    _pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}
