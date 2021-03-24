import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:tracking_app/Assistants/requestAssistant.dart';
import 'package:tracking_app/DataHandle/appData.dart';
import 'package:tracking_app/Models/address.dart';
import 'package:tracking_app/configMap.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(Position position, context) async {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng="+(position.latitude).toString()+","+(position.longitude).toString()+"&key="+mapKey;
    var response = await RequestAssitant.getRequest(url);
    if (response != "failed") {
      // placeAddress = response["results"][0]["formatted_address"];
      st1 = response["results"][0]["address_components"][3]["long_name"];
      st2 = response["results"][0]["address_components"][4]["long_name"];
      st3 = response["results"][0]["address_components"][5]["long_name"];
      st4 = response["results"][0]["address_components"][6]["long_name"];
      placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;
      Address userPickupAddress = new Address();
      userPickupAddress.longitutde = position.longitude;
      userPickupAddress.latitude = position.latitude;
      userPickupAddress.placeName = placeAddress;
      // Provider.of<AppData>(context, listen: false)
      //      .updatePickupLocation(userPickupAddress);
      
    }
    return placeAddress;
  }
}
