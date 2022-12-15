import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';
import '../main.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({super.key, required this.title});

  final String title;

  @override
  State<MySettingsPage> createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  // for bottom navigation
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        Navigator.of(context).pushReplacementNamed('/offer');
      } else if (_selectedIndex == 1) {
        Navigator.of(context).pushReplacementNamed('/main');
      } else {
        Navigator.of(context).pushReplacementNamed('/settings');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LiftsViewModel>(
        builder: (context, fuelPriceModel, child) {
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/main');
                    },
                    icon: const Icon(Icons.close_outlined)
                ),
                title: Text(widget.title, style: const TextStyle(fontSize: 14.0),),
                actions: [
                  Consumer<ApplicationState>(
                    builder: (context, appState, _) => AuthFunc(
                        loggedIn: appState.loggedIn,
                        signOut: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pushReplacementNamed('/home');
                        }),
                  ),
                ]
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Text('Light Mode VS Dark Mode', style: TextStyle(fontSize: 30.0),),
                  const SizedBox(
                    height: 40.0,
                  ),
                  const Icon(Icons.settings, size: 140.0, color: Colors.lightGreen),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.light_mode),
                      const SizedBox(width: 15.0,),
                      const Text('Light'),
                      const SizedBox(width: 40.0,),
                      Consumer<MyAppState>(
                          builder: (context, myAppState, child) {
                            return Switch(
                              activeColor: Colors.black,
                              value: myAppState.isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  myAppState.isSwitched = value;
                                });
                              },
                            );
                          }),
                      const SizedBox(width: 40.0,),
                      const Text('Dark'),
                      const SizedBox(width: 10.0,),
                      const Icon(Icons.dark_mode),
                    ],
                  ),

                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.local_offer_outlined),
                    label: 'Offer',
                    activeIcon: Icon(Icons.local_offer)
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.screen_search_desktop_outlined),
                    label: 'Search',
                    activeIcon: Icon(Icons.screen_search_desktop)
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                    activeIcon: Icon(Icons.settings)
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blue,
              onTap: _onItemTapped,
            ),
          );
        }
    );
  }
}