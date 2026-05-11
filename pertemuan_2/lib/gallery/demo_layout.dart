import 'package:flutter/material.dart';

class DemoLayout extends StatelessWidget {
  const DemoLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Stack - widget tumpuk tumpuk",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Stack(
          children: [
            Container(width: 100, height: 100, color: Colors.blue),
            Positioned(
                top: 10,
                left: 10,
                child: Container(width: 80, height: 80, color: Colors.red)),
            Positioned(
                top: 20,
                left: 20,
                child: Container(width: 60, height: 60, color: Colors.green)),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Wrap - baris yang bisa ganti baris otomatis",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: List.generate(
            10,
            (i) => Chip(
              avatar:
                  CircleAvatar(backgroundColor: Colors.blue, child: Text("$i")),
              label: Text("Item $i"),
            ),
          ),
        ),
      ],
    );
  }
}
