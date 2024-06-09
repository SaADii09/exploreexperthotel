import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/form_field_container_widget.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_header.dart';
import 'package:exploreexperthotel/models/room.dart';
import 'package:exploreexperthotel/utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:exploreexperthotel/services/database_services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HotelHeader(),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
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
                          dropdownMenuEntries: const <DropdownMenuEntry<
                              String>>[
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
                      hintText: 'Facility',
                      labelText: 'Facility:',
                      isPasswordField: false,
                      controller: facilityController,
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        File? selectedImage =
                            await getImageFromGallery(context);
                        if (selectedImage != null) {
                          bool success = await uploadFileForUser(selectedImage);
                          print(success);
                        }
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
                            vertical: 8, horizontal: 4),
                        padding: const EdgeInsets.all(1),
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 60,
                        child:
                            const Icon(Icons.add_a_photo), // Placeholder icon
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: MaterialButton(
                        onPressed: () {
                          String input = facilityController.text;
                          Room room = Room(
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
                          _databaseService.addRoom(room);
                        },
                        color: EXColors.primaryDark,
                        height: 60,
                        mouseCursor: WidgetStateMouseCursor.clickable,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
