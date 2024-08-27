import 'package:flutter/material.dart';

class Searchfield extends StatelessWidget {
  const Searchfield({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0XFFE9EAEB),
        borderRadius: BorderRadius.circular(10),
      ),
      width: width * 0.9,
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none, // Remove the border
          enabledBorder: InputBorder.none, // Ensure no border when enabled
          focusedBorder: InputBorder.none, // Ensure no border when focused
        ),
      ),
    );
  }
}
