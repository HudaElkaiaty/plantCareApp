// lib/core/widgets/custom_text_form_field.dart

import 'package:flutter/material.dart';
import 'package:plant_app/core/styles/colors_manager.dart';
import 'package:plant_app/core/styles/styles_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final FormFieldSetter<String>? onSaved;
  final String? initialValue;
  final bool enabled;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.initialValue,
    this.enabled = true,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;
  bool _obscureText = true;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(() {
      setState(() {
        _hasText = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.gray,
            borderRadius: BorderRadius.circular(20.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 14),
                child: Text(widget.labelText!, style: StyleManager.labelStyle),
              ),

              TextFormField(
                controller: _controller,
                obscureText: widget.isPassword ? _obscureText : false,
                keyboardType: widget.keyboardType,
                validator: widget.validator,
                onChanged: widget.onChanged,
                onSaved: widget.onSaved,
                initialValue: widget.controller == null
                    ? widget.initialValue
                    : null,
                enabled: widget.enabled,
                style: StyleManager.userText,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: StyleManager.hinitText,

                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          onPressed: _toggleVisibility,
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility,
                            color: AppColor.gray.withValues(alpha: 0.7),
                          ),
                        )
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
