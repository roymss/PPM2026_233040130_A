import 'package:flutter/material.dart';

class DemoButton extends StatelessWidget {
  const DemoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(onPressed: () {}, child: const Text("ElevatedButton")),
        const SizedBox(height: 10),
        OutlinedButton(onPressed: () {}, child: const Text("OutlinedButton")),
        const SizedBox(height: 10),
        TextButton(onPressed: () {}, child: const Text("TextButton")),
        const SizedBox(height: 10),
        IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle)),
        const SizedBox(height: 10),
        FloatingActionButton.extended(
            onPressed: () {},
            label: const Text("FAB Extended"),
            icon: const Icon(Icons.add)),
      ],
    );
  }
}
