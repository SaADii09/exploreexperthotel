import 'package:exploreexperthotel/features/user_auth/presentation/widgets/bottom_nav_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_header.dart';
import 'package:flutter/material.dart';

class HotelEditRoomPage extends StatelessWidget {
  const HotelEditRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HotelHeader(),
      ),
      resizeToAvoidBottomInset: false,
      // body : (),
      bottomNavigationBar: const BottomNavHotel(),
    );
  }
}
