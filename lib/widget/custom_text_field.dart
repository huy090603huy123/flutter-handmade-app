import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utility/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final double? height;
  final TextEditingController controller;
  final TextInputType? inputType;
  final int? lineNumber;
  final void Function(String?) onSave;
  final String? Function(String?)? validator;
  final Color? textColor; // Add textColor parameter
  final Color? labelColor;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.onSave,
    this.inputType = TextInputType.text,
    this.lineNumber = 1,
    this.validator, required this.controller, this.height,
    this.textColor, // Include in constructor
    this.labelColor,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          maxLines: lineNumber,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: AppColor.darkOrange),
            ),
          ),
          keyboardType: inputType,
          onSaved: (value) {
            onSave(value?.isEmpty ?? true ? null : value);
          },
          validator: validator,
          inputFormatters: [
            LengthLimitingTextInputFormatter(700),
            if (inputType == TextInputType.number) FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
          ],
        ),
      ),
    );
  }
}
