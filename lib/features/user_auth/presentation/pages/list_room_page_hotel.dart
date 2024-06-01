import 'package:exploreexperthotel/features/user_auth/presentation/pages/add_room_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
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
  bool deleter = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
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
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/ExploreXpertLogo.png'),
                          ),
                          title: Text(
                            'Room Type : ${room.roomType}',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Room Number : ${room.roomNumber}',
                              ),
                              Text(
                                'Floor Number : ${room.floor.toString()}',
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Confirmation'),
                                      content: const Text(
                                          'Are you sure you want to delete room?'),
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
                                            _databaseService.deleteRoom(roomId);
                                          },
                                          color: EXColors.primaryDark,
                                          textColor: Colors.white,
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HotelAddRoomPage()),
          );
        },
        backgroundColor: EXColors.primaryDark,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
