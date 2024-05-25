import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomNavHotel extends StatelessWidget {
  const BottomNavHotel({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage('assets/images/ExploreXpertLogoBlack.png'),
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
      ],
      // height: 80,
      // decoration: const BoxDecoration(
      //   color: Color.fromARGB(111, 74, 169, 188),
      //   borderRadius: BorderRadius.vertical(
      //     top: Radius.circular(30),
      //   ),
      // ),
      // child: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 50),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       IconButton(
      //         onPressed: () {},
      //         icon: const Icon(
      //           Icons.home_filled,
      //           color: true ? EXColors.primaryDark : EXColors.secondaryDark,
      //           size: 35,
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: const ImageIcon(
      //           AssetImage('assets/images/ExploreXpertLogoBlack.png'),
      //           color: false ? EXColors.primaryDark : EXColors.secondaryDark,
      //           size: 35,
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: const Icon(
      //           Icons.notifications,
      //           color: false ? EXColors.primaryDark : EXColors.secondaryDark,
      //           size: 35,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
