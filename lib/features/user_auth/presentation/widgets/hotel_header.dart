import 'package:exploreexperthotel/features/user_auth/presentation/pages/profile_setup_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HotelHeader extends StatelessWidget {
  const HotelHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 25,
                width: 200,
                // decoration: const BoxDecoration(
                //   image: DecorationImage(
                //     image:
                //         AssetImage('assets/images/ExploreXpertTitleBlack.png'),
                //   ),
                // ),
                child: const Image(
                  image: AssetImage('assets/images/ExploreXpertTitleBlack.png'),
                ),
              ),
              const Text(
                "Hotel/Agent Management",
                style: TextStyle(
                  fontSize: 18,
                  color: EXColors.primaryDark,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HotelProfileSetupPage(),
                ),
              );
            },
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: EXColors.primaryDark),
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/ProfileImg2.png'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
