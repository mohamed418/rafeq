import 'package:flutter/material.dart';

class RafeqScreen extends StatelessWidget {
  const RafeqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: Center(
          child: Text('RAFEEQ', style: TextStyle(
            fontSize: 50,
          ),),
        ),
      ),
    );
  }
}
