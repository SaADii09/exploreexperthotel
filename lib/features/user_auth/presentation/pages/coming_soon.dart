import 'package:flutter/material.dart';

class CommingSoon extends StatefulWidget {
  const CommingSoon({super.key});

  @override
  State<CommingSoon> createState() => _HomePageState();
}

class _HomePageState extends State<CommingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coming Soon'),
      ),
      body:

          // _user != null
          //     ? Column(
          //         children: [
          //           const Text('comming Soon 🙃'),
          //           Container(
          //             height: 100,
          //             width: 100,
          //             decoration: BoxDecoration(
          //               image: DecorationImage(
          //                 image: NetworkImage(_user!.photoURL!),
          //               ),
          //             ),
          //           ),
          //           Text(_user!.email!),
          //           Text(_user!.displayName ?? ""),
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width * 0.50,
          //             child: MaterialButton(
          //               onPressed: _auth.signOut,
          //               color: EXColors.warning,
          //               height: 60,
          //               mouseCursor: WidgetStateMouseCursor.clickable,
          //               shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(15)),
          //               child: const Center(
          //                 child: Text(
          //                   'Logout',
          //                   style: TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.bold),
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       )
          //     :
          const Column(
        children: [
          Text('Coming Soon 🌍'),
        ],
      ),
    );
  }
}
