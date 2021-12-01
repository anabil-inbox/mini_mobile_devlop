// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_place/google_place.dart';
// import 'package:inbox_clients/util/font_dimne.dart';


// class Body extends StatefulWidget {
//   int type;
//   MyLocation myLocation;
//   Function refresh;

//   Body({this.type, this.myLocation, this.refresh});

//   static LatLng center = LatLng(0.0, 0.0);

//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   double latitude = 42.394284;
//   double longitude = -82.206062;
//   bool IsDefult = false;
//   bool select_Loction = false;
//   List<Marker> markers = []; //collection
//   Completer<GoogleMapController> _controller = Completer();

//   //GoogleMapController controller;
//   final initVal = CameraPosition(
//     target: LatLng(42.1626543, -82.475222),
//     zoom: 14.4746,
//   );
//   Position currentLocation;
//   GlobalKey<FormState> fromKey;
//   TextEditingController _searchQuery = TextEditingController();
//   BitmapDescriptor customIcon;
//   int state = 1;
//   TextEditingController _textEditingControllerTitle;
//   TextEditingController _textEditingControllerDetails;
//   GooglePlace googlePlace;
//   List<AutocompletePrediction> predictions = [];
//   double zoom = 14.4746;
//   AutocompletePrediction SelectAutocompletePrediction = null;
//   final AddressControllerx = Get.put(AddressController());
//   final CheckPermtionControllerx = Get.put(CheckPermtionController());
//   String addressFromLocation = "";

//   @override
//   initState() {
//     fromKey = GlobalKey<FormState>();

//     _textEditingControllerTitle = TextEditingController();
//     _textEditingControllerDetails = TextEditingController();
//     if (widget.type == 2) {
//       _textEditingControllerTitle.text = widget.myLocation.addressTitle;
//       _textEditingControllerDetails.text = widget.myLocation.addressLine1;
//       latitude = widget.myLocation.addressLat;
//       longitude = widget.myLocation.addressLong;
//       IsDefult = widget.myLocation.isDefault;
//       addressFromLocation = widget.myLocation?.addressLine1;
//       _goToTheLake();
//       createCurrentMarker(LatLng(latitude, longitude), addressFromLocation);
//       select_Loction = true;
//     } else {
//       getUserLocation();
//     }
//     _searchQuery = TextEditingController();

//     //String apiKey = DotEnv.env[kGoogleApiKey];
//     googlePlace = GooglePlace(kGoogleApiKey);
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _searchQuery.dispose();
//     _textEditingControllerDetails.dispose();
//     _textEditingControllerDetails.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("Body.center");
//     print(Body.center);
//     return Container(
//       // padding: EdgeInsets.all(10),
//       alignment: Alignment.topCenter,
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Container(
//                         margin: EdgeInsets.only(top: 90),
//                         height: SizeConfig.screenHeight * 0.5,
//                         child: Stack(
//                           children: [
//                             GoogleMap(
//                               zoomControlsEnabled: false,
//                               mapType: MapType.normal,
//                               mapToolbarEnabled: false,
//                               myLocationEnabled: false,
//                               zoomGesturesEnabled: true,
//                               scrollGesturesEnabled: true,
//                               rotateGesturesEnabled: false,
//                               compassEnabled: false,
//                               myLocationButtonEnabled: false,
//                               gestureRecognizers: Set()
//                                 ..add(Factory<PanGestureRecognizer>(
//                                     () => PanGestureRecognizer()))
//                                 ..add(
//                                   Factory<VerticalDragGestureRecognizer>(
//                                       () => VerticalDragGestureRecognizer()),
//                                 )
//                                 ..add(
//                                   Factory<HorizontalDragGestureRecognizer>(
//                                       () => HorizontalDragGestureRecognizer()),
//                                 )
//                                 ..add(
//                                   Factory<ScaleGestureRecognizer>(
//                                       () => ScaleGestureRecognizer()),
//                                 ),
//                               initialCameraPosition: initVal,
//                               onCameraMove: (position) {
//                                 latitude = position.target.latitude;
//                                 longitude = position.target.longitude;
//                                 print(longitude);

//                                 print(position.zoom);
//                               },
//                               onCameraIdle: () {
//                                 print("longituddsdsdsdde $longitude");
//                                 print("latitudedsdsdsdde $latitude");
//                                 addressFromLocation = "";

//                                 getDetailsLocation(LatLng(latitude, longitude))
//                                     .then((values) {
//                                   addressFromLocation = "";
//                                   addressFromLocation = values;
//                                   print(
//                                       "ddddddddddddddsssss $addressFromLocation");

//                                   _textEditingControllerDetails.text =
//                                       addressFromLocation;
//                                   setState(() {});
//                                 });
//                               },
//                               onTap: (position) {
//                                 markers.clear();
//                                 _searchQuery.clear();
//                                 addressFromLocation = "";
//                                 getDetailsLocation(position).then((values) {
//                                   addressFromLocation = "";
//                                   addressFromLocation = values;
//                                   _textEditingControllerDetails.text =
//                                       addressFromLocation;
//                                   setState(() {});
//                                 });

//                                 CheckMarker(position);
//                               },
//                               onMapCreated: (GoogleMapController controller) {
//                                 _controller.complete(controller);
//                                 //this.controller = controller;

//                                 setState(() {});
//                               },
//                               markers: Set.from(markers),
//                             ),
//                             Align(
//                                 alignment: Alignment.center,
//                                 child: SvgPicture.asset(
//                                   'assets/icons/svg_marker.svg',
//                                   height: 30,
//                                   width: 20,
//                                   fit: BoxFit.fill,
//                                 )),

//                             Obx(() {
//                               return Positioned.directional(
//                                   bottom: 20,
//                                   textDirection: Directionality.of(context),
//                                   end: 20,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       _searchQuery.clear();
//                                       markers.clear();
//                                       setState(() {
//                                         zoom = 14.4746;
//                                       });
//                                       getUserLocation();
//                                     },
//                                     child: SvgPicture.asset(
//                                       (CheckPermtionControllerx
//                                               .isEnableLoction.value)
//                                           ? "assets/icons/enable_location.svg"
//                                           : "assets/images/disable_gps.svg",
//                                       height: getProportionateScreenWidth(35),
//                                       width: getProportionateScreenWidth(35),
//                                     ),
//                                   ));
//                             }),
//                             //Positioned( bottom: 0 , top: 0 , right: 0 , left: 0,child: Icon(Icons.check_circle_rounded , color: kColorButtom,)),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(30),
//                         child: Column(
//                           children: [
//                             (widget.type == 1)
//                                 ? Item_Header(
//                                     header: kAdd,
//                                     subHeader: kLocation,
//                                     iconsvg: 'assets/icons/add_place.svg',
//                                   )
//                                 : Item_Header(
//                                     header: kEdit,
//                                     subHeader: kLocation,
//                                     iconsvg: 'assets/icons/edit_place.svg',
//                                   ),
//                             Form(
//                               key: fromKey,
//                               child: Column(
//                                 children: [
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   BildeTextTitle(),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   BildeTextDesc(),
//                                 ],
//                               ),
//                             ),
//                             /*              BildeTextTitle(),
//                               SizedBox(height: 10,),
//                               BildeTextDesc(),*/
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Before_Footer(
//                               select: IsDefult,
//                               press: () {
//                                 if (IsDefult) {
//                                   IsDefult = false;
//                                 } else {
//                                   IsDefult = true;
//                                 }
//                                 setState(() {});
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
//                 child: Footer(
//                   status: state,
//                   select: select_Loction,
//                   pressCancel: () {
//                     Get.back();
//                   },
//                   pressSave: () {
//                     if (select_Loction) {
//                       if (state == 1) {
//                         if (fromKey.currentState.validate()) {
//                           {
//                             AddAndEditAddresses();
//                           }
//                         } else {
//                           print("ffffff");
//                         }
//                       }
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               Container(
//                 color: Colors.white,
//                 padding: const EdgeInsets.only(top: 20, bottom: 10),
//                 child: barMap(),
//               ),
//               SizedBox(
//                 height: 2,
//               ),
//               Expanded(
//                 child: (predictions.length == 0 || _searchQuery.text.isEmpty)
//                     ? SizedBox()
//                     : SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 30),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               color: Colors.white,
//                             ),
//                             margin: EdgeInsets.only(
//                                 left: 20, right: 20, top: 0, bottom: 10),
//                             child: ListView.builder(
//                               itemCount: predictions.length,
//                               padding: EdgeInsets.only(top: 10, bottom: 10),
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 print(predictions.length);
//                                 return GestureDetector(
//                                   onTap: () {
//                                     markers.clear();
//                                     SelectAutocompletePrediction =
//                                         predictions[index];
//                                     _textEditingControllerDetails.text =
//                                         predictions[index].description ??
//                                             addressFromLocation;
//                                     getDetailsPlace(
//                                         predictions[index].description,
//                                         SelectAutocompletePrediction.placeId);
//                                     ClearListSearch();
//                                   },
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 10, right: 10),
//                                         child: Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 predictions[index].description,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: TextStyle(fontSize: 11),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Divider(),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   CameraPosition _kGooglePlex(double lat, double long) {
//     CameraPosition _kGooglePlex = CameraPosition(
//       target: LatLng(lat, long),
//       zoom: zoom,
//     );
//     return _kGooglePlex;
//   }

//   Widget BildeTextTitle() {
//     return Iteam_EditeText_Address(
//       hintText: kLocationName,
//       lable: kLocationName,
//       controller: _textEditingControllerTitle,
//       iconsvg: 'assets/icons/location_home.svg',
//       validator: (value) {
//         if (value.trim().isEmpty) {
//           return "Add location title";
//         }
//         return null;
//       },
//     );
//   }

//   /*
// */
//   void autoCompleteSearch(String value) async {
//     var result = await googlePlace.queryAutocomplete.get(value);
//     if (result != null && result.predictions != null && mounted) {
//       setState(() {
//         print("predictions ${predictions.length}");
//         predictions = result.predictions;
//       });
//     } else {
//       setState(() {
//         predictions = [];
//       });
//     }
//   }

//   ClearListSearch() {
//     setState(() {
//       select_Loction = true;
//       _searchQuery.text = SelectAutocompletePrediction.description;
//       predictions = [];
//     });
//   }

//   CheckMarker(LatLng point) {
//     markers.clear();
//     // selectAddress = -1;
//     createCurrentMarker(point, addressFromLocation);
//     setState(() {});
//   }

//   // Widget BildeTextDesc() {
//   //   return Iteam_EditeText_Address(
//   //     hintText: kAddress,
//   //     lable: kAddress,
//   //     controller: _textEditingControllerDetails,
//   //     iconsvg: 'assets/icons/locatiom_marker.svg',
//   //     validator: (value) {
//   //       if (value.trim().isEmpty) {
//   //         return "Add Location description";
//   //       }
//   //       return null;
//   //     },
//   //   );
//   // }

//   // Future<void> getLoacation() async {
//   //   Geolocator.getCurrentPosition().then((value) {
//   //     Position mPosition = value;
//   //     print("lat");
//   //     print(mPosition.latitude);
//   //     print(mPosition.longitude);
//   //   });
//   // }

//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
//         !.buffer
//         .asUint8List();
//   }

//   void createCurrentMarker(LatLng point, String title) async {
//     _searchQuery.clear();
//     markers.clear();
//     final Uint8List markerIcon =
//         await getBytesFromAsset('assets/icons/marker_cutome.png', 60);

//     latitude = point.latitude;
//     longitude = point.longitude;

//     getDetailsLocation(point).then((values) {
//       addressFromLocation = "";
//       addressFromLocation = values;
//       _textEditingControllerDetails.text = addressFromLocation;
//       print("aa$values");
//       setState(() {});
//     });
//     setState(() {
//       select_Loction = true;
//     });

//     /* markers.add(Marker(
//       markerId: MarkerId('${latitude - longitude}'),
//       position: point,
//       infoWindow: title.toString().isNotEmpty ? InfoWindow(
//         title: title.toString()
//       ):InfoWindow(
//         title: addressFromLocation .length==0
//             ? "unknown address"
//             : "${addressFromLocation}",
//         //snippet: "${addressFromLocation}"
//       ),

//       icon: BitmapDescriptor.fromBytes(markerIcon),
//     ));*/
//     zoom = 14.4746;
//     _textEditingControllerDetails.text = title ?? addressFromLocation;
//     setState(() {});
//   }

//   getDetailsPlace(String PlaceName, String PlaceId) async {
//     googlePlace.details.get(PlaceId).then((value) {
//       DetailsResponse detailsResponse = value!;
//       latitude = detailsResponse.result!.geometry!.location!.lat!;
//       longitude = detailsResponse.result!.geometry!.location!.lng!;
//       addressFromLocation = PlaceName;
//       createCurrentMarker(LatLng(latitude, longitude), PlaceName);
//       _goToTheLake();
//     });
//   }

//   Future<Position> locateUser() async {
//     return Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.bestForNavigation);
//   }

//   Future<String> getDetailsLocation(LatLng position) async {
//     print("// get address:$addressFromLocation");
//     if (addressFromLocation.length > 0) return addressFromLocation;
//     List<add.Address> addresses = [];

//     try {
//       final coordinates = new Coordinates(
//           position.latitude,
//           position
//               .longitude); // Here 1 represent max location result to returned, by documents it recommended 1 to 5
//       addresses =
//           await Geocoder.local.findAddressesFromCoordinates(coordinates);
//       if (addresses == null || addresses.isEmpty) {
//         addressFromLocation = "unknown address";
//         setState(() {});
//         return "unknown address";
//       }
//       if (addresses[0] == null) {
//         addressFromLocation = "unknown address";
//         setState(() {});
//         return "unknown address";
//       }
//       String address = addresses[0]
//           .addressLine; // If any additional address line present than only, check with max available address lines by getMaxAddressLineIndex()
//       String city = addresses[0].locality;
//       String state = addresses[0].adminArea;
//       String country = addresses[0].countryName;
//       String postalCode = addresses[0].postalCode;
//       String knownName =
//           addresses[0].featureName; // Only if available else return NULL
//       if (address != null) {
//         addressFromLocation = address;
//         setState(() {});
//         return address;
//       }
//       if (city != null) {
//         addressFromLocation = city;
//         setState(() {});
//         return city;
//       }
//       if (state != null) {
//         addressFromLocation = state;
//         setState(() {});
//         return state;
//       }
//       if (country != null) {
//         addressFromLocation = country;
//         setState(() {});
//         return country;
//       }
//       setState(() {});
//       addressFromLocation = "unknown address";
//       return "unknown address";
//     } catch (e) {
//       addressFromLocation = "unknown address";
//       setState(() {});
//       return "unknown address";
//     } finally {
//       setState(() {});
//     }
//   }

//   getUserLocation() async {
//     markers.clear();
//     determinePosition().then((value) {
//       if (value == null) {
//         CheckPermtionControllerx.ChangePermation(false);
//         latitude = 42.1626543;
//         longitude = -82.475222;
//         _goToTheLake();
//         LatLng point = LatLng(latitude, longitude);
//         addressFromLocation = "";
//         getDetailsLocation(point).then((values) {
//           addressFromLocation = "";
//           addressFromLocation = values;
//           print("addressFromLocation $values");
//           _textEditingControllerDetails.text = addressFromLocation;
//           setState(() {});
//         });
//         createCurrentMarker(LatLng(latitude, longitude), addressFromLocation);
//       } else {
//         CheckPermtionControllerx.ChangePermation(true);

//         currentLocation = value;
//         latitude = currentLocation.latitude;
//         longitude = currentLocation.longitude;
//         LatLng point = LatLng(latitude, longitude);
//         addressFromLocation = "";
//         getDetailsLocation(point).then((values) {
//           addressFromLocation = "";
//           addressFromLocation = values;
//           _textEditingControllerDetails.text = addressFromLocation;
//           print("//addressFromLocation:$values");
//           setState(() {});
//         });
//         _goToTheLake();
//         createCurrentMarker(LatLng(latitude, longitude), addressFromLocation);
//         //_handleTap(point);
//         print('center ${Body.center}');
//         print('//center ${addressFromLocation}');
//       }
//     });
//   }

//   Future<void> _goToTheLake() async {
//     final GoogleMapController controller = await _controller.future;
//     controller.animateCamera(
//         CameraUpdate.newCameraPosition(_kGooglePlex(latitude, longitude)));
//     setState(() {});
//   }

//   Widget barMap() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(child: FiledSearch()),
//         ],
//       ),
//     );
//   }

//   Widget FiledSearch() {
//     return TextField(
//       maxLines: 1,
//       minLines: 1,
//       cursorColor: Colors.black,
//       style: TextStyle(
//           color: Colors.black, fontSize: fontSize15),
//       controller: _searchQuery,
//       textInputAction: TextInputAction.search,
//       onChanged: (value) {
//         print(value);
//         if (value.isNotEmpty) {
//           print("value $value");
//           autoCompleteSearch(value);
//         } else {
//           setState(() {
//             predictions = [];
//           });
//         }
//       },
//       decoration: InputDecoration(
//         hintText: kSearchOffPlace.tr,
//         filled: true,
//         fillColor: kSearchFiledColor,

//         prefixIconConstraints: BoxConstraints(minWidth: 23, maxHeight: 20),
//         prefixIcon: Padding(
//           padding: const EdgeInsets.only(right: 10, left: 10),
//           child: SvgPicture.asset("assets/images/large_search_icon.svg"),
//         ),
//         suffixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 35),
//         suffixIcon: GestureDetector(
//           onTap: () {
//             _searchQuery.clear();
//             setState(() {});
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(right: 10, left: 10),
//             child: Icon(
//               Icons.close,
//               color: _searchQuery.text.isEmpty
//                   ? Colors.transparent
//                   : /*kUnSelectTabColor*/ Colors.transparent,
//             ),
//           ),
//         ),
//         isDense: true,
//         contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         //  prefixIcon: new Icon(Icons.search,color: Colors.white),
//         border: InputBorder.none,
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(5)),
//             borderSide: BorderSide(color: Colors.white, width: 0.5)),

//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(5)),
//             borderSide: BorderSide(color: Colors.white, width: 0.5)),

//         hintStyle: TextStyle(
//           color: kUnSelectTabColor,
//           fontSize: fontSize15,
//           fontFamily: Font_poppins_regular,
//         ),
//       ),
//       textAlign: TextAlign.start,
//     );
//   }

//   void AddAndEditAddresses() {
//     hideKeyBord();
//     setState(() {
//       state = 2;
//     });
//     var bodyData;
//     if (widget.type == 1) {
//       bodyData = {
//         "address1": _textEditingControllerDetails.text,
//         "address2": "${_textEditingControllerDetails.text}",
//         "title": _textEditingControllerTitle.text,
//         "isDefault": "$IsDefult",
//         "lat": latitude,
//         "lng": longitude,
//       };
//     } else {
//       bodyData = {
//         "addressId": widget.myLocation.addressId,
//         "address1": _textEditingControllerDetails.text,
//         "address2": "${_textEditingControllerDetails.text}",
//         "title": _textEditingControllerTitle.text,
//         "isDefault": "$IsDefult",
//         "lat": latitude,
//         "lng": longitude,
//       };
//     }

//     DataClientApi.getInstance()
//         .EditeAndAddAddresse(bodyData, widget.type)
//         .then((value) {
//       ResultRespone result = value;
//       print(result.status);
//       if (result.status) {
//         DataClientApi.getInstance().getMyAddress().then((value) {
//           setState(() {
//             state = 1;
//             widget.refresh();
//             Get.back();
//             AddressControllerx.GetAddress();
//             snackSuccess(kSuccess.tr, result.message);
//           });
//         });
//       } else {
//         snackError(kErorr.tr, result.message);
//         setState(() {
//           state = 1;
//         });
//       }
//     });
//   }
// }
