import 'package:flutter/material.dart';

class DemoInput extends StatefulWidget {
  const DemoInput({super.key});

  @override
  State<DemoInput> createState() => _DemoInputState();
}

class _DemoInputState extends State<DemoInput> {
  bool _checked = false;
  bool _switched = false;
  double _sliderValue = 0.5;
  String _radioValue = "A";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("TextField", style: TextStyle(fontWeight: FontWeight.bold)),
        const TextField(decoration: InputDecoration(labelText: "Ketik sesuatu")),
        const SizedBox(height: 20),
        const Text("Checkbox"),
        Checkbox(
            value: _checked, onChanged: (v) => setState(() => _checked = v!)),
        const SizedBox(height: 20),
        const Text("Switch"),
        Switch(
            value: _switched, onChanged: (v) => setState(() => _switched = v)),
        const SizedBox(height: 20),
        const Text("Radio"),
        Row(
          children: [
            Radio(
                value: "A",
                groupValue: _radioValue,
                onChanged: (v) => setState(() => _radioValue = v.toString())),
            const Text("A"),
            Radio(
                value: "B",
                groupValue: _radioValue,
                onChanged: (v) => setState(() => _radioValue = v.toString())),
            const Text("B"),
          ],
        ),
        const SizedBox(height: 20),
        const Text("Slider"),
        Slider(
            value: _sliderValue,
            onChanged: (v) => setState(() => _sliderValue = v)),
      ],
    );
  }
}
