import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String label;
  final String value;
  final bool editable;
  final void Function(String)? onChanged;
  final int maxLines;
  final TextInputType inputType;
  final String? Function(String?)? validator;

  const ProfileField({
    super.key,
    required this.label,
    required this.value,
    this.editable = false,
    this.onChanged,
    this.maxLines = 1,
    this.inputType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          readOnly: !editable,
          keyboardType: inputType,
          maxLines: editable ? maxLines : 1,
          onChanged: onChanged,
          validator: validator,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          ),
        ),
        const SizedBox(height: 15),
      ]
    );
  }
}
