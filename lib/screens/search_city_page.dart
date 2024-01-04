// import 'package:flutter/material.dart';
// // import 'package:google_places_flutter/city_search.dart';
// // import 'package:google_places_flutter/place_service.dart';
// import 'package:weatherapp_starter_project/models/add_city_model.dart';
// import 'package:weatherapp_starter_project/models/place_service.dart';
// import 'package:uuid/uuid.dart';
// import 'package:weatherapp_starter_project/models/add_city_model.dart';
// import 'package:weatherapp_starter_project/models/place_service.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Add City',
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const SearchCityPage(title: 'Add City'),
//     );
//   }
// }

// class SearchCityPage extends StatefulWidget {
//   const SearchCityPage({super.key, required this.title});

//   final String title;

//   @override
//   _SearchCityPageState createState() => _SearchCityPageState();
// }

// class _SearchCityPageState extends State<SearchCityPage> {
//   final _controller = TextEditingController();
//   String _streetNumber = '';
//   String _street = '';
//   String _city = '';
//   String _zipCode = '';

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Container(
//         margin: const EdgeInsets.only(left: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             TextField(
//               controller: _controller,
//               readOnly: true,
//               onTap: () async {
//                 // generate a new token here
//                 final sessionToken = const Uuid().v4();
//                 final Suggestion? result = await showSearch(
//                   context: context,
//                   delegate: CitySearch(sessionToken),
//                 );
//                 // This will change the text displayed in the TextField
//                 if (result != null) {
//                   final placeDetails = await PlaceApiProvider(sessionToken)
//                       .getPlaceDetailFromId(result.placeId);
//                   setState(() {
//                     _controller.text = result.description;
//                     _streetNumber = placeDetails.streetNumber!;
//                     _street = placeDetails.street!;
//                     _city = placeDetails.city!;
//                     _zipCode = placeDetails.zipCode!;
//                   });
//                 }
//               },
//               decoration: const InputDecoration(
//                 icon: SizedBox(
//                   width: 10,
//                   height: 10,
//                   child: Icon(
//                     Icons.home,
//                     color: Colors.black,
//                   ),
//                 ),
//                 hintText: "Enter your city address",
//                 border: InputBorder.none,
//                 contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             Text('Street Number: $_streetNumber'),
//             Text('Street: $_street'),
//             Text('City: $_city'),
//             Text('ZIP Code: $_zipCode'),
//           ],
//         ),
//       ),
//     );
//   }
// }
