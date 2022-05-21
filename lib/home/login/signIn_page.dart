import 'package:cultart/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: "Email",
              filled: true,
              fillColor: Colors.white70,
            ),

          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              icon: const Icon(Icons.lock, color: Colors.purple),
              filled: true,
              hintText: "Şifrenizi giriniz",
              fillColor: Colors.black38,
              contentPadding: const EdgeInsets.only(
                  left: 14.0, bottom: 8.0, top: 8.0),
              focusedBorder: OutlineInputBorder(
                borderSide:  const BorderSide(color: Colors.black38),
                borderRadius:  BorderRadius.circular(25.7),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:  const BorderSide(color: Colors.black38),
                borderRadius:  BorderRadius.circular(25.7),
              ),
            ),

          ),
          ElevatedButton(
              onPressed: (){
                try{
                  signIn(emailController.text.trim(),
                          passwordController.text.trim())
                      .then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage())));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(e.toString())
                    ),
                  );
                }
              },
              child: const Text("Sign In"))
        ],
      ),
    );
  }
  Future<void> signIn (String email, String password) async {
    await auth.signInWithEmailAndPassword(
      email: email ,
      password: password,);
  }
}
