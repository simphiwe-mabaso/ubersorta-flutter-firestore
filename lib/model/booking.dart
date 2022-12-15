import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

/// Use this class to represent a Booking
class Booking {
  String? passengerId = FirebaseAuth.instance.currentUser!.uid;
  String liftId;
  bool confirmed = false;

  //TODO

  Booking({this.passengerId, required this.liftId, required this.confirmed});

  Booking.fromJson(Map<String, Object?> jsonMap)
      : this(
    passengerId: jsonMap['passengerId'] as String,
    liftId: jsonMap['liftId'] as String,
    confirmed: bool.fromEnvironment(jsonMap['confirmed'] as String),
  );

  Map<String, Object?> toJson() {
    return {
      'passengerId': passengerId,
      'liftId': liftId,
      'confirmed': confirmed,
    };
  }

  @override
  String toString() {
    return 'Booking{'
        'passengerId: $passengerId'
        'liftId: $liftId'
        'confirmed: $confirmed'
        '}';
  }
}
