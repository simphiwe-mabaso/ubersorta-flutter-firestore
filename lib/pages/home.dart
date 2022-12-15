import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';
import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // for bottom navigation
  int _selectedIndex = 1;

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
                const Text('Find a lift', style: TextStyle(fontSize: 30.0),),
                const SizedBox(
                  height: 40.0,
                ),
                const Icon(Icons.local_taxi_outlined, size: 140.0, color: Colors.lightGreen),
                const SizedBox(
                  height: 70.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      elevation: 16.0,
                      shadowColor: Colors.lightGreen,
                      child: SizedBox(
                        height: 60,
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/view-available-lifts');
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.directions_car_filled_outlined, size: 20.0, color: Colors.purple),
                                SizedBox(width: 4),
                                Text('Available lifts')],
                            ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 16.0,
                      shadowColor: Colors.lightGreen,
                      child: SizedBox(
                        height: 60,
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/search-available-lifts');
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.search, size: 20.0, color: Colors.purple),
                                SizedBox(width: 4),
                                Text('Search')],
                            ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 16.0,
                      shadowColor: Colors.lightGreen,
                      child: SizedBox(
                        height: 60,
                        child: OutlinedButton(
                            onPressed: () {},
                            child: Row(
                              children: const [
                                Icon(Icons.list_alt_outlined, size: 20.0, color: Colors.purple),
                                SizedBox(width: 4),
                                Text('Lift details')],
                            ),
                        ),
                      ),
                    ),
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
