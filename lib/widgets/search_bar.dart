import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onChanged;

  const CustomSearchBar({
    Key? key,
    required this.searchQuery,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4, 
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
