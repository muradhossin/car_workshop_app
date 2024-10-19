import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData icon;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final InputBorder? border;
  final EdgeInsetsGeometry? padding;
  final Color? fillColor;
  final bool filled;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.icon = Icons.text_fields,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.border,
    this.padding,
    this.fillColor,
    this.filled = false,
    this.validator,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        style: widget.textStyle ?? DefaultTextStyle.of(context).style,
        validator: widget.validator,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          labelStyle: widget.labelStyle ?? TextStyle(color: Colors.grey),
          hintStyle: widget.hintStyle ?? TextStyle(color: Colors.grey),
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          border: widget.border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
          filled: widget.filled,
          fillColor: widget.fillColor ?? Colors.white,
        ),
      ),
    );
  }
}
