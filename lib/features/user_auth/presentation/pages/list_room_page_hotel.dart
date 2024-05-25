import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_header.dart';
import 'package:exploreexperthotel/models/room.dart';
import 'package:exploreexperthotel/services/database_services.dart';
import 'package:flutter/material.dart';

class HotelListRoomPage extends StatefulWidget {
  const HotelListRoomPage({super.key});

  @override
  State<HotelListRoomPage> createState() => _HotelListRoomPageState();
}

class _HotelListRoomPageState extends State<HotelListRoomPage> {
  final DatabaseServices _databaseService = DatabaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HotelHeader(),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              height: 40,
              color: EXColors.primaryDark,
              child: const Center(
                child: Text(
                  'Room List',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: EXColors.secondaryLight),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.80,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                builder: (Context, snapshot) {
                  List rooms = snapshot.data?.docs.cast<dynamic>() ?? [];
                  if (rooms.isEmpty) {
                    return const Center(
                      child: Text('Add a Room!'),
                    );
                  }
                  // print(rooms);
                  return ListView.builder(
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      Room room = rooms[index].data();
                      String roomId = rooms[index].id;
                      // print(room);
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: ListTile(
                          title: Text(
                            room.roomType,
                          ),
                        ),
                      );
                    },
                  );
                },
                stream: _databaseService.getRooms(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
