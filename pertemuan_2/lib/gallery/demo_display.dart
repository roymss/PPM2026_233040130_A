import 'package:flutter/material.dart';

class DemoDisplay extends StatelessWidget {
  const DemoDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Text - widget buat tampilkan teks",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Text("Hello World!"),
        const SizedBox(height: 20),
        const Text("Icon - widget buat tampilkan simbol",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const Row(
          children: [
            Icon(Icons.star, color: Colors.amber),
            Icon(Icons.favorite, color: Colors.red),
            Icon(Icons.thumb_up, color: Colors.blue),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Image - widget buat tampilkan gambar",
            style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          height: 150,
          width: double.infinity,
          color: Colors.grey.shade300,
          child: const Center(child: Text("Image Placeholder")),
        ),
      ],
    );
  }
}
