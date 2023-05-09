// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({
//     Key? key, 
//     required this.title,
//     required this.destinationLatitude,
//     required this.destinationLongitude,
//   }) : super(key: key);

//   final String title;
//   final double destinationLatitude;
//   final double destinationLongitude;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final _mapController = MapController(initMapWithUserPosition: true);

//   var markerMap = <String, String>{};
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _mapController.listenerMapSingleTapping.addListener(() async {
//         //when tap on map, we will add a new marker

//         var position = _mapController.listenerMapSingleTapping.value;

//         if (position != null) {
//           await _mapController.addMarker(position,
//               markerIcon: const MarkerIcon(
//                 icon: Icon(
//                   Icons.pin_drop,
//                   color: Colors.blue,
//                   size: 48,
//                 ),
//               ));

//           //add marker to map, to hold information of marker in case
//           //we want to use it

//           var key = '${position.latitude},${position.longitude}';
//           markerMap[key] = markerMap.length.toString();
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _mapController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text(widget.title),
//       ),
//       body: OSMFlutter(
//         controller: _mapController,
//         mapIsLoading: const Center(
//           child: CircularProgressIndicator(),
//         ),
//         trackMyPosition: true,
//         initZoom: 12,
//         minZoomLevel: 4,
//         maxZoomLevel: 18,
//         stepZoom: 1.0,
//         roadConfiguration: const RoadOption(
//           roadColor: Colors.blueGrey,
//         ),
//         markerOption: MarkerOption(
//           defaultMarker: const MarkerIcon(
//             icon: Icon(
//               Icons.person_pin_circle,
//               color: Colors.black,
//               size: 48,
//             ),
//           ),
//         ),
//         onMapIsReady: (isReady) async {
//           if (isReady) {
//             Future.delayed(const Duration(seconds: 1), () async {
//               GeoPoint geoPoint = await _mapController.myLocation();
//               print("geopoint:$geoPoint==============================");
//               await _mapController.addMarker(geoPoint,
//                   markerIcon: const MarkerIcon(
//                     icon: Icon(
//                       Icons.pin_drop,
//                       color: Colors.blue,
//                       size: 70,
//                     ),
//                   ));
//               RoadInfo roadInfo = await _mapController.drawRoad(
//                 GeoPoint(
//                   latitude: geoPoint.latitude,
//                   longitude: geoPoint.longitude,
//                 ),
//                 GeoPoint(
//                   latitude: widget.destinationLatitude,
//                   longitude: widget.destinationLongitude,
//                 ), //destination
//                 roadType: RoadType.car,
//                 roadOption: const RoadOption(
//                   roadWidth: 15,
//                   roadColor: Colors.blue,
//                   zoomInto: true,
//                 ),
//               );
//             });
//           }
//         },
//         onGeoPointClicked: (geoPoint) {
//           var key = '${geoPoint.latitude},${geoPoint.longitude}';

//           //when user clicks on marker
//           showModalBottomSheet(
//             context: context,
//             builder: (context) {
//               return Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Expanded(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               'Position ${markerMap[key]}',
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue,
//                               ),
//                             ),
//                             const Divider(
//                               thickness: 1,
//                             ),
//                             Text(key),
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: const Icon(Icons.clear),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
