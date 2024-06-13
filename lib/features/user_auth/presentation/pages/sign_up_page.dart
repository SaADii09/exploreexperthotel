import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/pages/login_page.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/form_field_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final webcontroller = TextEditingController();
  final addresscontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final hNamecontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final uancontroller = TextEditingController();

  _signUpUser() async {
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
      if (passwordcontroller.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passwordcontroller.text,
        );

        addUserDetails(
          hNamecontroller.text.trim(),
          citycontroller.text.trim(),
          emailcontroller.text.trim(),
          addresscontroller.text.trim(),
          webcontroller.text.trim(),
          phonecontroller.text.trim(),
          uancontroller.text.trim(),
        );

        emailcontroller.clear();
        passwordcontroller.clear();
        confirmPasswordController.clear();
        webcontroller.clear();
        addresscontroller.clear();
        citycontroller.clear();
        hNamecontroller.clear();
        phonecontroller.clear();
        uancontroller.clear();
        // Only proceed if the widget is still mounted
        if (!mounted) return;

        // Pop the loading indicator
        Navigator.of(context).pop();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      } else {
        // Only proceed if the widget is still mounted
        if (!mounted) return;

        // Pop the loading indicator
        Navigator.of(context).pop();
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Passwords don\'t match '),
            );
          },
        );
      }
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

  Future addUserDetails(String hName, String city, String email, String address,
      String web, String phone, String uan) async {
    await FirebaseFirestore.instance.collection('users_hotel').doc(email).set({
      'address': address,
      'city': city,
      'email': email,
      'name': hName,
      'phones': [phone, uan],
      'website': web
    });
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
                height: MediaQuery.of(context).size.height * 0.20,
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
                height: MediaQuery.of(context).size.height * 0.80,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(252, 252, 252, 0.75),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55),
                        topRight: Radius.circular(55))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: EXColors.primaryDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Enter Your Hotel Name',
                          labelText: 'Hotel Name',
                          isPasswordField: false,
                          controller: hNamecontroller,
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Enter Your City',
                          labelText: 'City',
                          isPasswordField: false,
                          controller: citycontroller,
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Enter Your Address',
                          labelText: 'Complete Address',
                          isPasswordField: false,
                          controller: addresscontroller,
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Enter Your Website',
                          labelText: 'Website',
                          isPasswordField: false,
                          controller: webcontroller,
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Enter Your Phone Number',
                          labelText: 'Phone Number',
                          isPasswordField: false,
                          controller: phonecontroller,
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Enter Your UAN',
                          labelText: 'UAN',
                          isPasswordField: false,
                          controller: uancontroller,
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Enter Your Email',
                          labelText: 'Email',
                          isPasswordField: false,
                          controller: emailcontroller,
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Set a Password',
                          labelText: 'Password',
                          isPasswordField: true,
                          controller: passwordcontroller,
                        ),
                        const SizedBox(height: 10),
                        FormFieldContainerWidget(
                          hintText: 'Confirm Your Password',
                          labelText: 'Confirm Password',
                          isPasswordField: true,
                          controller: confirmPasswordController,
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          child: MaterialButton(
                            onPressed: _signUpUser,
                            color: EXColors.primaryDark,
                            height: 60,
                            mouseCursor: WidgetStateMouseCursor.clickable,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: const Center(
                                child: Text(
                              'Sign Up',
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
                            const Text("Already have an account?",
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
                                        builder: (context) => LoginPage()),
                                    (route) => false);
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: EXColors.primaryDark,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       height: 50,
                        //       width: 100,
                        //       child: Divider(
                        //         color: EXColors.secondaryMedium,
                        //         height: 20,
                        //         thickness: 1,
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.symmetric(horizontal: 10),
                        //       child: Text(
                        //         'OR',
                        //         style: TextStyle(
                        //             color: EXColors.secondaryMedium,
                        //             fontWeight: FontWeight.w500),
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: 50,
                        //       width: 100,
                        //       child: Divider(
                        //         color: EXColors.secondaryMedium,
                        //         height: 20,
                        //         thickness: 1,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     SizedBox(
                        //       width: MediaQuery.of(context).size.width * 0.15,
                        //       child: MaterialButton(
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       const SignUpPage()));
                        //         },
                        //         color: Colors.white,
                        //         height: 60,
                        //         mouseCursor: WidgetStateMouseCursor.clickable,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(50)),
                        //         child: const Center(
                        //           child: Icon(Icons.g_mobiledata),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 20),
                        //     SizedBox(
                        //       width: MediaQuery.of(context).size.width * 0.15,
                        //       child: MaterialButton(
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       const SignUpPage()));
                        //         },
                        //         color: Colors.white,
                        //         height: 60,
                        //         mouseCursor: WidgetStateMouseCursor.clickable,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(50)),
                        //         child: const Center(
                        //           child: Icon(Icons.facebook),
                        //         ),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 20),
                        //     SizedBox(
                        //       width: MediaQuery.of(context).size.width * 0.15,
                        //       child: MaterialButton(
                        //         onPressed: () {
                        //           Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       const SignUpPage()));
                        //         },
                        //         color: Colors.white,
                        //         height: 60,
                        //         mouseCursor: WidgetStateMouseCursor.clickable,
                        //         shape: RoundedRectangleBorder(
                        //             borderRadius: BorderRadius.circular(50)),
                        //         child: const Center(
                        //           child: Icon(Icons.apple),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // )
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
