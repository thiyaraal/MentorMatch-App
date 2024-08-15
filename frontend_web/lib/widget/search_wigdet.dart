import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  final ValueChanged<String>? onSearchTextChanged;

  SearchWidget({Key? key, this.onSearchTextChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: onSearchTextChanged,
        decoration: InputDecoration(
          hintText: 'Search by name, company, role',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
