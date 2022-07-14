import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yatra/DataHandler/appData.dart';
import 'package:yatra/mainscreen.dart';

import 'loginscreen.dart';
import 'registrationscreen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Yatra',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainScreen(),
      ),
    );
  }
}
