import 'package:flutter/material.dart';


class StartButton extends StatelessWidget {
  const StartButton({Key? key, required this.onTap, required this.buttonTitle}) : super(key: key);

  final VoidCallback? onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        color: Colors.green,
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.only(bottom: 8.0),
        width: double.infinity,
        height: 70.0,
      ),
    );
  }
}