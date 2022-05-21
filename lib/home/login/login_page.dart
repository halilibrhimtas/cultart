import 'package:cultart/home/login/google_sign_in.dart';
import 'package:cultart/home/login/signIn_page.dart';
import 'package:cultart/home/login/signUp_page.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInPage()),
                );
              },
              child: const Text("GİRİŞ"),
              style: ElevatedButton.styleFrom(
                primary: Colors.black38,
                fixedSize: const Size(150,75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              )
            ),
            const Padding(padding: EdgeInsets.all(8)),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpPage()),
                  );
                },
                child: const Text("KAYIT OL"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black38,
                  fixedSize: const Size(150,75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                  )
                )
            ),
            ElevatedButton(onPressed: () async {
              await signInWithGoogle().then((value) => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomePage())));
            },
                child: const Text("Sign in with Google")),
            const SizedBox(height: 50),
            TextButton(
                onPressed: (){},
                child: const Text("Giriş yapmadan devam edin",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black38
                ),
                ),
            ),
          ],
        ),
      ),
    ) ;
  }
}
