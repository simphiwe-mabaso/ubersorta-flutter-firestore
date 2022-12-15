import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';
import '../main.dart';
import '../widgets.dart';

class CreateLiftPage extends StatefulWidget {
  const CreateLiftPage({super.key, required this.title});

  final String title;

  @override
  State<CreateLiftPage> createState() => _CreateLiftPageState();
}

class _CreateLiftPageState extends State<CreateLiftPage> {
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

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>(debugLabel: '_LiftsBookState');
    final controllerDateTime = TextEditingController();
    final controllerDepartureTown = TextEditingController();
    final controllerDepartureStreet = TextEditingController();
    final controllerDestinationTown = TextEditingController();
    final controllerDestinationStreet = TextEditingController();
    final controllerNumberOfPassengers = TextEditingController();
    final controllerCostShareDescription = TextEditingController();
    final controllerAvailableSeats = TextEditingController();

    return Consumer<LiftsViewModel>(
        builder: (context, fuelPriceModel, child) {
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/offer');
                    },
                    icon: const Icon(Icons.navigate_before)
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('Create', style: TextStyle(fontSize: 30.0),),
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
                              hintText: 'Date and time',
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
                                hintText: 'Departure town',
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
                              hintText: 'Departure street',
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
                              hintText: 'Destination town',
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
                              hintText: 'Destination street',
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
                              hintText: 'Number of passengers',
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
                              hintText: 'Available seats',
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
                              hintText: 'Cost share',
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
                          Consumer<ApplicationState>(builder: (context, appState, _) {
                            return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple, //background color of button
                                    side: const BorderSide(width: 1, color: Colors.purple), //border width and color
                                    elevation: 3, //elevation of button
                                    shape: RoundedRectangleBorder( //to set border radius to button
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    padding: const EdgeInsets.all(20) //content padding inside button
                                ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    await appState.addFieldsToLiftsBook(
                                      controllerDateTime.text,
                                      controllerDepartureTown.text,
                                      controllerDepartureStreet.text,
                                      controllerDestinationTown.text,
                                      controllerDestinationStreet.text,
                                      controllerNumberOfPassengers.text,
                                      controllerCostShareDescription.text,
                                      controllerAvailableSeats.text,
                                    );
                                    controllerDateTime.clear();
                                    controllerDepartureTown.clear();
                                    controllerDepartureStreet.clear();
                                    controllerDestinationTown.clear();
                                    controllerDestinationStreet.clear();
                                    controllerNumberOfPassengers.clear();
                                    controllerCostShareDescription.clear();
                                    controllerAvailableSeats.clear();
                                  }
                                  const snackBar = SnackBar(
                                      content: Text('Created successfully'));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.create_new_folder_sharp, color: Colors.white,),
                                    SizedBox(width: 5),
                                    Text('CREATE', style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              );
                          }),
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
