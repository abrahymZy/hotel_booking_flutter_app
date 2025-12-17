import 'package:business_card/show_booking.dart';
import 'package:flutter/material.dart';

// import 'Dept.dart';
import 'Login.dart';
import 'Home.dart';
// import 'booking.dart';

import 'show_rooms.dart';
import 'show_clints.dart';
// import 'shw_detalls_2.dart';

void main() {
  runApp(
    MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
      routes: {
        "Login": (context) => Login(),
        "Home": (context) => Home(),
        // "BookingPage": (context) => BookingPage(),
        "Show_Clints": (context) => Show_Clints(),
        "Show_rooms": (context) => Show_rooms(),
        "Show_Booking": (context) => Show_Booking(),
        // "Show_Detalls_2": (context) => Show_Detalls_2(),
      },
    ),
  );
}
// Show_Detalls(idRent: 2),