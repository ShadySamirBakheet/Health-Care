import 'package:flutter/material.dart';

class NoFlashLight extends StatelessWidget {
  const NoFlashLight({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'error',
            style: TextStyle(color: Colors.red),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.close,
            ),
          )
        ],
      ),
    );
  }
}
