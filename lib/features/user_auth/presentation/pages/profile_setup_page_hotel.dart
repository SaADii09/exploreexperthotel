import 'dart:io';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/profile_setup_page_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class HotelProfileSetupPage extends StatelessWidget {
  const HotelProfileSetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: const SizedBox(
        height: 800,
        child: Column(
          children: [
            ProfileSetupHeader(),
            Column(
              children: [
                Icon(
                  Icons.menu_book_sharp,
                  size: 100,
                ),
                Text('View your Profile')
              ],
            ),
            ProfileWidget(),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(true ? Icons.check : Icons.edit),
                Text('Edit'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Row(
              children: [
                Icon(
                  Icons.cancel,
                ),
                Text('Cancel'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool isEditable = true;
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController agencyController = TextEditingController();
  XFile? _imageFile;
  //  = AssetImage('assets/images/ProfileImg2.png');
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: isEditable ? _pickImage : null,
          child: CircleAvatar(
            radius: 50,
            backgroundImage:
                _imageFile == null ? null : FileImage(File(_imageFile!.path)),
            foregroundImage: const AssetImage('assets/images/ProfileImg2.png'),
          ),
        ),
        const SizedBox(height: 16),
        buildTextField('City', cityController),
        buildTextField('Address', addressController),
        buildTextField('Category', categoryController),
        buildTextField('Services', servicesController),
        buildTextField('Hotel/Agency', agencyController),
        IconButton(
          icon: Icon(isEditable ? Icons.check : Icons.edit),
          onPressed: () {
            setState(() {
              isEditable = !isEditable;
            });
          },
        ),
      ],
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
            child: TextField(
              decoration: const InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              controller: controller,
              readOnly: !isEditable,
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
