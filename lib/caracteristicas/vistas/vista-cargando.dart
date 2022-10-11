import 'package:flutter/material.dart';

class VistaCargando extends StatelessWidget {
  const VistaCargando({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
  }
}