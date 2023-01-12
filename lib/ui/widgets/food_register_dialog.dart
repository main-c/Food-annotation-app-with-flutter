import 'package:flutter/material.dart';

class FoodRegisterDialog extends StatefulWidget {
  FoodRegisterDialog({Key? key}) : super(key: key);

  @override
  State<FoodRegisterDialog> createState() => _FoodRegisterDialogState();
}

class _FoodRegisterDialogState extends State<FoodRegisterDialog> {
  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("Alert!!"),
      content: Text("You are awesome!"),
    );
  }
}
