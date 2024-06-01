import 'package:exploreexperthotel/features/user_auth/presentation/pages/dashboard.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/list_pkg_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/list_room_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HotelHome extends StatefulWidget {
  const HotelHome({super.key});

  @override
  State<HotelHome> createState() => _HotelHomeState();
}

class _HotelHomeState extends State<HotelHome> {
  int myIndex = 0;
  List<Widget> widgetList = [
    const Dashboard(),
    const HotelListRoomPage(),
    const HotelListPkgPage(),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
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
        // showSelectedLabels: false,
        onTap: (index) => {
          setState(() {
            myIndex = index;
          })
        },
        currentIndex: myIndex,

        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/ExploreXpertLogoBlack.png'),
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.room_preferences),
            label: 'Rooms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gif_box),
            label: 'Packages',
          ),
        ],
      ),
    );
  }
}
