import 'package:flutter/material.dart';
import 'package:travelmatex/utils/constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {super.key,
      required this.icon,
      required this.hint,
      required this.controller});
  final IconData icon;
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: screenHeight * 0.06,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Material(
          elevation: 5,
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return '';
              }
              return null;
            },
            controller: controller,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                errorStyle: const TextStyle(
                  fontSize: -100,
                ),
                hintText: hint,
                prefixIcon: Icon(
                  icon,
                  color: Colors.grey,
                ),
                border: const OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ));
  }
}
