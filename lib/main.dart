import 'package:errunds_application/helpers/firebase.dart';
import 'package:errunds_application/helpers/navigation_provider.dart';
import 'package:errunds_application/models/customer_Models/home_item.dart';
import 'package:errunds_application/screens/customer/service_screen.dart';
import 'package:errunds_application/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      child: const MyApp(),
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider<HomeItem>(
          create: (_) => HomeItem(),
        ),
      ],
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    firebase.initFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomSplasScreen(),
      routes: {
        "/service_screen": (context) => const ServiceScreen(
              title: "Parcel delivery",
            )
      },
    );
  }
}
