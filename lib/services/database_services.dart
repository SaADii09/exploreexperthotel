import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreexperthotel/models/room.dart';

const String ROOM_COLLECTION_REF = "rooms";

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _roomsRef;

  DatabaseServices() {
    _roomsRef = _firestore.collection(ROOM_COLLECTION_REF).withConverter<Room>(
        fromFirestore: (snapshots, _) => Room.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (room, _) => room.toJson());
  }

  Stream<QuerySnapshot> getRooms() {
    return _roomsRef.snapshots();
  }

  void addRoom(Room room) async {
    _roomsRef.add(room);
  }
}
