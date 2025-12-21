import 'package:skolar/core/constant/color.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData? suffixIcon;
  final TextEditingController? myController;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final bool? isdropdown;
  final void Function()? ontapIcon;
  final void Function()? onTap;

  const CustomTextForm({
    super.key,
    required this.hintText,
    required this.labelText,
    this.suffixIcon,
    required this.myController,
    required this.valid,
    required this.isNumber,
    this.obscureText,
    this.ontapIcon,
    this.onTap,
    this.isdropdown,
  });

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final bool isObscured = widget.obscureText ?? false;

    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 18),
        child: TextFormField(
          cursorColor: AppColor.primaryColor,
          readOnly: widget.isdropdown == true,
          onTap: widget.onTap,
          obscureText: isObscured,
          keyboardType: widget.isNumber
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          validator: widget.valid,
          controller: widget.myController,
          decoration: InputDecoration(
            hintText: widget.hintText,

            // Borders
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isHover
                    ? AppColor.primaryColor.withOpacity(0.5)
                    : Colors.grey.shade300,
                width: 1.2,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColor.primaryColor,
                width: 1.8,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red.shade400, width: 1.2),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red.shade600, width: 1.8),
            ),

            // Label
            labelText: widget.labelText,
            labelStyle: TextStyle(color: AppColor.seconderyColor),
            floatingLabelBehavior: FloatingLabelBehavior.auto,

            suffixIcon: widget.suffixIcon != null
                ? InkWell(
                    onTap: widget.ontapIcon,
                    child: Icon(
                      widget.suffixIcon,
                      size: 20,
                      color: Colors.grey.shade600,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
