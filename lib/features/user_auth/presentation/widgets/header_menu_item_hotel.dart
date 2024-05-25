
import 'package:exploreexperthotel/features/user_auth/presentation/pages/profile_setup_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:flutter/material.dart';

class HotelHeaderMenuItem extends StatelessWidget {
  const HotelHeaderMenuItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          color: EXColors.primaryLight,
          child: Row(
            children: [
              IconButton(
                color: EXColors.primaryDark,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HotelProfileSetupPage()),
                  );
                },
                icon: const Icon(
                  Icons.person,
                ),
              ),
              const Text('Profile'),
            ],
          ),
        ),
        Container(
          height: 50,
          color: EXColors.primaryLight,
          child: Row(
            children: [
              IconButton(
                color: EXColors.primaryDark,
                onPressed: () {},
                icon: const Icon(
                  Icons.logout,
                ),
              ),
              const Text('Logout'),
            ],
          ),
        ),
      ],
    );
  }
}
