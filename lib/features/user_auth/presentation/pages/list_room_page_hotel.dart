import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/add_room_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/edit_room_page.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/models/room.dart';
import 'package:exploreexperthotel/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HotelListRoomPage extends StatefulWidget {
  const HotelListRoomPage({super.key});

  @override
  State<HotelListRoomPage> createState() => _HotelListRoomPageState();
}

class _HotelListRoomPageState extends State<HotelListRoomPage> {
  final DatabaseServices _databaseService = DatabaseServices();
  final User? uzer = FirebaseAuth.instance.currentUser;

  bool allSelected = true;
  bool bookedSelected = false;
  bool availableSelected = false;

  final ValueNotifier<Stream<QuerySnapshot<Room>>> streamNotifier =
      ValueNotifier<Stream<QuerySnapshot<Room>>>(
          const Stream<QuerySnapshot<Room>>.empty());

  @override
  void initState() {
    super.initState();
    // Set the initial stream
    streamNotifier.value = _databaseService.getAllRooms(uzer?.uid);
  }

  void selectChip(String chip) {
    setState(() {
      if (chip == 'All') {
        allSelected = true;
        bookedSelected = false;
        availableSelected = false;
        streamNotifier.value = _databaseService.getAllRooms(uzer?.uid);
      } else if (chip == 'Booked') {
        allSelected = false;
        bookedSelected = true;
        availableSelected = false;
        streamNotifier.value = _databaseService.getRoomsNotAvaiable(uzer?.uid);
      } else if (chip == 'Available') {
        allSelected = false;
        bookedSelected = false;
        availableSelected = true;
        streamNotifier.value = _databaseService.getRoomsAvaiable(uzer?.uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ChoiceChip(
                      label: const Text('All'),
                      selected: allSelected,
                      onSelected: (selected) {
                        selectChip('All');
                      },
                      selectedColor: Theme.of(context).colorScheme.primary,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ChoiceChip(
                      label: const Text('Booked'),
                      selected: bookedSelected,
                      onSelected: (selected) {
                        selectChip('Booked');
                      },
                      selectedColor: Theme.of(context).colorScheme.primary,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ChoiceChip(
                      label: const Text('Available'),
                      selected: availableSelected,
                      onSelected: (selected) {
                        selectChip('Available');
                      },
                      selectedColor: Theme.of(context).colorScheme.primary,
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Stream<QuerySnapshot<Room>>>(
                valueListenable: streamNotifier,
                builder: (context, stream, child) {
                  return StreamBuilder<QuerySnapshot<Room>>(
                    stream: stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('Add Room!'),
                        );
                      }
                      List<Room> rooms =
                          snapshot.data!.docs.map((doc) => doc.data()).toList();
                      return ListView.builder(
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          Room room = rooms[index];
                          String roomId = snapshot.data!.docs[index].id;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HotelEditRoomPage(
                                    roomie: room,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              decoration:
                                  BoxDecoration(border: Border.all(width: 1)),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/ExploreXpertLogo.png'),
                                ),
                                title: Text('Room Type : ${room.roomType}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Room Number : ${room.roomNumber}'),
                                    Text('Floor Number : ${room.floor}'),
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
                                                _databaseService
                                                    .deleteRoom(roomId);
                                              },
                                              color: EXColors.primaryDark,
                                              textColor: Colors.white,
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
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
