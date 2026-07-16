import 'package:flutter/material.dart';
import 'package:plant_app/core/styles/colors_manager.dart';
import 'package:plant_app/core/styles/styles_manager.dart';

class TermsCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String termsText;
  final String privacyText;

  const TermsCheckbox({
    super.key,
    required this.value,
    this.onChanged,
    this.termsText = 'terms & conditions',
    this.privacyText = 'privacy policy',
  });

  @override
  State<TermsCheckbox> createState() => _TermsCheckboxState();
}

class _TermsCheckboxState extends State<TermsCheckbox> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() => _isChecked = value ?? false);
            widget.onChanged?.call(value);
          },
          activeColor: AppColor.backgroundButton,
          side: const BorderSide(color: Colors.grey),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() => _isChecked = !_isChecked);
              widget.onChanged?.call(_isChecked);
            },
            child: RichText(
              text: TextSpan(
                style: StyleManager.termsGray,
                children: [
                  TextSpan(text: 'By signing up you agree to our '),
                  TextSpan(
                    text: widget.termsText,
                    style: StyleManager.termsGreen,
                  ),

                  TextSpan(text: ' of use and '),
                  TextSpan(
                    text: widget.privacyText,
                    style: StyleManager.termsGreen,
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
