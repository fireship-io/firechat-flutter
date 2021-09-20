import 'package:flutter/material.dart';
import 'package:firechat/styles.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black.withOpacity(0.50),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xffff9800),
          ),
          strokeWidth: 5.0,
          color: themeColor,
          value: null,
        ),
      ),
    );
  }
}
