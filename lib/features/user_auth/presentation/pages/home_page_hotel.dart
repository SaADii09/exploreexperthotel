import 'package:exploreexperthotel/features/user_auth/presentation/pages/list_pkg_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/list_room_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_header.dart';
import 'package:flutter/material.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/home_screen_chat_page.dart';
import 'package:flutter/services.dart';

class HotelHome extends StatefulWidget {
  const HotelHome({super.key});

  @override
  State<HotelHome> createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  int myIndex = 0;

  List<Widget> widgetList = [
    // const Dashboard(),
    const HotelListRoomPage(),
    const HotelListPkgPage(),
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Set the status bar color to white
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const HotelHeader(),
      ),
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: myIndex,
        children: widgetList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
          // BottomNavigationBarItem(
          //   icon: ImageIcon(
          //     AssetImage('assets/images/ExploreXpertLogoBlack.png'),
          //   ),
          //   label: 'Dashboard',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_preferences),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gif_box),
            label: 'Packages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy), // Use standard icon
            label: 'Chat AI',
          ),
        ],
      ),
    );
  }
}
