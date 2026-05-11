import 'package:flutter/material.dart';
import 'gallery/category_page.dart';
import 'gallery/demo_display.dart';
import 'gallery/demo_input.dart';
import 'gallery/demo_button.dart';
import 'gallery/demo_feedback.dart';
import 'gallery/demo_layout.dart';

class WidgetGallery extends StatelessWidget {
  const WidgetGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {"name": "Display", "icon": Icons.tv, "widget": const DemoDisplay()},
      {"name": "Input", "icon": Icons.input, "widget": const DemoInput()},
      {
        "name": "Button",
        "icon": Icons.smart_button,
        "widget": const DemoButton()
      },
      {
        "name": "Feedback",
        "icon": Icons.feedback,
        "widget": const DemoFeedback()
      },
      {"name": "Layout", "icon": Icons.layers, "widget": const DemoLayout()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Widget Gallery")),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CategoryPage(name: cat["name"], widget: cat["widget"]),
                ),
              );
            },
            child: Card(
              color: Colors.blue.shade50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(cat["icon"], size: 48, color: Colors.blue),
                  const SizedBox(height: 8),
                  Text(cat["name"],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
