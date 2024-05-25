import 'package:exploreexperthotel/features/user_auth/presentation/pages/add_pkg_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/add_room_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/del_pkg_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/del_room_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/edit_pkg_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/edit_room_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/list_pkg_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/list_room_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/bottom_nav_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_header.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_home_elev_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:exploreexperthotel/services/database_services.dart';

class HotelHome extends StatelessWidget {
  const HotelHome({super.key});

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
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 30),
              height: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/HotelMngLogo.png'),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 8),
                              child: Text(
                                "Rooms",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: EXColors.secondaryDark),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    HotelElevButton(
                                      ico: Icons.add,
                                      txt: "Add",
                                      height: 80,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      btn: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HotelAddRoomPage()),
                                        );
                                      },
                                    ),
                                    HotelElevButton(
                                      ico: Icons.edit,
                                      txt: "Edit",
                                      height: 80,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      btn: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HotelEditRoomPage()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      HotelElevButton(
                                        ico: Icons.list,
                                        txt: "List",
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        btn: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HotelListRoomPage()),
                                          );
                                        },
                                      ),
                                      HotelElevButton(
                                        ico: Icons.delete,
                                        txt: "Delete",
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        btn: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HotelDelRoomPage()),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 8),
                              child: Text(
                                "Packages",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: EXColors.secondaryDark),
                              ),
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    HotelElevButton(
                                      ico: Icons.add,
                                      txt: "Add",
                                      height: 80,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      btn: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HotelAddPkgPage()),
                                        );
                                      },
                                    ),
                                    HotelElevButton(
                                      ico: Icons.edit,
                                      txt: "Edit",
                                      height: 80,
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      btn: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HotelEditPkgPage()),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      HotelElevButton(
                                        ico: Icons.list,
                                        txt: "List",
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        btn: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HotelListPkgPage()),
                                          );
                                        },
                                      ),
                                      HotelElevButton(
                                        ico: Icons.delete,
                                        txt: "Delete",
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.45,
                                        btn: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HotelDelPkgPage()),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavHotel(),
    );
  }
}
