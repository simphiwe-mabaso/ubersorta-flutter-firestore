import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';
import '../main.dart';
import '../model/lift.dart';

class ViewAvailableLiftsPage extends StatefulWidget {
  const ViewAvailableLiftsPage({super.key, required this.title});

  final String title;

  @override
  State<ViewAvailableLiftsPage> createState() => _ViewAvailableLiftsPageState();
}

class _ViewAvailableLiftsPageState extends State<ViewAvailableLiftsPage> {
  bool isVisible = false;

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
    List<Lift> availableLiftsList =
        Provider.of<ApplicationState>(context, listen: true).getAvailableSeatsList;
    return Consumer<LiftsViewModel>(builder: (context, fuelPriceModel, child) {
      return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/main');
                },
                icon: const Icon(Icons.navigate_before)),
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
            ]),
        body: ListView.builder(
          itemCount: availableLiftsList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: Text(availableLiftsList.elementAt(index).destinationTown!),
                  ),
                  if (isVisible)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 10.0),
                        Text('Date & Time: ${availableLiftsList.elementAt(index).departureDateTime}'),
                        const SizedBox(height: 8.0),
                        Text('Seats: ${availableLiftsList.elementAt(index).availableSeats}'),
                        const SizedBox(height: 8.0),
                        Text('Email: ${availableLiftsList.elementAt(index).name}@ubersorta.com'),
                        const SizedBox(height: 8.0),
                        Consumer<ApplicationState>(builder: (context, appState, _) {
                          return ElevatedButton(onPressed: () async {
                            await appState.bookLifts(
                            availableLiftsList.elementAt(index).departureDateTime,
                            availableLiftsList.elementAt(index).departureTown!,
                            availableLiftsList.elementAt(index).departureStreet!,
                            availableLiftsList.elementAt(index).destinationTown!,
                            availableLiftsList.elementAt(index).destinationStreet!,
                            availableLiftsList.elementAt(index).numberPassengers!,
                            availableLiftsList.elementAt(index).costShareDescription!,
                            (int.parse(availableLiftsList.elementAt(index).availableSeats!) - 1).toString());

                            CollectionReference collection = FirebaseFirestore.instance.collection('liftsbook');
                            DocumentReference document = collection.doc(availableLiftsList.elementAt(index).id);
                            await document.update({
                              'departureDateTime': availableLiftsList.elementAt(index).departureDateTime,
                              'departureTown': availableLiftsList.elementAt(index).departureTown!,
                              'departureStreet': availableLiftsList.elementAt(index).departureStreet!,
                              'destinationTown': availableLiftsList.elementAt(index).destinationTown!,
                              'destinationStreet': availableLiftsList.elementAt(index).destinationStreet!,
                              'numberOfPassengers': availableLiftsList.elementAt(index).numberPassengers!,
                              'costShareDescription': availableLiftsList.elementAt(index).costShareDescription!,
                              'availableSeats': (int.parse(availableLiftsList.elementAt(index).availableSeats!) - 1).toString(),
                              'name': FirebaseAuth.instance.currentUser!
                                  .displayName,
                              'timestamp': DateTime
                                  .now()
                                  .millisecondsSinceEpoch,
                              'userId': FirebaseAuth.instance
                                  .currentUser!.uid,
                            });
                            const snackBar = SnackBar(
                                content: Text(
                                    'Booked successfully'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }, child: const Text('Book'));
                        }),
                        const SizedBox(height: 4.0),
                        const Divider(height: 2.0),
                      ],
                    ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
              ),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.local_offer_outlined),
                label: 'Offer',
                activeIcon: Icon(Icons.local_offer)),
            BottomNavigationBarItem(
                icon: Icon(Icons.screen_search_desktop_outlined),
                label: 'Search',
                activeIcon: Icon(Icons.screen_search_desktop)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
                activeIcon: Icon(Icons.settings)),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      );
    });
  }
}
