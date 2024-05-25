import 'package:exploreexperthotel/features/user_auth/presentation/pages/home_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MyApp());
}

class DefaultFirebaseOptions {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ExploreXpert',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: EXColors.primaryDark),
          useMaterial3: true,
        ),
        home: const HotelHome()
        // const HotelProfileSetupPage()

        //     const SplashScreen(
        //   child: AuthViaPage(),
        // ),
        );
  }
}
