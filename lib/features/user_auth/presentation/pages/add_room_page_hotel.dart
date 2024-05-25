
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/bottom_nav_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/form_field_container_widget.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HotelAddRoomPage extends StatelessWidget {
  const HotelAddRoomPage({super.key});

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
                    const FormFieldContainerWidget(
                      hintText: 'Room Number',
                      labelText: 'Room Number:',
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 10),

                    const FormFieldContainerWidget(
                      hintText: 'Floor',
                      labelText: 'Floor',
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 10),

                    const FormFieldContainerWidget(
                      hintText: 'Rent',
                      labelText: 'Rent',
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 10),

                    const FormFieldContainerWidget(
                      hintText: 'Discount',
                      labelText: 'Discount',
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 10),

                    const FormFieldContainerWidget(
                      hintText: 'Facility',
                      labelText: 'Facility:',
                      isPasswordField: false,
                    ),
                    const SizedBox(height: 10),
                    const ImagePreviewWidget(),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: MaterialButton(
                        onPressed: () {},
                        color: EXColors.primaryDark,
                        height: 60,
                        mouseCursor: MaterialStateMouseCursor.clickable,
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
      bottomNavigationBar: const BottomNavHotel(),
    );
  }
}

class ImagePreviewWidget extends StatefulWidget {
  const ImagePreviewWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ImagePreviewWidgetState createState() => _ImagePreviewWidgetState();
}

class _ImagePreviewWidgetState extends State<ImagePreviewWidget> {
  List<File?> _images = [null, null, null]; // List to store the selected images

  // Function to select an image from the gallery
  Future<void> _selectImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      // Update the selected image in the list
      _images[index] = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < _images.length; i++)
          GestureDetector(
            onTap: () => _selectImage(i),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.35),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 2,
                ),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              padding: const EdgeInsets.all(1),
              width: MediaQuery.of(context).size.width * 0.29,
              height: MediaQuery.of(context).size.width * 0.29,
              child: _images[i] != null
                  ? Image.file(
                      // Display the selected image
                      _images[i]!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.add_a_photo), // Placeholder icon
            ),
          ),
      ],
    );
  }
}
