import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/form_screen.dart';
import 'screens/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final hasName = prefs.getString('name')?.isNotEmpty ?? false;
  final hasEmail = prefs.getString('email')?.isNotEmpty ?? false;

  runApp(MyApp(showHome: hasName && hasEmail));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({super.key, required this.showHome});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Похудение AI',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: showHome ? const HomeScreen() : const FormScreen(),
    );
  }
}

