import 'package:flutter/material.dart';

class DemoFeedback extends StatelessWidget {
  const DemoFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Halo dari SnackBar!")));
          },
          child: const Text("Tampilkan SnackBar"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Peringatan"),
                content: const Text("Ini adalah AlertDialog"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Tutup"))
                ],
              ),
            );
          },
          child: const Text("Tampilkan AlertDialog"),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                child: const Text("Ini adalah BottomSheet"),
              ),
            );
          },
          child: const Text("Tampilkan BottomSheet"),
        ),
      ],
    );
  }
}
