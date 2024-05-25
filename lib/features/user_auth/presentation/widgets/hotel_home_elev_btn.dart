
import 'package:exploreexperthotel/features/user_auth/presentation/widgets/essentials.dart';
import 'package:flutter/material.dart';

class HotelElevButton extends StatelessWidget {
  final IconData ico;
  final String txt;
  final double height;
  final double width;
  final VoidCallback btn;
  const HotelElevButton({
    super.key,
    required this.height,
    required this.ico,
    required this.txt,
    required this.width,
    required this.btn,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: btn,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                24,
              ),
            ),
          ),
          backgroundColor: EXColors.primaryLight,
          foregroundColor: EXColors.secondaryDark,
        ),
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(
                  ico,
                  size: 30,
                ),
              ),
              Center(
                child: Text(
                  txt,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
