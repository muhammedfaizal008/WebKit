import 'package:flutter/material.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';

class MyTextFieldForm extends StatelessWidget {
   MyTextFieldForm({
    required this.nameController,
    required this.labeltext,
    required this.hintText,
    this.validator,
    this.icondata,
    super.key,  
  });

  final TextEditingController nameController;
  final String labeltext ;
  final String hintText ;
  final FormFieldValidator<String>? validator;
  final IconData? icondata;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
    controller: nameController,
    decoration: InputDecoration(
      labelText: labeltext,
      labelStyle: MyTextStyle.getStyle(
        color: Theme.of(context).hintColor,
        fontSize: 16,
        fontWeight: 10  
      ),
      prefixIcon: Icon(
      icondata ?? Icons.person,
      color: Theme.of(context).primaryColor,
      size: 24,
      ),
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        width: 1.5,
      ),
      ),
      focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
        width: 2.5,
      ),
      ),
      filled: true,
      fillColor: Theme.of(context).cardColor.withOpacity(0.9),
      contentPadding: EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 16,
      ),
      hintText: hintText,
      hintStyle: TextStyle(
      color: Theme.of(context).hintColor.withOpacity(0.7),
      ),
    ),
    validator: validator,
    textInputAction: TextInputAction.next,
    keyboardType: TextInputType.name,
    textCapitalization: TextCapitalization.words,
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    );
  }
}