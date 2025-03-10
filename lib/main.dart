import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_validation_task/firebase_options.dart';
import 'package:firebase_validation_task/screens/home_page.dart';
import 'package:firebase_validation_task/screens/login_page.dart';
import 'package:firebase_validation_task/screens/signup_page.dart';
import 'package:flutter/cupertino.dart' as WidgetFlutterBinding;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  bool isLoggedIn = await checkLoginState();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

Future<bool> checkLoginState() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}

class MyApp extends WidgetFlutterBinding.StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key,required this.isLoggedIn});

  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLoggedIn ? HomePage():LogInPage()
    );
  }
}
