// import 'package:flutter/material.dart';
// import 'package:food_course/scr/providers/app.dart';
// import 'package:food_course/scr/providers/category.dart';
// import 'package:food_course/scr/providers/product.dart';
// import 'package:food_course/scr/providers/restaurant.dart';
// import 'package:food_course/scr/providers/user.dart';
// import 'package:food_course/scr/screens/home.dart';
// import 'package:food_course/scr/screens/login.dart';
// import 'package:food_course/scr/screens/splash.dart';
// import 'package:food_course/scr/widgets/loading.dart';
// import 'package:provider/provider.dart';
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(value: AppProvider()),
//         ChangeNotifierProvider.value(value: UserProvider.initialize()),
//         ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
//         ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
//         ChangeNotifierProvider.value(value: ProductProvider.initialize()),
//       ],
//       child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Food App',
//           theme: ThemeData(
//             primarySwatch: Colors.red,
//           ),
//           home: ScreensController())));
// }
//
// class ScreensController extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<UserProvider>(context);
//     switch (auth.status) {
//       case Status.Uninitialized:
//         return Splash();
//       case Status.Unauthenticated:
//       case Status.Authenticating:
//         return LoginScreen();
//       case Status.Authenticated:
//         return Home();
//       default:
//         return LoginScreen();
//     }
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:food_course/color.dart';
import 'package:food_course/test.dart';

Future<List> fetchDirect() async {
  // print(await http.read('https://apis.wemap.asia/route-api/route?point=21.052403%2C105.78362&point=20.982317%2C105.863335&type=json&locale=en-US&vehicle=car&weighting=fastest&elevation=false&key=GqfwrZUEfxbwbnQUhtBMFivEysYIxelQ'));

  final response =
  // await http.get(Uri.https('apis.wemap.asia/route-api/route?point=21.052403%2C105.78362&point=20.982317%2C105.863335&type=json&locale=en-US&vehicle=car&weighting=fastest&elevation=false&key=GqfwrZUEfxbwbnQUhtBMFivEysYIxelQ','/'));
  await http.read('https://apis.wemap.asia/route-api/route?point=21.052403%2C105.78362&point=20.982317%2C105.863335&type=json&locale=en-US&vehicle=car&weighting=fastest&elevation=false&key=GqfwrZUEfxbwbnQUhtBMFivEysYIxelQ');
  // if (response) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
  print(jsonDecode(response)['paths'][0]['instructions'][0]);
  // print(Direct.fromJson(jsonDecode(response)['paths'][0]['instructions'][0]));
  var lst = new List();
  for( var i = 0 ; i < jsonDecode(response)['paths'][0]['instructions']; i++ ) {
    lst.add( Direct.fromJson(jsonDecode(response)['paths'][0]['instructions'][i]));
  }
  return lst;
  // } else {
  //   // If the server did not return a 200 OK response,
  //   // then throw an exception.
  //   throw Exception('Failed to load album');
  // }
}

class Direct {
  final double distinct;
  final String text;
  final int time;
  final String streetName;
  Direct({
      this.distinct,
      this.text,
      this.time,
      this.streetName
  });

  factory Direct.fromJson(Map<String, dynamic> json) {
    return Direct(
      distinct: json['distinct'],
      text: json['text'],
      time: json['time'],
      streetName: json['street_name']
    );
  }
}

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primary
      ),
      home: IndexPage(),
    )
);

class MyApp extends StatefulWidget {
  // MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Future<List> futureDirect;

  @override
  void initState() {
    super.initState();
    futureDirect = fetchDirect();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),

      ),
    );
  }
}
