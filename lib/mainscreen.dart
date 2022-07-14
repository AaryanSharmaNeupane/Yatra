import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:geocoder2/geocoder2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yatra/Assistants/assistantMethods.dart';
import 'package:yatra/DataHandler/appData.dart';
import 'package:yatra/Widgets/divider.dart';
import 'package:yatra/maps.dart';
import 'package:yatra/searchScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late GoogleMapController newGoogleMapContrtoller;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

//To locate current position of the user

  late Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        new CameraPosition(target: latLngPosition, zoom: 18);

    newGoogleMapContrtoller
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // GeoData data = await Geocoder2.getDataFromCoordinates(
    //     latitude: 40.714224, longitude: -73.961452, googleMapApiKey: "$mapKey");

    // //Formated Address
    // print(data.address);

    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    print("This is your address: " + address);
  }

  //.............

  static const CameraPosition _kathmandu = CameraPosition(
    target: LatLng(27.700769, 85.300140),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: Container(
        color: Colors.white,
        width: 255.0,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165.0,
                child: DrawerHeader(
                  child: Row(
                    children: [
                      Icon(
                        Icons.supervised_user_circle_outlined,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile Name",
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text("Visit profile"),
                        ],
                      ),
                    ],
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              DividerWidget(),

              SizedBox(
                height: 12.0,
              ),

              //Drawer Body Controllers

              // ListTile(
              //   leading: Icon(Icons.history),
              //   title: Text(
              //     "History",
              //     style: TextStyle(
              //       fontSize: 15.0,
              //     ),
              //   ),
              // ),

              // ListTile(
              //   leading: Icon(Icons.person),
              //   title: Text(
              //     "Visit Profile",
              //     style: TextStyle(
              //       fontSize: 15.0,
              //     ),
              //   ),
              // ),

              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            initialCameraPosition: _kathmandu,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapContrtoller = controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });

              locatePosition();
            },
          ),

          //HamburgerButton for Drawer
          // Positioned(
          //   top: 45.0,
          //   left: 22.0,
          //   child: GestureDetector(
          //     onTap: () {
          //       scaffoldkey.currentState?.openDrawer();
          //     },
          //     child: Container(
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(22.0),
          //         boxShadow: const [
          //           BoxShadow(
          //             color: Colors.black,
          //             blurRadius: 6.0,
          //             spreadRadius: 0.5,
          //             offset: Offset(
          //               0.7,
          //               0.7,
          //             ),
          //           )
          //         ],
          //       ),
          //       child: CircleAvatar(
          //         backgroundColor: Colors.white,
          //         child: Icon(
          //           Icons.menu,
          //           color: Colors.black,
          //         ),
          //         radius: 20.0,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 300.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18.0),
                  topRight: Radius.circular(18.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 16.0,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 18.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 6.0,
                    ),
                    const Text(
                      "Hi there, ",
                      style: TextStyle(fontSize: 12.0),
                    ),
                    const Text(
                      "Where to? ",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text("Search Drop Off"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Provider.of<AppData>(context).pickUpLocation !=
                                    null
                                ? Provider.of<AppData>(context)
                                    .pickUpLocation!
                                    .placeName
                                : "Add Home"),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Your living home address",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    DividerWidget(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.work,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Add Work"),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Your office address",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12.0,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
