import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/home_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/form_field_container_widget.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_header.dart';
import 'package:exploreexperthotel/models/room.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:exploreexperthotel/services/database_services.dart';
import 'package:image_picker/image_picker.dart';

class HotelAddRoomPage extends StatefulWidget {
  const HotelAddRoomPage({super.key});

  @override
  State<HotelAddRoomPage> createState() => _HotelAddRoomPageState();
}

class _HotelAddRoomPageState extends State<HotelAddRoomPage> {
  final DatabaseServices _databaseService = DatabaseServices();
  TextEditingController roomTypeController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController facilityController = TextEditingController();
  TextEditingController offersController = TextEditingController();
  TextEditingController timeSpanController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  List<String?> imgUrl = ['', '', ''];
  bool img0 = false;
  bool img1 = false;
  bool img2 = false;
  bool available = false;
  final uzer = FirebaseAuth.instance.currentUser;
  final ImagePicker _imagePicker = ImagePicker();
  Future<void> pickImage(int sel) async {
    try {
      XFile? res = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (res != null) {
        await UploadImageToFirebase(File(res.path), sel);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Center(
            child: Text(
              'Error during picking image!!',
            ),
          ),
        ),
      );
    }
  }

  Future<void> UploadImageToFirebase(File image, sel) async {
    try {
      Reference REF = FirebaseStorage.instance.ref().child(
          'HotelRoomImages/${DateTime.now()}-${image.path.split('/').last}');
      await REF.putFile(image).whenComplete(
        () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              content: Center(
                child: Text(
                  'uploading image!! successfull',
                ),
              ),
            ),
          );
        },
      );
      imgUrl[sel] = await REF.getDownloadURL();
      switch (sel) {
        case 0:
          setState(() {
            img0 = true;
          });
          break;
        case 1:
          setState(() {
            img1 = true;
          });
          break;
        case 2:
          setState(() {
            img2 = true;
          });
          break;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Center(
            child: Text(
              'Error during uploading image!!',
            ),
          ),
        ),
      );
    }
  }

  void _onChanged(bool? value) {
    setState(() {
      available = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HotelHeader(),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              color: EXColors.primaryDark,
              child: const Center(
                child: Text(
                  'Add Room',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: EXColors.secondaryLight),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  FormFieldContainerWidget(
                    hintText: 'Room Title',
                    labelText: 'Room Title',
                    isPasswordField: false,
                    controller: titleController,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.35),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownMenu(
                        controller: roomTypeController,
                        label: const Text('Room Type:'),
                        hintText: 'Select Room type',
                        enableSearch: true,
                        width: MediaQuery.of(context).size.width * 0.95,
                        dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(
                            value: 'Standard Room',
                            label: 'Standard Room',
                          ),
                          DropdownMenuEntry(
                            value: 'Deluxe Room',
                            label: 'Deluxe Room',
                          ),
                          DropdownMenuEntry(
                            value: 'Suite',
                            label: 'Suite',
                          ),
                          DropdownMenuEntry(
                            value: 'Executive Room',
                            label: 'Executive Room',
                          ),
                          DropdownMenuEntry(
                            value: 'Family Room',
                            label: 'Family Room',
                          ),
                          DropdownMenuEntry(
                            value: 'Connecting Room',
                            label: 'Connecting Room',
                          ),
                          DropdownMenuEntry(
                            value: 'Twin Room',
                            label: 'Twin Room',
                          ),
                          DropdownMenuEntry(
                            value: 'King Room',
                            label: 'King Room',
                          ),
                          DropdownMenuEntry(
                            value: 'Queen Room',
                            label: 'Queen Room',
                          ),
                          DropdownMenuEntry(
                            value: 'Accessible Room',
                            label: 'Accessible Room',
                          ),
                        ],
                        inputDecorationTheme: InputDecorationTheme(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: EXColors.primaryDark,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blueGrey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(15),
                          filled: true,
                          hintStyle: const TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  /////////////////////////////////////////////
                  FormFieldContainerWidget(
                    hintText: 'Room Number',
                    labelText: 'Room Number:',
                    isPasswordField: false,
                    controller: roomNumberController,
                  ),
                  const SizedBox(height: 10),

                  FormFieldContainerWidget(
                    hintText: 'Floor',
                    labelText: 'Floor',
                    isPasswordField: false,
                    controller: floorController,
                    inputType: TextInputType.number,
                  ),

                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.35),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownMenu(
                        controller: timeSpanController,
                        label: const Text('Time Span:'),
                        hintText: 'Select Time Span',
                        enableSearch: true,
                        width: MediaQuery.of(context).size.width * 0.95,
                        dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(
                            value: 'Day',
                            label: 'Day',
                          ),
                          DropdownMenuEntry(
                            value: 'Night',
                            label: 'Night',
                          ),
                        ],
                        inputDecorationTheme: InputDecorationTheme(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: EXColors.primaryDark,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blueGrey,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          contentPadding: const EdgeInsets.all(15),
                          filled: true,
                          hintStyle: const TextStyle(
                            color: Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  FormFieldContainerWidget(
                    hintText: 'Rent',
                    labelText: 'Rent',
                    isPasswordField: false,
                    controller: rentController,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),

                  FormFieldContainerWidget(
                    hintText: 'Discount',
                    labelText: 'Discount',
                    isPasswordField: false,
                    controller: discountController,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  FormFieldContainerWidget(
                    hintText: 'Offers',
                    labelText: 'Offers',
                    isPasswordField: false,
                    controller: offersController,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),

                  FormFieldContainerWidget(
                    hintText: 'Facility',
                    labelText: 'Facility:',
                    isPasswordField: false,
                    controller: facilityController,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.35),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Available:'),
                        Checkbox(
                          value: available,
                          onChanged: _onChanged,
                          checkColor: EXColors.primaryDark,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          pickImage(0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.35),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 2,
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          padding: const EdgeInsets.all(1),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: img0
                                ? Image.network(
                                    imgUrl[0]!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pickImage(1);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.35),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 2,
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          padding: const EdgeInsets.all(1),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: img1
                                ? Image.network(
                                    imgUrl[1]!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          pickImage(2);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.35),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 2,
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          padding: const EdgeInsets.all(1),
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.25,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: img2
                                ? Image.network(
                                    imgUrl[2]!,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: MaterialButton(
                      onPressed: () async {
                        if (discountController.text.isNotEmpty &&
                            rentController.text.isNotEmpty &&
                            roomNumberController.text.isNotEmpty &&
                            roomTypeController.text.isNotEmpty &&
                            floorController.text.isNotEmpty &&
                            facilityController.text.isNotEmpty &&
                            titleController.text.isNotEmpty &&
                            timeSpanController.text.isNotEmpty &&
                            offersController.text.isNotEmpty &&
                            img0 &&
                            img1 &&
                            img2) {
                          String input = facilityController.text;
                          Room room = Room(
                            images: imgUrl,
                            available: available,
                            title: titleController.text,
                            timespan: timeSpanController.text,
                            provider: await getHotelName(uzer?.email),
                            offers: offersController.text,
                            uId: uzer?.uid,
                            discount: int.parse(discountController.text),
                            rent: int.parse(rentController.text),
                            floor: int.parse(floorController.text),
                            roomNumber: roomNumberController.text,
                            roomType: roomTypeController.text,
                            facility: input.split(','),
                          );
                          discountController.clear();
                          rentController.clear();
                          roomNumberController.clear();
                          roomTypeController.clear();
                          floorController.clear();
                          facilityController.clear();
                          titleController.clear();
                          timeSpanController.clear();
                          offersController.clear();
                          setState(() {
                            img0 = false;
                            img1 = false;
                            img2 = false;
                          });

                          _databaseService.addRoom(room);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Center(
                                child: Text(
                                  'Room Added Successfully!!',
                                ),
                              ),
                            ),
                          );
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HotelHome()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.orange,
                              content: Center(
                                child: Text(
                                  'Fill out All fields and add wait for images to load!!',
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      color: EXColors.primaryDark,
                      height: 60,
                      mouseCursor: WidgetStateMouseCursor.clickable,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: EXColors.secondaryLight,
                          ),
                          Text(
                            'Add Room',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getHotelName(String? documentId) async {
    if (documentId != null) {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('users_hotel')
          .doc(documentId)
          .get();
      if (documentSnapshot.exists) {
        return documentSnapshot.get('name') as String;
      }
    }
    throw Exception('Hotel name not found or document does not exist.');
  }
}
