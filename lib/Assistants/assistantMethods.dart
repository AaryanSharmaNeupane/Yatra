import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:yatra/Assistants/requestAssistant.dart';
import 'package:yatra/DataHandler/appData.dart';
import 'package:yatra/Models/address.dart';
import 'package:yatra/maps.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    var response = await RequestAssistant.getRequest(Uri.parse(url));

    if (response != "failed") {
      // placeAddress = response["results"][0]["formatted_address"];

      st1 = response["results"][1]["address_components"][0]["long_name"];
      st2 = response["results"][0]["address_components"][1]["long_name"];
      //st3 = response["results"][0]["address_components"][5]["long_name"];
      st3 = response["results"][0]["address_components"][2]["long_name"];
      placeAddress = st1 + ", " + st2 + ", " + st3;
      // + ", " + ", " + st4

      // latitude: position.latitude,
      // longitude: position.longitude,
      // placeFormattedAddress: '',
      // placeId: '',
      // placeName: '',
      Address userPickUpAddress = Address();
      userPickUpAddress.longitude = position.longitude;
      userPickUpAddress.latitude = position.latitude;
      userPickUpAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickUpAddress);
    }

    return placeAddress;
  }
}
