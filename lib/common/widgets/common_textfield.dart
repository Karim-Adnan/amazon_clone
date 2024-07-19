import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController _controller;
  final String _hintText;
  final int _maxLines;
  final TextInputType _textInputType;

  const CustomTextField({
    super.key,
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    TextInputType textInputType = TextInputType.text,
  })  : _controller = controller,
        _hintText = hintText,
        _maxLines = maxLines,
        _textInputType = textInputType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      keyboardType: _textInputType,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        hintText: _hintText,
      ),
      maxLines: _maxLines,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter $_hintText';
        }
        return null;
      },
    );
  }
}
