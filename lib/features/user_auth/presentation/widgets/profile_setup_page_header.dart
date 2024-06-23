import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:flutter/material.dart';

class ProfileSetupHeader extends StatelessWidget {
  const ProfileSetupHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
              child: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/ExploreXpertLogoBlack.png'),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 207,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/ExploreXpertTitleBlack.png'),
                    ),
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
          ],
        ),
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: const Text(
            'Hotel/Agent Profile',
            style: TextStyle(
              fontSize: 25,
              color: EXColors.secondaryDark,
            ),
          ),
        )
      ],
    );
  }
}
