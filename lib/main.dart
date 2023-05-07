import 'package:flutter/material.dart';
import 'package:todo_app_flutter/screens/addItem/add_item_view.dart';
import 'package:todo_app_flutter/screens/home/home_view.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    //fontFamily: GoogleFonts.roboto().fontFamily,
      useMaterial3: true,
      brightness: Brightness.dark,
      iconTheme: const IconThemeData(color: Colors.black26)
  ),
    initialRoute: '/',
  routes: {
    '/': (context) => const HomePage(),
    '/addItem': (context) => const AddItemPage()
  },
));

