import 'package:flutter/material.dart';

class AddToCart extends StatelessWidget {
  final double width;
  final double height;
  final VoidCallback onCallback;
  final String? message;

  const AddToCart({
    super.key,
    required this.width,
    required this.height,
    required this.onCallback,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        minimumSize: Size(width, height),
      ),
      onPressed: onCallback,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (message == null)
            Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          SizedBox(width: 8),
          Text(
            message ?? "Add To Cart",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
