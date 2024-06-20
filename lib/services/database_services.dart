// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreexperthotel/models/pakage.dart';
import 'package:exploreexperthotel/models/room.dart';

const String ROOM_COLLECTION_REF = "rooms";
const String PAKAGE_COLLECTION_REF = "packages";

class PDatabaseServices {
  final _pfirestore = FirebaseFirestore.instance;

  late final CollectionReference _pakagesRef;

  PDatabaseServices() {
    _pakagesRef =
        _pfirestore.collection(PAKAGE_COLLECTION_REF).withConverter<Pakage>(
            fromFirestore: (snapshots, _) => Pakage.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (pakage, _) => pakage.toJson());
  }
  Stream<QuerySnapshot> getPakage(String? uid) {
    return _pakagesRef.where('uId', isEqualTo: uid).snapshots();
  }

  void addPakage(Pakage pakage) async {
    _pakagesRef.add(pakage);
  }

  void updatePakage(String pakageId, Pakage pakage) {
    _pakagesRef.doc(pakageId).update(pakage.toJson());
  }

  void deletePakage(String pakageId) {
    _pakagesRef.doc(pakageId).delete();
  }
}

class DatabaseServices {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<Room> _roomsRef;

  DatabaseServices() {
    _roomsRef = _firestore.collection(ROOM_COLLECTION_REF).withConverter<Room>(
        fromFirestore: (snapshots, _) => Room.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (room, _) => room.toJson());
  }

  Stream<QuerySnapshot<Room>> getAllRooms(String? uid) {
    return _roomsRef.where('uId', isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot<Room>> getRoomsAvaiable(String? uid) {
    return _roomsRef
        .where('uId', isEqualTo: uid)
        .where('available', isEqualTo: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Room>> getRoomsNotAvaiable(String? uid) {
    return _roomsRef
        .where('uId', isEqualTo: uid)
        .where('available', isEqualTo: false)
        .snapshots();
  }

  Future<void> addRoom(Room room) async {
    await _roomsRef.add(room);
  }

  Future<void> updateRoom(String roomId, Room room) async {
    await _roomsRef.doc(roomId).update(room.toJson());
  }

  Future<void> deleteRoom(String roomId) async {
    await _roomsRef.doc(roomId).delete();
  }
}
