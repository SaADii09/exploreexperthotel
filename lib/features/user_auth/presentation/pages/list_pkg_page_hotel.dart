import 'package:exploreexperthotel/features/user_auth/presentation/pages/add_pkg_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/models/pakage.dart';
import 'package:exploreexperthotel/services/database_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HotelListPkgPage extends StatefulWidget {
  const HotelListPkgPage({super.key});

  @override
  State<HotelListPkgPage> createState() => _HotelListPkgPageState();
}

class _HotelListPkgPageState extends State<HotelListPkgPage> {
  final PDatabaseServices _pdatabaseService = PDatabaseServices();
  final uzer = FirebaseAuth.instance.currentUser;

  bool deleter = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 40,
              color: EXColors.primaryDark,
              child: const Center(
                child: Text(
                  'Package List',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: EXColors.secondaryLight),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder(
                builder: (Context, snapshot) {
                  List pakages = snapshot.data?.docs.cast<dynamic>() ?? [];
                  if (pakages.isEmpty) {
                    return const Center(
                      child: Text('Add a Package!'),
                    );
                  }
                  // print(rooms);
                  return ListView.builder(
                    itemCount: pakages.length,
                    itemBuilder: (context, index) {
                      Pakage pakage = pakages[index].data();
                      String pakageId = pakages[index].id;
                      // print(room);
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/ExploreXpertLogo.png'),
                          ),
                          title: Text(
                            'Title : ${pakage.title}',
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Room Type : ${pakage.roomType}',
                              ),
                              Text(
                                'Price : ${pakage.price.toString()}',
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Confirmation'),
                                      content: const Text(
                                          'Are you sure you want to delete room?'),
                                      actions: [
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          color: EXColors.primaryDark,
                                          textColor: Colors.white,
                                          child: const Text('Cancel'),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            _pdatabaseService
                                                .deletePakage(pakageId);
                                          },
                                          color: EXColors.primaryDark,
                                          textColor: Colors.white,
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                      );
                    },
                  );
                },
                stream: _pdatabaseService.getPakage(uzer?.uid),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HotelAddPkgPage()),
          );
        },
        backgroundColor: EXColors.primaryDark,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
