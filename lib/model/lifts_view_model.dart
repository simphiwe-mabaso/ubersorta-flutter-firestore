
import 'package:flutter/foundation.dart';

///Contains the relevant lifts data for our views
class LiftsViewModel extends  ChangeNotifier {
  //TODO keep track of loaded Lifts and notify views on changes
  // LiftsViewModel() {
  //   init();
  // }
  //
  // bool _loggedIn = false;
  // bool get loggedIn => _loggedIn;
  //
  // StreamSubscription<QuerySnapshot>? _liftsBookSubscription;
  // List<Lift> _liftsBookList = [];
  // List<Lift> _availableSeatsList = [];
  // Map<String, dynamic> foundLifts = <String, dynamic>{};
  // List<Lift> get getLiftsBookList => _liftsBookList;
  // List<Lift> get getAvailableSeatsList => _availableSeatsList;
  //
  // Future<void> init() async {
  //   await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform);
  //
  //   FirebaseUIAuth.configureProviders([
  //     EmailAuthProvider(),
  //   ]);
  //
  //   FirebaseAuth.instance.userChanges().listen((user) {
  //     if (user != null) {
  //       _loggedIn = true;
  //       _liftsBookSubscription = FirebaseFirestore.instance
  //           .collection('liftsbook')
  //           .orderBy('departureDateTime', descending: true)
  //           .snapshots()
  //           .listen((snapshot) {
  //         _liftsBookList = [];
  //         _availableSeatsList = [];
  //         for (final document in snapshot.docs) {
  //           if (document.data()['availableSeats'] > 0) {
  //             _availableSeatsList.add(
  //                 Lift(
  //                   departureDateTime: document.data()['departureDateTime'] as String,
  //                   // departureTown: document.data()['departureTown'] as String,
  //                   // departureStreet: document.data()['departureStreet'] as String,
  //                   destinationTown: document.data()['destinationTown'] as String,
  //                   // destinationStreet: document.data()['destinationStreet'] as String,
  //                   // numberPassengers: int.parse(document.data()['numberPassengers'] as String),
  //                   id: document.id,
  //                   availableSeats: document.data()['availableSeats'],
  //                   // costShareDescription: document.data()['costShare'] as String,
  //                   name: document.data()['name'] as String,
  //                 )
  //             );
  //           }
  //           _liftsBookList.add(
  //               Lift(
  //                 departureDateTime: document.data()['departureDateTime'] as String,
  //                 // departureTown: document.data()['departureTown'] as String,
  //                 // departureStreet: document.data()['departureStreet'] as String,
  //                 destinationTown: document.data()['destinationTown'] as String,
  //                 // destinationStreet: document.data()['destinationStreet'] as String,
  //                 // numberPassengers: int.parse(document.data()['numberPassengers'] as String),
  //                 id: document.id,
  //                 // availableSeats: int.parse(document.data()['availableSeats'] as String),
  //                 // costShareDescription: document.data()['costShare'] as String,
  //               )
  //           );
  //         }
  //       });
  //     } else {
  //       _loggedIn = false;
  //       _liftsBookList = [];
  //       _availableSeatsList = [];
  //       _liftsBookSubscription?.cancel();
  //     }
  //     notifyListeners();
  //   });
  // }
  //
  // Future<DocumentReference> addFieldsToLiftsBook(
  //     String departureDateTime,
  //     String departureTown,
  //     String departureStreet,
  //     String destinationTown,
  //     String destinationStreet,
  //     int numberOfPassengers,
  //     String costShareDescription,
  //     int availableSeats,
  //     ) {
  //   if (!_loggedIn) {
  //     throw Exception('Must be logged in');
  //   }
  //
  //   return FirebaseFirestore.instance
  //       .collection('liftsbook')
  //       .add(<String, dynamic>{
  //     'departureDateTime': departureDateTime,
  //     'departureTown': departureTown,
  //     'departureStreet': departureStreet,
  //     'destinationTown': destinationTown,
  //     'destinationStreet': destinationStreet,
  //     'numberOfPassengers': numberOfPassengers,
  //     'costShareDescription': costShareDescription,
  //     'availableSeats': availableSeats,
  //     'name': FirebaseAuth.instance.currentUser!.displayName,
  //     'timestamp': DateTime.now().millisecondsSinceEpoch,
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //   });
  // }
  //
  // Future<DocumentReference> bookLifts(
  //     String departureDateTime,
  //     String departureTown,
  //     String departureStreet,
  //     String destinationTown,
  //     String destinationStreet,
  //     int numberOfPassengers,
  //     String costShareDescription,
  //     int availableSeats,
  //     ) {
  //   if (!_loggedIn) {
  //     throw Exception('Must be logged in');
  //   }
  //
  //   return FirebaseFirestore.instance
  //       .collection('bookings')
  //       .add(<String, dynamic>{
  //     'departureDateTime': departureDateTime,
  //     'departureTown': departureTown,
  //     'departureStreet': departureStreet,
  //     'destinationTown': destinationTown,
  //     'destinationStreet': destinationStreet,
  //     'numberOfPassengers': numberOfPassengers,
  //     'costShareDescription': costShareDescription,
  //     'availableSeats': availableSeats,
  //     'name': FirebaseAuth.instance.currentUser!.displayName,
  //     'timestamp': DateTime.now().millisecondsSinceEpoch,
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //   });
  // }
  //
  // Future searchLiftsBook(String destinationTown) {
  //   if (!_loggedIn) {
  //     throw Exception('Must be logged in');
  //   }
  //
  //   return FirebaseFirestore.instance
  //       .collection('liftsbook')
  //       .where('destinationTown', isEqualTo: destinationTown)
  //       .get()
  //       .then((value) => value.docs.forEach(
  //           (element) {
  //         foundLifts['destinationTown'] = element;
  //       })
  //   );
  // }
}