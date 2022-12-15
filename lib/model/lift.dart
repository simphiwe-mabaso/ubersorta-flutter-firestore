import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Use this class to represent a Lift
class Lift {
  // FIELDS
  late final String departureDateTime;
  String? id;
  String? ownerId = FirebaseAuth.instance.currentUser!.uid;
  String? departureStreet;
  String? departureTown;
  String? destinationStreet;
  String? destinationTown;
  String? numberPassengers;
  String? availableSeats;
  String? costShareDescription;
  String? name;

  //TODO

  Lift(
      {required this.departureDateTime,
      this.id,
      this.ownerId,
      this.departureStreet,
      required this.departureTown,
      this.destinationStreet,
      this.destinationTown,
      this.numberPassengers,
      this.availableSeats,
      this.costShareDescription,
      this.name});

  Lift.fromJson(Map<String, Object?> jsonMap)
      : this(
          departureDateTime: jsonMap['departureDateTime'] as String,
          id: jsonMap['id'] as String,
          ownerId: jsonMap['ownerId'] as String,
          departureStreet: jsonMap['departureStreet'] as String,
          departureTown: jsonMap['departureTown'] as String,
          destinationStreet: jsonMap['destinationStreet'] as String,
          destinationTown: jsonMap['destinationTown'] as String,
          numberPassengers: jsonMap['numberPassengers'] as String,
          availableSeats: jsonMap['availableSeats'] as String,
          costShareDescription: jsonMap['costShareDescription'] as String,
          name: jsonMap['name'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'departureDateTime': departureDateTime,
      'id': id,
      'ownerId': ownerId,
      'departureStreet': departureStreet,
      'departureTown': departureTown,
      'destinationStreet': destinationStreet,
      'destinationTown': destinationTown,
      'numberPassengers': numberPassengers,
      'availableSeats': availableSeats,
      'costShareDescription': costShareDescription,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Lift{'
        'departureDateTime: $departureDateTime'
        'id: $id'
        'ownerId: $ownerId'
        'departureStreet: $departureStreet'
        'departureTown: $departureTown'
        'destinationStreet: $destinationStreet'
        'destinationTown: $destinationTown'
        'numberPassengers: $numberPassengers'
        'availableSeats: $availableSeats'
        'costShareDescription: $costShareDescription'
        'name: $name'
        '}';
  }
}
