import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String _text;
  final VoidCallback _onPressed;
  const AccountButton({
    super.key,
    required String text,
    required VoidCallback onPressed,
  })  : _text = text,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white),
        child: OutlinedButton(
          onPressed: _onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black12.withOpacity(0.03),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
            _text,
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}
