class Room {
  int discount;
  int rent;
  List<dynamic> facility;
  int floor;
  String roomNumber;
  String roomType;

  Room({
    required this.discount,
    required this.rent,
    required this.facility,
    required this.floor,
    required this.roomNumber,
    required this.roomType,
  });

  Room.fromJson(Map<String, Object?> json)
      : this(
          discount: json['discount']! as int,
          rent: json['rent']! as int,
          facility: json['facility']! as List<dynamic>,
          floor: json['floor']! as int,
          roomNumber: json['room_number']! as String,
          roomType: json['room_type']! as String,
        );

  Room copyWith({
    int? discount,
    int? rent,
    List<String>? facility,
    int? floor,
    String? roomNumber,
    String? roomType,
  }) {
    return Room(
      discount: discount ?? this.discount,
      rent: rent ?? this.rent,
      facility: facility ?? this.facility,
      floor: floor ?? this.floor,
      roomNumber: roomNumber ?? this.roomNumber,
      roomType: roomType ?? this.roomType,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'discount': discount,
      'rent': rent,
      'facility': facility,
      'floor': floor,
      'room_number': roomNumber,
      'room_type': roomType,
    };
  }
}