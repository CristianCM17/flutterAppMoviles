import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final IconData prefixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;
  final String? Function(String?)
      validator; // Cambiado el tipo de la función de validación

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.name,
    required this.prefixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    required this.inputType,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        enabled: true,
        controller: controller,
        textCapitalization: textCapitalization,
        obscureText: obscureText,
        keyboardType: inputType,
        textAlign: TextAlign.start,
      decoration: InputDecoration(
        hintText: name,
        filled: true,
        fillColor: Color(0xffEBDCFA),
        prefixIcon: Icon(prefixIcon,color: Colors.grey),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 129, 37, 222)),
          borderRadius: BorderRadius.circular(50)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:BorderRadius.circular(50),
          borderSide: BorderSide(color: Color(0xffEBDCFA))
           )
      ),
      validator: validator,
      ),
    );
  }
}