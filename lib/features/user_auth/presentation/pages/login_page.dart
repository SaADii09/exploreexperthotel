import 'package:exploreexperthotel/features/user_auth/presentation/pages/forgot_password_page.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/home_page_hotel.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/form_field_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  void _signInUser() async {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      emailcontroller.dispose();
      passwordcontroller.dispose();
      // Only proceed if the widget is still mounted
      if (!mounted) return;

      // Pop the loading indicator
      Navigator.of(context).pop();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HotelHome()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      // Pop the loading indicator
      Navigator.of(context).pop();

      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = "Incorrect Email";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Incorrect Password";
      } else {
        errorMessage = "An error occurred";
      }

      // Show error dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(errorMessage),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      'assets/images/Pexels Photo by Mikhail Nilov.png'),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ExploreXpertLogo.png',
                        scale: 2.3,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/images/ExploreXpertTitle.png',
                        scale: 1.3,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.60,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(252, 252, 252, 0.75),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55),
                        topRight: Radius.circular(55))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.05),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: EXColors.primaryDark,
                            ),
                          ),
                        ),
                        FormFieldContainerWidget(
                          hintText: 'Email',
                          labelText: 'Email',
                          isPasswordField: false,
                          controller: emailcontroller,
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Password',
                          labelText: 'Password',
                          isPasswordField: true,
                          controller: passwordcontroller,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordPage()),
                                    (route) => false);
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: EXColors.primaryDark,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  decorationColor: EXColors.primaryDark,
                                  decorationThickness: 1.8,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: MaterialButton(
                            onPressed: _signInUser,
                            color: EXColors.primaryDark,
                            height: 60,
                            mouseCursor: WidgetStateMouseCursor.clickable,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: const Center(
                                child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?",
                                style: TextStyle(fontSize: 16)),
                            const SizedBox(
                              width: 3,
                              height: 60,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()),
                                    (route) => false);
                              },
                              child: const Text(
                                'SignUp',
                                style: TextStyle(
                                    color: EXColors.primaryDark,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
