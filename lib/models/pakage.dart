class Pakage {
  int discount;
  int price;
  List<dynamic> facility;
  String description;
  String title;
  String roomType;

  Pakage({
    required this.discount,
    required this.price,
    required this.facility,
    required this.description,
    required this.title,
    required this.roomType,
  });

  Pakage.fromJson(Map<String, Object?> json)
      : this(
          discount: json['discount']! as int,
          price: json['price']! as int,
          facility: json['facility']! as List<dynamic>,
          description: json['description']! as String,
          title: json['title']! as String,
          roomType: json['room_type']! as String,
        );

  Pakage copyWith({
    int? discount,
    int? price,
    List<String>? facility,
    String? description,
    String? title,
    String? roomType,
  }) {
    return Pakage(
      discount: discount ?? this.discount,
      price: price ?? this.price,
      facility: facility ?? this.facility,
      description: description ?? this.description,
      title: title ?? this.title,
      roomType: roomType ?? this.roomType,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'discount': discount,
      'price': price,
      'facility': facility,
      'description': description,
      'title': title,
      'room_type': roomType,
    };
  }
}
