import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/hotel_header.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/profile_setup_page_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

class HotelProfileSetupPage extends StatefulWidget {
  const HotelProfileSetupPage({super.key});

  @override
  State<HotelProfileSetupPage> createState() => _HotelProfileSetupPageState();
}

class _HotelProfileSetupPageState extends State<HotelProfileSetupPage> {
  bool isEditable = false;
  TextEditingController cityController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController uanController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String website = '';
  String uan = '';
  String phone = '';
  String name = '';
  String city = '';
  String address = '';
  final uzer = FirebaseAuth.instance.currentUser;

  // XFile? _imageFile;
  //  = AssetImage('assets/images/ProfileImg2.png');
  // final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getUserDetails(uzer!.email!);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );
    return Scaffold(
      appBar: AppBar(
        title: const HotelHeader(),
      ),
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 40,
              color: EXColors.primaryDark,
              child: const Center(
                child: Text(
                  'Hotel/Agent Profile',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: EXColors.secondaryLight),
                ),
              ),
            ),
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
                  child: const CircleAvatar(
                    radius: 50,
                    // backgroundImage: _imageFile == null
                    //     ? null
                    //     : FileImage(File(_imageFile!.path)),
                    foregroundImage:
                        AssetImage('assets/images/ProfileImg2.png'),
                  ),
                ),
                const SizedBox(height: 16),
                buildTextField(
                  'City',
                  cityController,
                  TextInputType.text,
                ),
                buildTextField(
                  'Address',
                  addressController,
                  TextInputType.text,
                ),
                buildTextField(
                  'Website',
                  websiteController,
                  TextInputType.text,
                ),
                buildTextField(
                  'Hotel/Agency',
                  nameController,
                  TextInputType.text,
                ),
                buildTextField(
                  'UAN',
                  uanController,
                  TextInputType.phone,
                ),
                buildTextField(
                  'Phone',
                  phoneController,
                  TextInputType.number,
                ),
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
                    if (isEditable) {
                      updateUserDetails(
                        nameController.text,
                        cityController.text,
                        uzer!.email!,
                        addressController.text,
                        websiteController.text,
                        phoneController.text,
                        uanController.text,
                      );
                    }

                    setState(
                      () {
                        isEditable = !isEditable;
                      },
                    );
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

  Widget buildTextField(
      String label, TextEditingController controller, TextInputType inputType) {
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
                keyboardType: inputType,
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

  Future updateUserDetails(String hName, String city, String email,
      String address, String web, String phone, String uan) async {
    await FirebaseFirestore.instance
        .collection('users_hotel')
        .doc(email)
        .update({
      'address': address,
      'city': city,
      'name': hName,
      'phones': [phone, uan],
      'website': web
    });
  }

  Future<void> getUserDetails(String email) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users_hotel')
          .doc(email)
          .get();
      if (snapshot.exists) {
        setState(() {
          // Set the initial values of the TextEditingController
          name = snapshot['name'];
          city = snapshot['city'];
          address = snapshot['address'];
          phone = (snapshot['phones'] as List<dynamic>).first;
          uan = (snapshot['phones'] as List<dynamic>).last;
          website = snapshot['website'];

          cityController.text = city;
          addressController.text = address;
          websiteController.text = website;
          nameController.text = name;
          uanController.text = uan;
          phoneController.text = phone;
          // Set other controllers similarly
        });
      } else {
        // Document does not exist
      }
    } catch (e) {
      // Error handling
      print('Error retrieving user details: $e');
    }
  }

  Future<void> _pickImage() async {
    // final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      // _imageFile = pickedFile;
    });
  }
}
