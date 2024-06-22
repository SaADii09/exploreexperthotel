// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:gallery_picker/gallery_picker.dart';

// // ignore: body_might_complete_normally_nullable
// // Future<File?> getImageFromGallery(BuildContext context) async {
// //   try {
// //     List<MediaFile>? singleMedia =
// //         await GalleryPicker.pickMedia(context: context, singleMedia: true);
// //     return singleMedia?.first.getFile();
// //   } catch (e) {
// //     print(e);
// //     return null;
// //   }
// // }

// Future<File?> getImageFromGallery(BuildContext context) async {
//   try {
//     List<MediaFile>? singleMedia =
//         await GalleryPicker.pickMedia(context: context, singleMedia: true);

//     // Check if singleMedia is not null and contains elements
//     if (singleMedia != null && singleMedia.isNotEmpty) {
//       return singleMedia.first.getFile();
//     } else {
//       print('No media selected');
//       return null;
//     }
//   } catch (e) {
//     print('Error selecting image: $e');
//     return null; // Handle gracefully, maybe show an error message
//   }
// }

// Future<bool> uploadFileForUser(File file) async {
//   try {
//     final userId = FirebaseAuth.instance.currentUser?.uid;
//     final storageRef = FirebaseStorage.instance.ref();
    // final fileName = file.path.split('/').last;
    // final timestamp = DateTime.now().microsecondsSinceEpoch;
//     final uploadRef =
        // storageRef.child("hotel/$userId/room1/$timestamp-$fileName");
//     await uploadRef.putFile(file);
//     return true;
//   } catch (e) {
//     print(e);

//     return false;
//   }
// }
