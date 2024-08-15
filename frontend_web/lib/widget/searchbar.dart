import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;

  SearchBarWidget({Key? key, required this.title, this.onPressed})
      : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // height: 352.0,
        // width: 200.0, // Ubah nilai lebar sesuai kebutuhan
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: widget.title,
            prefixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              onPressed: widget.onPressed,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            hintStyle: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
