import 'package:flutter/material.dart';

class OptrSearchField extends StatelessWidget {
  final bool autoSelected;

  final String searchHint;
  final Function(String search) onChange;

  const OptrSearchField({
    this.autoSelected = false,
    this.searchHint = 'Search Password',
    @required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        autofocus: true,
        onChanged: (String value) {
          onChange(value);
        },
        decoration: InputDecoration(
          hintText: searchHint,
          border: InputBorder.none,
          hintStyle: TextStyle(
              // color: mainTextColor.withAlpha(100),
              ),
          suffixIcon: Icon(
            Icons.search,
            // color: mainTextColor.withAlpha(100),
          ),
        ),
      ),
    );
  }
}
