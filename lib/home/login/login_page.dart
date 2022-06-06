import 'package:cultart/home/login/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF606670),
              Colors.white
            ]
          )
        ),
        child: Card(
          margin: const EdgeInsets.only(top: 150, bottom: 200, left: 30, right: 30),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png", scale: 5,),
                const Padding(padding: EdgeInsets.all(8)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF606670),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fixedSize: const Size(200, 50)
                  ),
                    onPressed: () async {

                  await signInWithGoogle().then((value) async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("email", "useremail");
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));

                  });
                },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/google.png", scale: 30,),
                        const Padding(padding: EdgeInsets.only(right: 8)),
                        const Text("Sign in with Google", ),
                      ],
                    )),
                const SizedBox(height: 50),

              ],
            ),
          ),
        ),
      ),
    ) ;
  }
}
