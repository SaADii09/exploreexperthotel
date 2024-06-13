import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreexperthotel/features/app/splash_screen.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/home_screen_chat_page.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/auth_page.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ExploreXpert',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: EXColors.primaryDark,
            primary: EXColors.primaryLight,
            secondary: EXColors.secondaryDark,
          ),
          useMaterial3: true,
        ),
        home:
        //  HomeScreen()
        // const HotelHome()
        // const HotelProfileSetupPage(),

          const SplashScreen(
        child: AuthPage(),
        ),
        );
  }
}
