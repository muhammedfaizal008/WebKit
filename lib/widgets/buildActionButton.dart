import 'package:flutter/material.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';


class BuildActionButton extends StatefulWidget {
  final IconData icon;
  Color? iconColor;
  final VoidCallback onPressed;
  final bool isPrimary;

   BuildActionButton({
    Key? key,
    required this.icon,
    this.iconColor,
    required this.onPressed,
    required this.isPrimary,
  }) : super(key: key);

  @override
  _BuildActionButtonState createState() => _BuildActionButtonState();
}

class _BuildActionButtonState extends State<BuildActionButton> with UIMixin{
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      child: Icon(
        widget.icon,
        size: 18,
        color: widget.isPrimary ? Colors.white:Colors.white,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isPrimary ? contentTheme.primary : widget.iconColor,
        elevation: widget.isPrimary ? 2 : 0,
        shadowColor: widget.isPrimary ? contentTheme.primary.withOpacity(0.3) : null,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: widget.isPrimary ? BorderSide.none : BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}