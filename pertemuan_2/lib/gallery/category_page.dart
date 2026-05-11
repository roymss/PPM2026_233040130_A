import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  final String name;
  final Widget widget;
  const CategoryPage({super.key, required this.name, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: widget,
      ),
    );
  }
}
