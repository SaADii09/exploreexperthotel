import 'dart:io';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/profile_setup_page_header.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class HotelProfileSetupPage extends StatefulWidget {
  const HotelProfileSetupPage({super.key});

  @override
  State<HotelProfileSetupPage> createState() => _HotelProfileSetupPageState();
}

class _HotelProfileSetupPageState extends State<HotelProfileSetupPage> {
  bool isEditable = false;
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController agencyController = TextEditingController();
  XFile? _imageFile;
  //  = AssetImage('assets/images/ProfileImg2.png');
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );
    return Scaffold(
      appBar: AppBar(
        title: const ProfileSetupHeader(),
      ),
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        child: Column(
          children: [
            // const ProfileSetupHeader(),
            const Column(
              children: [
                Icon(
                  Icons.menu_book_sharp,
                  size: 100,
                ),
                Text('View your Profile')
              ],
            ),
            Column(
              children: <Widget>[
                GestureDetector(
                  onTap: isEditable ? _pickImage : null,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile == null
                        ? null
                        : FileImage(File(_imageFile!.path)),
                    foregroundImage:
                        const AssetImage('assets/images/ProfileImg2.png'),
                  ),
                ),
                const SizedBox(height: 16),
                buildTextField('City', cityController),
                buildTextField('Address', addressController),
                buildTextField('Category', categoryController),
                buildTextField('Services', servicesController),
                buildTextField('Hotel/Agency', agencyController),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.06,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: !isEditable
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: EXColors.primaryDark,
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      isEditable = !isEditable;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        (isEditable) ? Icons.save : Icons.edit,
                        size: 20,
                      ),
                      Text(
                        (isEditable) ? ' Save' : 'Edit',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isEditable,
                  child: MaterialButton(
                    textColor: Colors.white,
                    color: EXColors.primaryDark,
                    onPressed: () {
                      setState(() {
                        isEditable = !isEditable;
                      });
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.cancel,
                          size: 20,
                        ),
                        Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      width: MediaQuery.of(context).size.width * (80),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: EXColors.secondaryDark,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.24,
            child: Text(
              label,
              style: const TextStyle(
                color: EXColors.secondaryMedium,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 20,
            width: MediaQuery.of(context).size.width * 0.56,
            child: Container(
              padding: const EdgeInsets.only(left: 2),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  left: BorderSide(
                    color: EXColors.secondaryMedium,
                  ),
                ),
              ),
              child: TextField(
                decoration: const InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                controller: controller,
                readOnly: !isEditable,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
