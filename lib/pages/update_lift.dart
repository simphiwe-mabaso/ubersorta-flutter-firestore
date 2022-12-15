import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';
import '../main.dart';
import '../model/lift.dart';
import '../widgets.dart';

class UpdateLiftPage extends StatefulWidget {
  Lift liftsViewModel;
  UpdateLiftPage(this.liftsViewModel, {super.key});

  @override
  State<UpdateLiftPage> createState() => _UpdateLiftPageState();
}

class _UpdateLiftPageState extends State<UpdateLiftPage> {
  @override
  initState() {
    super.initState();
    initControllers();
  }

  // for bottom navigation
  int _selectedIndex = 0;

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

  final GlobalKey<FormState> formKey = GlobalKey();
  final controllerDateTime = TextEditingController();
  final controllerDepartureTown = TextEditingController();
  final controllerDepartureStreet = TextEditingController();
  final controllerDestinationTown = TextEditingController();
  final controllerDestinationStreet = TextEditingController();
  final controllerNumberOfPassengers = TextEditingController();
  final controllerCostShareDescription = TextEditingController();
  final controllerAvailableSeats = TextEditingController();

  initControllers() {
    controllerDateTime.text = widget.liftsViewModel.departureDateTime;
    controllerDepartureTown.text = widget.liftsViewModel.departureTown!;
    controllerDepartureStreet.text = widget.liftsViewModel.departureStreet!;
    controllerDestinationTown.text = widget.liftsViewModel.destinationTown!;
    controllerDestinationStreet.text = widget.liftsViewModel.destinationStreet!;
    controllerNumberOfPassengers.text = widget.liftsViewModel.numberPassengers as String;
    controllerCostShareDescription.text = widget.liftsViewModel.costShareDescription!;
    controllerAvailableSeats.text = widget.liftsViewModel.availableSeats as String;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LiftsViewModel>(
        builder: (context, fuelPriceModel, child) {
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/editable-lift');
                    },
                    icon: const Icon(Icons.navigate_before)
                ),
                title: const Text('Update', style: TextStyle(fontSize: 14.0),),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('Update', style: TextStyle(fontSize: 30.0),),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: controllerDateTime,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.date_range),
                                border: OutlineInputBorder()
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter date and time to continue';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: controllerDepartureTown,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.departure_board),
                                border: OutlineInputBorder()
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your town of departure to continue';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: controllerDepartureStreet,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.departure_board),
                                border: OutlineInputBorder()
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your street of departure to continue';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: controllerDestinationTown,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.place),
                                border: OutlineInputBorder()
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your town of destination to continue';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: controllerDestinationStreet,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.place),
                                border: OutlineInputBorder()
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your street of destination to continue';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: controllerNumberOfPassengers,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.people),
                                border: OutlineInputBorder()
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter the number of passengers to continue';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: controllerAvailableSeats,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.people),
                                border: OutlineInputBorder()
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter the number of available seats to continue';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: controllerCostShareDescription,
                              decoration: const InputDecoration(
                                suffixIcon: Icon(Icons.people),
                                border: OutlineInputBorder()
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter the amount to be shared to continue';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                side: const BorderSide(width: 1, color: Colors.purple),
                                  elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                ),
                                padding: const EdgeInsets.all(20) //content padding inside button
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    CollectionReference collection = FirebaseFirestore.instance.collection('liftsbook');
                                    DocumentReference document = collection.doc(widget.liftsViewModel.id);
                                    await document.update({
                                      'departureDateTime': controllerDateTime.text,
                                      'departureTown': controllerDepartureTown.text,
                                      'departureStreet': controllerDepartureStreet.text,
                                      'destinationTown': controllerDestinationTown.text,
                                      'destinationStreet': controllerDestinationStreet.text,
                                      'numberOfPassengers': controllerNumberOfPassengers.text,
                                      'costShareDescription': controllerCostShareDescription.text,
                                      'availableSeats': controllerAvailableSeats.text,
                                      'name': FirebaseAuth.instance.currentUser!
                                          .displayName,
                                      'timestamp': DateTime
                                          .now()
                                          .millisecondsSinceEpoch,
                                      'userId': FirebaseAuth.instance
                                          .currentUser!.uid,
                                    });
                                  }
                                  const snackBar = SnackBar(
                                  content: Text(
                                  'Updated successfully'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.arrow_upward, color: Colors.white,),
                                    SizedBox(width: 5),
                                    Text('UPDATE', style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
