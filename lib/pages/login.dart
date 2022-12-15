import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';
import '../main.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPage();
}

class _MyLoginPage extends State<MyLoginPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login/Sign-Up', style: TextStyle(fontSize: 14.0),),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // const Image(image: AssetImage('assets/logos/cb18765a6a854e14b4356f201001c59c.png')),
                  const SizedBox(height: 40.0),
                  const Icon(Icons.directions_outlined, size: 140.0, color: Colors.purple),
                  const SizedBox(height: 10.0),
                  const Text('UberSorta', style: TextStyle(fontSize: 40.0),),
                  const Text('PHYSICAL MEETS DIGITAL', style: TextStyle(fontSize: 10.0),),
                  const SizedBox(height: 100.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightGreen
                            )
                        )
                    ),
                    Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightGreen
                            )
                        )
                    ),
                    Card(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                        ),
                        child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightGreen
                            )
                        )
                    ),
                  ]),
                  const SizedBox(height: 5.0),
                  Consumer<ApplicationState>(
                    builder: (context, appState, _) => AuthFunc(
                        loggedIn: appState.loggedIn,
                        signOut: () {
                          FirebaseAuth.instance.signOut();
                        }),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
