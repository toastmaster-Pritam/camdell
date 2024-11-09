import 'package:camdell/meta/utils/responsive.dart';
import 'package:flutter/material.dart';

class CounterButton extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int>? onChanged;

  const CounterButton({
    super.key,
    this.initialValue = 0,
    this.onChanged,
  });

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _count++;
      widget.onChanged?.call(_count);
    });
  }

  void _decrement() {
    setState(() {
      _count--;
      widget.onChanged?.call(_count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.05,
      width: screenwidth(context) * 0.3,
      decoration: BoxDecoration(
       border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildButton(Icons.remove, _decrement),
            Text(
              '$_count',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            _buildButton(Icons.add, _increment),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, size: 20),
      ),
    );
  }
}