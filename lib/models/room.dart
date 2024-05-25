import 'package:flutter/material.dart';

class Room {
  int discount;
  int rent;
  // List<String> facility;
  int floor;
  // List<String> images;
  String roomNumber;
  String roomType;

  Room({
    required this.discount,
    required this.rent,
    // required this.facility,
    required this.floor,
    // required this.images,
    required this.roomNumber,
    required this.roomType,
  });

  Room.fromJson(Map<String, Object?> json)
      : this(
          discount: json['discount']! as int,
          rent: json['rent']! as int,
          // facility: json['facility']! as List<String>,
          floor: json['floor']! as int,
          // images: json['images']! as List<String>,
          roomNumber: json['room_number']! as String,
          roomType: json['room_type']! as String,
        );

  Room copyWith({
    int? discount,
    int? rent,
    // List<String>? facility,
    int? floor,
    // List<String>? images,
    String? roomNumber,
    String? roomType,
  }) {
    return Room(
      discount: discount ?? this.discount,
      rent: rent ?? this.rent,
      // facility: facility ?? this.facility,
      floor: floor ?? this.floor,
      // images: images ?? this.images,
      roomNumber: roomNumber ?? this.roomNumber,
      roomType: roomType ?? this.roomType,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'discount': discount,
      'rent': rent,
      // 'facility': facility,
      'floor': floor,
      // 'images': images,
      'room_number': roomNumber,
      'room_type': roomType,
    };
  }
}
