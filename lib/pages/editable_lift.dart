import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/update_lift.dart';
import 'package:provider/provider.dart';

import '../authentication.dart';
import '../main.dart';
import '../model/lift.dart';

class EditableLiftPage extends StatefulWidget {
  const EditableLiftPage({super.key, required this.title});

  final String title;

  @override
  State<EditableLiftPage> createState() => _EditableLiftPageState();
}

class _EditableLiftPageState extends State<EditableLiftPage> {
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
    List<Lift> liftsList =
        Provider.of<ApplicationState>(context, listen: true).getLiftsBookList;

    return Consumer<LiftsViewModel>(builder: (context, liftsViewModel, child) {
      return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/offer');
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
          itemCount: liftsList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Card(
                elevation: 1.0,
                shadowColor: Colors.lightGreen,
                child: SizedBox(
                  height: 60,
                  child: Row(
                    children: [
                      const SizedBox(width: 8.0),
                      Text(liftsList.elementAt(index).departureDateTime),
                      const SizedBox(width: 8.0),
                      Text(liftsList.elementAt(index).destinationTown!),
                    ],
                  ),
                ),
              ),
              trailing: Consumer<ApplicationState>(
                  builder: (context, appState, _) {
                    return IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => UpdateLiftPage(liftsList.elementAt(index)), fullscreenDialog: true),
                          );
                        }
                    );
                  }),
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
