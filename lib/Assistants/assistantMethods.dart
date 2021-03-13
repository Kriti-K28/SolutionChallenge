import 'package:geolocator/geolocator.dart';
import 'package:tracking_app/Assistants/requestAssistant.dart';
import 'package:tracking_app/configMap.dart';

class AssistantMethods {
  Future<String> searchCoordinateAddress(Position position) async {
    String placeAddress = "";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestAssitant.getRequest(url);
    if (response != "failed") {
      placeAddress = response["results"][0]["formatted_address"];
    }
    return placeAddress;
  }
}
