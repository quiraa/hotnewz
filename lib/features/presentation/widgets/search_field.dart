import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onSearch;

  const SearchField({
    Key? key,
    required this.searchController,
    required this.onSearch,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      onSubmitted: (value) {
        widget.onSearch;
      },
      decoration: InputDecoration(
        hintText: 'Search News',
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        prefixIcon: IconButton(
          onPressed: widget.onSearch,
          icon: const Icon(
            Icons.search_rounded,
          ),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
