import 'package:exploreexperthotel/features/user_auth/presentation/pages/profile_setup_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          PopupMenuButton(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                "assets/images/ProfileImg2.png",
                width: 50,
              ),
            ),
            onSelected: (value) {
              if (value == "profile") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HotelProfileSetupPage(),
                  ),
                );
              } else if (value == "logout") {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('Are you sure you want to Logout?'),
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: EXColors.primaryDark,
                            textColor: Colors.white,
                            child: const Text('Cancel'),
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                              FirebaseAuth.instance.signOut();
                            },
                            color: EXColors.primaryDark,
                            textColor: Colors.white,
                            child: const Text('Logout'),
                          ),
                        ],
                      );
                    });
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: "profile",
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.account_box),
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: "logout",
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.logout)),
                    Text(
                      'Logout',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          )
          // GestureDetector(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const HotelProfileSetupPage(),
          //       ),
          //     );
          //   },
          //   child: Container(
          //     height: 45,
          //     width: 45,
          //     decoration: BoxDecoration(
          //       border: Border.all(width: 1, color: EXColors.primaryDark),
          //       borderRadius: const BorderRadius.all(
          //         Radius.circular(50),
          //       ),
          //       image: const DecorationImage(
          //         image: AssetImage('assets/images/ProfileImg2.png'),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
