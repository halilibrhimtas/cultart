import 'package:cultart/home/login_page.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      backgroundColor: Colors.black38,
      seconds: 6,
      navigateAfterSeconds: const LoginPage(),
      title: const Text("CULTART",
        textScaleFactor: 2,
      style: TextStyle(
        color: Colors.white
      ),),
      image: Image.asset("assets/logo.png"),
      photoSize: 110,
      loaderColor: Colors.white,
    );
  }
}
