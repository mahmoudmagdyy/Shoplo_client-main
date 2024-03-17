import 'dart:async';

import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    this.hint,
    this.controller,
    this.onChanged,
  });

  final String? hint;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounce;
  String query = "";
  final int _debouncetime = 600;

  onSearchChanged(String s) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debouncetime), () {
      widget.onChanged?.call(s);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: widget.controller,
        onChanged: (s) {
          setState(() {
            query = s;
          });
          onSearchChanged(s);
        },
        decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: const Icon(Icons.search),
            // clear
            suffixIcon: query.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        query = "";
                        widget.controller?.clear();
                      });
                      onSearchChanged(query);
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}
