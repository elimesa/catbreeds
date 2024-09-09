import 'package:flutter/material.dart';

import 'package:catbreeds/src/ui/home_page.dart';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
  
}