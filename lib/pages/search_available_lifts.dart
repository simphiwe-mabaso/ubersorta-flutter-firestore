import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';
import '../main.dart';

class SearchAvailableLiftsPage extends StatefulWidget {
  const SearchAvailableLiftsPage({super.key});

  @override
  State<SearchAvailableLiftsPage> createState() => _SearchAvailableLiftsPageState();
}

class _SearchAvailableLiftsPageState extends State<SearchAvailableLiftsPage> {
  late bool match = false;

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
    final formKey = GlobalKey<FormState>(debugLabel: '_LiftsBookState');
    final controllerDestinationTown = TextEditingController();

    return Consumer<LiftsViewModel>(
        builder: (context, liftsViewModel, _) {
          return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/main');
                    },
                    icon: const Icon(Icons.navigate_before)
                ),
                title: const Text('Search for a lift', style: TextStyle(fontSize: 14.0),),
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
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Text('Search', style: TextStyle(fontSize: 30.0),),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: controllerDestinationTown,
                              decoration: const InputDecoration(
                                  hintText: 'Search by town',
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
                            Consumer<ApplicationState>(builder: (context, appState, _) {
                              return Column(
                                children: <Widget>[
                                  ElevatedButton(
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
                                      await appState.searchLiftsBook(controllerDestinationTown.text);
                                      setState(() {
                                        match = true;
                                      });
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.search_sharp),
                                        SizedBox(width: 5),
                                        Text('SEARCH'),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
                                  SingleChildScrollView(
                                    child: match ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: appState.searchResults.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                            title: Card(
                                              elevation: 1.0,
                                              shadowColor: Colors.lightGreen,
                                              child: SizedBox(
                                                height: 100,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const SizedBox(width: 8.0),
                                                        Text('Date: ${appState.searchResults[index]['departureDateTime']}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const SizedBox(width: 8.0),
                                                        Text('Town: ${appState.searchResults[index]['destinationTown']}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const SizedBox(width: 8.0),
                                                        Text('Seats: ${appState.searchResults[index]['availableSeats']}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const SizedBox(width: 8.0),
                                                        Text('Cost: ${appState.searchResults[index]['costShareDescription']}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const SizedBox(width: 8.0),
                                                        Text('Email: ${appState.searchResults[index]['name']}@ubersorta.com'),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ) : const Text(''),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
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
