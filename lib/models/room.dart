class Room {
  int discount;
  int rent;
  List<dynamic> facility;
  int floor;
  String roomNumber;
  String roomType;
  //new added
  String offers;
  String? provider;
  String timespan;
  String title;
  //for fetch data
  String? uId;

  Room({
    required this.discount,
    required this.rent,
    required this.facility,
    required this.floor,
    required this.roomNumber,
    required this.roomType,
    //new added
    required this.offers,
    required this.provider,
    required this.timespan,
    required this.title,
    required this.uId,
  });

  Room.fromJson(Map<String, Object?> json)
      : this(
          discount: json['discount']! as int,
          rent: json['rent']! as int,
          facility: json['facility']! as List<dynamic>,
          floor: json['floor']! as int,
          roomNumber: json['room_number']! as String,
          roomType: json['room_type']! as String,
          //new
          offers: json['offers']! as String,
          provider: json['provider']! as String,
          timespan: json['timespan']! as String,
          title: json['title']! as String,
          uId: json['uId']! as String,
        );

  Room copyWith({
    int? discount,
    int? rent,
    List<String>? facility,
    int? floor,
    String? roomNumber,
    String? roomType,
    //new
    String? offers,
    String? provider,
    String? timespan,
    String? title,
    String? uId,
  }) {
    return Room(
      discount: discount ?? this.discount,
      rent: rent ?? this.rent,
      facility: facility ?? this.facility,
      floor: floor ?? this.floor,
      roomNumber: roomNumber ?? this.roomNumber,
      roomType: roomType ?? this.roomType,
      //new
      offers: offers ?? this.offers,
      provider: provider ?? this.provider,
      title: title ?? this.title,
      timespan: timespan ?? this.timespan,
      uId: uId ?? this.uId,
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
      //new
      'offers': offers,
      'provider': provider,
      'timespan': timespan,
      'title': title,
      'uId': uId,
    };
  }
}
