import 'package:flutter/material.dart';
import 'package:mobile_app/db/constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: primaryColorHover);
  }
}
