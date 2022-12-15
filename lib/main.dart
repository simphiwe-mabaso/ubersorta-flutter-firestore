import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifts_app/model/lifts_view_model.dart';
import 'package:lifts_app/pages/create_lift.dart';
import 'package:lifts_app/pages/editable_lift.dart';
import 'package:lifts_app/pages/home.dart';
import 'package:lifts_app/pages/login.dart';
import 'package:lifts_app/pages/offer.dart';
import 'package:lifts_app/pages/offered_lifts.dart';
import 'package:lifts_app/pages/search_available_lifts.dart';
import 'package:lifts_app/pages/settings.dart';
import 'package:lifts_app/pages/view_available_lifts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'model/lift.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider.value(value: LiftsViewModel()),
        ChangeNotifierProvider.value(value: ApplicationState()),
        Provider<MyAppState>(create: (_) => MyAppState())
      ], child: const MyApp())
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) {
          return const MyLoginPage();
        },
        '/sign-in': ((context) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                Navigator.of(context)
                    .pushNamed('/forgot-password', arguments: {'email': email});
              })),
              AuthStateChangeAction(((context, state) {
                if (state is SignedIn || state is UserCreated) {
                  var user = (state is SignedIn)
                      ? state.user
                      : (state as UserCreated).credential.user;
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  Navigator.of(context).pushReplacementNamed('/main');
                }
              })),
            ],
          );
        }),
        '/forgot-password': ((context) {
          final arguments = ModalRoute.of(context)?.settings.arguments
          as Map<String, dynamic>?;

          return ForgotPasswordScreen(
            email: arguments?['email'] as String,
            headerMaxExtent: 200,
          );
        }),
        '/profile': ((context) {
          return ProfileScreen(
            providers: const [],
            actions: [
              SignedOutAction(
                ((context) {
                  Navigator.of(context).pushReplacementNamed('/home');
                }),
              ),
            ],
          );
        }),
        '/main': (context) {return const MyHomePage(title: 'UberSorta');},
        '/offer': (context) {return const MyOfferPage(title: 'Manage offers');},
        '/settings': (context) {return const MySettingsPage(title: 'Settings');},
        '/create-offer': (context) {return const CreateLiftPage(title: 'Create offer');},
        '/view-offered': (context) {return const OfferedLiftsPage(title: 'View offered lifts');},
        '/editable-lift': (context) {return const EditableLiftPage(title: 'Edit');},
        '/view-available-lifts': (context) {return const ViewAvailableLiftsPage(title: 'Available seats lifts');},
        '/search-available-lifts' : (context) {return const SearchAvailableLiftsPage();},
      },
      title: 'UberSorta',
      // theme: lightTheme,
      // darkTheme: darkTheme,
      // themeMode: _themeManager.themeMode,
      theme: isSwitched ? ThemeData.dark(): ThemeData(primarySwatch: Colors.purple),
      // darkTheme: ThemeData.dark(),
    );
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _liftsBookSubscription;
  List<Lift> _liftsBookList = [];
  List<Lift> _availableSeatsList = [];
  Map<String, dynamic> foundLifts = <String, dynamic>{};
  List<Map<String, dynamic>> searchResults = [];
  List<Lift> get getLiftsBookList => _liftsBookList;
  List<Lift> get getAvailableSeatsList => _availableSeatsList;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _liftsBookSubscription = FirebaseFirestore.instance
        .collection('liftsbook')
        .orderBy('departureDateTime', descending: true)
        .snapshots()
        .listen((snapshot) {
          _liftsBookList = [];
          _availableSeatsList = [];

          for (final document in snapshot.docs) {
            if (int.parse(document.data()['availableSeats']) > 0) {
              _availableSeatsList.add(
                  Lift(
                    departureDateTime: document.data()['departureDateTime'] as String,
                    departureTown: document.data()['departureTown'] as String,
                    departureStreet: document.data()['departureStreet'] as String,
                    destinationTown: document.data()['destinationTown'] as String,
                    destinationStreet: document.data()['destinationStreet'] as String,
                    numberPassengers: document.data()['numberOfPassengers'] as String,
                    id: document.id,
                    availableSeats: document.data()['availableSeats'],
                    costShareDescription: document.data()['costShareDescription'] as String,
                    name: document.data()['name'] as String,
                  )
              );
            }
            _liftsBookList.add(
              Lift(
                departureDateTime: document.data()['departureDateTime'] as String,
                departureTown: document.data()['departureTown'] as String,
                departureStreet: document.data()['departureStreet'] as String,
                destinationTown: document.data()['destinationTown'] as String,
                destinationStreet: document.data()['destinationStreet'] as String,
                numberPassengers: document.data()['numberOfPassengers'] as String,
                id: document.id,
                availableSeats: document.data()['availableSeats'],
                costShareDescription: document.data()['costShareDescription'] as String,
              )
            );
          }
        });
      } else {
        _loggedIn = false;
        _liftsBookList = [];
        _availableSeatsList = [];
        _liftsBookSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addFieldsToLiftsBook(
      String departureDateTime,
      String departureTown,
      String departureStreet,
      String destinationTown,
      String destinationStreet,
      String numberOfPassengers,
      String costShareDescription,
      String availableSeats,
      ) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('liftsbook')
        .add(<String, dynamic>{
      'departureDateTime': departureDateTime,
      'departureTown': departureTown,
      'departureStreet': departureStreet,
      'destinationTown': destinationTown,
      'destinationStreet': destinationStreet,
      'numberOfPassengers': numberOfPassengers,
      'costShareDescription': costShareDescription,
      'availableSeats': availableSeats,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  Future<DocumentReference> bookLifts(
      String departureDateTime,
      String departureTown,
      String departureStreet,
      String destinationTown,
      String destinationStreet,
      String numberOfPassengers,
      String costShareDescription,
      String availableSeats,
      ) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('bookings')
        .add(<String, dynamic>{
      'departureDateTime': departureDateTime,
      'departureTown': departureTown,
      'departureStreet': departureStreet,
      'destinationTown': destinationTown,
      'destinationStreet': destinationStreet,
      'numberOfPassengers': numberOfPassengers,
      'costShareDescription': costShareDescription,
      'availableSeats': availableSeats,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  Future searchLiftsBook(String destinationTown) async {
    searchResults.clear();
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('liftsbook')
        .where('destinationTown', isEqualTo: destinationTown)
        .get()
        .then((value) => value.docs.forEach(
            (element) {
              Map<String, dynamic> map = <String, dynamic>{};
              map['departureDateTime'] = element.get('departureDateTime');
              map['destinationTown'] = element.get('destinationTown');
              map['availableSeats'] = element.get('availableSeats');
              map['costShareDescription'] = element.get('costShareDescription');
              map['name'] = element.get('name');
              searchResults.add(map);
            }),
    );
  }
}
