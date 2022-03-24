// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notebook_app/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
        ),
        shadowColor: Colors.yellowAccent,
      ),
      body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      controller: _email,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          const InputDecoration(hintText: "Enter your Email"),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                          hintText: "Enter your Password"),
                    ),
                    TextButton(
                      onPressed: () async {
                        // final _email = _email.text;
                        // final _password = _password.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _email.text, password: _password.text);
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == "user-not-found") {
                            print("Something Bad Happened");
                            print(e.runtimeType);
                            print(e.code);
                          } else if (e.code == "wrong-password") {
                            print("Your password isn't correct");
                          } else {
                            print(e.code);
                          }
                        }
                      },
                      child: const Text("Login"),
                    ),
                  ],
                );
              default:
                return const Text("Loading.......!");
            }
          }),
    );
  }
}

// class Setup {
//   static void setDb() async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .add({'name': 'ifeanyi'});
//   }
// }
